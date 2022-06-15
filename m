Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E24FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 12:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbiFOMu4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348414AbiFOMuf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 08:50:35 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA04F1FA
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 05:49:52 -0700 (PDT)
X-QQ-mid: bizesmtp87t1655297385t6bj9g1x
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 15 Jun 2022 20:49:21 +0800 (CST)
X-QQ-SSF: 01400000002000C0E000B00A0000000
X-QQ-FEAT: Y/4E1fKPEOrnRwXjViLjC1WqysMj8XwXdfd30Noaod4CcrBtePKhe15poi/zK
        ySjYFtXGe0KSI7wzPkAIJQkVz1ECi7bL1VowB935hAn2GLD5F+GWNghzTSWyHQ5UGvyFS5M
        D20VuEruiX3LQxOKyMBNLa67MZ0J7OV0BbOGhvST1tf6GQZvq/x/hRc+6s2l88B7x9DMqSy
        OcHinYch6Pm6Nbdei49dyytDq+tOGYBeeA8vTPREiEwel089fFHVltP1xSSE+kRJ41HUEjz
        naqM+DGeX3Nd8j8TmxQQkZkG54+o8pT+7ykYPe5msfZ8AhdgPXUew4XbpGX14c3JYfNdcZc
        5SEdYXm
X-QQ-GoodBg: 2
From:   Youwan Wang <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Youwan Wang <wangyouwan@uniontech.com>
Subject: [PATCH] obexd: Fix crash of transfer pointer has being freed
Date:   Wed, 15 Jun 2022 20:49:02 +0800
Message-Id: <20220615124902.17347-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

PC1 -> PC2 in the process of transferring the file,
PC2 terminate the reception.
It is found that PC1 will receive the Rcvd
Forbiden message.
transfer_response func is called and go to failed:
transfer_complete func is called and go to transfer_free

Invalid read of size 8
    at 0x129C9B: put_get_data (gobex-transfer.c:138)
    by 0x128675: get_body (gobex-packet.c:397)
    by 0x128675: g_obex_packet_encode (gobex-packet.c:451)
    by 0x1264ED: write_data (gobex.c:461)
    by 0x1264ED: write_data (gobex.c:431)
    by 0x49B7E97: g_main_context_dispatch ()
    by 0x49B8287: ??? ()
    by 0x49B8581: g_main_loop_run ()
    by 0x120834: main (main.c:322)
  Address 0x7300028 is 56 bytes inside a block of size 64 free'd
    at 0x48369AB: free (vg_replace_malloc.c:530)
    by 0x12A404: transfer_response (gobex-transfer.c:245)
    by 0x126B02: handle_response (gobex.c:1128)
    by 0x127087: incoming_data (gobex.c:1373)
    by 0x49B7E97: g_main_context_dispatch ()
    by 0x49B8287: ??? ()
    by 0x49B8581: g_main_loop_run ()
    by 0x120834: main (main.c:322)
  Block was alloc'd at
    at 0x4837B65: calloc (vg_replace_malloc.c:752)
    by 0x49BD9D8: g_malloc0 ()
    by 0x129A49: transfer_new (gobex-transfer.c:258)
    by 0x12A612: g_obex_put_req_pkt (gobex-transfer.c:282)
    by 0x12A612: g_obex_put_req_pkt (gobex-transfer.c:271)
    by 0x145862: transfer_start_put (transfer.c:880)
    by 0x145862: obc_transfer_start (transfer.c:911)
    by 0x13B487: session_process_transfer (session.c:836)
    by 0x13C128: session_process_queue (session.c:887)
    by 0x13C128: session_process_queue (session.c:872)
    by 0x13C18F: session_process (session.c:820)
    by 0x49B7E97: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/)
    by 0x49B8287: ??? (in /usr/lib/x86_64-linux-gnu/)
    by 0x49B8581: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/)
    by 0x120834: main (main.c:322)
---
 gobex/gobex-transfer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index c94d018b2..8e97fc73e 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -197,6 +197,14 @@ static void transfer_response(GObex *obex, GError *err, GObexPacket *rsp,
 	}
 
 	rspcode = g_obex_packet_get_operation(rsp, &final);
+	if (rspcode == G_OBEX_RSP_FORBIDDEN) {
+		err = g_error_new(G_OBEX_ERROR, rspcode, "%s",
+						g_obex_strerror(rspcode));
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
 	if (rspcode != G_OBEX_RSP_SUCCESS && rspcode != G_OBEX_RSP_CONTINUE) {
 		err = g_error_new(G_OBEX_ERROR, rspcode, "%s",
 						g_obex_strerror(rspcode));
-- 
2.20.1



