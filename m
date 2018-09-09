Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Dag Bakke <dag@bakke.com>
Subject: BLE5 Long Range Coded PHY
To: linux-bluetooth@vger.kernel.org
Message-ID: <3fd57520-85b0-ae07-e1d1-dec6e9cf23eb@bakke.com>
Date: Sun, 9 Sep 2018 16:07:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.


I am looking at BLE5 Long Range applications, and would like to know the
status of support for this in bluez and relevant kernel modules.
Scanning the mailing list revealed some patches at least acknowledging
the existence of coded PHY, but that was about it.

BLE5 has two "long range" bitrates, at 125 and 500 kbps. (AKA BLE5 Coded
PHY). As I understand it, selecting the PHY Coded rate can be undertaken
by the bluetooth controller itself, or be controlled/requested by the host.

Support for these rates appears to be available in controllers based on
Nordic Semiconductors' nRF52840, Texas Instruments' CC2640R2F and SiLabs
EFR32xG13. (Development/beta SDK/firmware may be required?). At least
the first to exist  as USB dongle implementations.

Is anyone successfully playing with this under Linux? Are required bits
for host control of PHY rate upstream? To what extent is support in the
HCIBTUSB kernel driver required for this functionality?


Thanks,


Dag B
