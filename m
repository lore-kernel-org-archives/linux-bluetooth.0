Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93822CE79AB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 19:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjISTOL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjISTOK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 15:14:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B974F2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 12:14:04 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c46b30a1ceso26845395ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695150843; x=1695755643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e3DSfd1QMDUvDxuzaLa+khU7LuNYV1lZStvg4Dic3ZI=;
        b=Blerur2OSudQuBNM8vdIJoRNoTPOqtPvCed6WduKv+OXr7EchlEotJ4ibJM9lfyFbH
         u5nBbrhA8+/dEWPKkAYeMTwBY8v+KABqemlyiGwVKZeKJHXgEI4fyE2hAi7EMpXvKqFs
         DN12zliKYGzH5fzJdWoYRbjWWlkb+CMjKitdY4AlgxP2jSTR1wc7ztjcwL/PjiI4LYG/
         vTGju9sK5W8+E86C5EIvSxwrHXw+xWhFDyQd/6My8MacO6Ls29UsznAZ/1FJZ8ZnpR96
         0mY95QVsekZZq2TWwruxuSbdRyOL53VWFexYhKHHws/aKo6iqHQUY5EBhC6wP04aP9pe
         49ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150843; x=1695755643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3DSfd1QMDUvDxuzaLa+khU7LuNYV1lZStvg4Dic3ZI=;
        b=cy8jB7rQrCf3gFGoL1C94NOC+UuoOp9WvdZoMTJNoItIIVo50XTeQbqaX/4Y9ynLTM
         X+sSkqfQJUtEPpdrtvv4E7FI9+it2TgkKA7aLfLwwume7s8daecJcJClbVepcnSrx0UU
         xPAKB8hEsZ5VC2L8SLrS9o/yPLtjku5VeWt24IPRj63990oBRouJsHprjdtnNNjXj+F3
         ONiSZrPaD5zJTSptHD9AlHY4xXYIh6jDh0fqn9WiMqWuUxCnqdwIqytPnhowj0fr65lP
         g/YlJUIVNyPUnzklkwqC7sJ+brtFRjTkseJkaT2rP59wJoj82kAftteNJ8Jeei285QeT
         b5Kg==
X-Gm-Message-State: AOJu0YxHGmZjstESBLaEDuE2DmagQi9StNfTfTirVLOu0Bz5Fk/qIqxE
        F54vPTaPX292EBzpYVtdbZ25rxE71X0=
X-Google-Smtp-Source: AGHT+IFJiMXBkWBgHfUI12F7xRRRVqekQN5wEtwSey0DsL4WBdRcnjK7+42lSMq+3n236cSxkJD71g==
X-Received: by 2002:a17:90a:64c5:b0:274:6135:835e with SMTP id i5-20020a17090a64c500b002746135835emr621937pjm.39.1695150843130;
        Tue, 19 Sep 2023 12:14:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id gv4-20020a17090b11c400b00273f65fa424sm8895613pjb.8.2023.09.19.12.14.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:14:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] pbap: Fix not checking Primary/Secundary Counter length
Date:   Tue, 19 Sep 2023 12:14:01 -0700
Message-ID: <20230919191401.311236-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Primary/Secundary Counters are supposed to be 16 bytes values, if the
server has implemented them incorrectly it may lead to the following
crash:

=================================================================
==31860==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x607000001878 at pc 0x7f95a1575638 bp 0x7fff58c6bb80 sp 0x7fff58c6b328

 READ of size 48 at 0x607000001878 thread T0
     #0 0x7f95a1575637 in MemcmpInterceptorCommon(void*, int (*)(void const*, void const*, unsigned long), void const*, void const*, unsigned long) ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:860
     #1 0x7f95a1575ba6 in __interceptor_memcmp ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:892
     #2 0x7f95a1575ba6 in __interceptor_memcmp ../../../../src/libsanitizer/sanitizer_common/sanitizer_common_interceptors.inc:887
     #3 0x564df69c77a0 in read_version obexd/client/pbap.c:288
     #4 0x564df69c77a0 in read_return_apparam obexd/client/pbap.c:352
     #5 0x564df69c77a0 in phonebook_size_callback obexd/client/pbap.c:374
     #6 0x564df69bea3c in session_terminate_transfer obexd/client/session.c:921
     #7 0x564df69d56b0 in get_xfer_progress_first obexd/client/transfer.c:729
     #8 0x564df698b9ee in handle_response gobex/gobex.c:1140
     #9 0x564df698cdea in incoming_data gobex/gobex.c:1385
     #10 0x7f95a12fdc43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
     #11 0x7f95a13526c7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xaa6c7)
     #12 0x7f95a12fd2b2 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)
     #13 0x564df6977d41 in main obexd/src/main.c:307
     #14 0x7f95a10a7d8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
     #15 0x7f95a10a7e3f in __libc_start_main_impl ../csu/libc-start.c:392
     #16 0x564df6978704 in _start (/usr/local/libexec/bluetooth/obexd+0x8b704)
 0x607000001878 is located 0 bytes to the right of 72-byte region [0x607000001830,0x607000001878)

 allocated by thread T0 here:
     #0 0x7f95a1595a37 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
     #1 0x564df69c8b6a in pbap_probe obexd/client/pbap.c:1259
---
 obexd/client/pbap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 1ed8c68eccd0..2d2aa950898c 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -285,7 +285,7 @@ static void read_version(struct pbap_data *pbap, GObexApparam *apparam)
 		data = value;
 	}
 
-	if (memcmp(pbap->primary, data, len)) {
+	if (len == sizeof(pbap->primary) && memcmp(pbap->primary, data, len)) {
 		memcpy(pbap->primary, data, len);
 		g_dbus_emit_property_changed(conn,
 					obc_session_get_path(pbap->session),
@@ -299,7 +299,8 @@ static void read_version(struct pbap_data *pbap, GObexApparam *apparam)
 		data = value;
 	}
 
-	if (memcmp(pbap->secondary, data, len)) {
+	if (len == sizeof(pbap->secondary) &&
+			memcmp(pbap->secondary, data, len)) {
 		memcpy(pbap->secondary, data, len);
 		g_dbus_emit_property_changed(conn,
 					obc_session_get_path(pbap->session),
-- 
2.41.0

