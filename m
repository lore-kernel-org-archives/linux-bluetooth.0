Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12208C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FE8619A2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhGHG01 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhGHG01 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8C4C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:23:46 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id y35-20020a0cb8a30000b0290270c2da88e8so3369976qvf.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aOqA8U5BHV+P1I3p5Zk/+AMkeiZJOsUk1qheCnJv3iU=;
        b=Ztz7RQ0zfm73o30rz29q3wGXZEcjU+jNzJ9LPUgN3iDDlflEm8AZaxuByBmZY2FOQ5
         nDPVElfXKP0P+vukODyFYj2cycGu4MAoDMsqLNbTCnWdggsLkl3jnuhgWMDo/eCyR9Pk
         kjT1CG4RWk8OVbGUZdyx7+PRGEVXRsVmdw7UDij5ig70RJWlyXFNXbavo2kkh/uEpQ9W
         vJEJoIwzf0bxluP964LYNI3EfaOT1DGhohI0N/8fQRa/UpQg49+p6FvHX8mqZljuS+nj
         10WJyXbw9NHR+E6sW3OPVSGtdn10fvZUGHplkC3CgoV+Zm2ySveYwyRXovB+nwkTxdaU
         HXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aOqA8U5BHV+P1I3p5Zk/+AMkeiZJOsUk1qheCnJv3iU=;
        b=jAuNWojqPG6CyvpnkTh987U+t25t0JV+PL01RrTD7HhIduLqh61xDwe4cd3ecqaMvi
         4XMQwImInXdxTNhFY/Ysboak5oqH0KkGQqoE0/PgFDwyNB04AH+faT08ALz+DBy4vx2y
         8v9WP+yl39xSXXroIhxzHE3MUJ5pEHHqp7zcOhvctO15EAykSmqiWAZI65M3zdgLtmDF
         BShHG3xZZCzF+mEaGJGD7eiRhCWCUXzs37gsOABUTwVjyF/KI17l4B928E/jcBkvAflS
         uVj5mhw2j/U3G3iiIjcAO6y0hMg6put9BkWdzih0ph3wd4oH1uv30PFzNOq8CHgJh9uy
         rJgQ==
X-Gm-Message-State: AOAM530+pt3EIG/FCzZX1DoLvGgpdEpWMjxy9oGZr0/UllJx9SBVqoDT
        xChpHDUpcc19C7LWxIjzsQA1jLtQoRTX8R5R3ZvORtcw+gc0YkZry/5g+zFDQUiJolWIjeKcvhx
        M8807/Qoxv28szHLMS9kW/WTVrxGoG5KrOwDabTMnvzgs7POriqsQIrTFqhyxLuoQUqZk9VIQ+D
        MANsMV36kmh5Q=
X-Google-Smtp-Source: ABdhPJz7FXIllfTDTavI0wln3o99V/+28Uun5VUJ4z1hnhWpkj6/SLe+GeyseZUbN1w6HsMXrXmUlFx3sPO/kvbiIA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:ad4:538c:: with SMTP id
 i12mr28407230qvv.51.1625725425227; Wed, 07 Jul 2021 23:23:45 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:06 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.6.I123189fa93aad2c2d1be645d38dbc494aa15563c@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 06/14] audio: Remove Media1 interface when a2dp
 source disallowed
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When A2DP source profile is removed from adapter, a2dp_server and
everything inside the object will be removed, which also releases all
MediaEndpoints and MediaPlayer. When A2DP source profile is re-added,
although a2dp_server will be created, clients are not able to know they
can register their endpoints and player by then.

This patch handles this case by unregistering Media1 interface
when we remove a2dp_server, and register it back when a2dp_source is
allowed.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
perform following steps
1. SetServiceAllowList to empty list
2. pair with an LE headset, then turn off the headset
3. SetServiceAllowList to "0x1234"
4. SetServiceAllowList to empty list
5. turn on the headset and check if it is reconnected.

 profiles/audio/a2dp.c  | 2 ++
 profiles/audio/avrcp.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d31ed845cbe7..26d4f365207e 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -3275,6 +3275,7 @@ static int a2dp_source_server_probe(struct btd_profile *p,
 {
 	struct a2dp_server *server;
 
+	media_register(adapter);
 	DBG("path %s", adapter_get_path(adapter));
 
 	server = find_server(servers, adapter);
@@ -3315,6 +3316,7 @@ static void a2dp_source_server_remove(struct btd_profile *p,
 		return;
 
 	a2dp_server_unregister(server);
+	media_unregister(adapter);
 }
 
 static int a2dp_sink_server_probe(struct btd_profile *p,
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ccf34b2207a9..997a5be9a0f4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4751,6 +4751,8 @@ static void avrcp_controller_server_remove(struct btd_profile *p,
 
 	if (server->tg_record_id == 0)
 		avrcp_server_unregister(server);
+
+	media_unregister(adapter);
 }
 
 static int avrcp_controller_server_probe(struct btd_profile *p,
@@ -4761,6 +4763,7 @@ static int avrcp_controller_server_probe(struct btd_profile *p,
 
 	DBG("path %s", adapter_get_path(adapter));
 
+	media_register(adapter);
 	server = find_server(servers, adapter);
 	if (server != NULL)
 		goto done;
-- 
2.32.0.93.g670b81a890-goog

