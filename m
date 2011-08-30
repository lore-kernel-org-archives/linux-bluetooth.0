Return-Path: <cyrus@holtmann.org>
From: Pavel Raiskup <praiskup@redhat.com>
To: linux-bluetooth@vger.kernel.org
Cc: ovasik@redhat.com
Subject: [PATCH 7/8] Possible static overrun removed
Date: Tue, 30 Aug 2011 15:17:03 +0200
Message-Id: <1314710223-13575-1-git-send-email-praiskup@redhat.com>
In-Reply-To: <op.v0awcau9h52hc0@dhcp-25-209.brq.redhat.com>
References: <op.v0awcau9h52hc0@dhcp-25-209.brq.redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There will be static overrun on c_brf_chip array when brf_chip
is greater than 7.
---
 tools/hciattach_tialt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
index 1ba009c..fc3ed20 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -234,7 +234,8 @@ int texasalt_init(int fd, int speed, struct termios *ti)
 				((brf_chip > 7) ? "unknown" : c_brf_chip[brf_chip]),
 				brf_chip);
 
-		sprintf(fw, "/etc/firmware/%s.bin", c_brf_chip[brf_chip]);
+		sprintf(fw, "/etc/firmware/%s.bin",
+			brf_chip > 7 ? "unknown" : c_brf_chip[brf_chip]);
 		texas_load_firmware(fd, fw);
 
 		texas_change_speed(fd, speed);
-- 
1.7.4.4

