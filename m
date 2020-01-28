Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF55C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 02:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DBF2467C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 02:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tf5vMLAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgA1CFP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 21:05:15 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:40727 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1CFP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 21:05:15 -0500
Received: by mail-pl1-f175.google.com with SMTP id y1so947650plp.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2020 18:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S6MZbi0mzpP07Agsgnrrb32qLrG53mkbj8Al32OGINo=;
        b=Tf5vMLArMDXrKq+rzrIaoAUQ9S33pODR3uJ8Lk4kVvt5QVPPXH5rL6q+tc8pLRYzTU
         TOgnRqXb7ebm+Vbsg1n1LEEsnXS4yFOT6bc8mbgT5Hgg+9ZTQcA65TPaMc23eD9jm+Ae
         FcKRUwxxHUjvanNVbLlCrbQwrxWEu3XFUV0BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S6MZbi0mzpP07Agsgnrrb32qLrG53mkbj8Al32OGINo=;
        b=o8JnEnscJn+VOEH0Zx5RvzrOUVN2IpIlw36Xf+eDrBNyganioOeD61oSn1UgBvRAKN
         Sq5VYg8LX1pfYAyXqY4zuGYJThwIxx5KIYsPbPUiGbKcdXEhVBWLzHQvrQxIYNpstHv8
         RZZ5iNqd0lCXmCujv5tp/gFLqlGV1S2ipF+Bj8KMGGMA4HFFxKoeh+Xlsg4yHKuGAFQM
         c0rAflm41kJ+gf/S16lNZPK1nE0zOVNV/GznS0OuMhVtmbnNL4DwDBfEFJi8HDgoo8BM
         qqsoWPa0eBGzKRAyWit7ewmVsNsS8f+V/aUzdHpZCy87bMvr3KpTJXW/iHIOLrMnNWgf
         w2HA==
X-Gm-Message-State: APjAAAVWsy2so2Ds7NazIh8+/TylTv0qvjvMeEjxzVdLXA6RGQdleuOn
        Ca6PEf04QVxatxFZ5YTsZ/CrtA==
X-Google-Smtp-Source: APXvYqyrgcuhfFt/TokltexN0CzeMB2kPlZUldmu5KCsDwi9q/6IZWNlocYiwhYnXLH304yEKyX1fQ==
X-Received: by 2002:a17:902:7442:: with SMTP id e2mr8339069plt.158.1580177114545;
        Mon, 27 Jan 2020 18:05:14 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id z19sm17119015pfn.49.2020.01.27.18.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 18:05:14 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH v3 4/5] doc/device-api: Add WakeCapable
Date:   Mon, 27 Jan 2020 18:05:04 -0800
Message-Id: <20200127180433.BlueZ.v3.4.I5b076d560ee47afa4c9a8d5602aebf67ffd3d131@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200128020505.239349-1-abhishekpandit@chromium.org>
References: <20200128020505.239349-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add documentation for WakeCapable, which allows a device to wake the
system from suspend.

---

Changes in v3:
* Added documentation for WakeCapable

Changes in v2: None

 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 65d8fee37..492a7f8c7 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -189,6 +189,11 @@ Properties	string Address [readonly]
 			drivers will also be removed and no new ones will
 			be probed as long as the device is blocked.
 
+		boolean WakeCapable [readwrite]
+
+			If set to true this device will be allowed to wake the
+			host processor from system suspend.
+
 		string Alias [readwrite]
 
 			The name alias for the remote device. The alias can
-- 
2.25.0.341.g760bfbb309-goog

