Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gap: Enable external flag
Date: Thu, 12 May 2016 15:53:04 +0200
Message-Id: <1463061185-2838-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This enable GAP Characteristics to be accessed over D-Bus.

In Web Bluetooth world, we would like developers to access GAP characteristics
the same way they already do with other characteristics. Sadly,
`generic_access` service seems to be unaccessible when not marked as `external`.


Francois Beaufort (1):
  gap: Enable external flag

 profiles/gap/gas.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.7.0

