Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 3/5] btmon: Fix segmentation fault with malformed packet
Date: Tue, 12 Aug 2014 15:46:34 +0300
Message-Id: <1407847596-14781-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407847596-14781-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20140812090449.GA18519@t440s.ger.corp.intel.com>
 <1407847596-14781-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Do not allow to read more then buffer size.
This fixes segmentation fault reading capture from target (apparently
end of the trace was broken).
---
 monitor/btsnoop.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/monitor/btsnoop.c b/monitor/btsnoop.c
index fafeff8..83aaee5 100644
--- a/monitor/btsnoop.c
+++ b/monitor/btsnoop.c
@@ -304,6 +304,13 @@ int btsnoop_read_hci(struct timeval *tv, uint16_t *index, uint16_t *opcode,
 	}
 
 	toread = be32toh(pkt.size);
+	if (toread > BTSNOOP_MAX_PACKET_SIZE) {
+		perror("Packet len suspicially big: %u", toread);
+		close(btsnoop_fd);
+		btsnoop_fd = -1;
+		return -1;
+	}
+
 	flags = be32toh(pkt.flags);
 
 	ts = be64toh(pkt.ts) - 0x00E03AB44A676000ll;
-- 
1.9.1

