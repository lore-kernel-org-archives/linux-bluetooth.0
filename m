Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <a172fe730901120058g49333ea7o2e07f34ab0e4f4d6@mail.gmail.com>
References: <a172fe730901120058g49333ea7o2e07f34ab0e4f4d6@mail.gmail.com>
Date: Mon, 12 Jan 2009 17:08:02 +0800
Message-ID: <a172fe730901120108n27b21584ydec4107cf8b7f469@mail.gmail.com>
Subject: disconnect incoming ACL connection
From: =?GB2312?B?seXA2g==?= <mykofzone@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
    I'm debugging Qtopia bluetooth in my EVB, and found this issue:
    If it is a incoming HFP connection, after pressed "Disconnect
HFP", the Qtopia only release rfcomm device and disconnect rfcomm
connection, and the ACL incoming connection can't be
disconnected(check this by 'hcitool con'). Is this a bug or something
else? Thanks. And happy new year!
    My develop environment:
    kernel : 2.6.18.8 + some patches
    BlueZ : 3.26
    BT HW : STLC2500
    Headset : iTech

BR.
LeiBian
2008-12-31
