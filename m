Return-Path: <dcb314@hotmail.com>
From: David Binderman <dcb314@hotmail.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: drivers/bluetooth/dtl1_cs.c:559: bad if statement ?
Date: Tue, 15 Nov 2016 10:42:40 +0000
Message-ID: <VI1PR08MB1022A48C7808FE88DB66059D9CBF0@VI1PR08MB1022.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hello there,

drivers/bluetooth/dtl1_cs.c:559:32: warning: logical =91or=92 of collective=
ly exhaustive tests is always true [-Wlogical-op]

Source code is

    if ((p_dev->resource[1]->end) || (p_dev->resource[1]->end < 8))
        return -ENODEV;

Maybe better code

    if ((p_dev->resource[1]->end < 0) || (p_dev->resource[1]->end >=3D 8))
        return -ENODEV;

Regards

David Binderman
