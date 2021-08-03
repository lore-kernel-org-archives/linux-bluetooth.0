Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A95DC19F31
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8D9610CC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhHCLox (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbhHCLoZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:44:25 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23A5C061757
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:44:13 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h5-20020a05620a0525b02903b861bec838so16357369qkh.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BgXc2kiWvh+2MYy3WKOMfVJuAoB8PiBWseCwaLJ30Ac=;
        b=an90IaburIFSquqHgA8wIoA2feBnMT/COU6ZvWjf2uatCngTBWRtEX+3AfhZ7ajroT
         H4uN1/A6zxR42QtedP0RPjXZBfYNHqRdVfsAmI1CJacNTzFhDwc4Aviv2qXIKD8G7y2w
         NiMOJLR0LhYqVn6Ctfp8iD/bfjv9E1PDwKMVgYRn4/8vp0TVub+6QoQ87ekNdZJlBQVi
         jhkSBCTkBnPVnCDQ92a6JLwRZJ6cKQ3DKlMBar6i8VkT+KjpoI9qDatUGjvYJNZ0ThsB
         7jyW1QycVs+/cFNQXH8yqqMBEeti2ZEPFOfMvfV8xIxnpxl5EGVIGiYqzBk4OTY8NMHD
         Ei9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BgXc2kiWvh+2MYy3WKOMfVJuAoB8PiBWseCwaLJ30Ac=;
        b=dpFGd2SnGU/VwyytVUC3KFFfVEHt8k2tFfQg32v2oibkpv3DLurNkNuu2e+H8fF/T0
         Jdu6F6RTpg9a466fLxXQkzNV1lm6pbfHvFjZoLV8IKVd2rTTOA9ttcZbGIuMFXSQ4WMo
         fr3vuomAQe3C8xJxwsxFi0MOiGjyl8p/5esLEzBTnvUBvn0+0Di/AMI2DUnG4ENg/NvN
         +WJ2JWB2ZB8xpjcwQD9echqyU8hLnE1WpizIfUIgx7bnps8L8GZrTeY1LiUPdmPZygN4
         mHTfCx4VCNy5MBh3X/E4kIp0065kjxHjuhG1HyikWRWHsfYWCi9Q5X863uYYo7EJW1Xu
         7K6g==
X-Gm-Message-State: AOAM53399RmS9I5YNV06e6DZrIL3qUvL94jvij3ZohR+HQMXC5396sV9
        H2RIMPsMdwhWpzVmV5ng3w2Rfe83JfCUTeXLusWY5mBklbfmAX589qy0+Y+euRuOpQI5eHIldRH
        9v2H91hyhUyqJm/YokDAoSMGyfCZph6TGwHXiJKqjrZughOjFB6IC6YjoVW2Qr0ejEvrlB3ckq2
        1UeAVeFBuMkEU=
X-Google-Smtp-Source: ABdhPJwQfO+ETJr8jBGHxEHdjjoMWkuKtZo7o9cYDY+mK/XlKup0+2KhInfcdmlVSTGUeM1UTSf3vB3vE/cER2QnmA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a05:6214:e62:: with SMTP id
 jz2mr20972479qvb.21.1627991052895; Tue, 03 Aug 2021 04:44:12 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:17 +0800
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
Message-Id: <20210803194127.Bluez.v9.13.Ide727bc4654c80ce67a268b624a6c5a0f79a11e1@changeid>
Mime-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 13/13] doc: add admin policy file storage description
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds storage description of admin policy file in
doc/settings-storage.txt
---

(no changes since v1)

 doc/settings-storage.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index d21150f09ecb..1d96cd66d94f 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -36,6 +36,7 @@ root, named based on the address, which contains:
 
  - a settings file for the local adapter
  - an attributes file containing attributes of supported LE services
+ - an admin policy file containing current values of admin policies
  - a cache directory containing:
     - one file per device, named by remote device address, which contains
     device name
@@ -50,6 +51,7 @@ So the directory structure is:
     /var/lib/bluetooth/<adapter address>/
         ./settings
         ./attributes
+	./admin_policy_settings
         ./cache/
             ./<remote device address>
             ./<remote device address>
@@ -140,6 +142,24 @@ Sample:
   Value=4578616D706C6520446576696365
 
 
+Admin Policy file format
+======================
+
+The admin policy file stores the current value of each admin policy.
+
+[General] group contains:
+
+  ServiceAllowlist	List of		List of service UUID allowed by
+			strings		adapter in 128-bits format, separated
+					by ','. Default is empty.
+
+Sample:
+  [General]
+  ServiceAllowlist=
+
+
+
+
 CCC file format
 ======================
 
-- 
2.32.0.554.ge1b32706d8-goog

