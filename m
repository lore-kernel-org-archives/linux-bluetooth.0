Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 6/9] monitor: Fix tab misuse
Date: Fri, 27 Apr 2012 10:36:49 -0400
Message-Id: <1335537412-26478-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/packet.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 356e0a3..0f14ea6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -654,7 +654,7 @@ void packet_hci_scodata(struct timeval *tv, uint16_t index, bool in,
 	}
 
 	printf("%c SCO Data: handle %d flags 0x%2.2x dlen %d\n",
-			in ? '>' : '<',	acl_handle(handle), flags, hdr->dlen);
+			in ? '>' : '<', acl_handle(handle), flags, hdr->dlen);
 
 	data += HCI_SCO_HDR_SIZE;
 	size -= HCI_SCO_HDR_SIZE;
-- 
1.7.5.4

