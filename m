Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/6] Proximity configs and LinkLoss alert write
Date: Wed, 27 Jul 2011 18:53:00 -0300
Message-Id: <1311803586-5405-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dependency: "[PATCH BlueZ 0/5] Add Get/Set Property for Link Loss"

The following patches implement the configuration file to allow
disabling Proximity Monitor services and Find Me. First patch using
attio connection callback registration mechanism to write Link Loss
Alert level.

Anderson Lizardo (1):
  Proximity Monitor: Write Alert Level to Reporter

Claudio Takahasi (5):
  Add Tx Power and Immediate Alert UUID
  Add config file for proximity monitor
  Match probed UUIDs and enabled services
  Return an error if LinkLoss is disabled
  Return LinkLossAlertLevel if enabled

 Makefile.am              |    4 +-
 proximity/main.c         |   30 ++++++++++++-
 proximity/manager.c      |   52 ++++++++++++++++++++--
 proximity/manager.h      |    2 +-
 proximity/monitor.c      |  108 ++++++++++++++++++++++++++++++++++++++++++++-
 proximity/monitor.h      |    9 +++-
 proximity/proximity.conf |    9 ++++
 7 files changed, 201 insertions(+), 13 deletions(-)
 create mode 100644 proximity/proximity.conf

-- 
1.7.6

