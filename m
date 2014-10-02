Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLBVPswz2C7xQMN4XCk4Dw+V4mZ08v65iQ+jfH7WmDpLQ@mail.gmail.com>
References: <1412163494-20283-1-git-send-email-luiz.dentz@gmail.com>
	<1412163494-20283-2-git-send-email-luiz.dentz@gmail.com>
	<20141001123408.GA26432@t440s.lan>
	<CABBYNZLK6JfiQWp+pNK8+Pg-YOcShrm4TcbwHdnAKtbfhOcJmg@mail.gmail.com>
	<CAHrH25T1FqMi7zho+gYCbuhmdQpsVoqV5ee3H+UbZwwhqeNC9A@mail.gmail.com>
	<CABBYNZLBVPswz2C7xQMN4XCk4Dw+V4mZ08v65iQ+jfH7WmDpLQ@mail.gmail.com>
Date: Thu, 2 Oct 2014 11:36:35 -0700
Message-ID: <CAHrH25SGArD8cOjs4-1ZxDVhNKG6+=k7BhaDSrS3yunOasyv7g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] shared/gatt-client: Take fd in bt_gatt_client_new
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> Right, it might make the code more modular but also allow mistakes
> such as creating 2 different instances of bt_att for handling client
> and server separately.
>

Yeah. I think overall libshared is going to be mostly a set of tools
that are flexible enough to be put together in different ways based on
platform needs. You can imagine an embedded peripheral platform that
doesn't even run bluetoothd but instead simply uses btmgmt and
bt_gatt_server. So, I like to think of the shared/ directory as a
flexible library collection of sorts, though it may be just me.


> Actually we should probably notify a error response otherwise it may
> call destroy which gives no hint what happened with the call itself,
> but now I figure you actually have a timeout callback which can be
> used but it is not per operation and I can only register one at time
> so I cannot register one in gatt-client.c otherwise it may get
> overwritten, perhaps we should add a timeout callback to bt_att_send
> or just remove since disconnect callback should be called anyway and
> that can be registered by gatt-client.c.
>

Yeah, actually in my first patches for bt_att, the
bt_att_response_func_t had a "bool timeout" parameter. I later added a
bt_att_register_timeout in the bt_att_register_disconnect fashion,
though Marcel suggested to have a single handler for now. I don't
really know what the right thing to do is here but since there isn't
really a good way to recover from a timeout other than a disconnect,
maybe just invoking disconnect_callback would be sufficient.


> Btw, I resend the patches skipping this one, please check if they are
> no breaking anything for you.
>

Just tried your patches and bt_gatt_client seems to work fine for me.

Cheers,
Arman
