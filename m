Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C6C33CB3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E023720842
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 21:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AsxFrYOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgAQV2T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:28:19 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38900 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgAQV2S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 16:28:18 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so3894360pje.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2020 13:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9y9il0kC93JGG3FVJiBkjdDB4nyw3/7Pni/iIyZYTnI=;
        b=AsxFrYOxg7STkCo3KJfJvcyI/P5MkO4H3t+0m6ELJoZiVK3MprOu5DQiuF2FPPQw93
         aWcA6im7u61eQEZEijOfJXY2/UWt/sv3hFVKYw1ICplQiwmLdbH/nRvoLb5HCZVwx2HR
         Bg1aqxCa+Kbp4vhSsCAyku5zC80vmq3DUEPws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9y9il0kC93JGG3FVJiBkjdDB4nyw3/7Pni/iIyZYTnI=;
        b=iYUK4gUVJPSUofqVBGPkTORSprTS6qz1sWs02N9PFCm+W74HKHjT1/BlNpVJZTRGiY
         UohY6opxb6auXau6n9CtA2cgYf+EfYcljc8IhiwurBhuunwDu8+Djh8tHDJDFCr282rF
         P9z3yJuqSdj1w65NGgcgnTNSxLur1MeBwyPDm9dvFulROLATm726UYwMt/o/9ZR0UedF
         2enhUt5hwSMJm8s12PkPmZpBWmAwnwYVXUiT9YMyc4vMEwBMN4jMc2bdL8UlrLYF4npb
         2lDYaZu9I0j3vVxeYayrVemfvuZUTxBDTfoN8G1hFatOvNEZXu01kKlyjt12szsw9+0h
         67Uw==
X-Gm-Message-State: APjAAAXG7Io11SmPVvbDZIfYMIqR6+KAXc89ndSIEJ3RtWV+Lxdan4Ki
        4QUHw8uXHaAZjAlswqrMiQqvqA==
X-Google-Smtp-Source: APXvYqxjcqR7KcQSAvt839znyqr9Zjo/jTeJ2lFF23kr0a1hc+eKYHVg9fYAZCtc3/ngJMcKq4x8eQ==
X-Received: by 2002:a17:90a:5215:: with SMTP id v21mr8405134pjh.31.1579296498265;
        Fri, 17 Jan 2020 13:28:18 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id j20sm29938790pfe.168.2020.01.17.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:28:17 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH 2/2] input: Make HID devices wake capable
Date:   Fri, 17 Jan 2020 13:28:13 -0800
Message-Id: <20200117132754.BlueZ.2.Ie24be91b472c0a274606191bc4d14df030fe3598@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200117132754.BlueZ.1.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
References: <20200117132754.BlueZ.1.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HID devices can wake the host from a suspended state. Mark them as wake
capable when they are accepted.

---

 profiles/input/device.c | 1 +
 profiles/input/hog.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 2cb3811c8..a6b0e8053 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1381,6 +1381,7 @@ int input_device_register(struct btd_service *service)
 	}
 
 	btd_service_set_user_data(service, idev);
+	device_set_wake_capable(device, true);
 
 	return 0;
 }
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 83c017dcb..8627f3557 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -159,6 +159,7 @@ static int hog_probe(struct btd_service *service)
 		return -EINVAL;
 
 	btd_service_set_user_data(service, dev);
+	device_set_wake_capable(device, true);
 	return 0;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

