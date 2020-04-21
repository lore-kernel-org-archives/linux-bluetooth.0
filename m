Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EB7C54FCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 20:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309BC206E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 20:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IBuPXDdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDUUr0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUUr0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 16:47:26 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D7C0610D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 13:47:26 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 1so98233vsl.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 13:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Itaj7kaG8lC3FVC/lWJypXu3PFIwcyHH2UVpvUsv6Es=;
        b=IBuPXDdpBGEIUzcsxYJwQT5pEbKnf321DaMMkVBYyhpVgFy2fXS7Bmc7GEwh9Gq+He
         w0fpSCy4A6tDJ3QKD+WZf9DVsH+H78BNWz3opci5bM2BqF4ImkTPiHMRtpokb7mhyGWu
         MsQ1biSqHBMd/vtsMVSDrCzJY4G65QPUDTlqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Itaj7kaG8lC3FVC/lWJypXu3PFIwcyHH2UVpvUsv6Es=;
        b=axKhYyrPCUI4spF8ibGQc4ldDHrRF5PHpHrM/zZ+f4kJM/5juoHYCnUIzaHX2gpj8q
         ZxVUSDPuS3pS+HQdOKO3rQ7I5KAgM111xmnslUpJYDsYza+E4YNbB2pAzXrpgLSc6w1C
         1fYYgsm9bwSmlXYz0KhZP7GGymdLLhmjtN+c9qVNWH3lraHUXomRK3o0PDGUxmnnVqPh
         4Uz1B/RXeqgLkrdPPTTdpBYQWWu5z8GfqZ01cBvsSEKXRwWXtxnDiJVHIryucAzXj7j9
         P10wlYO0AEOeCSqhpNq4jKvI85HGWLDsw6FC7PVnkK9Nlp19d/2Yg2yBL0KTQAttfnoE
         Z1Ig==
X-Gm-Message-State: AGi0PuaRVN2R66OmZDl9ifzPityVT9SMAiKAQhfyCYiWuYaVsn9quR7t
        QbSssygKDwZECu+s45RWPL4M33f1ykY=
X-Google-Smtp-Source: APiQypKXdWpk+7O3ctTdt3JdRfoa64gx+HiA/dWxbD8yTiPZn+XG7qgE/uxtVMo+kg11WZmN1pd57g==
X-Received: by 2002:a67:3284:: with SMTP id y126mr9675320vsy.175.1587502045370;
        Tue, 21 Apr 2020 13:47:25 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id u13sm783300vsg.12.2020.04.21.13.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:47:24 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2] doc:Adding LESupportedRoles property
Date:   Tue, 21 Apr 2020 20:47:21 +0000
Message-Id: <20200421204722.195637-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds a new property to indicate the support for concurrent
LE roles which means that the controller has reported the appropriate
LE_Supported_States (hdev->le_states) and that the controller's driver
has reported correctly handling the various reported states.
---

 doc/adapter-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index acae032d9..f76e1e910 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -326,3 +326,11 @@ Properties	string Address [readonly]
 
 			Local Device ID information in modalias format
 			used by the kernel and udev.
+
+		array{string} LERoles [readonly]
+
+			List of supported LE roles.  Possible values:
+				"central" - Supports the central role.
+				"peripheral" - Supports the peripheral role.
+				"central-peripheral" - Supports both roles
+						       concurrently.
-- 
2.26.1.301.g55bc3eb7cb9-goog

