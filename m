Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED17C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 09:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F53D613BE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 09:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhEEJEc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 05:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhEEJEc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 05:04:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96EC061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 02:03:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y5-20020a2586050000b02904ee36d3b170so1623758ybk.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xAMaQ5FO5dpvYa0Y/4TL7rBrT8AN+p+4RCIjZ/saNFs=;
        b=v3m+bCpYdzkA/Hb/HQ2kofTd350hi1rGOJCJwMgL0EeMlzycxQo3dmnkKPzawegVJP
         P+CZ0EBm/fwrn+nZyXvqKLtycIB2Alx115KkXCj5NKfcc/v6OlF+JPbfTry54uo4bajL
         0X1l45QSUvR/53kb1TEvDMga7hCFaQ8f0JtGfbL7afVDqNF4Ubtlx0JCXMzygvOSVa74
         GKKxaOJWsMRPIHWlokXhTy2STcWzWtbMgsHnT21agop/N3jHfDOHEhfKYF2Eue632Gt7
         XAHI1R/FkQZeKeTrl7Snw3HjhgXgl6txHVgHohGxiRD9H0IS3sRTrqp5dJGTM2GXnTNd
         Jzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xAMaQ5FO5dpvYa0Y/4TL7rBrT8AN+p+4RCIjZ/saNFs=;
        b=n3WQR/QQ8DQFO7nsLxRmqwZncTppoiiyGm3/o2RN3RvorGMjg1a32sXfEg6FntgbXQ
         98wC6OfZ0jjUxwrC2qQwzUZCIJAfnqaa1CPlfYQHTfcB5mzcIfmow3YuT77rMwgOhqfP
         kwK4BE55/fsDLYHgWaT4qCZcRS5GbQAiB3RjJcgxoaK249AbeI3nCTsJPMNt/LA1NDGX
         QwLk4Nq9YS7UeYFTBpLvvGqVY10W96kwZD5pC1veHnZHSQNtzIsKsh+Lcyprv3Sow2sG
         /A/JRWBj7takv4IQTxRteZlodw1QtzjS6YxAFDmggu03SbCKPmMhn+mMiLmAwV9YVJJh
         VnAA==
X-Gm-Message-State: AOAM5324ZI6Voe+9ixxTKG/OwZVlSPChSq3QXwPCLYMrxRLLLdOXClI1
        mhTGwxMB7RRwXAqZVkMmdAh3WufWSZDpG4nTNtC0G9UBrSgOHn0uWZR8SMKP1NSy0AHvLj+jl34
        /TvwDZIl/7ijmVR5mcFquDlHrRWqCi/6jQgXv+Sc2/Xdlkhs7YkjIwrDozRIkpNFRZiB1zTPQ6j
        Ao
X-Google-Smtp-Source: ABdhPJwMe2gwta2eWvOsEIb3LUnOAgWm8yQstOBKkcIYCwo4QPhop2ej4HQ2iQ6nRS+AQXhuB3x6dUB1q0mP
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:7d20:5af0:80ac:f978])
 (user=apusaka job=sendgmr) by 2002:a25:aa2e:: with SMTP id
 s43mr15133434ybi.131.1620205415473; Wed, 05 May 2021 02:03:35 -0700 (PDT)
Date:   Wed,  5 May 2021 17:03:29 +0800
Message-Id: <20210505170318.Bluez.v2.1.I462ae10efbf980757258cabcce883b212259a793@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [Bluez PATCH v2 1/2] PRE-UPSTREAM: unit/gobex: remove timer only when
 it's not removed yet
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

There are instances where timer is removed because timeout has
occurred, yet we still remove it again by the end of the test. This
causes double removal and prints ugly messages which obscures the
real culprit.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v2:
* Set timer_id in the timeout function instead of relying on GError
* Also handle potential freeing problem with io_id
* Also remove some smaller structs and opt to just use test_data
  for all tests in gobex

 unit/test-gobex-transfer.c | 453 +++++++++++++++++++++----------------
 unit/test-gobex.c          | 384 +++++++++++++++++--------------
 unit/util.c                |   3 +-
 unit/util.h                |   3 +-
 4 files changed, 476 insertions(+), 367 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index 4f652dea81..4fc97f4541 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -270,7 +270,6 @@ static void test_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_req_first, sizeof(put_req_first) },
