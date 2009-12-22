Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 04/10] bluetooth: add __init/__exit macros to
 drivers/bluetooth/btmrvl_sdio.c
From: Marcel Holtmann <marcel@holtmann.org>
To: peterhuewe@gmx.de
Cc: Jiri Kosina <trivial@kernel.org>, kernel-janitors@vger.kernel.org,
	Bing Zhao <bzhao@marvell.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	=?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
	Julia Lawall <julia@diku.dk>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <1261470861-23988-1-git-send-email-peterhuewe@gmx.de>
References: <1261470861-23988-1-git-send-email-peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Dec 2009 00:43:42 -0800
Message-Id: <1261471422.4041.200.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> From: Peter Huewe <peterhuewe@gmx.de>
> 
> Trivial patch which adds the __init/__exit macros to the module_init/
> module_exit functions of
> 
> drivers/bluetooth/btmrvl_sdio.c
> 
> Please have a look at the small patch and either pull it through
> your tree, or please ack' it so Jiri can pull it through the trivial
> tree.

patch has been applied to my tree. Thanks.

Regards

Marcel


