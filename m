Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH  0/3] Add support for decoding AVRCP browsing packets
Date: Tue, 21 Apr 2015 17:35:44 +0530
Message-id: <1429617947-5784-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Decodes below AVRCP browsing packets,

1) Get Item Attibutes
2) Search Item
3) General Reject

Bharat Panda (3):
  monitor: Add Support for AVRCP GetItemAttributes
  monitor: Add support for AVRCP Search
  monitor: Add support for AVRCP GeneralReject

 monitor/avctp.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

-- 
1.9.1

