Return-Path: <SRS0=rxlX=4P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B083DC11D3D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 19:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CBD24691
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Feb 2020 19:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KKcGYu5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgB0TWg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:22:36 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:37308 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgB0TWf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Feb 2020 14:22:35 -0500
Received: by mail-vs1-f41.google.com with SMTP id x18so398559vsq.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2020 11:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V4ANM0b74s6dfvQa89CPbaUJcPENEXPBWmM+dvZxjRE=;
        b=KKcGYu5o4LFuXUp91El+FX+w5t6+TaTyjjv3VavyadblyIUQVFvToMHDwD651xCN0I
         8jcMmCN1TGCxJhbbxnRqLjTI7KcKTxGxz2lxGb6bcn3rMTxH5ZoDE1shrt7tIyB7I6q3
         JF3KXY0r4P3IpWZs15Kphmr80Ru5S2jLPl9RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V4ANM0b74s6dfvQa89CPbaUJcPENEXPBWmM+dvZxjRE=;
        b=PI+VJTiRj9vW+krAYxvUoHnbgNhGKuL3yJ8IPY0xoeMHuKujksVpI1UNecCmIAjR43
         7epYjB2Xl5FW7QG28a7CqFxPAfh9DAJ1CcWqk2o1V5686GtmofL0SN/mma2/Y7cs+1Mg
         UxgXwXMiQkBkSMP6/249pgGNFleDSZk+4FdIgbrcEAt8WzxLLUOMDhCqwlvn2BQuTX4S
         C+aR1a+Rx/suT/ORSe3ePeRnz2XaxCKH84mXJYe7OvHmFftsCsVrEWSY+P88h+taCQHq
         gbgK5LeNBgpcZX6bzKQ6E3OEp3BokF6QrB8J0uNCHzp/q8r0tQJoZWKnIeXU20HguoAY
         upHg==
X-Gm-Message-State: ANhLgQ3riGErD3lW+6t7rd6uEJT5u0IGXjjJt5YmMS5FpftmRq1gBclP
        ZzENjFaPYkSFySKhZFC0rerYiOLHmgg=
X-Google-Smtp-Source: ADFU+vug8wWIeTcRLeEHSBe6H2RaRXL3oB/AoXT69/5yQHTAIuDEVvoSl8i5i1U2Oi+/kJ5fwgO+EA==
X-Received: by 2002:a67:ee46:: with SMTP id g6mr527149vsp.153.1582831352775;
        Thu, 27 Feb 2020 11:22:32 -0800 (PST)
Received: from alain.c.googlers.com.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id b79sm499390vkb.47.2020.02.27.11.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 11:22:32 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v2] Add controller wideband speech query capability
Date:   Thu, 27 Feb 2020 19:22:28 +0000
Message-Id: <20200227192228.120076-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change allows higher level HFP implementations to query the local
controller's support for wide band speech.

---

 doc/mgmt-api.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index a5a98609d..1e2ac13ce 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -308,6 +308,7 @@ Read Controller Information Command
 		14	Controller Configuration
 		15	Static Address
 		16	Phy Configuration
+		17	Wide Band Speech Supported
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
-- 
2.25.1.481.gfbce0eb801-goog

