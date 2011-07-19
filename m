Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 0/1] RSSI Monitor
Date: Tue, 19 Jul 2011 19:15:32 -0300
Message-Id: <1311113733-7425-1-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This RFC is about RSSI monitoring. This feature is needed by Proximity
profile, at least. The suggested proposal adds two Management commands in order
to handle a list of RSSI Monitors. Each connection can have just one registered
RSSI monitor. Each monitor has two triggers for RSSI values and alerts will be
sent from kernel to userspace when a trigger is reached. The kernel will be
responsible to decide when and to send the alerts to userspace.

Anderson Briglia (1):
  Add RSSI Monitor documentation API

 doc/mgmt-api.txt |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

-- 
1.7.4.1

