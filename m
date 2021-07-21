Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27113C636CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 09:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078D461222
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jul 2021 09:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbhGUIqQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbhGUIhX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jul 2021 04:37:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0472AC0613E3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 02:17:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l7so1377855wrv.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4d5t+D4n4dPVhfNv4Djc2hxDjUPBLuqi+Qul6Gj7j8A=;
        b=nbvLY+B5NC13qgunqr2dISeRdrtFGFl0+H1TDlkMtw/P2QDtFX5rdameo9VgejbE+c
         EFbPJf2A7lIdCEvCrjYPTnWRVHWIDS7H8DPD0HdStytbgp5uoIUL4n37JB/6K7DcM1rL
         JsGnHnQXWFtaEJFGA/65AqzBSZiE4qssaJoDytmIu4DBIOrvGjVo7rAiUQLWTHfHR4j9
         P3By7KCgvhBvEPHOhTVzLkKkYovAOr/Ume+H/c0UKZkg9wY2yHtt1e7w2sHJKw3ekuX+
         NXE3NOmlENoCCYLg4h4XU6NPBC2jcQMYrcHfy+c1ww36zRwVrRKCTBzMRtbEzsVMPzVN
         MoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4d5t+D4n4dPVhfNv4Djc2hxDjUPBLuqi+Qul6Gj7j8A=;
        b=Inl4ko2tjHhfdQA0dvxepgj6H+tfIOOFd6hFSxxsnb3umyd8xxsq7jeUzbfJ25oH63
         UhjPW3nb/Vliakw5qtscRkP2b2mQxbmeXMuJUnh3IKbZjGnw7bRk6aOfUyMObVqTU5ew
         MMgUbFYBr/zTdnFganWPDlbqRgoDq7nh9FMkB6urt1eEd2pzVD7uIYKUe81e2D1Ymrpw
         3jqM5brqZ+182AQ7s/o7VCdoqpS/1+jKMKKLOMRgWplY2LPLVaMzCeaeijH6CMErime4
         03OLL9cil+wOF4eXtukux9uunJeupZpnS5GGYs6nRR6Y78+l0BShafWAVIQfPpNpB2li
         ZpJA==
X-Gm-Message-State: AOAM532LcvXOZi/ILC6xcXnfP5I93yQUM8SiIR0rB7XALxO7xDuSwXbV
        jdyOQMwQSiLFshTvgPa70XjaGqzGMeylHw==
X-Google-Smtp-Source: ABdhPJxMnZb82/rbbha4R0VdK/nPuEqS+rXxGY8jLZrt/bE/Y1zXiOcigGjdZ7IOYpqooBau6lqcRQ==
X-Received: by 2002:adf:da43:: with SMTP id r3mr37099338wrl.307.1626859053648;
        Wed, 21 Jul 2021 02:17:33 -0700 (PDT)
Received: from Tux.s.capssion.com ([2a01:e34:ee5d:2b50:2e0:4cff:fe7e:dae9])
        by smtp.gmail.com with ESMTPSA id a64sm21156957wme.8.2021.07.21.02.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 02:17:33 -0700 (PDT)
From:   =?UTF-8?q?S=C3=A9bastien=20Viande?= <sviande@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?S=C3=A9bastien=20Viande?= <sviande@gmail.com>
Subject: [PATCH BlueZ] [BlueZ] audio/a2dp: refcount
Date:   Wed, 21 Jul 2021 11:17:27 +0200
Message-Id: <20210721091727.177872-1-sviande@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix a2dp setup.

I'm not the initial author of the code you can find the source on
https://patches.linaro.org/patch/285268/

This patch fix my problem the a2dp source not available there was only
HSP/HFP.
---
 profiles/audio/a2dp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 86bc02994..be707edda 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1568,6 +1568,8 @@ static void channel_free(void *data)
 	}
 
 	avdtp_remove_state_cb(chan->state_id);
+	if (chan->session)
+		avdtp_unref(chan->session);
 
 	queue_destroy(chan->seps, remove_remote_sep);
 	free(chan->last_used);
@@ -2149,7 +2151,7 @@ static void avdtp_state_cb(struct btd_device *dev, struct avdtp *session,
 		break;
 	case AVDTP_SESSION_STATE_CONNECTED:
 		if (!chan->session)
-			chan->session = session;
+			chan->session = avdtp_ref(session);
 		load_remote_seps(chan);
 		break;
 	}
@@ -2229,6 +2231,7 @@ found:
 		channel_remove(chan);
 		return NULL;
 	}
+	avdtp_ref(chan->session);
 
 	return avdtp_ref(chan->session);
 }
@@ -2249,6 +2252,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 			error("Unable to create AVDTP session");
 			goto fail;
 		}
+		avdtp_ref(chan->session);
 	}
 
 	g_io_channel_unref(chan->io);
-- 
2.32.0

