Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B767FC90-10FE-41A1-8607-90F8D3F18BD1@holtmann.org>
References: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com>
	<CAKT1EBfqP75+XJWkLt2yvkdEBVmNRmFC1_T667LAnuBrNFBxuQ@mail.gmail.com>
	<CAHrH25TeYWXMxQPqBGd9YnNWw+y5sYT+k4e-88hu_SRtFYWY+g@mail.gmail.com>
	<B767FC90-10FE-41A1-8607-90F8D3F18BD1@holtmann.org>
Date: Mon, 7 Apr 2014 17:02:10 -0700
Message-ID: <CAHrH25QWJKOVstwGHW3oY6U-sF4zCRP2sPCkSJSqi2y8yOvY4w@mail.gmail.com>
Subject: Re: Removing GAttrib.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> at the moment ConnectProfile() is BR/EDR specific and it most likely will stay way. So for LE only devices it
> should just return an error at the moment.

This simplifies things quite a bit.

> We want to use Service Changed notification and do a selective re-discover to avoid the extra overhead that a
> full discovery might cause. It does not have to be done in the beginning, but that is where this should be
> heading towards.

That makes sense, and this is what I had in mind as well.

> Some time back I started look into writing src/shared/att.c that really is suppose to be dead simple and just
> treats ATT protocol as a transport. This is how I see that basic interaction.
>
>         struct bt_att;
>
>         struct bt_att *bt_att_new(int fd);
>
>         struct bt_att *att_ref(struct bt_att *att);
>         void bt_att_unref(struct bt_att *att);
>
>         bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
>                                 void *user_data, bt_att_destroy_func_t destroy);
>
>         bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
>
> For a lot of new code, I prefer if we are using file descriptors as base. Then it becomes easy to use on a
> socketpair for unit testing or put this onto a different transport.
>
> The GIOChannel and BtIO forces us to have knowledge about every single detail of transport. I think we did
> this the wrong way around. The actual IO handling should be done inside struct att and be an implementation
> detail. And it should just deal with the transport and not the setup of the transport. The setup is out of scope
> for the protocol handling.

That makes sense. So in the end we would have src/device explicitly
set up the l2cap socket to the remote device and create a struct
bt_att that it owns and all the profiles would add a ref to that
struct bt_att to perform I/O?

It seems to me that we ultimately want an API that is just like
attrib/gatt.h that uses "struct bt_att" instead of GAttrib. There is
already a lot of code in attrib/* that is useful for dealing with the
attribute protocol and I don't really see the point of throwing that
code away, especially attrib/att.h can be used (at least initially) by
the new src/shared/att to encode/decode ATT MTUs.

As for the higher-level GATT interactions: we are clearly moving
towards a btd_attribute based GATT client/server API. So it makes
sense to approach this from the top-down. Here is what I propose for a
step-by-step refactor:

1. Add src/shared/att.*. Define struct bt_att as a simple wrapper
around the file descriptor with basic reference counting logic similar
to src/shared/mgmt (i.e. bt_att_set_close_on_unref, etc.) only.

2. Define a new GATT API for remote attribute discovery in src/gatt.*.
Have the functions take in a struct btd_att pointer. Have all
attributes represented as btd_attribute. Perhaps get this code tested
by introducing a new gatttool.

3. Implement the GATT discovery functions by using GAttrib inside
src/gatt.c at first, calling into the functions in attrib/gatt.h.

4. Partially remove the GAttrib dependency in src/device by having it
call into the new discovery functions in src/gatt instead of calling
attrib/gatt functions directly. At this point src/device will probably
still create the connection using bt_io_connect but it will wrap the
underlying fd around a "struct bt_att" instead of a GAttrib when
making calls to src/gatt.

Here we will remove the call to attrib_from_device (defined in
src/attrib-server.h) from src/device.c. I don't know if this will
break anything big, but it seems to be how incoming connections are
currently being handled. I think this logic has been pretty much taken
over by the new GATT server code in src/gatt.*, but correct me if I'm
wrong.

To prevent breaking the profiles that use attio and GAttrib,
src/device will keep notifying registered attio callbacks in this
step. This means that it will probably create a GAttrib simply for the
purpose of notifying the profiles but it won't use it to call into
attrib/gatt functions.

5. Have the profiles call into the new functions in src/gatt for
attribute requests instead of using attrib/gatt. This is the step
where we remove GAttrib from the profiles and modify attio to take in
a "struct bt_att".

6. Remove GAttrib entirely from src/device.

7. Remove GIOChannel from src/device by removing calls to
bt_io_connect and have it create the raw fd directly.

Sorry for the long email. Let me know if any of the above doesn't make
sense or if there is a much better/simpler way to approach this. There
might also be some things that I'm missing, for example there might be
complexities involving pairing and bonding steps and incoming
connections. I'm guessing that once step 5 is done we can add the GATT
D-Bus client API code. With all 7 steps complete, we can then make
src/gatt not use GAttrib at all and implement a new ATT I/O mechanism
using "struct bt_att".

Thanks!
Arman
