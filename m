Return-Path: <SRS0=pK2I=ZD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBF9C43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 12:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B54F21872
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Nov 2019 12:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfKKMAM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:00:12 -0500
Received: from hall.aurel32.net ([195.154.113.88]:54250 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfKKMAL (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Nov 2019 07:00:11 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1iU8Mc-0006et-By; Mon, 11 Nov 2019 13:00:10 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
        (envelope-from <aurelien@aurel32.net>)
        id 1iU8Mb-0000vq-D0; Mon, 11 Nov 2019 13:00:09 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH BlueZ] mesh: fix node default TTL
Date:   Mon, 11 Nov 2019 13:00:07 +0100
Message-Id: <20191111120007.3511-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a confusion between the node default TTL (section 4.2.7) and
the publish TTL (section 4.2.2.5):

- The node default TTL can only take values 0x00, and 0x02 to 0x7f. The
  value 0xff is not prohibited.
- The publish TTL can take values 0x00 to 0x7f, as well as 0xff which
  means use the node default TTL.

Currently the default node TTL is set to 0xff (DEFAULT_TTL), and
read_default_ttl() also allows such a value. This patch fixes that to
use 0x7f (TTL_MASK) as the default value instead.

Note that the code handling OP_CONFIG_DEFAULT_TTL_SET correctly use 0x7f
(TTL_MASK) for the upper allowed limit.
---
 mesh/mesh-config-json.c | 2 +-
 mesh/node.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index b2cff6824..5ca2961b0 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -358,7 +358,7 @@ static bool read_default_ttl(json_object *jobj, uint8_t *ttl)
 	if (!val && errno == EINVAL)
 		return false;
 
-	if (val < 0 || val == 1 || val > DEFAULT_TTL)
+	if (val < 0 || val == 1 || val > TTL_MASK)
 		return false;
 
 	*ttl = (uint8_t) val;
diff --git a/mesh/node.c b/mesh/node.c
index e23f32dd1..5dcffe6f7 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -672,7 +672,7 @@ struct l_queue *node_get_element_models(struct mesh_node *node,
 uint8_t node_default_ttl_get(struct mesh_node *node)
 {
 	if (!node)
-		return DEFAULT_TTL;
+		return TTL_MASK;
 	return node->ttl;
 }
 
@@ -1352,7 +1352,7 @@ static void set_defaults(struct mesh_node *node)
 	node->friend = MESH_MODE_UNSUPPORTED;
 	node->beacon = MESH_MODE_DISABLED;
 	node->relay.mode = MESH_MODE_DISABLED;
-	node->ttl = DEFAULT_TTL;
+	node->ttl = TTL_MASK;
 	node->seq_number = DEFAULT_SEQUENCE_NUMBER;
 
 	/* Add configuration server model on primary element */
-- 
2.24.0

