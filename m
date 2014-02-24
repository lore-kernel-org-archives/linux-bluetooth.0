Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] android/pics: Add PICS and PIXIT for HSP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393242895-19447-1-git-send-email-sebastian.chlad@tieto.com>
Date: Mon, 24 Feb 2014 09:57:14 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <6632C143-D06A-48DC-A403-FDE4B40AB1B5@holtmann.org>
References: <1393242895-19447-1-git-send-email-sebastian.chlad@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

> Added PICS and PIXIT target Android 4.4
> ---
> android/Makefile.am   |   2 +
> android/pics-hsp.txt  | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
> android/pixit-hsp.txt |  30 +++++++++++++++
> 3 files changed, 135 insertions(+)
> create mode 100644 android/pics-hsp.txt
> create mode 100644 android/pixit-hsp.txt

so we are doing Headset profile (HSP) and also Handsfree profile (HFP). I am fine with also doing HSP since it seems that is what Android uses on tablets.

Regards

Marcel

