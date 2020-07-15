Return-Path: <SRS0=eiFZ=A2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537EDC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 22:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F4A2065D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jul 2020 22:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mL8hWUQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGOW20 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgGOW2Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jul 2020 18:28:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB2AC061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 15:28:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so3693153pjc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2020 15:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D34xJWmipzmXVSNToY0e2bj92OfU6zmBJh4+b4kN3sw=;
        b=mL8hWUQHHP9QLJktTCRh3znAc0Ue/04VB/mlVT4TsQXNf8RVd4gDKfluKfQwyneFme
         v1uGg23w1BTN1eMEhfftWWjTLPD71wcqq33TqOk7PEVyS1tgtKQPoUnb91yHQFBJHcaL
         EOUbJOeYcx5S7mx/zBFVuYJkAgX1zqyNPsREw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D34xJWmipzmXVSNToY0e2bj92OfU6zmBJh4+b4kN3sw=;
        b=cSyOhp2pdfuIIU7tBXsqbIAQnETcQu5k5o9N5WSKvHDAjTv0QSHxZBe2EbkeHgaszV
         qM+asG+O28cm0EKDbwkLk+Ust73AInmirXWyQsz7njWAeJPEuM0vTXC0rmKU689guyI7
         pmKZxSA+21vg4IoJ3KfYDfzFp24LQvgCVTuemL8n7M22pXRG35rMGat+izOi29iM7gvN
         4nT4ptVKEXti764bDSYTvm5ahns1rgJ34eLHAYCyhhFmkP9NdE1c959n0h2NpdY53RD/
         TO7PZQ6uoWJ3rfLi2aUBGixqfXnVCwzsWjZ17PGY5HwLOReJeCx4L8WMIIu0r7WrOob3
         diEA==
X-Gm-Message-State: AOAM530EAbgW4WFghLI0XVqA7KgFQHJSwdW5o2NTsQFccTyhbJ7jLAFY
        v2MAUia8zJ0VQhSj3QHonDVMAfvIhkY=
X-Google-Smtp-Source: ABdhPJzRS6GkFOfe9SCqYlQK5A+af1XuSqEIPb/xfX97y+t3d+uJ7yJUHNujA9d5r+I48MFAWIB1aw==
X-Received: by 2002:a17:902:9a81:: with SMTP id w1mr1252766plp.186.1594852104960;
        Wed, 15 Jul 2020 15:28:24 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id 4sm2923774pgk.68.2020.07.15.15.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 15:28:24 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] profile: Add exception from being claimed internally
Date:   Wed, 15 Jul 2020 15:28:12 -0700
Message-Id: <20200715222812.238172-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a flag to give exception to profiles that are considered safe
to be both handled internally and externally via GATT API. Currently
this includes the battery profile.

---
 profiles/battery/battery.c | 1 +
 src/device.c               | 2 +-
 src/profile.h              | 5 +++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 4da4355a1..20aa47727 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -354,6 +354,7 @@ static struct btd_profile batt_profile = {
 	.device_remove	= batt_remove,
 	.accept		= batt_accept,
 	.disconnect	= batt_disconnect,
+	.claim_service_exception = true,
 };
 
 static int batt_init(void)
diff --git a/src/device.c b/src/device.c
index 0deee2707..cfa52461f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3818,7 +3818,7 @@ done:
 	profile = btd_service_get_profile(service);
 
 	/* Claim attributes of internal profiles */
-	if (!profile->external) {
+	if (!profile->external && !profile->claim_service_exception) {
 		/* Mark the service as claimed by the existing profile. */
 		gatt_db_service_set_claimed(attr, true);
 	}
diff --git a/src/profile.h b/src/profile.h
index 4448a2a6d..25e83381b 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -36,6 +36,11 @@ struct btd_profile {
 
 	bool auto_connect;
 	bool external;
+	/* Some profiles are considered safe to be handled internally and also
+	 * be exposed in the GATT API. This flag give such profiles exception
+	 * from being claimed internally.
+	 */
+	bool claim_service_exception;
 
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
-- 
2.26.2