@@ -281,11 +280,11 @@ static void test_put_req(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_put_req(obex, provide_data, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -299,9 +298,12 @@ static void test_put_req(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -347,7 +349,6 @@ static void test_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_rsp_first, sizeof(put_rsp_first) },
@@ -358,11 +359,11 @@ static void test_put_rsp(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put, &d);
 
@@ -376,9 +377,12 @@ static void test_put_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -413,7 +417,6 @@ static void test_stream_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_rsp_first, sizeof(put_rsp_first) },
@@ -428,11 +431,11 @@ static void test_stream_put_rsp(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_seq,
 									&d);
@@ -447,9 +450,12 @@ static void test_stream_put_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -475,7 +481,6 @@ static void test_stream_put_req_abort(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_req_first, sizeof(put_req_first) },
@@ -485,11 +490,11 @@ static void test_stream_put_req_abort(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	d.id = g_obex_put_req(obex, abort_data, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -503,9 +508,12 @@ static void test_stream_put_req_abort(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_error(d.err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED);
@@ -516,7 +524,6 @@ static void test_stream_put_rsp_abort(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_rsp_first, sizeof(put_rsp_first) },
@@ -531,11 +538,11 @@ static void test_stream_put_rsp_abort(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_seq, &d);
 
@@ -549,9 +556,12 @@ static void test_stream_put_rsp_abort(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_error(d.err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED);
@@ -584,7 +594,6 @@ static void test_packet_put_rsp_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 		{ put_rsp_first_srm_wait, sizeof(put_rsp_first_srm_wait) },
@@ -599,11 +608,11 @@ static void test_packet_put_rsp_wait(void)
 	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_PUT,
 						handle_put_seq_wait, &d);
@@ -619,9 +628,12 @@ static void test_packet_put_rsp_wait(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -631,7 +643,6 @@ static void test_packet_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ put_rsp_first_srm, sizeof(put_rsp_first_srm) },
@@ -646,11 +657,11 @@ static void test_packet_put_rsp(void)
 	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_seq, &d);
 
@@ -665,9 +676,12 @@ static void test_packet_put_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -677,7 +691,6 @@ static void test_get_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_req_first, sizeof(get_req_first) },
@@ -688,11 +701,11 @@ static void test_get_req(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_get_req(obex, rcv_data, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -706,9 +719,12 @@ static void test_get_req(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -718,7 +734,6 @@ static void test_stream_get_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_req_first, sizeof(get_req_first) },
@@ -733,11 +748,11 @@ static void test_stream_get_req(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -751,9 +766,12 @@ static void test_stream_get_req(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -763,7 +781,6 @@ static void test_packet_get_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ get_req_first_srm, sizeof(get_req_first_srm) },
@@ -778,11 +795,11 @@ static void test_packet_get_req(void)
 	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -796,9 +813,12 @@ static void test_packet_get_req(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -808,7 +828,6 @@ static void test_packet_get_req_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 		{ get_req_first_srm_wait, sizeof(get_req_first_srm_wait) },
@@ -823,11 +842,11 @@ static void test_packet_get_req_wait(void)
 	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -842,9 +861,12 @@ static void test_packet_get_req_wait(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -867,7 +889,6 @@ static void test_packet_get_req_suspend_resume(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 		{ get_req_first_srm, sizeof(get_req_first_srm) },
@@ -884,11 +905,11 @@ static void test_packet_get_req_suspend_resume(void)
 	d.provide_delay = 1;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_get_req(obex, rcv_seq_delay, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -902,9 +923,12 @@ static void test_packet_get_req_suspend_resume(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -914,7 +938,6 @@ static void test_packet_get_req_wait_next(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 		{ get_req_first_srm, sizeof(get_req_first_srm) },
@@ -930,11 +953,11 @@ static void test_packet_get_req_wait_next(void)
 	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_get_req(obex, rcv_seq, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -948,9 +971,12 @@ static void test_packet_get_req_wait_next(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -960,7 +986,6 @@ static void test_get_req_app(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ get_req_first_app, sizeof(get_req_first_app) },
@@ -973,11 +998,11 @@ static void test_get_req_app(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_get_req(obex, rcv_data, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -992,9 +1017,12 @@ static void test_get_req_app(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1043,7 +1071,6 @@ static void test_stream_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ NULL, 0 },
@@ -1059,11 +1086,11 @@ static void test_stream_put_req(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_put_req(obex, provide_seq, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -1077,9 +1104,12 @@ static void test_stream_put_req(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1117,7 +1147,6 @@ static void test_packet_put_req_suspend_resume(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ NULL, 0 },
@@ -1134,7 +1163,7 @@ static void test_packet_put_req_suspend_resume(void)
 	d.provide_delay = 1;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
@@ -1150,8 +1179,10 @@ static void test_packet_put_req_suspend_resume(void)
 
 	g_main_loop_unref(d.mainloop);
 
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1161,7 +1192,6 @@ static void test_packet_put_req_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 		{ NULL, 0 },
@@ -1177,11 +1207,11 @@ static void test_packet_put_req_wait(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_put_req(obex, provide_seq, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -1195,9 +1225,12 @@ static void test_packet_put_req_wait(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1207,7 +1240,6 @@ static void test_packet_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ NULL, 0 },
@@ -1223,11 +1255,11 @@ static void test_packet_put_req(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_put_req(obex, provide_seq, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -1241,9 +1273,12 @@ static void test_packet_put_req(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1253,7 +1288,6 @@ static void test_put_req_eagain(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_req_first, sizeof(put_req_first) },
@@ -1266,11 +1300,11 @@ static void test_put_req_eagain(void)
 	d.provide_delay = 200;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_put_req(obex, provide_eagain, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -1284,9 +1318,12 @@ static void test_put_req_eagain(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1296,7 +1333,6 @@ static void test_get_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_rsp_first, sizeof(get_rsp_first) },
@@ -1307,11 +1343,11 @@ static void test_get_rsp(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get, &d);
 
@@ -1325,9 +1361,12 @@ static void test_get_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1357,7 +1396,6 @@ static void test_stream_get_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ NULL, 0 },
@@ -1371,11 +1409,11 @@ static void test_stream_get_rsp(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_seq, &d);
 
@@ -1389,9 +1427,12 @@ static void test_stream_get_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1401,7 +1442,6 @@ static void test_packet_get_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ NULL, 0 },
@@ -1415,11 +1455,11 @@ static void test_packet_get_rsp(void)
 	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_seq, &d);
 
@@ -1434,9 +1474,12 @@ static void test_packet_get_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1468,7 +1511,6 @@ static void test_packet_get_rsp_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ NULL, 0 },
@@ -1482,11 +1524,11 @@ static void test_packet_get_rsp_wait(void)
 	create_endpoints(&obex, &io, SOCK_SEQPACKET);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_GET,
 					handle_get_seq_srm_wait, &d);
@@ -1502,9 +1544,12 @@ static void test_packet_get_rsp_wait(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1537,7 +1582,6 @@ static void test_get_rsp_app(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ get_rsp_first_app, sizeof(get_rsp_first_app) },
@@ -1551,11 +1595,11 @@ static void test_get_rsp_app(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_app, &d);
 
@@ -1569,9 +1613,12 @@ static void test_get_rsp_app(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1581,7 +1628,6 @@ static void test_put_req_delay(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_req_first, sizeof(put_req_first) },
@@ -1594,11 +1640,11 @@ static void test_put_req_delay(void)
 	d.provide_delay = 200;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_put_req(obex, provide_data, transfer_complete, &d, &d.err,
 					G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -1612,9 +1658,12 @@ static void test_put_req_delay(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1624,7 +1673,6 @@ static void test_get_rsp_delay(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_rsp_first, sizeof(get_rsp_first) },
@@ -1637,11 +1685,11 @@ static void test_get_rsp_delay(void)
 	d.provide_delay = 200;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get, &d);
 
@@ -1655,9 +1703,12 @@ static void test_get_rsp_delay(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1708,7 +1759,6 @@ static void test_put_rsp_delay(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_rsp_first, sizeof(put_rsp_first) },
@@ -1721,11 +1771,11 @@ static void test_put_rsp_delay(void)
 	d.provide_delay = 200;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_PUT, handle_put_delay, &d);
 
@@ -1739,9 +1789,12 @@ static void test_put_rsp_delay(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1751,7 +1804,6 @@ static void test_get_req_delay(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_req_first, sizeof(get_req_first) },
@@ -1764,11 +1816,11 @@ static void test_get_req_delay(void)
 	d.provide_delay = 200;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_get_req(obex, rcv_data_delay, transfer_complete, &d, &d.err,
 				G_OBEX_HDR_TYPE, hdr_type, sizeof(hdr_type),
@@ -1782,9 +1834,12 @@ static void test_get_req_delay(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1794,7 +1849,6 @@ static void test_get_rsp_eagain(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_rsp_first, sizeof(get_rsp_first) },
@@ -1807,11 +1861,11 @@ static void test_get_rsp_eagain(void)
 	d.provide_delay = 200;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_GET, handle_get_eagain,
 									&d);
@@ -1826,9 +1880,12 @@ static void test_get_rsp_eagain(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1849,7 +1906,6 @@ static void test_conn_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ conn_req, sizeof(conn_req) } }, {
@@ -1859,11 +1915,11 @@ static void test_conn_req(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_connect(obex, conn_complete, &d, &d.err, G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
@@ -1874,9 +1930,12 @@ static void test_conn_req(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1906,7 +1965,6 @@ static void test_conn_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_rsp, sizeof(conn_rsp) } }, {
@@ -1916,11 +1974,11 @@ static void test_conn_rsp(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT,
 						handle_conn_rsp, &d);
@@ -1935,10 +1993,12 @@ static void test_conn_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	if (!d.io_completed)
-		g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1964,7 +2024,6 @@ static void test_conn_get_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_req, sizeof(conn_req) },
@@ -1978,11 +2037,11 @@ static void test_conn_get_req(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_connect(obex, conn_complete_get_req, &d, &d.err,
 							G_OBEX_HDR_INVALID);
@@ -1994,9 +2053,12 @@ static void test_conn_get_req(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -2006,7 +2068,6 @@ static void test_conn_get_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_rsp, sizeof(conn_rsp) },
@@ -2020,11 +2081,11 @@ static void test_conn_get_rsp(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT,
 						handle_conn_rsp, &d);
@@ -2042,9 +2103,12 @@ static void test_conn_get_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -2070,7 +2134,6 @@ static void test_conn_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_req, sizeof(conn_req) },
@@ -2084,11 +2147,11 @@ static void test_conn_put_req(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_connect(obex, conn_complete_put_req, &d, &d.err,
 							G_OBEX_HDR_INVALID);
@@ -2100,9 +2163,12 @@ static void test_conn_put_req(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -2112,7 +2178,6 @@ static void test_conn_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_rsp, sizeof(conn_rsp) },
@@ -2126,11 +2191,11 @@ static void test_conn_put_rsp(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT,
 						handle_conn_rsp, &d);
@@ -2148,9 +2213,12 @@ static void test_conn_put_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -2160,7 +2228,6 @@ static void test_conn_get_wrg_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_rsp, sizeof(conn_rsp) },
@@ -2172,11 +2239,11 @@ static void test_conn_get_wrg_rsp(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT,
 						handle_conn_rsp, &d);
@@ -2191,10 +2258,12 @@ static void test_conn_get_wrg_rsp(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	if (!d.io_completed)
-		g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -2220,7 +2289,6 @@ static void test_conn_put_req_seq(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ conn_req, sizeof(conn_req) } ,
@@ -2236,11 +2304,11 @@ static void test_conn_put_req_seq(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_connect(obex, conn_complete_put_req_seq, &d, &d.err,
 							G_OBEX_HDR_INVALID);
@@ -2252,9 +2320,12 @@ static void test_conn_put_req_seq(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -2280,7 +2351,6 @@ static void test_conn_put_req_seq_srm(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ conn_req_srm, sizeof(conn_req_srm) } ,
@@ -2296,11 +2366,11 @@ static void test_conn_put_req_seq_srm(void)
 	d.obex = obex;
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_connect(obex, conn_complete_put_req_seq_srm, &d, &d.err,
 					G_OBEX_HDR_SRM, G_OBEX_SRM_INDICATE,
@@ -2313,9 +2383,12 @@ static void test_conn_put_req_seq_srm(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 6fbfa183ec..c393292d00 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -95,12 +95,13 @@ static uint8_t pkt_put_body[] = { G_OBEX_OP_PUT, 0x00, 0x0a,
 
 static gboolean timeout(gpointer user_data)
 {
-	GError **err = user_data;
+	struct test_data *d = user_data;
 
 	if (!g_main_loop_is_running(mainloop))
 		return FALSE;
 
-	g_set_error(err, TEST_ERROR, TEST_ERROR_TIMEOUT, "Timed out");
+	g_set_error(&d->err, TEST_ERROR, TEST_ERROR_TIMEOUT, "Timed out");
+	d->timer_id = 0;
 
 	g_main_loop_quit(mainloop);
 
@@ -191,46 +192,51 @@ static gboolean recv_and_send(GIOChannel *io, void *data, gsize len,
 static gboolean send_connect_rsp(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	GError **err = user_data;
+	struct test_data *d = user_data;
 
-	if (!recv_and_send(io, pkt_connect_rsp, sizeof(pkt_connect_rsp), err))
+	if (!recv_and_send(io, pkt_connect_rsp, sizeof(pkt_connect_rsp),
+								&d->err))
 		g_main_loop_quit(mainloop);
 
+	d->io_id = 0;
 	return FALSE;
 }
 
 static gboolean send_nval_connect_rsp(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	GError **err = user_data;
+	struct test_data *d = user_data;
 
 	if (!recv_and_send(io, pkt_nval_connect_rsp,
-					sizeof(pkt_nval_connect_rsp), err))
+					sizeof(pkt_nval_connect_rsp), &d->err))
 		g_main_loop_quit(mainloop);
 
+	d->io_id = 0;
 	return FALSE;
 }
 
 static gboolean send_nval_short_rsp(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	GError **err = user_data;
+	struct test_data *d = user_data;
 
 	if (!recv_and_send(io, pkt_nval_short_rsp,
-					sizeof(pkt_nval_short_rsp), err))
+					sizeof(pkt_nval_short_rsp), &d->err))
 		g_main_loop_quit(mainloop);
 
+	d->io_id = 0;
 	return FALSE;
 }
 
 static gboolean send_nothing(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	GError **err = user_data;
+	struct test_data *d = user_data;
 
-	if (!recv_and_send(io, NULL, 0, err))
+	if (!recv_and_send(io, NULL, 0, &d->err))
 		g_main_loop_quit(mainloop);
 
+	d->io_id = 0;
 	return FALSE;
 }
 
@@ -238,19 +244,20 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
 				GIOFunc send_rsp_func, int req_timeout,
 				int transport_type)
 {
-	GError *gerr = NULL;
+	struct test_data d;
 	GIOChannel *io;
 	GIOCondition cond;
-	guint timer_id, test_time;
+	int test_time;
 	GObex *obex;
 
 	create_endpoints(&obex, &io, transport_type);
 
-	g_obex_send_req(obex, req, req_timeout, rsp_func, &gerr, &gerr);
-	g_assert_no_error(gerr);
+	d.err = NULL;
+	g_obex_send_req(obex, req, req_timeout, rsp_func, &d.err, &d.err);
+	g_assert_no_error(d.err);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	g_io_add_watch(io, cond, send_rsp_func, &gerr);
+	d.io_id = g_io_add_watch(io, cond, send_rsp_func, &d);
 
 	mainloop = g_main_loop_new(NULL, FALSE);
 
@@ -259,18 +266,22 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
 	else
 		test_time = 1;
 
-	timer_id = g_timeout_add_seconds(test_time, timeout, &gerr);
+	d.timer_id = g_timeout_add_seconds(test_time, timeout, &d);
 
 	g_main_loop_run(mainloop);
 
 	g_main_loop_unref(mainloop);
 	mainloop = NULL;
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
 	g_obex_unref(obex);
 
-	g_assert_no_error(gerr);
+	g_assert_no_error(d.err);
 }
 
 static void send_connect(GObexResponseFunc rsp_func, GIOFunc send_rsp_func,
@@ -325,19 +336,13 @@ static void test_send_connect_req_timeout_pkt(void)
 	send_connect(timeout_rsp, send_nothing, 0, SOCK_SEQPACKET);
 }
 
-struct req_info {
-	GObex *obex;
-	guint id;
-	GError *err;
-};
-
 static void req_done(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
-	struct req_info *r = user_data;
+	struct test_data *d = user_data;
 
 	if (!g_error_matches(err, G_OBEX_ERROR, G_OBEX_ERROR_CANCELLED))
-		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 				"Did not get expected cancelled error");
 
 	g_main_loop_quit(mainloop);
@@ -346,55 +351,55 @@ static void req_done(GObex *obex, GError *err, GObexPacket *rsp,
 static void test_cancel_req_immediate(void)
 {
 	GObexPacket *req;
-	struct req_info r;
+	struct test_data d;
 	gboolean ret;
 
-	create_endpoints(&r.obex, NULL, SOCK_STREAM);
+	create_endpoints(&d.obex, NULL, SOCK_STREAM);
 
-	r.err = NULL;
+	d.err = NULL;
 
 	req = g_obex_packet_new(G_OBEX_OP_PUT, TRUE, G_OBEX_HDR_INVALID);
-	r.id = g_obex_send_req(r.obex, req, -1, req_done, &r, &r.err);
-	g_assert_no_error(r.err);
-	g_assert(r.id != 0);
+	d.id = g_obex_send_req(d.obex, req, -1, req_done, &d, &d.err);
+	g_assert_no_error(d.err);
+	g_assert(d.id != 0);
 
-	ret = g_obex_cancel_req(r.obex, r.id, FALSE);
+	ret = g_obex_cancel_req(d.obex, d.id, FALSE);
 	g_assert(ret == TRUE);
 
 	mainloop = g_main_loop_new(NULL, FALSE);
 
 	g_main_loop_run(mainloop);
 
-	g_assert_no_error(r.err);
+	g_assert_no_error(d.err);
 
-	g_obex_unref(r.obex);
+	g_obex_unref(d.obex);
 	g_main_loop_unref(mainloop);
 }
 
 static gboolean cancel_server(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	struct req_info *r = user_data;
+	struct test_data *d = user_data;
 	GIOStatus status;
 	gsize bytes_written, rbytes;
 	char buf[255];
 
 	status = g_io_channel_read_chars(io, buf, sizeof(buf), &rbytes, NULL);
 	if (status != G_IO_STATUS_NORMAL) {
-		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 				"Reading data failed with status %d", status);
 		goto failed;
 	}
 
 	if (rbytes < 3) {
-		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 					"Not enough data from socket");
 		goto failed;
 	}
 
 	if ((uint8_t) buf[0] == (G_OBEX_OP_PUT | FINAL_BIT)) {
-		if (!g_obex_cancel_req(r->obex, r->id, FALSE)) {
-			g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+		if (!g_obex_cancel_req(d->obex, d->id, FALSE)) {
+			g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 					"Cancelling request failed");
 			goto failed;
 		}
@@ -402,7 +407,7 @@ static gboolean cancel_server(GIOChannel *io, GIOCondition cond,
 	}
 
 	if ((uint8_t) buf[0] != (G_OBEX_OP_ABORT | FINAL_BIT)) {
-		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 				"Neither Put nor Abort packet received");
 		goto failed;
 	}
@@ -410,7 +415,7 @@ static gboolean cancel_server(GIOChannel *io, GIOCondition cond,
 	g_io_channel_write_chars(io, (char *) pkt_abort_rsp,
 				sizeof(pkt_abort_rsp), &bytes_written, NULL);
 	if (bytes_written != sizeof(pkt_abort_rsp)) {
-		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 						"Unable to write to socket");
 		goto failed;
 	}
@@ -418,6 +423,7 @@ static gboolean cancel_server(GIOChannel *io, GIOCondition cond,
 	return TRUE;
 
 failed:
+	d->io_id = 0;
 	g_main_loop_quit(mainloop);
 	return FALSE;
 }
@@ -425,35 +431,37 @@ failed:
 static void test_cancel_req_delay(int transport_type)
 {
 	GIOChannel *io;
-	guint io_id, timer_id;
-	struct req_info r;
+	struct test_data d;
 	GObexPacket *req;
 	GIOCondition cond;
 
-	create_endpoints(&r.obex, &io, transport_type);
+	create_endpoints(&d.obex, &io, transport_type);
 
-	r.err = NULL;
+	d.err = NULL;
 
 	req = g_obex_packet_new(G_OBEX_OP_PUT, TRUE, G_OBEX_HDR_INVALID);
-	r.id = g_obex_send_req(r.obex, req, -1, req_done, &r, &r.err);
-	g_assert_no_error(r.err);
-	g_assert(r.id != 0);
+	d.id = g_obex_send_req(d.obex, req, -1, req_done, &d, &d.err);
+	g_assert_no_error(d.err);
+	g_assert(d.id != 0);
 
 	mainloop = g_main_loop_new(NULL, FALSE);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, cancel_server, &r);
+	d.io_id = g_io_add_watch(io, cond, cancel_server, &d);
 
-	timer_id = g_timeout_add_seconds(2, timeout, &r.err);
+	d.timer_id = g_timeout_add_seconds(2, timeout, &d);
 
 	g_main_loop_run(mainloop);
 
-	g_assert_no_error(r.err);
+	g_assert_no_error(d.err);
+
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
 
-	g_source_remove(timer_id);
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
-	g_obex_unref(r.obex);
+	g_obex_unref(d.obex);
 	g_main_loop_unref(mainloop);
 }
 
@@ -467,97 +475,93 @@ static void test_cancel_req_delay_pkt(void)
 	test_cancel_req_delay(SOCK_SEQPACKET);
 }
 
-struct rcv_buf_info {
-	GError *err;
-	const guint8 *buf;
-	gsize len;
-	gboolean completed;
-};
-
 static gboolean rcv_data(GIOChannel *io, GIOCondition cond, gpointer user_data)
 {
-	struct rcv_buf_info *r = user_data;
+	struct test_data *d = user_data;
+	struct test_buf *b = d->recv;
 	GIOStatus status;
 	gsize rbytes;
 	char buf[255];
 
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
-		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 				"Unexpected condition %d on socket", cond);
 		goto done;
 	}
 
 	status = g_io_channel_read_chars(io, buf, sizeof(buf), &rbytes, NULL);
 	if (status != G_IO_STATUS_NORMAL) {
-		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 				"Reading data failed with status %d", status);
 		goto done;
 	}
 
-	if (rbytes != r->len) {
-		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+	if (rbytes != b->len) {
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 				"Got %zu bytes instead of %zu",
 				rbytes, sizeof(pkt_connect_req));
-		dump_bufs(r->buf, r->len, buf, rbytes);
+		dump_bufs(b->data, b->len, buf, rbytes);
 		goto done;
 	}
 
-	if (memcmp(buf, r->buf, rbytes) != 0) {
-		g_set_error(&r->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
+	if (memcmp(buf, b->data, rbytes) != 0) {
+		g_set_error(&d->err, TEST_ERROR, TEST_ERROR_UNEXPECTED,
 				"Mismatch with received data");
-		dump_bufs(r->buf, r->len, buf, rbytes);
+		dump_bufs(b->data, b->len, buf, rbytes);
 		goto done;
 	}
 
 done:
+	d->io_id = 0;
 	g_main_loop_quit(mainloop);
-	r->completed = TRUE;
 	return FALSE;
 }
 
 static void test_send_connect(int transport_type)
 {
 	guint8 connect_data[] = { 0x10, 0x00, 0x10, 0x00 };
-	struct rcv_buf_info r;
+	struct test_data d;
+	struct test_buf *b = d.recv;
 	GIOChannel *io;
 	GIOCondition cond;
 	GObexPacket *req;
-	guint io_id, timer_id;
 	GObex *obex;
 
 	create_endpoints(&obex, &io, transport_type);
 
-	memset(&r, 0, sizeof(r));
-	r.buf = pkt_connect_req;
-	r.len = sizeof(pkt_connect_req);
+	memset(&d, 0, sizeof(d));
+	b->data = pkt_connect_req;
+	b->len = sizeof(pkt_connect_req);
 
 	req = g_obex_packet_new(G_OBEX_OP_CONNECT, TRUE, G_OBEX_HDR_INVALID);
 	g_assert(req != NULL);
 
 	g_obex_packet_set_data(req, connect_data, sizeof(connect_data),
 							G_OBEX_DATA_REF);
-	g_obex_send(obex, req, &r.err);
-	g_assert_no_error(r.err);
+	g_obex_send(obex, req, &d.err);
+	g_assert_no_error(d.err);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, rcv_data, &r);
+	d.io_id = g_io_add_watch(io, cond, rcv_data, &d);
 
 	mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, timeout, &r.err);
+	d.timer_id = g_timeout_add_seconds(1, timeout, &d);
 
 	g_main_loop_run(mainloop);
 
 	g_main_loop_unref(mainloop);
 	mainloop = NULL;
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	if (!r.completed)
-		g_source_remove(io_id);
 	g_obex_unref(obex);
 
-	g_assert_no_error(r.err);
+	g_assert_no_error(d.err);
 }
 
 static void test_send_connect_stream(void)
@@ -583,40 +587,42 @@ static void unexpected_disconn(GObex *obex, GError *err, gpointer user_data)
 
 static void test_recv_unexpected(void)
 {
-	GError *err = NULL;
+	struct test_data d;
 	GObexPacket *req;
 	GIOChannel *io;
-	guint timer_id;
 	GObex *obex;
 	guint8 buf[255];
 	gssize len;
 
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
-	g_obex_set_disconnect_function(obex, unexpected_disconn, &err);
+	d.err = NULL;
+	g_obex_set_disconnect_function(obex, unexpected_disconn, &d.err);
 
 	req = g_obex_packet_new(G_OBEX_RSP_CONTINUE, TRUE, G_OBEX_HDR_INVALID);
 	len = g_obex_packet_encode(req, buf, sizeof(buf));
 	g_obex_packet_free(req);
 	g_assert_cmpint(len, >=, 0);
 
-	g_io_channel_write_chars(io, (char *) buf, len, NULL, &err);
-	g_assert_no_error(err);
+	g_io_channel_write_chars(io, (char *) buf, len, NULL, &d.err);
+	g_assert_no_error(d.err);
 
 	mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, timeout, &err);
+	d.timer_id = g_timeout_add_seconds(1, timeout, &d);
 
 	g_main_loop_run(mainloop);
 
 	g_main_loop_unref(mainloop);
 	mainloop = NULL;
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+
 	g_io_channel_unref(io);
 	g_obex_unref(obex);
 
-	g_assert_no_error(err);
+	g_assert_no_error(d.err);
 }
 
 static gssize get_body_data(void *buf, gsize len, gpointer user_data)
@@ -636,44 +642,46 @@ static gssize get_body_data_fail(void *buf, gsize len, gpointer user_data)
 
 static void test_send_on_demand(int transport_type, GObexDataProducer func)
 {
-	struct rcv_buf_info r;
+	struct test_data d;
+	struct test_buf *b = d.recv;
 	GIOChannel *io;
 	GIOCondition cond;
 	GObexPacket *req;
-	guint io_id, timer_id;
 	GObex *obex;
 
 	create_endpoints(&obex, &io, transport_type);
 
-	memset(&r, 0, sizeof(r));
-	r.buf = pkt_put_body;
-	r.len = sizeof(pkt_put_body);
+	memset(&d, 0, sizeof(d));
+	b->data = pkt_put_body;
+	b->len = sizeof(pkt_put_body);
 
 	req = g_obex_packet_new(G_OBEX_OP_PUT, FALSE, G_OBEX_HDR_INVALID);
-	g_obex_packet_add_body(req, func, &r);
+	g_obex_packet_add_body(req, func, &d);
 
-	g_obex_send(obex, req, &r.err);
-	g_assert_no_error(r.err);
+	g_obex_send(obex, req, &d.err);
+	g_assert_no_error(d.err);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, rcv_data, &r);
+	d.io_id = g_io_add_watch(io, cond, rcv_data, &d);
 
 	mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, timeout, &r.err);
+	d.timer_id = g_timeout_add_seconds(1, timeout, &d);
 
 	g_main_loop_run(mainloop);
 
 	g_main_loop_unref(mainloop);
 	mainloop = NULL;
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	if (!r.completed)
-		g_source_remove(io_id);
 	g_obex_unref(obex);
 
-	g_assert_no_error(r.err);
+	g_assert_no_error(d.err);
 }
 
 static void test_send_on_demand_stream(void)
@@ -723,8 +731,7 @@ static void handle_connect_err(GObex *obex, GError *err, gpointer user_data)
 
 static void recv_connect(int transport_type)
 {
-	GError *gerr = NULL;
-	guint timer_id;
+	struct test_data d;
 	GObex *obex;
 	GIOChannel *io;
 	GIOStatus status;
@@ -732,9 +739,10 @@ static void recv_connect(int transport_type)
 
 	create_endpoints(&obex, &io, transport_type);
 
+	d.err = NULL;
 	g_obex_add_request_function(obex, G_OBEX_OP_CONNECT,
-						handle_connect_req, &gerr);
-	g_obex_set_disconnect_function(obex, handle_connect_err, &gerr);
+						handle_connect_req, &d.err);
+	g_obex_set_disconnect_function(obex, handle_connect_err, &d.err);
 
 	status = g_io_channel_write_chars(io, (char *) pkt_connect_req,
 						sizeof(pkt_connect_req),
@@ -744,18 +752,20 @@ static void recv_connect(int transport_type)
 
 	mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, timeout, &gerr);
+	d.timer_id = g_timeout_add_seconds(1, timeout, &d);
 
 	g_main_loop_run(mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+
 	g_obex_unref(obex);
 	g_io_channel_unref(io);
 
 	g_main_loop_unref(mainloop);
 	mainloop = NULL;
 
-	g_assert_no_error(gerr);
+	g_assert_no_error(d.err);
 }
 
 static void test_recv_connect_stream(void)
@@ -781,16 +791,16 @@ static void disconn_ev(GObex *obex, GError *err, gpointer user_data)
 
 static void test_disconnect(void)
 {
-	GError *gerr = NULL;
-	guint timer_id;
+	struct test_data d;
 	GObex *obex;
 	GIOChannel *io;
 
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
-	g_obex_set_disconnect_function(obex, disconn_ev, &gerr);
+	d.err = NULL;
+	g_obex_set_disconnect_function(obex, disconn_ev, &d.err);
 
-	timer_id = g_timeout_add_seconds(1, timeout, &gerr);
+	d.timer_id = g_timeout_add_seconds(1, timeout, &d);
 
 	mainloop = g_main_loop_new(NULL, FALSE);
 
@@ -798,9 +808,11 @@ static void test_disconnect(void)
 
 	g_main_loop_run(mainloop);
 
-	g_assert_no_error(gerr);
+	g_assert_no_error(d.err);
+
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
 
-	g_source_remove(timer_id);
 	g_io_channel_unref(io);
 	g_obex_unref(obex);
 
@@ -857,7 +869,6 @@ static void test_connect(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ pkt_connect_req, sizeof(pkt_connect_req) } }, {
@@ -866,11 +877,11 @@ static void test_connect(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_connect(obex, req_complete, &d, &d.err, G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
@@ -881,9 +892,12 @@ static void test_connect(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -893,7 +907,6 @@ static void test_obex_disconnect(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_disconnect_req, sizeof(pkt_disconnect_req) } }, {
@@ -902,11 +915,11 @@ static void test_obex_disconnect(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_disconnect(obex, req_complete, &d, &d.err);
 	g_assert_no_error(d.err);
@@ -917,9 +930,12 @@ static void test_obex_disconnect(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -929,7 +945,6 @@ static void test_auth(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ pkt_connect_req, sizeof(pkt_connect_req) },
@@ -941,11 +956,11 @@ static void test_auth(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_connect(obex, req_complete, &d, &d.err, G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
@@ -956,9 +971,12 @@ static void test_auth(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -968,7 +986,6 @@ static void test_auth_fail(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ pkt_connect_req, sizeof(pkt_connect_req) },
@@ -980,11 +997,11 @@ static void test_auth_fail(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_connect(obex, req_complete, &d, &d.err, G_OBEX_HDR_INVALID);
 	g_assert_no_error(d.err);
@@ -995,9 +1012,12 @@ static void test_auth_fail(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1007,7 +1027,6 @@ static void test_setpath(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_setpath_req, sizeof(pkt_setpath_req) } }, {
@@ -1016,11 +1035,11 @@ static void test_setpath(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_setpath(obex, "dir", req_complete, &d, &d.err);
 	g_assert_no_error(d.err);
@@ -1031,9 +1050,12 @@ static void test_setpath(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1043,7 +1065,6 @@ static void test_setpath_up(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_setpath_up_req, sizeof(pkt_setpath_up_req) } }, {
@@ -1052,11 +1073,11 @@ static void test_setpath_up(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_setpath(obex, "..", req_complete, &d, &d.err);
 	g_assert_no_error(d.err);
@@ -1067,9 +1088,12 @@ static void test_setpath_up(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1079,7 +1103,6 @@ static void test_setpath_up_down(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_setpath_up_down_req,
@@ -1089,11 +1112,11 @@ static void test_setpath_up_down(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_setpath(obex, "../dir", req_complete, &d, &d.err);
 	g_assert_no_error(d.err);
@@ -1104,9 +1127,12 @@ static void test_setpath_up_down(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1116,7 +1142,6 @@ static void test_mkdir(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_mkdir_req, sizeof(pkt_mkdir_req) } }, {
@@ -1125,11 +1150,11 @@ static void test_mkdir(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_mkdir(obex, "dir", req_complete, &d, &d.err);
 	g_assert_no_error(d.err);
@@ -1140,9 +1165,12 @@ static void test_mkdir(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1152,7 +1180,6 @@ static void test_delete(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_delete_req, sizeof(pkt_delete_req) } }, {
@@ -1161,11 +1188,11 @@ static void test_delete(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_delete(obex, "foo.txt", req_complete, &d, &d.err);
 	g_assert_no_error(d.err);
@@ -1176,9 +1203,12 @@ static void test_delete(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1188,7 +1218,6 @@ static void test_copy(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_copy_req, sizeof(pkt_copy_req) } }, {
@@ -1197,11 +1226,11 @@ static void test_copy(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_copy(obex, "foo", "bar", req_complete, &d, &d.err);
 	g_assert_no_error(d.err);
@@ -1212,9 +1241,12 @@ static void test_copy(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
@@ -1224,7 +1256,6 @@ static void test_move(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_move_req, sizeof(pkt_move_req) } }, {
@@ -1233,11 +1264,11 @@ static void test_move(void)
 	create_endpoints(&obex, &io, SOCK_STREAM);
 
 	cond = G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL;
-	io_id = g_io_add_watch(io, cond, test_io_cb, &d);
+	d.io_id = g_io_add_watch(io, cond, test_io_cb, &d);
 
 	d.mainloop = g_main_loop_new(NULL, FALSE);
 
-	timer_id = g_timeout_add_seconds(1, test_timeout, &d);
+	d.timer_id = g_timeout_add_seconds(1, test_timeout, &d);
 
 	g_obex_move(obex, "foo", "bar", req_complete, &d, &d.err);
 	g_assert_no_error(d.err);
@@ -1248,9 +1279,12 @@ static void test_move(void)
 
 	g_main_loop_unref(d.mainloop);
 
-	g_source_remove(timer_id);
+	if (d.timer_id > 0)
+		g_source_remove(d.timer_id);
+	if (d.io_id > 0)
+		g_source_remove(d.io_id);
+
 	g_io_channel_unref(io);
-	g_source_remove(io_id);
 	g_obex_unref(obex);
 
 	g_assert_no_error(d.err);
diff --git a/unit/util.c b/unit/util.c
index e7804d884f..1322d80b6a 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -115,6 +115,7 @@ gboolean test_timeout(gpointer user_data)
 		return FALSE;
 
 	d->err = g_error_new(TEST_ERROR, TEST_ERROR_TIMEOUT, "Timed out");
+	d->timer_id = 0;
 
 	g_main_loop_quit(d->mainloop);
 
@@ -187,7 +188,7 @@ send:
 	return TRUE;
 
 failed:
+	d->io_id = 0;
 	g_main_loop_quit(d->mainloop);
-	d->io_completed = TRUE;
 	return FALSE;
 }
diff --git a/unit/util.h b/unit/util.h
index d5d0f19c5f..27a450981e 100644
--- a/unit/util.h
+++ b/unit/util.h
@@ -28,8 +28,9 @@ struct test_data {
 	GObex *obex;
 	guint id;
 	gsize total;
+	guint timer_id;
+	guint io_id;
 	GMainLoop *mainloop;
-	gboolean io_completed;
 };
 
 #define TEST_ERROR test_error_quark()
-- 
2.31.1.527.g47e6f16901-goog

