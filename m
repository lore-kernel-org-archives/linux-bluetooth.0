Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMPA5gdEvk-yft+tLdmmSpGii2320sTymJoAaemLhco8cFOrDQ@mail.gmail.com>
References: <CAMPA5gdEvk-yft+tLdmmSpGii2320sTymJoAaemLhco8cFOrDQ@mail.gmail.com>
Date: Mon, 11 May 2015 10:44:11 +0300
Message-ID: <CABBYNZL1SYZK7fBbPL=2pn_MMKvVXGQHekgDWJyak1edwnn+0A@mail.gmail.com>
Subject: Re: Can I develop a GATT server under 4.66?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Joshua Kramer <joskra42.list@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joshua,

On Mon, May 11, 2015 at 2:03 AM, Joshua Kramer <joskra42.list@gmail.com> wrote:
> Hello,
>
> For reasons I can't control I may be stuck with Bluez 4.66 (the
> version included with RedHat EL 6).  Does this version of Bluez
> support creating a peripheral device?  If so, is there a tutorial on
> how to compile and link a plugin for bluetoothd that will provide GATT
> services?

Sorry this might be too old so you would probably have to rebase
everything from BlueZ 5, also you might need to backport the kernel
patches as well anyway but perhaps you can find something in the
compat tree.


-- 
Luiz Augusto von Dentz
