Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A874DC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 05:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9D920663
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 05:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWXYP6Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387811AbgCLFzq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 01:55:46 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37914 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387677AbgCLFzq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 01:55:46 -0400
Received: by mail-pg1-f202.google.com with SMTP id x16so2807982pgg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 22:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TfwPFQ5KgNL4/IvOXn65RQ44FclgLRwK239/9gWjlhc=;
        b=ZWXYP6Z/vHZDne32XGF30phJUxPhs5itsrIKZwao5E5Ex2j6LYj1x+TnlCTvZMssYp
         L/seG39CgI/AQSw9XZ5OmuB0NN89t3I3zRHFNLu0iej3eABbPn5TG0UAT/26WcRrhqjw
         i+NQFHAp/sMXGchot4XgzX3alPcekBuTynjF+bv6k8jh0Ba8e+X+jbHpd4FmVbc6P3Ou
         e4TNtKVwo1tBYHSWKUTadayOxZ9gHZPehz6p1ZQhz1U+Vcg+GTF4aKUEeGa0u6gJDPKK
         uEiFbAvkR9UkslTZkP1pFBy6eXarQYsy9zM0lpgmrrviwLw7IxO3AhapwQpY87HsEWPi
         cH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TfwPFQ5KgNL4/IvOXn65RQ44FclgLRwK239/9gWjlhc=;
        b=mGb3s1DGc2a7gpB2l3CLNbWuQZ7SJhZUfD6u2WQLFI/fAJC8wyifq4XOCZjHt8+QPU
         Mxi85+5s8eksEYS7RzR0o1xCCGD4kkh9huqRE3OQxE/wTX5LGr9MJWoeooBtAAJ2GY6y
         O0XIadyyMxIrVPRlaQiAe9pYkn0aBsQnY7iUViN/N8EsudpLzVMyKDQUmAdtkE/V837Z
         fpH8FYRjhh7cstyMJtJSGQjE4/C11gmCWobFTSLOcLLU7TFJLO+3VLI7w0j4QgH2BB58
         xAwwB2RWad3nxMHDbyVXr6qeAN/Bk5dlQ7jlk8uS0YD0nKRbjt+Wrs9ZoQfoMxNQ9OhM
         hZcA==
X-Gm-Message-State: ANhLgQ2LtUUvfck8BZbK1DNwAuJ2IgkyT/TvsO8LSA/8W7kjY+1mzH5z
        jGZ2y5ufxXu0pf4UifGGLsFiYMnbNBwuw0dXi02l9SI6njLAf9nx345Ee8AtWmbTxNfB5K52kU7
        RTKquzd3U+5QUrINecjz1otPYFoQNhTaLpWKzqa/I8o28Izfdy495EeyXzNEjfnVjkbHLE4cjsn
        bp
X-Google-Smtp-Source: ADFU+vs5QeSo3bWJ07pZyrrCshitXJGIU4s5TB6NAFu/a/wo4tdncnn+y4cEsw1pxjQLzc1t8eguyYT20ukX
X-Received: by 2002:a17:90a:d14d:: with SMTP id t13mr2292515pjw.83.1583992542789;
 Wed, 11 Mar 2020 22:55:42 -0700 (PDT)
Date:   Thu, 12 Mar 2020 13:54:37 +0800
Message-Id: <20200312135409.Bluez.v1.1.I24708f815f78397d51e263f5c68fc47ec0b76acd@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [Bluez PATCH v1] a2dp: Fix race when connecting and being connected
 at the same time
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

There is a possibility where BlueZ initiate an A2DP connection just
around the same time as the peripheral also initiate it.

One scenario is the peripheral initiate the connection first, so
confirm_cb() on /profiles/audio/a2dp.c is called. However, while we
are waiting for the authentication step, BlueZ initiate a connection
to the peripheral, therefore a2dp_sink_connect() is called, which
from there a2dp_avdtp_get() is called.

If this happens: When calling confirm_cb(), chan for the
corresponding device is created.

Then when calling a2dp_avdtp_get(), chan will be found as it is
created in confirm_cb(), and the value of chan->io is not NULL.
However, a NULL is supplied instead to create a new session and
assigned to chan->session.

Then when calling connect_cb(), chan->session will NOT be NULL, as
it is assigned in a2dp_avdtp_get(). Nevertheless, chan->session is
always assigned a new value.

These cause failure in connection.

Therefore, fixing this by supplying the value of chan->io inside
a2dp_avdtp_get() (it's going to be NULL on the normal case so it is
fine), and check whether chan->session already assigned inside
connect_cb().
---

 profiles/audio/a2dp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index e8262cdfe..a5590b24c 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2118,7 +2118,7 @@ struct avdtp *a2dp_avdtp_get(struct btd_device *device)
 	return NULL;
 
 found:
-	chan->session = avdtp_new(NULL, device, server->seps);
+	chan->session = avdtp_new(chan->io, device, server->seps);
 	if (!chan->session) {
 		channel_remove(chan);
 		return NULL;
@@ -2136,10 +2136,13 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 		goto fail;
 	}
 
-	chan->session = avdtp_new(chan->io, chan->device, chan->server->seps);
 	if (!chan->session) {
-		error("Unable to create AVDTP session");
-		goto fail;
+		chan->session = avdtp_new(chan->io, chan->device,
+							chan->server->seps);
+		if (!chan->session) {
+			error("Unable to create AVDTP session");
+			goto fail;
+		}
 	}
 
 	g_io_channel_unref(chan->io);
-- 
2.25.1.481.gfbce0eb801-goog

