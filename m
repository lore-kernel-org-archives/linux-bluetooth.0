Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/4 v2] bluetooth: add btmrvl driver to support Marvell
 bluetooth devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1243640590-31666-1-git-send-email-bzhao@marvell.com>
References: <1243640590-31666-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain
Date: Sat, 30 May 2009 09:09:20 +0200
Message-Id: <1243667360.3523.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> This driver provides basic definitions and library functions to
> support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
> combo chip.

we still have to talk about the handling of vendor commands. Handling
these inside the driver is a bad idea. We can just let the core forward
them to you if you are interested. I have to think about it a little
bit.

> +struct btm_thread {
> +	struct task_struct *task;
> +	wait_queue_head_t wait_q;
> +	void *priv;
> +};

Please prefix everything with btmrvl_* for cleaner namespace. Especially
for the exported symbol it is important that you have a clean namespace.

Regards

Marcel


