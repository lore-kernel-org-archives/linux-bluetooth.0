Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 00/11] Immediate Alert patches
Date: Mon,  8 Aug 2011 15:46:39 -0300
Message-Id: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dependency: none. RSSI threshold monitor patches are not required for
this patch series.

Implementation of D-Bus properties and GATT/ATT operations related to
alert level of the Immediate alert service.

Bruna Moreira (1):
  Add read remote Tx Power

Claudio Takahasi (10):
  Add Immediate Alert handle discovery
  Write Immediate Alert if necessary
  Emit PropertyChanged after writting alert
  Write Immediate Alert after discovering handle
  Request connection when writting Immediate alert
  Reset Immediate Alert after 5 seconds
  Reset the Immediate Alert at disconnection
  Set default value for ImmediateAlertLevel
  Write Immediate Alert if connected
  Fix wrong alert value for ImmediateAlertLevel

 proximity/monitor.c |  205 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 199 insertions(+), 6 deletions(-)

-- 
1.7.6

