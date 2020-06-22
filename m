Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D6FC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65D020720
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d/b3OYTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgFVXlN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbgFVXlM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 19:41:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE29C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so8997858pgk.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4uFZVzrG9+F3xibfIkVhnHUnIUo2jKohyxEvygPu4H8=;
        b=d/b3OYTrRdCe5+RoIHr/vG06+exg6bxQE8xD5ZBMjmng78a4u5vhgCS+GbV5Zng/UC
         Zg+mPcuBmAXuDmP/r/G68vPSLQEypI9UT0ljBfw3gPJ1cAWEG14+cNoJRBxmUIZZba0j
         qn2nNod4lqdf2y18ZzCz9Wwu932Yx+jBzzGV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4uFZVzrG9+F3xibfIkVhnHUnIUo2jKohyxEvygPu4H8=;
        b=Up0E9f4HLB6HstHQZN7HRbQqcSGsNgRzloHf2h/WRmfrlKR4LwOtab1FoN3rGNLlLC
         DYhJ7GN2COrjq/JCakKoURBdLYZapo/MoQ+YJGvJekx7pWVcRB2nqZk1vmn48/9Rt8dm
         C7d9EV5hzzYjYAv09waa18Fy5K2LbWFzP4fmV0GPnmT6+NihYyck0eOTTcOLBmh6aKrE
         1y0HCzPLu8DJF6RKNeUixE4kmsDpAfXrJGjks2qlKAucJrIBTQloOFYBvSzLF5lyJEo9
         3Q3VWF0tPEy0bXMUBlHfGDvko9K52Mhc/2WyykDIHd4NoYZVJRYlqivIrpWnF4lhsjUh
         t8ng==
X-Gm-Message-State: AOAM530ZnV7JmnUuF481Mu9CoaA9AQc/8bPgUoQhkfYx63C/8T7ryY0W
        bDl5KlW1JKzq4EqfVzfa9JaZMA==
X-Google-Smtp-Source: ABdhPJwkTNN65JZtzY/loqnnJXxVqFZbAVEZvw/RsDvRfP2Phy7oQqECia8zSoFIP/AQDavZYEZWNQ==
X-Received: by 2002:a62:e81a:: with SMTP id c26mr22515998pfi.281.1592869270621;
        Mon, 22 Jun 2020 16:41:10 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w22sm15049500pfq.193.2020.06.22.16.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:41:10 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 5/6] doc/device-api: Add WakeAllowed
Date:   Mon, 22 Jun 2020 16:40:50 -0700
Message-Id: <20200622164003.BlueZ.v5.5.If391d18ed934a1d9c24d3f54e4fee3fded0b17ab@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622234051.206800-1-abhishekpandit@chromium.org>
References: <20200622234051.206800-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add documentation for WakeAllowed, which allows a device to wake the
system from suspend.

---

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
2.27.0.111.gc72c7da667-goog

