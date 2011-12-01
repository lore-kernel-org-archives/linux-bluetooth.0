Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 1 Dec 2011 21:51:11 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btusb: Add AR3006 in blacklist_table
Message-ID: <20111201125111.GD2894@joana>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF417E@nasanexd02b.na.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF417E@nasanexd02b.na.qualcomm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

* Yao, Costa <cqyao@qca.qualcomm.com> [2011-11-22 02:49:50 +0000]:

> From c21eede5fafd811fdf6c100693a07a64f621ddea Mon Sep 17 00:00:00 2001
> From: Costa Yao <cqyao@qca.qualcomm.com>
> Date: Fri, 18 Nov 2011 14:08:56 +0800
> Subject: [PATCH] Bluetooth: btusb: Add AR3006 in blacklist_table.
> 
> Add AR3006 entry in blacklist_table in btusb.c for bcdDevice check.
> Then ath3k.c has the chance to download firmware and reset hardware.
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)

There is still something wrong with your patch. 

Applying: Bluetooth: btusb: Add AR3006 in blacklist_table
error: patch failed: drivers/bluetooth/btusb.c:54
error: drivers/bluetooth/btusb.c: patch does not apply
Patch failed at 0001 Bluetooth: btusb: Add AR3006 in blacklist_table
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Please fix your patch and resend.

	Gustavo
