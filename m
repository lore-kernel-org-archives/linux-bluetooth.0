Return-Path: <cyrus@holtmann.org>
From: "Sumangala, Suraj" <surajs@qca.qualcomm.com>
To: "Johan Hedberg (johan.hedberg@gmail.com)" <johan.hedberg@gmail.com>
CC: "Marcel Holtmann (marcel@holtmann.org)" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: using management interface from WiFi driver
Date: Thu, 1 Sep 2011 08:09:09 +0000
Message-ID: <480687D4EEFE7447A2E09AADFF6673621AF82890@nasanexd02a.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

I am working on a Bluetooth -WiFi coex mechanism in our WiFi kernel driver =
which would like get information regarding certain ongoing Bluetooth operat=
ions to manage BT-WiFI shared resources.
Some of the operations we are interested are inquiry status, SCO, A2DP stre=
aming status.

Is there any API exported by the management interface that I can call in my=
 WiFi device driver so as to get information like "Is SCO connected?" or "I=
s inquiry going on?" etc?

Regards
Suraj
