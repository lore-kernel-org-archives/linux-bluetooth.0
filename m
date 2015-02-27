Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 27 Feb 2015 13:02:19 +0100
Message-ID: <CADDKRnAd4HCS80X+88fMB7C83bf13EKs8=CC9ZPa7amvpsQBPw@mail.gmail.com>
Subject: [V4.0] Regression: Support for Bluetooth Adapter dropped.
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth has ever been working on my Notebook. I successfully
use Bluetooth mouse and Obex file transfer for years. And with
Kernel V4.00 the Adapter is no longer recognized.

It is an Intel 8087:07da.

The first bad commit is:
commit d0ac9eb72b6dceae318c15ee82ef2aaee233666d
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Wed Jan 28 19:41:43 2015 -0800

    Bluetooth: btusb: Ignore unknown Intel devices with generic descriptor

Can you please revert that commit?

Thanks, J=C3=B6rg
