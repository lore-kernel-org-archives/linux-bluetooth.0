Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Seblu <seblu@seblu.net>
Date: Wed, 9 May 2012 00:21:02 +0200
Message-ID: <CAJSTwE5EQnKkfgA4e7JeKNK3FUjyY_UU-G7OUia25rQDMdgBww@mail.gmail.com>
Subject: Bluetooth led not synced with hciconfig status since ca0d6c7ece
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Since the commit ca0d6c7ece0e78268cd7c5c378d6b1b610625085 [1], the
bluetooth led on my dell latitude e6410 is no more synced with the
hciconfig hci0 down or up status.

I reverted the commit on top of 3.3.4 and led is synced again. I
suppose we should add dell latitude e6410 on a quirk list?

[1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=ca0d6c7ece0e78268cd7c5c378d6b1b610625085

Cheers,

-- 
Sébastien Luttringer
www.seblu.net
