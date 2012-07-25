Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 24 Jul 2012 22:57:28 -0400
Message-ID: <CANM+e8yPJhe1anFTsTQYqmQf2k8BfRTgKrhsNkaWrRVdG=ybkA@mail.gmail.com>
Subject: sdp.h correction and update
From: Zoltan Csik <zicsik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bluez-4.99\lib\sdp.h
Line 98: #define VIDEO_CONF_SVCLASS_ID          0x110f

doesn't match with the latest SIG assigned numbers list:
"A/V_RemoteControlController    0x110F  Audio/Video Remote Control Profile
(AVRCP) Service Class           NOTE: The AVRCP specification v1.3 and later
require that 0x110E also be included in the ServiceClassIDList before
0x110F for backwards compatibility.     "

Also according to above referenced list there are some service
class_ID definitions missing from sdp.h:
Headset - HS                 0x1131 Headset Profile (HSP)
Message Access Server        0x1132 Message Access Profile (MAP)
Message Notification Server  0x1133 Message Access Profile (MAP)
Message Access Profile       0x1134 Message Access Profile (MAP)
GNSS                         0x1135 Global Navigation Satellite System
Profile (GNSS)
GNSS_Server                  0x1136 Global Navigation Satellite System
Profile (GNSS)

Thank you,
Zoltan
