Return-Path: <cyrus@holtmann.org>
Date: Sat, 25 Jan 2014 17:12:03 -0500
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/2] Basic [sg]etsockopt() testing in l2cap-tester
Message-ID: <20140125221203.GA14531@x220.p-661hnu-f1>
References: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390614842-28379-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Jan 24, 2014, Anderson Lizardo wrote:
> These patches extend existing tests in l2cap-tester to exercise two common
> operations on LE sockets:
> 
> * getsockopt(BT_SECURITY) on client side (to set security level)
> * setsockopt(L2CAP_OPTIONS) on server side (called by bt_io_get())
> 
> At the moment, there is a regression on kernel introduced by commit
> a5a1e0e6b9c1dea3696192b5ec153d03917eb7b8 ("Bluetooth: Switch ATT channels to
> use L2CAP_CHAN_FIXED") which is affecting these two operations. I'm currently
> implementing and testing fixes for this regression.

I pushed your first patch and a slightly different version of the
second one which is more thorough in its checks. I also sent fixes for
the kernel side so you don't need to spend more time on that (unless you
disagree with the fixes I sent).

Johan
