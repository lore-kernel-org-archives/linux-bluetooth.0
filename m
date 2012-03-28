Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 0/4] Add Property Changed callbacks to btd_device
Date: Wed, 28 Mar 2012 16:46:25 +0200
Message-Id: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add a callback mechanism for the btd_device, allowing other parts of the bluez
stack to receive notifications for device properties which are changed. This 
mechanism is based on the D-BUS API for Device PropertyChanged.

Chen Ganir (4):
  Add property changed callback
  Centralize property changed events
  Use macros instead of strings
  Call registered callbacks

 src/device.c |  223 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 src/device.h |   93 ++++++++++++++++++++++++
 2 files changed, 281 insertions(+), 35 deletions(-)

-- 
1.7.4.1

