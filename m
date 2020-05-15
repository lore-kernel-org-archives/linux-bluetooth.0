Return-Path: <SRS0=w0Ns=65=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6F4C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 06:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8A22065F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 May 2020 06:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgEOGPd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 May 2020 02:15:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:57945 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgEOGPc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 May 2020 02:15:32 -0400
IronPort-SDR: k4EuXctDFfSpSxOA0OPChxLo6nW/Rz2DSNgRM8lmkPej+5Vxh9+FpXbb84NAAqs2HwFAd74vWb
 UgG+5dXb+t0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 23:15:32 -0700
IronPort-SDR: SzCaFt/jR0l5GN4Cs1XZ6PsXKEdwsSJwvckUSXvq5Nrbqa+U7/leoY3v/a9+heENEnl+EatfX+
 nqDpa6ztpw2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="252292029"
Received: from aghosh1-mobl.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.255.230.36])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2020 23:15:31 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Fix segfault caused by re-enabling of HCI controller
Date:   Thu, 14 May 2020 23:15:30 -0700
Message-Id: <20200515061530.4983-1-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes a crash incase when a controller used by bluetooth-meshd
is removed and then added back again.

Add a "restart" operation to mesh-io API to deal with a distinct case
of re-adding a previously used controller.

Backtrace:
0x00005618e754d040 in ?? ()
0x00005618e6e12d9a in io_ready_callback (user_data=0x5618e75538a0, result=<optimized out>) at mesh/mesh.c:174
0x00005618e6e3d2c8 in l_queue_foreach (queue=<optimized out>, function=0x5618e6e158e0 <process_read_info_req>, user_data=0x0)
    at ell/queue.c:441
0x00005618e6e37927 in request_complete (mgmt=mgmt@entry=0x5618e754ad50, status=<optimized out>, opcode=opcode@entry=4,
    index=index@entry=0, length=length@entry=280, param=0x5618e754b389) at src/shared/mgmt.c:261
---
 mesh/mesh-io-api.h     |  2 ++
 mesh/mesh-io-generic.c | 21 +++++++++++++++++++++
 mesh/mesh-io.c         |  8 ++++++++
 mesh/mesh-io.h         |  1 +
 mesh/mesh.c            | 12 +++++++++++-
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/mesh/mesh-io-api.h b/mesh/mesh-io-api.h
index 7a5b49c60..f6ca59833 100644
--- a/mesh/mesh-io-api.h
+++ b/mesh/mesh-io-api.h
@@ -22,6 +22,7 @@ struct mesh_io_private;
 typedef bool (*mesh_io_init_t)(struct mesh_io *io, void *opts,
 				mesh_io_ready_func_t cb, void *user_data);
 typedef bool (*mesh_io_destroy_t)(struct mesh_io *io);
+typedef bool (*mesh_io_restart_t)(struct mesh_io *io);
 typedef bool (*mesh_io_caps_t)(struct mesh_io *io, struct mesh_io_caps *caps);
 typedef bool (*mesh_io_send_t)(struct mesh_io *io,
 					struct mesh_io_send_info *info,
@@ -37,6 +38,7 @@ typedef bool (*mesh_io_tx_cancel_t)(struct mesh_io *io, const uint8_t *pattern,
 struct mesh_io_api {
 	mesh_io_init_t		init;
 	mesh_io_destroy_t	destroy;
+	mesh_io_restart_t	restart;
 	mesh_io_caps_t		caps;
 	mesh_io_send_t		send;
 	mesh_io_register_t	reg;
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 2efd32f12..36aebc44f 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -769,6 +769,26 @@ static bool find_active(const void *a, const void *b)
 	return false;
 }
 
+static bool dev_restart(struct mesh_io *io)
+{
+	struct bt_hci_cmd_le_set_scan_enable cmd;
+	struct mesh_io_private *pvt = io->pvt;
+
+	if (!pvt)
+		return false;
+
+	if (l_queue_isempty(pvt->rx_regs))
+		return true;
+
+	pvt->active = l_queue_find(pvt->rx_regs, find_active, NULL);
+	cmd.enable = 0x00;	/* Disable scanning */
+	cmd.filter_dup = 0x00;	/* Report duplicates */
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+				&cmd, sizeof(cmd), scan_disable_rsp, pvt, NULL);
+
+	return true;
+}
+
 static bool recv_register(struct mesh_io *io, const uint8_t *filter,
 			uint8_t len, mesh_io_recv_func_t cb, void *user_data)
 {
@@ -845,6 +865,7 @@ static bool recv_deregister(struct mesh_io *io, const uint8_t *filter,
 const struct mesh_io_api mesh_io_generic = {
 	.init = dev_init,
 	.destroy = dev_destroy,
+	.restart = dev_restart,
 	.caps = dev_caps,
 	.send = send_tx,
 	.reg = recv_register,
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index c4eaecefd..3cf5b0d67 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -96,6 +96,14 @@ fail:
 	return NULL;
 }
 
+void mesh_io_restart(struct mesh_io *io)
+{
+	io = l_queue_find(io_list, match_by_io, io);
+
+	if (io && io->api)
+		io->api->restart(io);
+}
+
 void mesh_io_destroy(struct mesh_io *io)
 {
 	io = l_queue_remove_if(io_list, match_by_io, io);
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index fc0422020..2af713d2c 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -83,6 +83,7 @@ typedef void (*mesh_io_ready_func_t)(void *user_data, bool result);
 
 struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
 				mesh_io_ready_func_t cb, void *user_data);
+void mesh_io_restart(struct mesh_io *io);
 void mesh_io_destroy(struct mesh_io *io);
 
 bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 890a3aa8f..e47587f43 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -66,6 +66,7 @@ struct bt_mesh {
 	uint16_t req_index;
 	uint8_t friend_queue_sz;
 	uint8_t max_filters;
+	bool initialized;
 };
 
 struct join_data{
@@ -91,7 +92,8 @@ static struct bt_mesh mesh = {
 	.lpn_support = false,
 	.proxy_support = false,
 	.crpl = DEFAULT_CRPL,
-	.friend_queue_sz = DEFAULT_FRIEND_QUEUE_SZ
+	.friend_queue_sz = DEFAULT_FRIEND_QUEUE_SZ,
+	.initialized = false
 };
 
 /* We allow only one outstanding Join request */
@@ -168,9 +170,17 @@ static void io_ready_callback(void *user_data, bool result)
 {
 	struct mesh_init_request *req = user_data;
 
+	if (mesh.initialized) {
+		if (result)
+			mesh_io_restart(mesh.io);
+		return;
+	}
+
 	if (result)
 		node_attach_io_all(mesh.io);
 
+	mesh.initialized = true;
+
 	req->cb(req->user_data, result);
 
 	l_free(req);
-- 
2.26.2

