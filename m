Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Add Eddystone GATT Config Service to known UUIDs 
Date: Wed, 20 Apr 2016 11:16:12 +0200
Message-Id: <1461143773-17833-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The goal here is to be able to see the new Eddystone Configuration GATT Service
(https://github.com/google/eddystone/tree/master/configuration-service) UUIDs in BlueZ.

Francois Beaufort (1):
  Recognize Eddystone Configuration Service UUIDs

 monitor/uuid.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.7.0

