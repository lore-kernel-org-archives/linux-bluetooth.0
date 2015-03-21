Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 3/6] btwilink: add minimal device tree support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426915068-10371-1-git-send-email-gigi.joseph@ti.com>
Date: Fri, 20 Mar 2015 22:21:17 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Gigi Joseph <gigi.joseph@ti.com>, Eyal Reizer <eyalr@ti.com>,
	bvijay <bvijay@ti.com>
Message-Id: <7C323026-5997-47FF-A872-004FB55A0428@holtmann.org>
References: <C03A9F83-A4A3-424A-B50C-D6A9630705C8@holtmann.org> <1426915068-10371-1-git-send-email-gigi.joseph@ti.com>
To: Gigi Joseph <gigi.joseph@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gigi,

> Add minimal device tree support to the btwilink driver that is used
> for binding bluetooth with the ti-st shared transport driver.
> 
> Signed-off-by: Eyal Reizer <eyalr@ti.com>
> Signed-off-by: bvijay <bvijay@ti.com>
> Signed-off-by: Gigi Joseph <gigi.joseph@ti.com>
> ---
> Changes in v2:
> 	* Reformat device_id table to match other drivers
> 	* Add empty line before MODULE_DEVICE_TABLE
> 
> drivers/bluetooth/btwilink.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)

I was wondering if you do not want to document this Documentation/devicetree/bindings/ or some place on what this entries actually means and how you use it.

Regards

Marcel

