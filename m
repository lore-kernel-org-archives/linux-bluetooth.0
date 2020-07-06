Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D174EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2D520BED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 20:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMsRRXFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgGFUZi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGFUZh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jul 2020 16:25:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B951C061755
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jul 2020 13:25:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k27so2824359pgm.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jul 2020 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kufSIwBkTCOC8NS3izomh7PEGJvrLLTDuQTWRmVaS3c=;
        b=WMsRRXFAsVnGc3JgqeyrWeQNQ0kqBbB8/AHUpF5Kawxj6P7sEJaiFBjkNqjWlRY1RJ
         eImakgV8lXHteuTc1tsC68NI0T7Ls9JdsEqzOwSHLVfszBYo6g2VXlrYnxdM6W+zyk2T
         elkNKxlXkoF5C8uTuGksqGWzAbpr/I79+MpEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kufSIwBkTCOC8NS3izomh7PEGJvrLLTDuQTWRmVaS3c=;
        b=gNsJIdaETgxwMSaS9kZATTq1EmF34X6xZHvRmnaJhybIE3oofXTZvUu2gGqoiGD73G
         MQuyVUWIppxxQSSy2TjJ45Q9t/sK09bpYZ39nhgnf1HeUDv10QoXAIxBFKbWOXFaBbcQ
         7c8VNP1tP4bIhsx6c8LbljrBUppSpohM/PiF2Rs04pu5A/fwcvFhIXGKiXaiz1LbNF0a
         7FefgNK5jpLz3iV1uUwyDq9UnTPWTKFmDLMymS0J0xNtGJBppsnHelEteQG8Nik5+wGq
         ILrVv1W2SKPnOuCf5dKoTex3Dg8+H6C+JSHMmtXIWxkOysATpIlAIDq83l3jf/b1QxZM
         08sg==
X-Gm-Message-State: AOAM530OPjKmWLJTauTiQNyI44d1C4rK/G0z31rOkzXbXCUbkejtgpsJ
        KT0P6YceI3zWRDT9Fls9Rqq6LA==
X-Google-Smtp-Source: ABdhPJzRQSblEfSUXwfIhsKThWX/YcGcUNbhgVD+xNOMqB7FCxZPtpIPVACoVPl+OklOwZrArP6FeQ==
X-Received: by 2002:a65:60d4:: with SMTP id r20mr37992478pgv.436.1594067136842;
        Mon, 06 Jul 2020 13:25:36 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id n25sm3320226pff.51.2020.07.06.13.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:25:36 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, marcel@holtmann.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v7 6/6] input: Make HID devices support wake
Date:   Mon,  6 Jul 2020 13:25:18 -0700
Message-Id: <20200706132503.BlueZ.v7.6.I3290604153369ff32013f3dcadda4df3f2eb0f36@changeid>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200706202518.1153647-1-abhishekpandit@chromium.org>
References: <20200706202518.1153647-1-abhishekpandit@chromium.org>
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

Changes in v7: None
Changes in v6: None
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
2.27.0.212.ge8ba1cc988-goog

