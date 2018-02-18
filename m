Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/1 v2] BT Mesh API doc
Date: Sat, 17 Feb 2018 22:48:18 -0800
Message-Id: <20180218064819.23459-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch contains revision 2 of initial documentation describing proposed
BT Mesh user space/kernel interface.
The idea behind this interface is to divide mesh functionality between
user space and kernel in order to utilize kernel's finer timing mechanisms
and provide efficient filtering of mesh-specific packets.

Feedback is appreciated.

Inga Stotland (1):
  Add initial doc describing Bluetooth Mesh API

 doc/mesh-api.txt | 269 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 269 insertions(+)
 create mode 100644 doc/mesh-api.txt

-- 
2.13.6

