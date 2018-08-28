Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: BlueZ: How to avoid fixed Coordinate Invalid Curve Attack
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <AM6PR0402MB38483C66931FD452B32A8096940A0@AM6PR0402MB3848.eurprd04.prod.outlook.com>
Date: Tue, 28 Aug 2018 20:35:32 +0200
Cc: Andy Duan <fugang.duan@nxp.com>,
        "rtatiya@codeaurora.org" <rtatiya@codeaurora.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <2C1879AB-5D93-4F31-BC7A-4DFBBC946A3A@holtmann.org>
References: <VI1PR0402MB3600BAF04C81783B3A119AB6FF0A0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <2A6353B1-324D-4D3B-BE3F-F06DE314961B@holtmann.org>
 <AM6PR0402MB38483C66931FD452B32A8096940A0@AM6PR0402MB3848.eurprd04.prod.outlook.com>
To: NXP psirt <psirt@nxp.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Asim,

> Is this the patch you are referring to?
> 
> https://patchwork.kernel.org/patch/9976233/

no it is not. The patch you are looking for is this:

commit ea169a30a6bf6782a05a51d2b9cf73db151eab8b
Author: Stephan Mueller <smueller@chronox.de>
Date:   Mon Jun 25 12:00:18 2018 +0200

    crypto: ecdh - add public key verification test

It follows closely the NIST recommendation for public key remmomen
Regards

Marcel
