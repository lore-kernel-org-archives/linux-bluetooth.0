Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/4] Bluetooth: hci_uart: various fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
Date: Tue, 30 Aug 2016 09:48:13 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, jason.abele@gmail.com
Message-Id: <0649B498-A8BC-42D1-8F70-07B3C8CAB8E2@holtmann.org>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Boris,

> We recently faced some problems when using an BT uart chip interfaced
> through the H5 proto (rtk_h5). Here are the logs of the 2 different
> issues we had when closing the line discipline (actually, restoring
> the previous one) [1][2]. I know the kernel is Tainted in those logs,
> but after some investigations I found a few potential issues that might
> explain what we're seeing.

while I can look through these patches, but I wonder when we are finally getting a full and proper RTK support that doesn't use these hackish hciattach code I have seen.

I mean the only thing userspace should be doing is attaching the line discipline and then everything else should run inside the kernel. Attaching the line discipline is the same as plugging in an USB dongle. Detaching it is the same as unplugging the dongle. That is how we should treat it. So for the lifetime of a system it should never detach. All the power control etc. should be done inside the kernel. Same as how we have done it for Broadcom and Intel devices.

Regards

Marcel
