Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix compilation error in mgmt/main.c
Date: Wed, 18 Jan 2012 13:23:51 +0100
Message-ID: <1326889431-24546-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use %u instead of %zu for printing len which is of type uint16_t.

CC     mgmt/main.o
cc1: warnings being treated as errors
mgmt/main.c: In function ‘mgmt_device_found’:
mgmt/main.c:561: error: format ‘%zu’ expects type ‘size_t’, but argument 4 has type ‘int’
---
 mgmt/main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mgmt/main.c b/mgmt/main.c
index 096a8a4..ecb922d 100644
--- a/mgmt/main.c
+++ b/mgmt/main.c
@@ -557,7 +557,7 @@ static int mgmt_device_found(int mgmt_sk, uint16_t index,
 
 	eir_len = bt_get_le16(&ev->eir_len);
 	if (len != sizeof(*ev) + eir_len) {
-		fprintf(stderr, "dev_found: expected %zu bytes, got %zu bytes",
+		fprintf(stderr, "dev_found: expected %zu bytes, got %u bytes",
 						sizeof(*ev) + eir_len, len);
 		return -EINVAL;
 	}
-- 
on behalf of ST-Ericsson

