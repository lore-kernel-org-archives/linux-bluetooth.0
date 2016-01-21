Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Kasper Markus (ETAS-PSC/ECE1)" <Markus.Kasper@escrypt.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [BUG] LEAdvertisingManager suffers from ObjectManager hierarchy
Date: Thu, 21 Jan 2016 15:53:33 +0000
Message-ID: <938d66c7e3ba4933912f948240b2669f@FE-MBX1011.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I managed to get up my GATT Server using my patched BlueZ (I'm working on getting all clearances allowing me to contribute the patch to BlueZ, but this may take some weeks). 
Meanwhile I added the advertisement part to my code and found the LEAdvertisementManager1 to suffer from a similar problem as the GattManager:
The DBUS ObjectManager is required to be in the same path as the managed objects. Luiz fixed a similar issue for the GattManager with his Patch from January, 5th by introducing the Application API.
I'll again try to identify a solution for patching my working copy of BlueZ, but it may take a while until I am able to share it.

Re contributing: 
Are the guidelines within the repository up to date: "HACKING" "doc/coding-style.txt" "doc/maintainer-guidelines"? 
I'm a bit confused about Marcels recent remark re signed-off-by. 

As I do not have any experiences in contributing to open source projects: 
Other hints/specialties I should be aware of to prepare a clean patch are welcome.
Especially, the "how/where to commit/send?" is not really clear to me.

Cheers,
Markus
