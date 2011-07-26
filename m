Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/5] Add Get/Set Property for Link Loss
Date: Tue, 26 Jul 2011 13:53:11 -0300
Message-Id: <1311699196-16472-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dependency: "[PATCH] Proximity Monitor implementation (for testing)"
sent from Anderson Lizardo. Small conflict in proximity/manager.c

The following patches implement Get/SetProperty for LinkLossAlertLevel
in the Proximity Monitor. Contains D-Bus methods/signals implementation
without remote comunication, alert level characteristic value is not
being written yet.

Bruna Moreira (1):
  Add load/store functions for Alert Level

Sheldon Demario (4):
  Add set Link Loss Alert Level
  Add get Link Loss Alert Level
  Emit a signal when Link Loss Alert Level changes
  Use device object path on Proximity Monitor

 proximity/manager.c |   11 +---
 proximity/monitor.c |  190 ++++++++++++++++++++++++++++++++++++++++++++++-----
 proximity/monitor.h |    4 +-
 3 files changed, 177 insertions(+), 28 deletions(-)

-- 
1.7.6

