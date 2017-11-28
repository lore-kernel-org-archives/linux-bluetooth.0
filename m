Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 0/4 v3] LE New PHYs kernel interfaces
Date: Tue, 28 Nov 2017 18:23:30 +0530
Message-Id: <1511873614-18068-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches enables user to get the supported phys by the
controller and set preferred phy to be used in subsequent
scanning and connection initiation.

Also added flags to support user selection for phy to be
advertised.

Jaganath Kanakkassery (4):
  doc/mgmt-api: Add support for Get PHY Configuration command
  doc/mgmt-api: Add support for Set Phy Configuration command
  doc/mgmt-api: Add advertising phys support to flags
  doc/mgmt-api: Update Duration Parameter description of Add Advertising

 doc/mgmt-api.txt | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

-- 
2.7.4

