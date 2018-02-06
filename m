Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 0/1] BT Mesh API doc
Date: Tue,  6 Feb 2018 00:24:54 -0800
Message-Id: <20180206082455.3424-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch contains initial documentation describing proposed BT Mesh
user space/kernel interface. The idea behind this interface is to divide
mesh functionality between user space and kernel in order to utilize
kernel's finer timing mechanisms and provide efficient filtering of
mesh-specific packets.

Feedback is greatly appreciated.

Inga

Inga Stotland (1):
  Add initial doc describing Bluetooth Mesh API

 doc/mesh-api.txt | 273 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 273 insertions(+)
 create mode 100644 doc/mesh-api.txt

-- 
2.13.6

