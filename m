Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Bluez 5.33 won't connect to advertising Nexus 6
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEZxfGP=P-5J_CFkwN6u=b+au7FcELCbXU_SSzomraFCC6UK9w@mail.gmail.com>
Date: Thu, 27 Aug 2015 12:55:27 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7D13E5DD-914F-4E8B-8724-0E40B604DD36@holtmann.org>
References: <CAEZxfGP=P-5J_CFkwN6u=b+au7FcELCbXU_SSzomraFCC6UK9w@mail.gmail.com>
To: =?utf-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francois,

> Bluez 5.33 allows me to connect to my Nexus 6 on chromebook A but not
> chromebook B. Here's the full steps to reproduce the issue:
> 
> 1. Install https://play.google.com/store/apps/details?id=io.github.webbluetoothcg.bletestperipheral
> on Nexus 6
> 2. Run it and advertise Battery Service
> 3. Open Chrome OS Shell bluetooth console [Ctrl] + [Alt] + T and:
> crosh> bt_console
> 4. Scan for devices until Nexus 6 appears and turn it off.
> [bluetooth]# scan on
> [bluetooth]# scan off
> 5. Connect to Nexus 6 wit the appropriate BT address:
> [bluetooth]# connect 63:7B:C2:07:EF:AD
> Attempting to connect to 63:7B:C2:07:EF:AD
> 
> If you're lucky, you'll see "Connection successful".
> If not, you'll get "Failed to connect: org.bluez.Error.Failed"
> 
> More background at
> https://code.google.com/p/chromium/issues/detail?id=508541#c15
> 
> I'd like to figure out what is happening behind the scenes there.
> Here's a btsnoop.log file in case it
> helps:https://www.cloudshark.org/captures/dcb775e24f91

try an info on the bluetooth console and it should tell you what chip you have locally on your Chromebook and compare them with each other. If you want to do that in a real terminal, hciconfig -a please.

For me this looks pretty much like a firmware issue. You could use an over-air-analyzer like Ellisys to really see why the connection does not establish.

However since you are running this against the Nexus 6 with multi-advertising Broadcom specific vendor feature, you are moving into territory that is actually not covered by a Bluetooth standard and its qualification testing. So I would blame whoever insisted on relying on vendor stuff for Android LE peripheral mode.

It could be also if this is really Broadcom vs Broadcom on both sides, that the firmware tries to outsmart itself ;)

Regards

Marcel

