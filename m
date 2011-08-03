Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/3] Add Proximity Monitor properties
Date: Wed,  3 Aug 2011 10:46:05 -0300
Message-Id: <1312379168-14795-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Proximity API simplification patch is now upstream. The following patches
are implementing get properties(ImmediateAlertLevel and SignalLevel) and
set property(ImmediateAlertLevel).

ImmediateAlertLevel will be used by Path Loss and Find Me. SignalLevel is
emitted by Proximity Monitor when Path Loss enabled and tracking the RSSI
threshold alerts.

Claudio Takahasi (3):
  Add set Immediate Alert for Proximity Monitor
  Add get Immediate Alert for Proximity Monitor
  Add get Path Loss RSSI signal level

 proximity/monitor.c |   55 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 49 insertions(+), 6 deletions(-)

-- 
1.7.6

