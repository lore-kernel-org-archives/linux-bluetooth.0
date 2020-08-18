Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04282C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 07:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44262075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 07:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLXTjLg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHRHe0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgHRHeZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 03:34:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01486C061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 00:34:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so21189954ybi.23
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8eTraBlLlZCXBncwAvZWxQxxNtGKOGN+XtQwQFx1HXU=;
        b=oLXTjLg9JsSbeSESfrYdN+sWTj4eYdQBTbi0VDv9oe97jmF+izvH84C+t9zSXZ8RgY
         mp4STyZ1D9wvXZuJiDhpUdmzC7ZWdaslsH+MtuNx0j3J39NUNbJ/wiNL3ztpw1KSf1Lo
         luREMngUkloNOjk3pbMnQ5Rkxv47+BhUfcNtNpNlksUv5/cE/PpLBMjv2VB4MM/rh5Ss
         EV8FmlZUYqbDcjFEugVRiGAcpashJP1XVkMZ9VSX6F34r6Ck2NlQ0rUF9ni1YdRpg7rl
         hOWSZJOJkA97lu7Li1ynSWrsoTI0JF5yfsWeMo5fxVtQxWCcleDTSVs1Lpr86pPtVs5J
         tNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8eTraBlLlZCXBncwAvZWxQxxNtGKOGN+XtQwQFx1HXU=;
        b=K3wtRp0XWvtVHhrOo8H0r4tgegbyHa8emMNs9UEa72c6T3vDDh5yFETIWnzwhy32UD
         Spb71J7hWboAPtNf17CMhuYv0qR2No6mfcLpDrAj/7oJTi31kqzsXw/mybBjJirYB9n3
         w8jnK40C+L9OOM01Ml2JpoUlqX1adZ/ugDjgMQNWGrxZ9gCdPSb1FsV7MlNYjMJsGjs7
         VJA8gybPnyDzczNpeg1V+wDtQzyiwKIQ/i9IlcULDgW2I8Z4xnjQAdVtRmPHp2w2blRn
         EndTcoVw/YvYPeZ8Eh2Vh2MtpYYWywCLXjAK2p39OE5BQsRV4GMWE6iZ4CyzoEXwFEIW
         2/TQ==
X-Gm-Message-State: AOAM533R5SEVlRwU0jIWfiHU08xk9sFnbhryxKtK3jrmSjduYWBDxZ2q
        /VldGDgeCwzkGzofcmXj8gHRPHOOipsthQrpgokDpplpkKsCMhfipdnb8Wq7EKMGnRsIAM4QddH
        /dwiMnh7BqFD2MOMJ6ROk9fHt/ZnrAipB0HKU00G29xU2Rb6+A1c5/imSvKmeN/YEc+gzhqyByu
        Dx
X-Google-Smtp-Source: ABdhPJwBQ3GuJfx/yUbGcoSKdYE8lQg651boXcPHkh1lnS3K7Usfz9FttXBdXqViV2452GkFUxZ5kF4ryBC7
X-Received: by 2002:a25:7453:: with SMTP id p80mr24878522ybc.441.1597736064054;
 Tue, 18 Aug 2020 00:34:24 -0700 (PDT)
Date:   Tue, 18 Aug 2020 15:34:10 +0800
In-Reply-To: <20200818153257.Bluez.v3.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
Message-Id: <20200818153257.Bluez.v3.2.Ic94b32e61bb62c601e5c56e2eb32a4896c4bbf1c@changeid>
Mime-Version: 1.0
References: <20200818153257.Bluez.v3.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [Bluez PATCH v3 2/2] main: add configurable refresh_discovery parameter
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This is to configure the default behavior of issuing SDP query
to update the services upon profile connection.
---

Changes in v3:
* Add main_opts.refresh_discovery

Changes in v2: None

 src/device.c  | 2 +-
 src/hcid.h    | 1 +
 src/main.c    | 8 ++++++++
 src/main.conf | 4 ++++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 52dfea18f..a91eda027 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4076,7 +4076,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	device->db_id = gatt_db_register(device->db, gatt_service_added,
 					gatt_service_removed, device, NULL);
 
-	device->refresh_discovery = true;
+	device->refresh_discovery = main_opts.refresh_discovery;
 
 	return btd_device_ref(device);
 }
diff --git a/src/hcid.h b/src/hcid.h
index 5f249ebf9..3624ba6ea 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -100,6 +100,7 @@ struct main_opts {
 	gboolean	name_resolv;
 	gboolean	debug_keys;
 	gboolean	fast_conn;
+	gboolean	refresh_discovery;
 
 	uint16_t	did_source;
 	uint16_t	did_vendor;
diff --git a/src/main.c b/src/main.c
index ec7a9fbd7..b205575f6 100644
--- a/src/main.c
+++ b/src/main.c
@@ -627,6 +627,13 @@ static void parse_config(GKeyFile *config)
 	else
 		main_opts.fast_conn = boolean;
 
+	boolean = g_key_file_get_boolean(config, "General",
+						"RefreshDiscovery", &err);
+	if (err)
+		g_clear_error(&err);
+	else
+		main_opts.refresh_discovery = boolean;
+
 	str = g_key_file_get_string(config, "GATT", "Cache", &err);
 	if (err) {
 		DBG("%s", err->message);
@@ -688,6 +695,7 @@ static void init_defaults(void)
 	main_opts.reverse_discovery = TRUE;
 	main_opts.name_resolv = TRUE;
 	main_opts.debug_keys = FALSE;
+	main_opts.refresh_discovery = TRUE;
 
 	main_opts.default_params.num_entries = 0;
 	main_opts.default_params.br_page_scan_type = 0xFFFF;
diff --git a/src/main.conf b/src/main.conf
index f41203b96..42f7e41c5 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -82,6 +82,10 @@
 # 0 = disable timer, i.e. never keep temporary devices
 #TemporaryTimeout = 30
 
+# Enables the device to issue an SDP request to update known services when
+# profile is connected. Defaults to true.
+#RefreshDiscovery = true
+
 [Controller]
 # The following values are used to load default adapter parameters.  BlueZ loads
 # the values into the kernel before the adapter is powered if the kernel
-- 
2.28.0.220.ged08abb693-goog

