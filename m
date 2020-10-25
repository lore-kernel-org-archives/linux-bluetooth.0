Return-Path: <SRS0=eDkG=EA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E06C388F7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Oct 2020 16:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7502021D41
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Oct 2020 16:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYJqRhZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417157AbgJYQ1q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Oct 2020 12:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417129AbgJYQ1q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Oct 2020 12:27:46 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A98C0613CE
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2020 09:27:45 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg9so6900917edb.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Oct 2020 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHC46FtSi5Vh0QJOnXwhOPEpFW6y1XbIKpBe2/NGyYM=;
        b=oYJqRhZW54vfEo193qFbsE+6YrOArspeNgzc0kkMb2ZjBIBo/E8npcjMKrqX1xiN9T
         uvRzq6xUDTPz6JPjX6YpFEXoDBjKCQFBVIyYDlyHdQ7xKzYHbJ54nrH0Yr1iFG/4IKDd
         jWezKu4wbjK5sLWDrCVKcSJxEqoxugTs+yOpAGfxfp928ivP3V9lxGktEm1+RLUkCSVt
         TDzG3b+cwW9etJ+UFMDJQT33bT/mpKy5Jn0MrNy65Ikkl0eA1IoCLF4PlzU8KUjEYf1X
         iDSN+y18O6BeDKO47PC0Hmef61Zt8HS2qJ2colVP2U+fPMiBYAg+nEgGIwwwVkc/HRUx
         4Z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IHC46FtSi5Vh0QJOnXwhOPEpFW6y1XbIKpBe2/NGyYM=;
        b=jHEbqm9Atm7rCaTxIfbHtciF0eaoSh6z7S+bIgkV/5yAB1OQAXUk49XI8G6tQVq2xF
         xxBXgSv6ZUZ/EwIctH9KTIoBB+Pd2Tr/l9i8PsiHg6osaSglnfY3AuymaZv09Avmlogi
         4s7FanBeq0IgMdIgWohqC99Xs4JE29TcDGEJ/f6shoTqrYelA0qlwnECAA02YjydGtBs
         rjPHY/7kAMssQPEvTUzHc3dMN729bkQAabFdskATXgGrNq4X9ZuXbCVegv7/MxzvgR1H
         VOgB+YD2g4GFitRH0fMubgDo2P/mLfLtg8EVs7P0b2oEiITqSKT9ke0iLPP5hjI/K/vb
         D0rw==
X-Gm-Message-State: AOAM532khqToe58JZ2J9xsK+3U3R3g4OX7oc3WooeroJfEak9a++dDjx
        TExazjOjWt1Cmee0pLx3oylycs4sgOI=
X-Google-Smtp-Source: ABdhPJzeTsyCQ8ldUrjhfSU2eQ75fLXxBnNzwXWVnXPPTzVPpylfT2xI3bnNG4R9djQ717VEGYFYvw==
X-Received: by 2002:a05:6402:2073:: with SMTP id bd19mr11699848edb.127.1603643264254;
        Sun, 25 Oct 2020 09:27:44 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id a27sm4185928ejb.67.2020.10.25.09.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 09:27:43 -0700 (PDT)
From:   Marijn Suijten <marijns95@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, pali@kernel.org,
        Marijn Suijten <marijns95@gmail.com>
Subject: [PATCH BlueZ] audio/a2dp: a2dp_channel should have a refcount on avdtp session
Date:   Sun, 25 Oct 2020 17:27:30 +0100
Message-Id: <20201025162730.47247-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

a2dp_channel keeps a reference to an avdtp session without incrementing
its refcount.  Not only does this appear wrong, it causes unexpected
disconnections when the remote SEP responds with rejections.

During testing with an audio application disconnections are observed
when a codec config change through MediaEndpoint1.SetConfiguration
fails.  As soon as BlueZ receives this failure from the peer the
corresponding a2dp_setup object is cleaned up which holds the last
refcount to an avdtp session, in turn starting the disconnect process.
An eventual open sink/source and transport have already closed by that
time and released their refcounts.

Adding refcounting semantics around a2dp_channel resolves the
disconnections and allows future calls on MediaEndpoint1 to safely
access the sesion stored within this channel.
---
 profiles/audio/a2dp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index cc4866b5b..0eac0135f 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1507,6 +1507,9 @@ static void channel_free(void *data)
 
 	avdtp_remove_state_cb(chan->state_id);
 
+	if (chan->session)
+		avdtp_unref(chan->session);
+
 	queue_destroy(chan->seps, remove_remote_sep);
 	free(chan->last_used);
 	g_free(chan);
@@ -2065,7 +2068,7 @@ static void avdtp_state_cb(struct btd_device *dev, struct avdtp *session,
 		break;
 	case AVDTP_SESSION_STATE_CONNECTED:
 		if (!chan->session)
-			chan->session = session;
+			chan->session = avdtp_ref(session);
 		load_remote_seps(chan);
 		break;
 	}
@@ -2145,6 +2148,7 @@ found:
 		channel_remove(chan);
 		return NULL;
 	}
+	avdtp_ref(chan->session);
 
 	return avdtp_ref(chan->session);
 }
@@ -2165,6 +2169,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 			error("Unable to create AVDTP session");
 			goto fail;
 		}
+		avdtp_ref(chan->session);
 	}
 
 	g_io_channel_unref(chan->io);
-- 
2.29.1

Marijn Suijten
