Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7873BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572B820720
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dTi0e7hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgFVXlM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731085AbgFVXlM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 19:41:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D13AC061795
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so1971348pfu.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3PfK6QUgkIF1Eoe6Yq3txIIjXluV0eFd2f20nkoGxM=;
        b=dTi0e7hqPsOq4VW/d2Nvfv24/RzBW1kGkz7E2KI8ACl7q8AG1HPDqyuILCFOWx0ozZ
         B3ZejWHeT92xh4Q7HUZllBZlraDBv8j7PhhtPBQ3fzHDXBk8qw17J0AuYT3LkKK6J1lj
         os8OCLyGf6YNt2F99OKiBXUjz0I9YiRkDfXxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3PfK6QUgkIF1Eoe6Yq3txIIjXluV0eFd2f20nkoGxM=;
        b=oPT8x++dzOlSOSTKNhFxxtTJN7V5xLZob7kGs3e+rr0KDXeDwP3JC0GnDSmpJ1E/F1
         e8s5dqXjJ7pkBmMqknzRJKHZgoisFmA9gfKK1E12cx4XVZdlOuRqNCS3N1TQYxZ65Awz
         Ps2CWYEkXzp4N5moHo8p9uuQrUR5xyymdQfwm/amP6zpFSxqhEPL59PQJWhe3TklKtMo
         sVbusY+pL4kFLGAVgiGzLesFlt7BDCzLLfYmq03Ai2gx3Qy33LKX93mKMyTrGcJt1A7N
         fmyCxY8XF0LLEoeMjyasf7q27MDUAztS9RjZflJv28TzxMvYEmlTBCDBdlIFes1dhirH
         jO5A==
X-Gm-Message-State: AOAM5300uIUs211dZmLtV7W1mr37+Y6OTxwLqLH3wicgKsu6IQxMKlM+
        eHy7cGiQnuv8sgvnQ2NJXKQ1SQ==
X-Google-Smtp-Source: ABdhPJyLG4hue6NS4lAgOmntU3qOooAM1nwcamYyIGZJ+R/PbB4MLz3+O8rP4NyUfWF3wMAGTQ8vBw==
X-Received: by 2002:aa7:99c4:: with SMTP id v4mr22749933pfi.40.1592869271573;
        Mon, 22 Jun 2020 16:41:11 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w22sm15049500pfq.193.2020.06.22.16.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:41:11 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v5 6/6] input: Make HID devices support wake
Date:   Mon, 22 Jun 2020 16:40:51 -0700
Message-Id: <20200622164003.BlueZ.v5.6.I3290604153369ff32013f3dcadda4df3f2eb0f36@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622234051.206800-1-abhishekpandit@chromium.org>
References: <20200622234051.206800-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HID devices can wake the host from a suspended state. Mark the profiles
to support wake when they are accepted. If the device hasn't already
been configured with a Wake Allowed configuration, it will default to
yes when the profile is accepted.

---

Changes in v5:
* Only call device_set_wake_support

Changes in v4:
* Renamed device_set_profile_wake_support to just
device_set_wake_support

Changes in v3:
* Mark HID device to support wake from suspend

Changes in v2: None

 profiles/input/device.c | 1 +
 profiles/input/hog.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index d3724ed54..2dc2ecab2 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1409,6 +1409,7 @@ int input_device_register(struct btd_service *service)
 	}
 
 	btd_service_set_user_data(service, idev);
+	device_set_wake_support(device, true);
 
 	return 0;
 }
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 9335b7e8b..130f696a9 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -166,6 +166,7 @@ static int hog_probe(struct btd_service *service)
 		return -EINVAL;
 
 	btd_service_set_user_data(service, dev);
+	device_set_wake_support(device, true);
 	return 0;
 }
 
-- 
2.27.0.111.gc72c7da667-goog

