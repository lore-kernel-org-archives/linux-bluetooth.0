Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 16/17] csr_bcsp: Fix missing errno attribution
Date: Wed, 16 Nov 2011 09:20:03 -0400
Message-Id: <1321449604-4188-17-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

do_command() is supposed to set errno if returning -1.
---
 tools/csr_bcsp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tools/csr_bcsp.c b/tools/csr_bcsp.c
index df247a2..7bfaf5a 100644
--- a/tools/csr_bcsp.c
+++ b/tools/csr_bcsp.c
@@ -219,6 +219,7 @@ static int do_command(uint16_t command, uint16_t seqnum, uint16_t varid, uint8_t
 
 			if (timeout++ > 5000) {
 				fprintf(stderr, "Operation timed out\n");
+				errno = ETIMEDOUT;
 				return -1;
 			}
 		}
-- 
1.7.0.4

