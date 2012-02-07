Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAA37ika1p7nHs97Nu3kmS5ARK7qjGA0RtHSVeq9+FJ8pF745bw@mail.gmail.com>
References: <1328539133-26410-1-git-send-email-luiz.dentz@gmail.com>
	<201202071221.51920.szymon.janc@tieto.com>
	<CAA37ikZSaELhgHmU53jYA==B-11PPiAxVnKxuEjHQMaQiddZCw@mail.gmail.com>
	<201202071302.59506.szymon.janc@tieto.com>
	<CAA37ika1p7nHs97Nu3kmS5ARK7qjGA0RtHSVeq9+FJ8pF745bw@mail.gmail.com>
Date: Tue, 7 Feb 2012 15:28:01 +0200
Message-ID: <CABBYNZJ8rRS6C_2bsiH9fBRT8-OmLZW5P7MKCSvKp9tC2X2cJw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix not clearing ack timer when sending an i-frame
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Tue, Feb 7, 2012 at 2:37 PM, Ulisses Furquim <ulisses@profusion.mobi> wrote:
>> Well, if ack timer is running we have sth to ack. Isn't that enough?
>
> That should be the case. When ack timer is running we have something
> to ack. The point is answering if we still have pending acks to send.
> And that's being answered by the return of calling l2cap_ertm_send()
> which was wrong until now and I don't think it's a good idea. Marcel,
> any opinions on that? Luiz?

For now I would just try to fix current code upstream without changing
too much the logic and risk more regressions. Im afraid we gonna have
to change quite a bit ertm code for next releases but we have
obexd/obex-client to test regressions so it should be easier to test
this code, so perhaps Szymon fix should be applied before its too late
to do a pull request.

Btw, here is what Ive been using to test this code:

> obexd/tools/test-server -b -c 4097 -p -i 32767 -o 32767

> obexd/tools/test-client -b -s <address of source adapter> -d <address of destination adapter> -c 4097 -p -i 32767 -o 32767

Im using 32767 as MTU because that is what we use by default in OBEX,
but currently it doesn't work due to some bug in ERTM that apparently
doesn't handle MTU being bigger than mts * tx_win, so the transfer
just stall at some point, using something like 16384 works though.

-- 
Luiz Augusto von Dentz
