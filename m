Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com, cpgs@samsung.com
Subject: [PATCH 0/7] L2CAP control field + AVRCP browsing PDU parsing
Date: Fri, 21 Nov 2014 19:17:38 +0530
Message-id: <1416577665-21876-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Support for ERTM control bytes adjustment, parsing L2CAP extended control
field and AVRCP SetBrowsedPlayer added in Bluetooth monitor.

Vikrampal Yadav (7):
  monitor: Adjust for ERTM control bytes
  monitor: Make the parameter name generic
  monitor: Add functionality to store extented control in DB
  monitor: Extract extended L2CAP extended control field
  monitor: Add support for parsing L2CAP extended control field
  monitor: Add support for parsing L2CAP control field
  monitor: Add AVRCP SetBrowsedPlayer support

 monitor/avctp.c |  86 +++++++++++++++++++-
 monitor/l2cap.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 322 insertions(+), 6 deletions(-)

-- 
1.9.1

