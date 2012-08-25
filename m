Return-Path: <cyrus@holtmann.org>
Message-ID: <50390B54.4040706@shealevy.com>
Date: Sat, 25 Aug 2012 13:28:52 -0400
From: Shea Levy <shea@shealevy.com>
MIME-Version: 1.0
To: Henrik Rydberg <rydberg@euromail.se>
CC: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add support for Apple vendor-specific devices
References: <1345915686-3915-1-git-send-email-rydberg@euromail.se>
In-Reply-To: <1345915686-3915-1-git-send-email-rydberg@euromail.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

On 08/25/2012 01:28 PM, Henrik Rydberg wrote:
> +	/* Apple-specific (Broadcom) devices */
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x05ac, 0xff, 0x01, 0x01) },
> +
>

Would this subsume https://lkml.org/lkml/2012/8/22/689 ?

Thanks,
Shea Levy
