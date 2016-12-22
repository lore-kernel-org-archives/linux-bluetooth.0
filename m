Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH 0/3] Dualshock4 controller enhancements
Date: Wed, 21 Dec 2016 21:20:51 -0800
Message-Id: <1482384054-59718-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set contains enhancements for the Dualshock4 controller.

There are now two Dualshock4 PIDs out there, add second one to
special case handler.

Modify sixaxis plugin to add support for pairing DS4 controllers over USB.
The HID report also allows for the link key to be set but since there is
currently no API to set it from the plugins, this has not been implemented.

Because of this the DS4 will connect to the bluez host automatically but
the bonding still has to happen over the bluetooth connection as normal.

Also set connected controllers "paired" by default. This allows for hands-free
connection to bluez host.

Juha Kuikka (3):
  Add new DS4 controller PID into special case handler
  sixaxis: Add support for pairing DS4 over USB
  sixaxis: Set created devices trusted by default

 plugins/sixaxis.c       | 87 +++++++++++++++++++++++++++++++++++++------------
 profiles/input/server.c |  2 +-
 2 files changed, 68 insertions(+), 21 deletions(-)

-- 
1.9.1

