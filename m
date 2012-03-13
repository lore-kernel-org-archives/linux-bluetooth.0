Return-Path: <cyrus@holtmann.org>
Message-ID: <1331651751.14217.93.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix broken usage of get_unaligned_le16
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 13 Mar 2012 08:15:51 -0700
In-Reply-To: <20120313072933.GA15895@aemeltch-MOBL1>
References: <1331609468-22906-1-git-send-email-marcel@holtmann.org>
	 <20120313072933.GA15895@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > In case the struct is already __packed, there is no need to use unaligned
> > access to the data. So just use __le16_to_cpu in these cases.
> 
> One minor comment related to use of __xxx versions. What is the general
> rule when to use __le16_to_cpu and when le16_to_cpu? In mgmt.c looks that
> mostly in use version without underscore.

honestly I do not know. We have been using __le16_to_cpu and cpu_to_le16
as long as I can remember.

Regards

Marcel


