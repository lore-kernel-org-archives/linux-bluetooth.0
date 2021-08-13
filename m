Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9349C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C7C60F00
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbhHMMXC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbhHMMXC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:02 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF20CC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:35 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id p16-20020a05620a22b0b02903ca40d6cc81so6950849qkh.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dUmaDnKF+nTZ9KIWjkthLxmZ3VNyCPUmaVnTwDGA3FQ=;
        b=Sw+eBerrvl4GCDAZ7wPlrd8bvHJ/VBB3jkdNkBpCR8JCFcSwcN9HQBzg/J/TadXxjK
         RCiDVh6SWKmfm1sTRPnsFjLyFZelrWlY+oa8ofHA/uhtV/YJPL6tpIFdJDoxcjtnV70a
         xp06FURv4s2GmeP7R3t5bx2oO4CnaQ0iCF0T2E0vt+zkP0DRj3SsM5eNzgNu/g+8q4wv
         H3uE85zWX82QR40WPeyt8Gu4gHcSbxnN+s4KkvjfS5i5/2dwLwAS0G5y/F7TQhJ5pFCY
         09tAlnly6U7t2t8bIRj5ZpOJJ/FQT6KsDuSIuFxrXvQ8HQvePLGjp+dk3P13nx7RShxz
         vrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dUmaDnKF+nTZ9KIWjkthLxmZ3VNyCPUmaVnTwDGA3FQ=;
        b=a5tWbLdpVrBKxWf0ITdBimU7QXXHgihOEBgNxAqEjp+c6Dh7mJVmOao+CaHQy7hhYM
         45rJZUVIRDCIgdw8VoHySmob8p8wuOCJrAauVrq9iDAyCzLSoaOHSbetaBW7hKYK+O7J
         qDnQe5nAyQ/MZVkYxbM0mMO9QDwJ/vzJIxmhMO6UrNd3dqG2fA9NHnnOfCnpyApt8o/3
         RObadzKhatJnrTwMhr3A03ow4mf/kxXchKWcWoeZwgxIQkz3d8NKBXInewJHVheh43qi
         ivKa+kfZ6DuwMXRcRUcP0aLqQ4Xp16QClHS3z3Slz/08rULqAhAio6huxos2b1ICvVdw
         Wc9Q==
X-Gm-Message-State: AOAM532UMDI5CBItt1xJy0K1hr3NiII7XOe1/4YymSR9XV9mvaTdG5e+
        FGZwNhAhKsAbiqjSjYp4VISNFIK4gwrd6LVehjQE/1TTZ6NpbLLE+urvmsMMXQQKoqIfD6YZhK8
        wGIUIgfC5yHukinQc3slJ8a2fW6QXzjGKLTiddP3enh4DDpdO5f7YcZ7OrvrhlCnkix1a14n0tC
        2T
X-Google-Smtp-Source: ABdhPJzBZvA8II73Nwus1hOhbJTnM+yOxYaefljgxhtisH7TyLau6ZkLQRITYjsHtZfs2gnoq8kkXYGznQyV
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:21ed:: with SMTP id
 p13mr1839448qvj.49.1628857354806; Fri, 13 Aug 2021 05:22:34 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:34 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.49.I6d0329e84141a7bf2300edca52522fe1a647b301@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 49/62] sdp: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" is preferred, as reflected in the BT core spec 5.3.
---

 src/sdpd-server.c | 8 ++++----
 src/sdpd.h        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index c71e2c22da..07480372f8 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -41,7 +41,7 @@ static int l2cap_sock = -1, unix_sock = -1;
  * l2cap and unix sockets over which discovery and registration clients
  * access us respectively
  */
-static int init_server(uint16_t mtu, int master, int compat)
+static int init_server(uint16_t mtu, int central, int compat)
 {
 	struct l2cap_options opts;
 	struct sockaddr_l2 l2addr;
@@ -71,7 +71,7 @@ static int init_server(uint16_t mtu, int master, int compat)
 		return -1;
 	}
 
-	if (master) {
+	if (central) {
 		int opt = L2CAP_LM_CENTRAL;
 		if (setsockopt(l2cap_sock, SOL_L2CAP, L2CAP_LM, &opt, sizeof(opt)) < 0) {
 			error("setsockopt: %s", strerror(errno));
@@ -218,12 +218,12 @@ static gboolean io_accept_event(GIOChannel *chan, GIOCondition cond, gpointer da
 int start_sdp_server(uint16_t mtu, uint32_t flags)
 {
 	int compat = flags & SDP_SERVER_COMPAT;
-	int master = flags & SDP_SERVER_MASTER;
+	int central = flags & SDP_SERVER_CENTRAL;
 	GIOChannel *io;
 
 	info("Starting SDP server");
 
-	if (init_server(mtu, master, compat) < 0) {
+	if (init_server(mtu, central, compat) < 0) {
 		error("Server initialization failed");
 		return -1;
 	}
diff --git a/src/sdpd.h b/src/sdpd.h
index 257411f039..9488535d38 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -59,7 +59,7 @@ uint32_t sdp_next_handle(void);
 uint32_t sdp_get_time(void);
 
 #define SDP_SERVER_COMPAT (1 << 0)
-#define SDP_SERVER_MASTER (1 << 1)
+#define SDP_SERVER_CENTRAL (1 << 1)
 
 int start_sdp_server(uint16_t mtu, uint32_t flags);
 void stop_sdp_server(void);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

