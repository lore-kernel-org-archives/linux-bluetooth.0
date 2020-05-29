Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EC7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7941C208A7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 06:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgE2Gh4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 02:37:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:53721 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgE2Ghz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 02:37:55 -0400
IronPort-SDR: F3jiO/fINfV59MJcQjS85aXkT71Cq67vh+IA3KDCoeG3uyp4AjqJLTXnV7B7yapfbPPVmN8WKJ
 2HX5v76cUfBQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 23:37:55 -0700
IronPort-SDR: gHcqqN4kRBDFD5TEm52D/qnKNZc8Mk/9cG4jgr6oHkXSUdpmIeTtCl1EG4V9vPeL4kOeOxLN5C
 vAgpReKZIftA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="257260601"
Received: from dmikkels-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.228.187])
  by fmsmga008.fm.intel.com with ESMTP; 28 May 2020 23:37:54 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 3/5] mesh: Remove debug-only related callback for packet send
Date:   Thu, 28 May 2020 23:37:48 -0700
Message-Id: <20200529063750.186278-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063750.186278-1-inga.stotland@intel.com>
References: <20200529063750.186278-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This removes callback for sending every single access layer packet
since the callback does nothing but print debug satement. This
functionality is mature enough not to require such heavy debugging.
---
 mesh/model.c | 27 ++-------------------------
 mesh/net.c   | 20 +-------------------
 mesh/net.h   |  9 ++-------
 3 files changed, 5 insertions(+), 51 deletions(-)

diff --git a/mesh/model.c b/mesh/model.c
index dc6f28eb8..49e7c50fa 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -508,29 +508,6 @@ static int virt_packet_decrypt(struct mesh_net *net, const uint8_t *data,
 	return -1;
 }
 
-static void cmplt(uint16_t remote, uint8_t status,
-					void *data, uint16_t size,
-					void *user_data)
-{
-	struct timeval tx_end;
-
-	gettimeofday(&tx_end, NULL);
-
-	if (tx_end.tv_sec == tx_start.tv_sec) {
-		l_debug("Duration 0.%6.6lu seconds",
-				tx_end.tv_usec - tx_start.tv_usec);
-	} else {
-		if (tx_start.tv_usec > tx_end.tv_usec)
-			l_debug("Duration %lu.%6.6lu seconds",
-				tx_end.tv_sec - tx_start.tv_sec - 1,
-				tx_end.tv_usec + 1000000 - tx_start.tv_usec);
-		else
-			l_debug("Duration %lu.%6.6lu seconds",
-					tx_end.tv_sec - tx_start.tv_sec,
-					tx_end.tv_usec - tx_start.tv_usec);
-	}
-}
-
 static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 		uint32_t dst, uint16_t app_idx, uint16_t net_idx,
 		uint8_t *label, uint8_t ttl, bool segmented,
@@ -585,9 +562,9 @@ static bool msg_send(struct mesh_node *node, bool credential, uint16_t src,
 		goto done;
 	}
 
-	ret = mesh_net_app_send(net, credential, src, dst, key_aid, net_idx,
+	ret =  mesh_net_app_send(net, credential, src, dst, key_aid, net_idx,
 					ttl, seq_num, iv_index, segmented,
-					szmic, out, out_len, cmplt, NULL);
+					szmic, out, out_len);
 done:
 	l_free(out);
 	return ret;
diff --git a/mesh/net.c b/mesh/net.c
index f9e7bce4c..08544ad61 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -171,8 +171,6 @@ struct mesh_sar {
 	unsigned int id;
 	struct l_timeout *seg_timeout;
 	struct l_timeout *msg_timeout;
-	mesh_net_status_func_t status_func;
-	void *user_data;
 	uint32_t flags;
 	uint32_t last_nak;
 	uint32_t iv_index;
@@ -1657,12 +1655,6 @@ static void outmsg_to(struct l_timeout *msg_timeout, void *user_data)
 		return;
 
 	sar->msg_timeout = NULL;
-
-	if (sar->status_func)
-		sar->status_func(sar->remote, 1,
-				sar->buf, sar->len - 4,
-				sar->user_data);
-
 	mesh_sar_free(sar);
 }
 
@@ -1712,10 +1704,6 @@ static void ack_received(struct mesh_net *net, bool timeout,
 		l_debug("ob_sar_removal (%x)", outgoing->flags);
 
 		/* Note: ack_flags == 0x00000000 is a remote Cancel request */
-		if (outgoing->status_func)
-			outgoing->status_func(src, ack_flag ? 0 : 1,
-					outgoing->buf,
-					outgoing->len - 4, outgoing->user_data);
 
 		l_queue_remove(net->sar_out, outgoing);
 		send_queued_sar(net, outgoing->remote);
@@ -3154,9 +3142,7 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 				uint16_t dst, uint8_t key_aid, uint16_t net_idx,
 				uint8_t ttl, uint32_t seq, uint32_t iv_index,
 				bool segmented, bool szmic,
-				const void *msg, uint16_t msg_len,
-				mesh_net_status_func_t status_func,
-				void *user_data)
+				const void *msg, uint16_t msg_len)
 {
 	struct mesh_sar *payload = NULL;
 	uint8_t seg, seg_max;
@@ -3214,8 +3200,6 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 	if (segmented) {
 		payload->flags = 0xffffffff >> (31 - seg_max);
 		payload->seqZero = seq & SEQ_ZERO_MASK;
-		payload->status_func = status_func;
-		payload->user_data = user_data;
 		payload->id = ++net->sar_id_next;
 
 		/* Single thread SAR messages to same Unicast DST */
@@ -3251,8 +3235,6 @@ bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 			l_timeout_create(SEG_TO, outseg_to, net, NULL);
 		payload->msg_timeout =
 			l_timeout_create(MSG_TO, outmsg_to, net, NULL);
-		payload->status_func = status_func;
-		payload->user_data = user_data;
 		payload->id = ++net->sar_id_next;
 	} else
 		mesh_sar_free(payload);
diff --git a/mesh/net.h b/mesh/net.h
index 8646d5aef..12808ce38 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -260,9 +260,6 @@ struct mesh_friend_msg {
 };
 
 typedef void (*mesh_status_func_t)(void *user_data, bool result);
-typedef void (*mesh_net_status_func_t)(uint16_t remote, uint8_t status,
-					void *data, uint16_t size,
-					void *user_data);
 
 struct mesh_net *mesh_net_new(struct mesh_node *node);
 void mesh_net_free(void *net);
@@ -313,10 +310,8 @@ void mesh_net_transport_send(struct mesh_net *net, uint32_t key_id,
 bool mesh_net_app_send(struct mesh_net *net, bool frnd_cred, uint16_t src,
 				uint16_t dst, uint8_t key_id, uint16_t net_idx,
 				uint8_t ttl, uint32_t seq, uint32_t iv_index,
-				bool segmented, bool szmic,
-				const void *msg, uint16_t msg_len,
-				mesh_net_status_func_t status_func,
-				void *user_data);
+				bool segmented, bool szmic, const void *msg,
+				uint16_t msg_len);
 void mesh_net_ack_send(struct mesh_net *net, uint32_t key_id,
 				uint32_t iv_index, uint8_t ttl, uint32_t seq,
 				uint16_t src, uint16_t dst, bool rly,
-- 
2.26.2

