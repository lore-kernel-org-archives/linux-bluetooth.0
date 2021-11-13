Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95181C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 02:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FE760EE4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 02:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbhKMCiz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 21:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhKMCiy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 21:38:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34B2C061766
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 18:36:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so8411892pjb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 18:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=THLf6o3JzTtzThS8U6PlEoELizBkSo+EEng61BaAMTI=;
        b=pTVw/xmqhCyb708C4KeiB3vRMwKhYpL8kPZ7Ov/JQ6zB88pVU2XyeiqTibRFGQi42t
         jZjQlklAtj6e2U2kzcf73xfjOduMr/Ctt/OrCjlqzUt1+y+NYwvSjyNxxDA8YsgwuJh9
         WkC2OY1bMoYW+2Y8JsLOSGiFluHF+MAuNLacsWqlkB65bFBLnsUY09IJxj0iFcZYpiBP
         QSFYI7J0bXl9J8UZXiSae6TtIb0IJH+ofxWMsSRu3G4ual/rtlPBYNttPVyUkTZ0EIzh
         cdDDhvvuzL6nDkfiueKVIYS3jrS6YjSo3iSlaEndx/Vg7h7xG9HdeFzcSRGN6dchCg+F
         Z0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THLf6o3JzTtzThS8U6PlEoELizBkSo+EEng61BaAMTI=;
        b=OjRQZFw/wsN/F1hQkYSPPob9zfF0RQ8jPbdChW421QKGJs5u89wc3smf71v3XzyEE0
         tMBYzh7pRmLFHGsfT54zvAC5m0C0h/ANUOEZ1iORhhm8wL37gmZYDk2VylDMhnpN+ygX
         ZKXWTYF35K5CgaHe5vMKOWelwUU7uM0Ss0Vl4KzgCOq8ErQkYj7vQK5rWgDjEAkLWe2V
         KR1fIi6Gk0jcqz1iZn7jPsLvPZp1PL/KuLtkdnTYWzCRX5Hnh2jayEtmNbsOvJm3Ah8T
         C2Ks4ZHZvsEu+jOLkszdLEqbybBSK0OVUOBvfNWNBYtJEuxwfaA/B/NZgYWYPyAcMGFK
         VS1Q==
X-Gm-Message-State: AOAM5318vifdBWiSfEjprlcRGUl/bGTXsFxWmHcd5Kq4nNNEWgpdb0c6
        YzO9aJ1hoPUfK/k0qWkeyrDqLhUbZKA=
X-Google-Smtp-Source: ABdhPJyp0sUgk5BWb0UmcTul4Rh2TeX+PRJsHVRPIKvIYKtF4UWbHnvo/aKhcuQAvoC8Hw0K7GYunQ==
X-Received: by 2002:a17:90b:17cf:: with SMTP id me15mr22998856pjb.125.1636770962128;
        Fri, 12 Nov 2021 18:36:02 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:5c5a:3570:def6:e3d5])
        by smtp.gmail.com with ESMTPSA id co4sm12006768pjb.2.2021.11.12.18.36.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 18:36:01 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 3/3] client: Fix uninitiailzed scalar variable
Date:   Fri, 12 Nov 2021 18:35:59 -0800
Message-Id: <20211113023559.212793-3-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211113023559.212793-1-hj.tedd.an@gmail.com>
References: <20211113023559.212793-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the uninitiailzed varialble(CWE-457) reported by
the Coverity scan.
---
 client/gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index ce13b3341..9c991c2ac 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -175,6 +175,7 @@ static void print_service_proxy(GDBusProxy *proxy, const char *description)
 
 	dbus_message_iter_get_basic(&iter, &primary);
 
+	memset(&service, 0, sizeof(service));
 	service.path = (char *) g_dbus_proxy_get_path(proxy);
 	service.uuid = (char *) uuid;
 	service.primary = primary;
@@ -257,6 +258,7 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 
 	dbus_message_iter_get_basic(&iter, &uuid);
 
+	memset(&chrc, 0, sizeof(chrc));
 	chrc.path = (char *) g_dbus_proxy_get_path(proxy);
 	chrc.uuid = (char *) uuid;
 
@@ -350,6 +352,7 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
 
 	dbus_message_iter_get_basic(&iter, &uuid);
 
+	memset(&desc, 0, sizeof(desc));
 	desc.path = (char *) g_dbus_proxy_get_path(proxy);
 	desc.uuid = (char *) uuid;
 
-- 
2.25.1

