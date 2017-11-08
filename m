Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Dogiel Pawel <Pawel.Dogiel@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: 6loWPAN IPSP devices fail to communicate (bluetooth-next 4.14.0-rc7 )
Date: Wed, 8 Nov 2017 12:40:00 +0000
Message-ID: <AMSPR04MB2967B540C13E7F755F74E7E9B560@AMSPR04MB296.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have issue with IPSP devices over 6loWPAN on kernel 4.14.0-rc7.

The thing is that when i connect My Linux machine (with forwarding enabled)=
 to one IPSP device using 'debugfs' interface the communication is OK. Ping=
s are working, the CoAP Server responds well.
But when second IPSP device is connected (CoAP client in this example) then=
 neither CoAP Server is responding nor pings are working on any IPSP device=
 ('resource unreachable').

Please help

Regards,
Pawel
