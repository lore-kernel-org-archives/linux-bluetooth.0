Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Fix bluez build break by initializing variable.
Date: Thu, 21 Apr 2016 10:18:48 +0200
Message-Id: <1461226729-17372-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From Chromium: https://chromium.googlesource.com/chromiumos/third_party/bluez/+/c3d3ca2%5E%21/

Francois Beaufort (1):
  Fix bluez build break by initializing variable.

 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.0

