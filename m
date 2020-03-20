Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC72BC4332D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B4F20753
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nN4ECh2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCTBud (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:50:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46670 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbgCTBuc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Mar 2020 21:50:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id r3so1832990pls.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2020 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DfSSR55MLYDi3PSWtKuQhudT+yQxp3dfMZoaynRORc0=;
        b=nN4ECh2vEbK6E4nOaAfv8m3kF0O8q6jQr71Prf7fXog6jlgdDV95kXPcAfjYbLPFVx
         AWTngBBQJL443t4jrpyYllBtOtbqikx0GEtSh2iN9wI7KSxdHJizKNMpHrLAVTqRgs0m
         zH7pE1s0KoOOiuiA7yiWyEK06EpirH0v/gCpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfSSR55MLYDi3PSWtKuQhudT+yQxp3dfMZoaynRORc0=;
        b=rMJlUcfIYd2T1w0BHqhfZDZX/dRThUuJtBuNglu8VgCSg4ZMy8qm6u0jaBX0PeK9dA
         nLPtovdFAcLtGD6HiRyEL5GWDwPVz83rkVVdBn39JZ1tLKvAkFwBxt/A4JDB8q178O+x
         UYEQUh5O/GrYSZrkuIThIcal2rSF8CUjPlEKgCXybDP8gDzvMEjHMs3NiIWC4iLd26SJ
         W1alGtJHBhC6NwkuKDkKgMYMFoK7atfpUcHkV8pjmxBfgNOgODx4V9hlD5X6fsQnjgZF
         jWBdvicOxsFpRFAqzm/bPN7LdK7R6gSHEzlGvunHG0mNHEBoSx1133zt2fvQTc3RTkie
         hmkw==
X-Gm-Message-State: ANhLgQ02tnIvv7Tc+/rh3LZjEQzzGKOJ501uvMBUeforHvWuuatCj8aK
        Szuj+3JB7U8P1s7jtkxIiw8M1UB4s6k=
X-Google-Smtp-Source: ADFU+vsDQbEhsN2tuFHtUsI/7N3So4T9imSCXTf3HpOZDKL+p8NNTg8ql2UrgUz1pzIsY6iXshykqA==
X-Received: by 2002:a17:902:82c7:: with SMTP id u7mr1585982plz.10.1584669031576;
        Thu, 19 Mar 2020 18:50:31 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 136sm3410485pgh.26.2020.03.19.18.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:50:31 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v4 5/5] input: Make HID devices support wake
Date:   Thu, 19 Mar 2020 18:50:23 -0700
Message-Id: <20200319185000.BlueZ.v4.5.Ie24be91b472c0a274606191bc4d14df030fe3598@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320015023.85896-1-abhishekpandit@chromium.org>
References: <20200320015023.85896-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HID devices can wake the host from a suspended state. Mark the profiles
to support wake when they are accepted.
---

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
index d89da2d7c..d2a4ec82e 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1402,6 +1402,7 @@ int input_device_register(struct btd_service *service)
 	}
 
 	btd_service_set_user_data(service, idev);
+	device_set_wake_support(device, true);
 
 	return 0;
 }
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 327a1d1c3..0e4bd1c34 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -168,6 +168,7 @@ static int hog_probe(struct btd_service *service)
 		return -EINVAL;
 
 	btd_service_set_user_data(service, dev);
+	device_set_wake_support(device, true);
 	return 0;
 }
 
-- 
2.25.1.696.g5e7596f4ac-goog

