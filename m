Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Show UUIDs when listing services, characteristics and descriptors.    
Date: Tue, 20 Sep 2016 15:12:43 +0200
Message-Id: <20160920131245.19156-1-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Francois Beaufort (1):
  client: Show UUIDs when listing services, characteristics and
    descriptors.

 client/gatt.c | 75 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 28 deletions(-)

-- 
2.10.0

