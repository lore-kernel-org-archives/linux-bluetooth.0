Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
References: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
Date: Fri, 17 Apr 2015 14:55:27 +0300
Message-ID: <CABBYNZKj4xMXJP56g8j52zxddB_tfVg9GfM23YHdGFa6zonbMg@mail.gmail.com>
Subject: Re: [V4.1] Regression: Bluetooth mouse not working.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi J=C3=B6rg,

On Fri, Apr 17, 2015 at 12:36 PM, J=C3=B6rg Otte <jrg.otte@gmail.com> wrote=
:
> The BT mouse is "death" in v4.1.
> The BT mouse has been working in 4.0 and previous kernels, so this
> is a regression.
>
> BT adapter is an intel 8087:07da. The mouse is an MS Notebook Mouse 500.
>
> It just doesn't work without any errors displayed in dmesg.

We might need some logs, bluetoothd logs and btmon trace, to start
with, I don't recall any recent changes in HID just in HoG (Bluetooth
LE/Smart) which uses uHID.


--=20
Luiz Augusto von Dentz
