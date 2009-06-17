Return-Path: <cyrus@holtmann.org>
From: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Date: Wed, 17 Jun 2009 18:19:41 +0530
Subject: HSP Ring command
Message-ID: <44EE5C37ADC36343B0625A05DD408C485068E39C2B@CHEXMB-01.global.atheros.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
I am running HSP profile test cases with PTS tool.
I am using Ubuntu 9.04 with Bluez 4.32.

For all HSP test cases, PTS is expecting RING command from IUT.
>From our analysis, headset_send(hs, "\r\nRING\r\n"); " in audio/headset.c i=
s not getting initiated.
I am thinking, RING command is suppose to send by dbus as we register the c=
all backs. But dbus is not triggering the RING command.
Is this expected behavior in BlueZ?
What version of BlueZ and dbus do we need to use for better performance?

Please clarify.

Thanks,
Jothi
