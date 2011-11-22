Return-Path: <cyrus@holtmann.org>
Message-ID: <1321947673.2011.21.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: btusb: Add AR3006 in blacklist_table
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 22 Nov 2011 08:41:13 +0100
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF417E@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEF417E@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> From c21eede5fafd811fdf6c100693a07a64f621ddea Mon Sep 17 00:00:00 2001
> From: Costa Yao <cqyao@qca.qualcomm.com>
> Date: Fri, 18 Nov 2011 14:08:56 +0800
> Subject: [PATCH] Bluetooth: btusb: Add AR3006 in blacklist_table.

why do we have this twice here. Please fix your mail system. It is not
Gustavo's job to fix up your emails.

> Add AR3006 entry in blacklist_table in btusb.c for bcdDevice check.
> Then ath3k.c has the chance to download firmware and reset hardware.
> 
> Signed-off-by: Costa Yao <cqyao@qca.qualcomm.com>

And as I said once I acked it you can carry that ack around. You are
making the life of the maintainers extra hard here.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


