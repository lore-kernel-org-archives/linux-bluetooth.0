Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gap: Enable external flag
Date: Thu, 12 May 2016 15:36:02 +0200
Message-Id: <1463060163-29749-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This enable GAP Characteristics to be accessed over D-Bus.


Francois Beaufort (1):
  gap: Enable external flag

 profiles/gap/gas.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.7.0

