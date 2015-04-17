Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 17 Apr 2015 11:36:09 +0200
Message-ID: <CADDKRnBzf+dPqzHxXBWynwssc4su-7LVDCteZCNJJXJEuVca0w@mail.gmail.com>
Subject: [V4.1] Regression: Bluetooth mouse not working.
From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

The BT mouse is "death" in v4.1.
The BT mouse has been working in 4.0 and previous kernels, so this
is a regression.

BT adapter is an intel 8087:07da. The mouse is an MS Notebook Mouse 500.

It just doesn't work without any errors displayed in dmesg.

Thanks, J=C3=B6rg
