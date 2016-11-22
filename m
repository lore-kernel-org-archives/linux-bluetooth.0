Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: drivers/bluetooth/dtl1_cs.c:559: bad if statement ?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <VI1PR08MB1022A48C7808FE88DB66059D9CBF0@VI1PR08MB1022.eurprd08.prod.outlook.com>
Date: Tue, 22 Nov 2016 22:49:38 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <3184A4EA-4F3C-4CBC-AAA1-355CB62B5DE2@holtmann.org>
References: <VI1PR08MB1022A48C7808FE88DB66059D9CBF0@VI1PR08MB1022.eurprd08.prod.outlook.com>
To: David Binderman <dcb314@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> drivers/bluetooth/dtl1_cs.c:559:32: warning: logical ‘or’ of collectively exhaustive tests is always true [-Wlogical-op]
> 
> Source code is
> 
>    if ((p_dev->resource[1]->end) || (p_dev->resource[1]->end < 8))
>        return -ENODEV;
> 
> Maybe better code
> 
>    if ((p_dev->resource[1]->end < 0) || (p_dev->resource[1]->end >= 8))
>        return -ENODEV;

mind sending a patch?

Regards

Marcel
