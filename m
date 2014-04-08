Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: Removing GAttrib.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25QWJKOVstwGHW3oY6U-sF4zCRP2sPCkSJSqi2y8yOvY4w@mail.gmail.com>
Date: Tue, 8 Apr 2014 00:40:11 -0700
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <8B6D3E26-762A-490C-9E33-A8E8357C97F5@holtmann.org>
References: <CAHrH25QBL52xfM4Qnk=NE1xn3RX2Bwxq_i0osDDCoi4egO2tkg@mail.gmail.com> <CAKT1EBfqP75+XJWkLt2yvkdEBVmNRmFC1_T667LAnuBrNFBxuQ@mail.gmail.com> <CAHrH25TeYWXMxQPqBGd9YnNWw+y5sYT+k4e-88hu_SRtFYWY+g@mail.gmail.com> <B767FC90-10FE-41A1-8607-90F8D3F18BD1@holtmann.org> <CAHrH25QWJKOVstwGHW3oY6U-sF4zCRP2sPCkSJSqi2y8yOvY4w@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> at the moment ConnectProfile() is BR/EDR specific and it most likely will stay way. So for LE only devices it
>> should just return an error at the moment.
> 
> This simplifies things quite a bit.
> 
>> We want to use Service Changed notification and do a selective re-discover to avoid the extra overhead that a
>> full discovery might cause. It does not have to be done in the beginning, but that is where this should be
>> heading towards.
> 
> That makes sense, and this is what I had in mind as well.
> 
>> Some time back I started look into writing src/shared/att.c that really is suppose to be dead simple and just
>> treats ATT protocol as a transport. This is how I see that basic interaction.
>> 
>>        struct bt_att;
>> 
>>        struct bt_att *bt_att_new(int fd);
>> 
>>        struct bt_att *att_ref(struct bt_att *att);
>>        void bt_att_unref(struct bt_att *att);
>> 
>>        bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
>>                                void *user_data, bt_att_destroy_func_t destroy);
>> 
>>        bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
>> 
>> For a lot of new code, I prefer if we are using file descriptors as base. Then it becomes easy to use on a
>> socketpair for unit testing or put this onto a different transport.
>> 
>> The GIOChannel and BtIO forces us to have knowledge about every single detail of transport. I think we did
>> this the wrong way around. The actual IO handling should be done inside struct att and be an implementation
>> detail. And it should just deal with the transport and not the setup of the transport. The setup is out of scope
>> for the protocol handling.
> 
> That makes sense. So in the end we would have src/device explicitly
> set up the l2cap socket to the remote device and create a struct
> bt_att that it owns and all the profiles would add a ref to that
> struct bt_att to perform I/O?

the way I see the kernel evolving is that we either get an L2CAP fd for the fixed ATT channel from accept() or from connect(). Keep in mind that auto-connect from kernel side we get it via accept().

You would hand over the fd to bt_att and mark it as close_on_unref and then just let bt_att handle the whole handling.

Maybe this needs to be two layered and we should have a bt_gatt that takes a fd and bt_att_db for the database. So internally bt_gatt would then use bt_att and bt_add_db. Just an idea at this point.

> It seems to me that we ultimately want an API that is just like
> attrib/gatt.h that uses "struct bt_att" instead of GAttrib. There is
> already a lot of code in attrib/* that is useful for dealing with the
> attribute protocol and I don't really see the point of throwing that
> code away, especially attrib/att.h can be used (at least initially) by
> the new src/shared/att to encode/decode ATT MTUs.
> 
> As for the higher-level GATT interactions: we are clearly moving
> towards a btd_attribute based GATT client/server API. So it makes
> sense to approach this from the top-down. Here is what I propose for a
> step-by-step refactor:
> 
> 1. Add src/shared/att.*. Define struct bt_att as a simple wrapper
> around the file descriptor with basic reference counting logic similar
> to src/shared/mgmt (i.e. bt_att_set_close_on_unref, etc.) only.

Since ATT is one transaction at a time, we can make it even simpler. So I want basic PDU handling here. Something like bt_att_send for request/response and bt_att_register for handling notification. The devil is a bit in the details here, but the way the ATT transactions are defined this should be rather simple in the end.

> 2. Define a new GATT API for remote attribute discovery in src/gatt.*.
> Have the functions take in a struct btd_att pointer. Have all
> attributes represented as btd_attribute. Perhaps get this code tested
> by introducing a new gatttool.

Personally I think we should add an interactive mode to btmgmt and also add ATT/GATT support to btmgmt. My thinking is that bluetoothctl is for D-Bus based APIs and btmgmt will handle the low-level mgmt and socket APIs directly. This will be needed for qualification and low-level testing anyway. So a good idea to confine this into a single tool. Remember that in some cases you want to bring up some GATT DB without having to run bluetoothd.

> 3. Implement the GATT discovery functions by using GAttrib inside
> src/gatt.c at first, calling into the functions in attrib/gatt.h.

I think we might want to establish src/shared/gatt.[ch] with bt_gatt as main entry for client and server handling. As I said above, it can take an bt_att_db or even empty db for no registered services.

So what I am thinking in a really dead simple case you do things like this:

	fd = l2cap_connect_att_over_le(bdaddr, bdaddr_type);

	gatt = bt_gatt_new(fd, NULL);

	bt_gatt_set_close_on_unref(gatt, true);

	bt_gatt_discover(gatt, callback);

	bt_gatt_unref(gatt);

> 4. Partially remove the GAttrib dependency in src/device by having it
> call into the new discovery functions in src/gatt instead of calling
> attrib/gatt functions directly. At this point src/device will probably
> still create the connection using bt_io_connect but it will wrap the
> underlying fd around a "struct bt_att" instead of a GAttrib when
> making calls to src/gatt.
> 
> Here we will remove the call to attrib_from_device (defined in
> src/attrib-server.h) from src/device.c. I don't know if this will
> break anything big, but it seems to be how incoming connections are
> currently being handled. I think this logic has been pretty much taken
> over by the new GATT server code in src/gatt.*, but correct me if I'm
> wrong.
> 
> To prevent breaking the profiles that use attio and GAttrib,
> src/device will keep notifying registered attio callbacks in this
> step. This means that it will probably create a GAttrib simply for the
> purpose of notifying the profiles but it won't use it to call into
> attrib/gatt functions.

We can just establish the basic shared functions for ATT and GATT first and start testing them out in btmgmt tool. Once we now they work, we can modify the daemon code.

> 5. Have the profiles call into the new functions in src/gatt for
> attribute requests instead of using attrib/gatt. This is the step
> where we remove GAttrib from the profiles and modify attio to take in
> a "struct bt_att".
> 
> 6. Remove GAttrib entirely from src/device.
> 
> 7. Remove GIOChannel from src/device by removing calls to
> bt_io_connect and have it create the raw fd directly.
> 
> Sorry for the long email. Let me know if any of the above doesn't make
> sense or if there is a much better/simpler way to approach this. There
> might also be some things that I'm missing, for example there might be
> complexities involving pairing and bonding steps and incoming
> connections. I'm guessing that once step 5 is done we can add the GATT
> D-Bus client API code. With all 7 steps complete, we can then make
> src/gatt not use GAttrib at all and implement a new ATT I/O mechanism
> using "struct bt_att”.

I am pretty open on how many steps we want to take at a time or what we want to do later. What I know for sure is that I want to rid of GIOChannel and BtIO usage and GLib.

Regards

Marcel

