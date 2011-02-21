Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 2/2] Fix end grp handle on Find By Type response
Date: Mon, 21 Feb 2011 10:36:54 -0400
Message-Id: <1298299014-31175-2-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1298299014-31175-1-git-send-email-bruna.moreira@openbossa.org>
References: <1298299014-31175-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The attribute server was incorrectly setting the end group handle of the
last attribute to 0xFFFF on Find By Type response (used by Discover
Primary Service by UUID).
---
 src/attrib-server.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 2eb800f..7ec0f56 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -486,13 +486,6 @@ static int find_by_type(uint16_t start, uint16_t end, uuid_t *uuid,
 		}
 	}
 
-	if (range) {
-		if (l == NULL) {
-			/* Avoids another iteration */
-			range->end = 0xFFFF;
-		}
-	}
-
 	if (matches == NULL)
 		return enc_error_resp(ATT_OP_FIND_BY_TYPE_REQ, start,
 				ATT_ECODE_ATTR_NOT_FOUND, opdu, mtu);
-- 
1.7.0.4

