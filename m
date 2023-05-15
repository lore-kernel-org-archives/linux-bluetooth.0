Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B73C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 21:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245319AbjEOVFy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 17:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjEOVFw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 17:05:52 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D221991
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:50 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5307502146aso3952586a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684184749; x=1686776749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBo++OSugDX16NBEk0VGJUq2Te47F5j23MhSdO7vJs0=;
        b=LOBiyrbojjsL70op0RarW2KQoClfbNbqpVBm7q0Hgnd5hhS4li+/Ed3y/1ZYHE06jC
         J5q2OGKD5uWrW8J8jGfTuwIvIqn1NgPODbeOsTdulCjLTQN7X5K3LQoMyEaaexdpJssU
         273bfhOLmzhbmmnluvvJvG/AzkZ/LSSyCYLS1gppzMXMlJiRN2ddFpgHEq9SJK4U1W1D
         DWtNMAOD+l7mZHpQia7eF3xjZmPDMPQ5EpfZcWb3awFKx7nfVvkKUQwygjdjs+6o8dyX
         ivZtaevoYamVIMsW2ieGftoM5Qi/f2AOS1BgKm+vd66eGfHVV8UVNVSqwU6ayRpV4zcd
         Yjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684184749; x=1686776749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBo++OSugDX16NBEk0VGJUq2Te47F5j23MhSdO7vJs0=;
        b=gJFd+jV4P7KZWhbfpah50zyniQ0mTWzMA4jYCtXy7r2YaYqnO/t78NDKoyxTxMWd+X
         /KWkFeVv8ZCF56pmFUpxu0IA1ulrjsSqemWdRRZ0GKWLatFBmiQ5W9AlboODEuAX4w/n
         8vUDFlgC7VXHsUu9OqK7bl0AvWFd005C27A6OF1G+PBZCajrSDxz8Z6YGZydCSBL6Cxg
         y9nA0BQeaEkUf4ab7KJu0SqsIF+5086BuZnvDceZ2GKlnsc1l25hhu+RIkORX//g9wBd
         zwe5R3eDmnGx2YvH3sNxlWBqB1E3ylPf2fuFtMIzl5bfWr4Q3fZd5cQtHgH/q6/CGR7F
         12lg==
X-Gm-Message-State: AC+VfDyiTn8EFe1x9wQ1p40bUU6jrzDYfDaCZx7ve8R0E2bbt/4/Z9BT
        m/utlQCWD866FWrrnSPHyN7iacablIo=
X-Google-Smtp-Source: ACHHUZ4zmYypqBiYhKcKQZojIyFUnOT37mdikDbvVNOoAUVYo3uhSyyxaxbbUOAJxYfSKWXrS4SISQ==
X-Received: by 2002:a17:902:f551:b0:1ae:ccf:6b40 with SMTP id h17-20020a170902f55100b001ae0ccf6b40mr8720617plf.13.1684184749216;
        Mon, 15 May 2023 14:05:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001a04ff0e2eesm13990050plb.58.2023.05.15.14.05.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 14:05:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] bap: Mark driver as experimental
Date:   Mon, 15 May 2023 14:05:40 -0700
Message-Id: <20230515210545.718701-2-luiz.dentz@gmail.com>
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
 profiles/audio/bap.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8f12fc410f67..1a543a9ce99b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1354,18 +1354,19 @@ static struct btd_profile bap_profile = {
 	.accept		= bap_accept,
 	.disconnect	= bap_disconnect,
 	.auto_connect	= true,
+	.experimental	= true,
 };
 
 static unsigned int bap_id = 0;
 
 static int bap_init(void)
 {
-	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
-		warn("D-Bus experimental not enabled");
-		return -ENOTSUP;
-	}
+	int err;
+
+	err = btd_profile_register(&bap_profile);
+	if (err)
+		return err;
 
-	btd_profile_register(&bap_profile);
 	bap_id = bt_bap_register(bap_attached, bap_detached, NULL);
 
 	return 0;
@@ -1373,10 +1374,8 @@ static int bap_init(void)
 
 static void bap_exit(void)
 {
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		btd_profile_unregister(&bap_profile);
-		bt_bap_unregister(bap_id);
-	}
+	btd_profile_unregister(&bap_profile);
+	bt_bap_unregister(bap_id);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(bap, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-- 
2.40.1

