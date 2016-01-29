Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: Add missing COMPATIBLE_IOCTL for UART line discipline
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAA+NYvQ35ZoSRy8dEfctXWpfkAN4NuckFnMobdcwjW4hS7ei0g@mail.gmail.com>
Date: Fri, 29 Jan 2016 11:44:26 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EB5B11A1-B0CC-4C3D-92F3-689BA44D158F@holtmann.org>
References: <1453707843-92704-1-git-send-email-marcel@holtmann.org> <20160127154921.GA13196@t440s> <CAA+NYvQ35ZoSRy8dEfctXWpfkAN4NuckFnMobdcwjW4hS7ei0g@mail.gmail.com>
To: Jaap Jan Meijer <jjmeijer88@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaap,

> Could you please also add
> "[PATCH] Bluetooth: hci_ldisc: Add support for compat_ioctl handling"
> to get proper ioctl compat functionality?
> 
> Many thanks in advance,

are you sure that is really needed? I do wonder why we need that. At least with COMPATIBLE_IOCTL the error message should actually change. Can you trace how far we get in the code path.

Regards

Marcel

