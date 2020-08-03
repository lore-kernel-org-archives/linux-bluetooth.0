Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37C1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 23:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C539B2245C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 23:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pY8qCSOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgHCX6Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgHCX6W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 19:58:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDB7C0617A0
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2020 16:58:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r1so7230805ybg.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Aug 2020 16:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=we5XgM9D/FaMqpDjAxLlNgitGEtix5X3KZAI9OVXI+Q=;
        b=pY8qCSOzC6iiErMuP9CTXE3NltWwjZ7lSbcKrVBfAMy9qTdAEwdoc6K2J9PKi+uUfT
         lZLns8PNAfzUZ4wKDpGbTLwvULJXY8VeBzbJtuQKJmWC3mwm0lMq5gRPR0Mc2BokqL5X
         AenKXWKyUmT/WVayuYU/fbJXI0zU4Yg7OuUZ1LASAKe1NU9XW78T1OWNKeAR0ZS2Ricf
         ULSs5WtG1BsDaLX782jH+Oy14OhOvsbrWjz2UTtUmCV5SMS0AnofgeWzKbr4Lf4Acb62
         5Qam0PnLzuejFH4F6HMOTCoj+I0e6ehTlp7aaVCOAbVX81oZETPHlvnb7D/46c3i6dK9
         Ew4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=we5XgM9D/FaMqpDjAxLlNgitGEtix5X3KZAI9OVXI+Q=;
        b=HLUeck/bicbDO6+45cWmOBxazId05rfPIl32qaQqt16SUYpM5lYM8kDiwj6AqG7RXw
         nKqveP290Q2GM7FLK5QUD0K5LHSRmaI0AanrUKpDBlQuqWPJTNo+KSdEwkQDhIw5H/rP
         7Mut57tnROCQtdS3y48GcxV7nMDlegpWI6BVjKzGJXgYrD0nBm6wZHrZAUMO/cC/NOSo
         Bt06pzyfog7MbsjdWFH+PA86FaeBY2refkuaq8HsdJqevhduFjNeTpNTO6n9QJOSc6jf
         lcttYwjfsAIVBJAjerht/eFsPm2lHkE0jNkKHksa8BEqzesF/J+6ClyQfLoRkT9qQRtU
         b+tg==
X-Gm-Message-State: AOAM5309e0mnFSaqUIn35AY/rWX9kBaLTv9af9kFnb731jEuZFETrX2r
        VuArjA3lv28j3+wpPSAfOKObTxhuG/vLQ/Lm+It9GpfZ1R9eYP9csrx6VCkuizTjYD+ZQ2PWUaN
        aTDIf/cdHViAgxiDzpPN7N4u9kbWd/JK1Hu8f0UmjWSbpvgaY7+idASDD1tvKuOeqYRnMYctA65
        2Q
X-Google-Smtp-Source: ABdhPJyow2D93lYIGorxjwbD2s8L89iJWAb+APXTF4pA4mPd5J1ykxyXrVphQiS1zIk7/zc9eFNYRIqhk88e
X-Received: by 2002:a25:38c5:: with SMTP id f188mr28455307yba.132.1596499101772;
 Mon, 03 Aug 2020 16:58:21 -0700 (PDT)
Date:   Mon,  3 Aug 2020 16:58:11 -0700
In-Reply-To: <20200803235811.2441774-1-yudiliu@google.com>
Message-Id: <20200803165804.RFC.v1.1.Ibaa1dfd49179a141c19a651f3c2132a28b71b344@changeid>
Mime-Version: 1.0
References: <20200803235811.2441774-1-yudiliu@google.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH v1 1/1] adapter - D-Bus API for querying the adapter's capability
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Archie Pusaka <apusaka@chromium.org>, sonnysasaka@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Initially this is introduced to query whether WBS is supported by the adapter,
the API is generic enough to be extended to support querying others in
the future.

Reviewed-by: sonnysasaka@chromium.org

---

Changes in v1:
- Initial change

 doc/adapter-api.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 1a7255750..250d0e9b3 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -204,6 +204,23 @@ Methods		void StartDiscovery()
 					 org.bluez.Error.NotReady
 					 org.bluez.Error.Failed
 
+		dict GetSupportedCapabilities()
+
+			This method returns a dictionary of supported
+			capabilities that is populated when the adapter
+			initiated.
+
+			The dictionary is following the format
+			{capability : value}, where:
+
+			string capability:	The supported capability under
+						discussion.
+			variant value:		A more detailed description of
+						the capability.
+
+			Possible errors: org.bluez.Error.NotReady
+					 org.bluez.Error.Failed
+
 Properties	string Address [readonly]
 
 			The Bluetooth device address.
-- 
2.28.0.163.g6104cc2f0b6-goog

