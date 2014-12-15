Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/5] shared/gatt: Improve handling search requests
Date: Mon, 15 Dec 2014 10:59:02 +0100
Message-Id: <1418637547-20848-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set of patches improves handling GATT request which requires more
then one ATT request to complete full GATT request, like service search or similar.
Now it is possible to track such GATT request with one request id.

Lukasz Rymanowski (5):
  attrib/gatt: Fix minor coding style
  shared/gatt: Extract send_att function
  shared/gatt: Add bt_send_att_with_id functions
  attrib/gattrib: Fix gattrib send command
  attrib/gatt: Fix for search searvices

 attrib/gatt.c    | 43 ++++++++++++++++++++++++++---------
 attrib/gattrib.c |  9 +++++---
 src/shared/att.c | 68 +++++++++++++++++++++++++++++++++++++++++---------------
 src/shared/att.h |  6 +++++
 4 files changed, 94 insertions(+), 32 deletions(-)

-- 
1.8.4

