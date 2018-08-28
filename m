Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: BlueZ: How to avoid fixed Coordinate Invalid Curve Attack
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <VI1PR0402MB3600BAF04C81783B3A119AB6FF0A0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
Date: Tue, 28 Aug 2018 11:56:26 +0200
Cc: "rtatiya@codeaurora.org" <rtatiya@codeaurora.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Asim Zaidi <asim.zaidi@nxp.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <2A6353B1-324D-4D3B-BE3F-F06DE314961B@holtmann.org>
References: <VI1PR0402MB3600BAF04C81783B3A119AB6FF0A0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
To: Andy Duan <fugang.duan@nxp.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> Do you have patches for BlueZ to avoid Bluetooth curve attack ?
> 
> As I know, Many vendors supply Android Flueride host fixes & Firmware fixes to avoid the curve attack, but BlueZ community doesn’t have the topic. Does there have plan to fix the hole ? 

the Linux kernel crypto subsystem and its ECDH support has a patch to ensure that the public key is validated before calculating the shared secret.

Regards

Marcel
