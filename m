Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344E7C7EE25
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 21:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245341AbjEOVFz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245274AbjEOVFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 17:05:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3FE49F9
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aafa03f541so129093575ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684184751; x=1686776751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FaiRL7R9hAB8QTE8OFJBjT36cb1wdquZAEQfKkG1Kg8=;
        b=McBFc+R5/zUD68wMabnB9Cv5xZ7+BGSE21U6aRXKd/QCSCR2BQ/Bz25SdXpx7ufeKO
         DDV15rxfCJfoCcnaVc98qQwC0jV9C0eQPZjHwRAv7krdH04qOkI2vv5O7IlavagUQb4M
         9xV6WB/1JNt4V93z8RBnsvYIuxzh9jtb0CENTt49Gm04JemF9h5LblBHh+JaILoYW+Lr
         ah4TyFejiDtK64Pp5RWiv/A4mDEHhFFbw5L0m+vHAgEGFmaMdfxA0SpLX0jIYgiLwCZW
         r3oggYzmS65k6wnOEy6iISC8BF7asDdsD8nYP5VGUiogu+27okHBYvaEnDNEi1+btYpq
         1Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184751; x=1686776751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaiRL7R9hAB8QTE8OFJBjT36cb1wdquZAEQfKkG1Kg8=;
        b=Kxfu8Qm+XGoSlSKXnau0WI0cGFGjURedGpGxy0COVyGPqORtphaOcslDuwoyMEwDK2
         Mohx3N+UFAVZKv7A+PxxTW+CXHPuy5pAuUl7kp3mtQ/C0JpPqTTxLZ140bzdWsu80A8G
         tupHl2F3l4S8CKjLquX9vgUTbyMZ+XKfZ0BrIpWqa7ZX+L0/IUFULUPtcxJ/ysgYiFdX
         ShNAsrBK+Pbtcz7XnCta0jlwIuz9Xkne3ycWHLgrlJvy5Vi0SmkZ2rCfYTJ9FWxXMMNb
         AUYmYwDTjN5b323yPkXWxv1bfv6pZvh0oWB2pRJK8QZS50e2n0IIj6KZ6IuHdDxXLpM1
         9Kfw==
X-Gm-Message-State: AC+VfDwwOujrhIVQeC16lEzdD5iYW1y3FKK5iqngv5OsQHhodZpnkfS9
        yrQAISmPSKom0SuU2G1YnlizWpQxqnI=
X-Google-Smtp-Source: ACHHUZ44GSID+NCqiugMDi5wzt1z+l5UoY9RteKlw++kj9ET9Jy4yG4DqMmteH9xd1u2wtb4ep68Sg==
X-Received: by 2002:a17:903:338e:b0:1a6:6fe3:df8d with SMTP id kb14-20020a170903338e00b001a66fe3df8dmr28898503plb.8.1684184750840;
        Mon, 15 May 2023 14:05:50 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a04ff0e2eesm13990050plb.58.2023.05.15.14.05.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 14:05:49 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] bass: Mark driver as experimental
Date:   Mon, 15 May 2023 14:05:41 -0700
Message-Id: <20230515210545.718701-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515210545.718701-1-luiz.dentz@gmail.com>
References: <20230515210545.718701-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses the btd_profile.experimental to mark the driver as
experimental.
---
 profiles/audio/bass.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index a7fcc9718d56..fae7fe00412a 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -276,18 +276,19 @@ static struct btd_profile bass_service = {
 	.device_remove	= bass_remove,
 	.accept		= bass_accept,
 	.disconnect	= bass_disconnect,
+	.experimental	= true,
 };
 
 static unsigned int bass_id;
 
 static int bass_init(void)
 {
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
-		return -ENOTSUP;
-	}
+	int err;
+
+	err = btd_profile_register(&bass_service);
+	if (err)
+		return err;
 
-	btd_profile_register(&bass_service);
 	bass_id = bt_bass_register(bass_attached, bass_detached, NULL);
 
 	return 0;
@@ -295,10 +296,8 @@ static int bass_init(void)
 
 static void bass_exit(void)
 {
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		btd_profile_unregister(&bass_service);
-		bt_bass_unregister(bass_id);
-	}
+	btd_profile_unregister(&bass_service);
+	bt_bass_unregister(bass_id);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(bass, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.40.1

