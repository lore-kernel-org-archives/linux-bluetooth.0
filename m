Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth:ath3k&btusb: Add support for Qualcomm Atheros
 3006 composite device
From: Marcel Holtmann <marcel@holtmann.org>
To: "Yao, Costa" <cqyao@qca.qualcomm.com>
Cc: "padovan@profusion.mobi" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 08 Nov 2011 15:16:03 +0900
In-Reply-To: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C62@nasanexd02b.na.qualcomm.com>
References: <07BBB2AAB1A10A488A2AD166C7CB8B0DEE9C62@nasanexd02b.na.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320732967.15441.314.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Costa,

> From 312e18c8c46527cb7213fa57afc32094cdc9459c Mon Sep 17 00:00:00 2001
> From: Costa yao <cqyao@qca.qualcomm.com>
> Date: Thu, 3 Nov 2011 14:45:33 +0800
> 
> 
> AR3006 is a composite device, and interface 0 is used for hid function, not bluetooth function.
> So, we should make the following changes:
> 1  Blacklist AR3006 PID/VID in btusb and ath3k to load patch and sysconfig files
> 2  Add composite_device_table in btusb.c and ath3k_composite_device_table in ath3k.c
>     to check whether it is bluetooth interface
> 3  interface 3 is used for data->isoc

please send proper formatted patch. This one is all messed up and I am
not even trying to review it.

Also split this at least into 2 patches, one for btusb.c and one for the
ath3k.c changes.

Regards

Marcel


