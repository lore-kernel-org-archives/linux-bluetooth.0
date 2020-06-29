Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A356AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C01E206C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TgqteYzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgF2XCg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgF2XCf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 19:02:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D84C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k1so7688846pls.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xY3f6LHANd9HL4qtWewE6j/avY0O3O3qpSOKn6v3IpA=;
        b=TgqteYzF3Qo8SNCLDAu3rSFoz4yt7f0q7lmXMZgfb+rHO72XZuJlEC+55r9B9t06U5
         AUDTaHAZns0j5Cn3MAgEfIK1cCRigF0gPt2Dm/eAAIml3PE/2TWjpxqq1urb3Xva0EBo
         MY3L+3JDAO0Ev9lg8w1e8NsQW39LDf9wLcHp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xY3f6LHANd9HL4qtWewE6j/avY0O3O3qpSOKn6v3IpA=;
        b=NBmmqLQsJ0oTpJdwa+z+PWsoYNhcUU6rMbCfXt9HO2j9BExTJTsH3PUzY7tmTOSzXo
         xLb/gAIJwNG12Qqh2XwYljASlfkO5R2lbmOCEuYaNV621xyHk77bhGol/pONHnNDO1iZ
         6Dnts3HjvCYbTJAzwpA9dm/NoglTjZylixV2Kcv/u+MWgCbkG6J1FCqZWOpluHoV4zEh
         NukMKeFk96PoH1g3PJE1A3AOTsHx0eH45RhCKYIIU7YglN3qu2nq51wBzOxSO8CQa+jB
         n8vkjAQmMosqKlS04grxrQSgWapmyy0qkvYrjTpLHdZAaUD5qluTLtSwjAq5J/665jij
         DVjw==
X-Gm-Message-State: AOAM53351mP1I+/dwGMK6r4k6ClRKEZADJyVH2uO0LVTh0iw96IO4rOm
        MqjieWXnneMeEcK8jczHdQak4w==
X-Google-Smtp-Source: ABdhPJzkQoby85gty2n0QUwDODB2heVXg5ccm3vGX9FUUp4oERuWFI6wET/Op5zKsjIWnVtYkvHOsw==
X-Received: by 2002:a17:902:8c8a:: with SMTP id t10mr12742132plo.153.1593471755120;
        Mon, 29 Jun 2020 16:02:35 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id i13sm467275pjd.33.2020.06.29.16.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:02:34 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v6 5/6] doc/device-api: Add WakeAllowed
Date:   Mon, 29 Jun 2020 16:02:22 -0700
Message-Id: <20200629160206.BlueZ.v6.5.If391d18ed934a1d9c24d3f54e4fee3fded0b17ab@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200629230223.3538949-1-abhishekpandit@chromium.org>
References: <20200629230223.3538949-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add documentation for WakeAllowed, which allows a device to wake the
system from suspend.

---

Changes in v6: None
Changes in v5: None
Changes in v4:
* Renamed WakeCapable to WakeAllowed

Changes in v3:
* Added documentation for WakeCapable

Changes in v2: None

 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 65d8fee37..4e824d2de 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -189,6 +189,11 @@ Properties	string Address [readonly]
 			drivers will also be removed and no new ones will
 			be probed as long as the device is blocked.
 
+		boolean WakeAllowed [readwrite]
+
+			If set to true this device will be allowed to wake the
+			host from system suspend.
+
 		string Alias [readwrite]
 
 			The name alias for the remote device. The alias can
-- 
2.27.0.212.ge8ba1cc988-goog

