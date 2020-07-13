Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653B8C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 20:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C342076D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 20:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eRfNJtyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGMUPD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMUPC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 16:15:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3558C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 13:15:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so6011016plr.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2020 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPLCESdS/Ve1h9h7+XMTn1nlcKJ28YFSVJfO0CW+h5Q=;
        b=eRfNJtywXo3LygM13DluPcmtp1uxJcCcbYpA/gcHHRI5glgbWwyrx+NWBYH/rJpA9y
         7FxcYqbcwMLdYmGqly6KSs4Pf/CyU5c79QNQovyIT8BdT5DTxQ/WjAL5ipZ5Ns/ROKYj
         dmCfo9/h+AIcfu/x6tozDcUb6v4cGQfpIm7DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPLCESdS/Ve1h9h7+XMTn1nlcKJ28YFSVJfO0CW+h5Q=;
        b=cg3C4xfO4ZyV6zAcNarJJZti79JYizQa8Bsx/fClgm8QHjYB86pPAiIs+ObhsvNuBq
         AKMH/oe46v5Ndl3xDk5eos36j/Ua0YNkO8slezhiA7/gTdk5TFmsR2nBWv3slld1Ahq5
         q0jr76swDZsJArPiZneYQD/novLCqdR7rHaC0uMtTdOCPBs3u1eTx0sfB9w9ye2nM+1e
         wh27lLpLtjPLyRJdkA/8jjQqMXcdUaWEBz0w22amniN3kEeUC4q60CfR8JUHrq6Q1TTV
         SlH2/FoAj4cfHi4r+G4Ebk2tD2GWpNhgs38D8tJmT8e0zbc5zy103ooUWkiErSMzILqX
         AXWA==
X-Gm-Message-State: AOAM532IUW9cMdYwVGYeufs7p2xmkwbP53qxIcs/sVJGffymwY0I/Lwr
        RfgvGEr/HpOUMBQ0rgjTXJdXfQ==
X-Google-Smtp-Source: ABdhPJx90lgXLXGMBM07VI7NfT+wBeZIIGLGjq10C5JzG2M/Udv0vGnBiPKT4cV4dBGJRVRhivlX6w==
X-Received: by 2002:a17:90a:6948:: with SMTP id j8mr984297pjm.45.1594671302200;
        Mon, 13 Jul 2020 13:15:02 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id h18sm7866135pfr.186.2020.07.13.13.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 13:15:01 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth-@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ 1/3] doc: Add "AllowInternalProfiles" property to org.bluez.Device1
Date:   Mon, 13 Jul 2020 13:14:39 -0700
Message-Id: <20200713201441.235959-2-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713201441.235959-1-sonnysasaka@chromium.org>
References: <20200713201441.235959-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 doc/device-api.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 4e824d2de..5c2b2b26b 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -189,6 +189,19 @@ Properties	string Address [readonly]
 			drivers will also be removed and no new ones will
 			be probed as long as the device is blocked.
 
+		boolean AllowInternalProfiles [readwrite]
+
+			If set to true, connection to this device will activate
+			BlueZ internal profiles (e.g. A2DP, HOG, Battery).
+			If set to false, internal profiles will not be activated
+			allowing the client to handle profiles which would
+			otherwise be controlled by internal handlers.
+			The default is configurable in main.conf.
+
+			Write operation to this property can only be accepted
+			when the device is not connected, otherwise
+			org.bluez.Error.Failed is returned.
+
 		boolean WakeAllowed [readwrite]
 
 			If set to true this device will be allowed to wake the
-- 
2.26.2

