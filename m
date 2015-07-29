Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <dh79.pyun@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ v2 0/2] Remove Health device signals for ObjectManager
Date: Wed, 29 Jul 2015 10:23:16 +0900
Message-id: <1438132998-13784-1-git-send-email-dh79.pyun@samsung.com>
In-reply-to: <1437319871-3004-1-git-send-email-dh79.pyun () samsung ! com>
References: <1437319871-3004-1-git-send-email-dh79.pyun () samsung ! com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

Since BlueZ has ObjectManager interface, ChannelConnected and ChannelDeleted
Signals of HealthDevice interface was not available. Instead of these signals
objectManager generates "InterfaceAdded" and "InterfaceRemoved" signals for
org.bluez.HealthChannel1 interface. If health-api document contains these
signals, application or service using Bluez Dbus API will get the unexpected
result.

Notes
====

PATCH v2
  - Only including patches to remove health device signals

PATCH v1
  -  Initial patchset

Dohyun Pyun (2):
  doc/health-api: Remove ChannelConnected and ChannelDeleted signals
  profiles/health: Remove HealthDevice signals

 doc/health-api.txt    | 13 -------------
 profiles/health/hdp.c | 48 +-----------------------------------------------
 2 files changed, 1 insertion(+), 60 deletions(-)

-- 
1.8.1.2

