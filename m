Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC51C4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B154220753
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 01:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C8E0aD14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgCTBuc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:50:32 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51584 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCTBub (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Mar 2020 21:50:31 -0400
Received: by mail-pj1-f68.google.com with SMTP id hg10so1801586pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2020 18:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PwTkDVax+9S5osced+g7kTgXU9VF2EcYgGp89+K7CWQ=;
        b=C8E0aD14RozvgrDkMU9hh78zuU+a3EqWbwAMgTZmbN4CsEvI8XwuJcw+5OGbP2VJ3s
         uEWe/UT2KbZM5FuNOkWUd3UUWiIBsOE4deTQAwXRnf5cEZeHjrDzFcXw/9pBgicn08eg
         sR6Qijjb8H13uByxxKyq7bMh/JIhGBozruHnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PwTkDVax+9S5osced+g7kTgXU9VF2EcYgGp89+K7CWQ=;
        b=qB0xWh1rwpR6ouNkQozwvfudNFJw+DTzF+QD8YBLqZyWImowUkYCrDGvVyJik36Akf
         nAk5DjQGVaezTqmPlAzzxFb+3sEeXAaiFHsm4oxtT5YKQCqoVXlzDoM+gXa3nMtfxgYg
         5Oc+nFPFwqoYk4YAbtxK19A6e+iVkME3xIGYiCN7XEfwHiCgnK7/CalrZp3S559F3etP
         9Cc8ZITWTKNb2pSNF941D6VCZShQ859L6kxikQ8XGEvHvLDmXD7AcTdx6jJFPFZdwv2u
         Nf6Fxw+Ki2phu2cgHmJZA2OaHiJJkbMYNlzvRJYTndCAExZGXk/An6r3SA0pnIdW3NIm
         zUrw==
X-Gm-Message-State: ANhLgQ2YZh5pkTp8FxKbbS7fBp1dOEIV9H+HUhu5PgEGtbqMOriY1/aY
        roku0/drDmOE8JzvEHC97hjeSQ==
X-Google-Smtp-Source: ADFU+vvZHk7eE6Xif4GCoiBEsY6Pn4IabOoEbn5dNM3dBYOhfEv2dcdA6Rn6YXGdbdi2m7didx1K5Q==
X-Received: by 2002:a17:902:904c:: with SMTP id w12mr5816135plz.338.1584669030679;
        Thu, 19 Mar 2020 18:50:30 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id 136sm3410485pgh.26.2020.03.19.18.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 18:50:30 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v4 4/5] doc/device-api: Add WakeAllowed
Date:   Thu, 19 Mar 2020 18:50:22 -0700
Message-Id: <20200319185000.BlueZ.v4.4.I5b076d560ee47afa4c9a8d5602aebf67ffd3d131@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320015023.85896-1-abhishekpandit@chromium.org>
References: <20200320015023.85896-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add documentation for WakeAllowed, which allows a device to wake the
system from suspend.
---

Changes in v4:
* Renamed WakeCapable to WakeAllowed

Changes in v3:
* Added documentation for WakeCapable

Changes in v2: None

 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 65d8fee37..6b265c73b 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -189,6 +189,11 @@ Properties	string Address [readonly]
 			drivers will also be removed and no new ones will
 			be probed as long as the device is blocked.
 
+		boolean WakeAllowed [readwrite]
+
+			If set to true this device will be allowed to wake the
+			host processor from system suspend.
+
 		string Alias [readwrite]
 
 			The name alias for the remote device. The alias can
-- 
2.25.1.696.g5e7596f4ac-goog

