Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 0/3] LE New PHYs kernel interfaces
Date: Tue, 14 Nov 2017 16:02:14 +0530
Message-Id: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches enables user to get the supported phys by the
controller and set preferred phy to be used in subsequent
scanning and connection initiation.

Also added flags to support user selection for phy to be
advertised.

Jaganath Kanakkassery (3):
  doc/mgmt-api: Add support for Get supported phys command
  doc/mgmt-api: Add support for Set default Phy command
  doc/mgmt-api: Add advertising phys support to flags

 doc/mgmt-api.txt | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

-- 
2.7.4

