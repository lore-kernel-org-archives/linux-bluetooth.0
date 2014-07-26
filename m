Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <6DBCE20A-3015-4B1D-A4AC-B3DF786D2D58@holtmann.org>
References: <1406326123-10564-1-git-send-email-armansito@chromium.org>
	<1406326123-10564-4-git-send-email-armansito@chromium.org>
	<6DBCE20A-3015-4B1D-A4AC-B3DF786D2D58@holtmann.org>
Date: Sat, 26 Jul 2014 13:03:47 -0700
Message-ID: <CAHrH25TVTc1mo02dvX-B3ggrUJy9MmYvKWk1xuLpevzr-435=A@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] shared/gatt: Implement "Discover All Primary
 Services" procedure.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I think we need to fix bt_att_send to return false when we got disconnect=
ed in between the individual commands. I did run some tests with the code h=
ere and if we receive a disconnect, we get stuck and the callback is never =
called. So when we have running longer procedures, we need to handle the ca=
ses where we loose the connection in the middle of it.
>

I'm actually aware of this issue and was trying to decide who is
responsible for handling disconnects. I'm guessing that bt_att can use
io_set_disconnect_handler to crate a handler for this case, in which I
guess the right thing to do is to mark the bt_att structure as
invalidated, cancel all pending ATT operations, and perhaps notify the
user with a special callback (similar to the timeout callback)? The
user will then have to create a new connection and pass the fd to
bt_att_new to obtain a new instance.

Does that make sense or is there a better place to handle disconnects
in general?

-Arman
