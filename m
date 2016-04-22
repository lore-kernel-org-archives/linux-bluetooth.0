Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Freek de Kruijf <f.de.kruijf@gmail.com>
To: Maillist Bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth device causes system crash
Date: Fri, 22 Apr 2016 15:02:39 +0200
Message-ID: <1979712.ub1I3X9q6o@eik132.beelaertsict.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have a bluetooth device:

ID 0cf3:3005 Atheros Communications, Inc. AR3011 Bluetooth

in a Rasberry Pi 1B.

It reads each 5 minutes some information from a device with a bluetooth 
interface. Almost daily the system halts and only a power down / power up 
makes the system run again. I tested the system without this device and it 
stays on; only the bluetooth dongle removed.

Any idea how to solve this problem?

-- 
fr.gr.

Freek de Kruijf

