Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ v0 0/2] Phone Alert and Alert Notification APIs
Date: Fri, 27 Jan 2012 18:10:27 -0300
Message-Id: <1327698629-11104-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

API proposal to implement Phone Alert Profile and Alert Notification
Profile over GATT. Platforms should register and implement an agent
to inform events/alerts.

GATT is not exposed to the upper layers, BlueZ control/get the status
of the alerts using D-Bus method calls and signals. Only ringer control
requires communication from BlueZ to the agent/platform, the remaining
communication are events sent from the agent to BlueZ.

Use cases:
1) watch(or carkit) controlling phone's ringer/profile
2) watch(or carkit) displaying new messages(or alerts)


Claudio Takahasi (2):
  Add Alert Agent API
  Add Alert Notification API

 doc/alert-api.txt |  127 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 127 insertions(+), 0 deletions(-)
 create mode 100644 doc/alert-api.txt

-- 
1.7.8.1

