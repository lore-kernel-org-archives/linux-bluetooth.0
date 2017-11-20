Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH 0/3 v2] LE New PHYs kernel interfaces
Date: Mon, 20 Nov 2017 15:56:54 +0530
Message-Id: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches enables user to get the supported phys by the
controller and set preferred phy to be used in subsequent
scanning and connection initiation.

Also added flags to support user selection for phy to be
advertised.

v1: Applied Marcel's comments
v2: Applied Eramoto's comments

Jaganath Kanakkassery (3):
  doc/mgmt-api: Add support for Get PHY information command
  doc/mgmt-api: Add support for Set default Phy command
  doc/mgmt-api: Add advertising phys support to flags

 doc/mgmt-api.txt | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

-- 
2.7.4

