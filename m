Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/5] shared/btsnoop: Fix segmentation fault with malformed packet
Date: Tue, 12 Aug 2014 15:46:33 +0300
Message-Id: <1407847596-14781-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
 src/shared/btsnoop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index 17a872c..3592c2e 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -415,6 +415,11 @@ bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
 	}
 
 	toread = be32toh(pkt.size);
+	if (toread > BTSNOOP_MAX_PACKET_SIZE) {
+		btsnoop->aborted = true;
+		return false;
+	}
+
 	flags = be32toh(pkt.flags);
 
 	ts = be64toh(pkt.ts) - 0x00E03AB44A676000ll;
-- 
1.9.1

