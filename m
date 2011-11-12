Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 4/4] Fix responding indications and notifications with not supported
Date: Fri, 11 Nov 2011 21:20:09 -0300
Message-Id: <1321057209-24931-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1321057209-24931-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1321057209-24931-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index e412061..2abec7f 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -904,6 +904,10 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
 		break;
 	case ATT_OP_HANDLE_CNF:
 		return;
+	case ATT_OP_HANDLE_IND:
+	case ATT_OP_HANDLE_NOTIFY:
+		/* The attribute client is already handling these */
+		return;
 	case ATT_OP_READ_MULTI_REQ:
 	case ATT_OP_PREP_WRITE_REQ:
 	case ATT_OP_EXEC_WRITE_REQ:
-- 
1.7.7

