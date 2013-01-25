Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 0/6] LE Connection Establishment fixes
Date: Fri, 25 Jan 2013 00:07:01 -0300
Message-Id: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Sending this as a RFC because I don't know if this is what you guys
had in mind.

Patches 1/6/ and 2/6 are simple enough fixes and should be considered
for inclusion, perhaps 6/6 as well, but the improvement is
non-functional.

The only problem with this aproach that I found while testing is the
problem exposed on the message of commit 5/6: If the remote device is
out of range during pairing any connection attempt will fail until the
Connection Complete event comes (with an error). This is the reason
that we put the devices in the connect list before pairing.

Is this reason enough to have the device put in the connect list
during pairing?


Cheers,


Vinicius Costa Gomes (6):
  device: Fix invalid memory access during Find Included
  device: Fix memory leak while storing GATT capable devices
  device: Clean up device_att_connect()
  device: Rename device_att_connect to device_connect_le
  core: Add a way to connect to LE devices
  gas: Move all the code to only one file

 Makefile.plugins        |   4 +-
 profiles/gatt/gas.c     |  46 +++++++++++++++++++++
 profiles/gatt/main.c    |  47 ---------------------
 profiles/gatt/manager.c |  79 -----------------------------------
 profiles/gatt/manager.h |  24 -----------
 src/adapter.c           |  22 +++++++++-
 src/adapter.h           |   3 ++
 src/device.c            | 108 +++++++++++++++++++++---------------------------
 src/device.h            |   3 +-
 9 files changed, 119 insertions(+), 217 deletions(-)
 delete mode 100644 profiles/gatt/main.c
 delete mode 100644 profiles/gatt/manager.c
 delete mode 100644 profiles/gatt/manager.h

-- 
1.8.1.1

