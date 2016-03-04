Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Implement btmgmt BTLE Network Management API
Date: Fri,  4 Mar 2016 13:41:47 +0200
Message-Id: <1457091710-21751-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

	Hi,

This patch set implements the commands in RFC v3 of the Network Management
API proposal for the btmgmt tool.

Please review,

       Patrik


Patrik Flykt (3):
  btmgmt: Implement Get Networks Management API command
  btmgmt: Implement Add Network Management API command
  btmgmt: Implement Remove Network Management API command

 lib/mgmt.h     |  45 ++++++++++
 tools/btmgmt.c | 256 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 301 insertions(+)

-- 
2.1.4

