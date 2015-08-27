Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Thu, 27 Aug 2015 10:34:58 +0200
Message-ID: <CAEZxfGP=P-5J_CFkwN6u=b+au7FcELCbXU_SSzomraFCC6UK9w@mail.gmail.com>
Subject: Bluez 5.33 won't connect to advertising Nexus 6
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello!

Bluez 5.33 allows me to connect to my Nexus 6 on chromebook A but not
chromebook B. Here's the full steps to reproduce the issue:

1. Install https://play.google.com/store/apps/details?id=io.github.webbluetoothcg.bletestperipheral
on Nexus 6
2. Run it and advertise Battery Service
3. Open Chrome OS Shell bluetooth console [Ctrl] + [Alt] + T and:
crosh> bt_console
4. Scan for devices until Nexus 6 appears and turn it off.
[bluetooth]# scan on
[bluetooth]# scan off
5. Connect to Nexus 6 wit the appropriate BT address:
[bluetooth]# connect 63:7B:C2:07:EF:AD
Attempting to connect to 63:7B:C2:07:EF:AD

If you're lucky, you'll see "Connection successful".
If not, you'll get "Failed to connect: org.bluez.Error.Failed"

More background at
https://code.google.com/p/chromium/issues/detail?id=508541#c15

I'd like to figure out what is happening behind the scenes there.
Here's a btsnoop.log file in case it
helps:https://www.cloudshark.org/captures/dcb775e24f91
