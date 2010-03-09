Return-Path: <cyrus@holtmann.org>
Subject: Re: [patch] bluetooth: storing negative values as unsigned char
From: Marcel Holtmann <marcel@holtmann.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Bing Zhao <bzhao@marvell.com>, Rahul Tank <rahult@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20100308121559.GG6469@bicker>
References: <20100308121559.GG6469@bicker>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Mar 2010 16:54:50 -0800
Message-ID: <1268096091.3712.30.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> This is mostly cleanup.  There is only one caller and it just checks for 
> non-zero return values.  Still "ret" should be int because we want to return 
> -EINVAL on errors.

patch has been applied. Thanks.

Regards

Marcel


