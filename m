Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix incorrect alignment in Marvell
 BT-over-SDIO driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1247078654-8666-1-git-send-email-bzhao@marvell.com>
References: <1247078654-8666-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain
Date: Wed, 08 Jul 2009 11:54:16 -0700
Message-Id: <1247079256.9709.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> The driver uses "u32" for alignment check and calculation which
> works only on 32-bit system. It will crash the 64-bit system.
> Replace "u32" with "unsigned long" to fix this issue.

I pushed that patch into the bluetooth-mrvl-2.6 tree now.

However I am pretty sure that are better "Linux" ways on handling the
alignment for the SKBs.

Regards

Marcel


