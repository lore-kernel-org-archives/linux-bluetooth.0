Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470A8C433E3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B12E20738
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Svj3xn8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgHUHzY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgHUHzS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 03:55:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2A0C061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:55:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so683894pfn.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4BsBm4/JaybyWDiNEa/bs5RXulRrirwodkdVtO+qdI=;
        b=Svj3xn8vjjkw4I9/qdmVCZhG9PJ6VPW5bsS6q5zU/LDg1/Z0gbc3KUWZAuIzNly1S0
         2aae/orbI5V6AYL2aw4N8gKOi6P6z4AvHYf6Q+Z4vQcOdkVpyYbA+SSbgJYBRN3AZIC+
         1apboJ9kUPbB2LXBNxTvr5xvWZcQdwMWK6EJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4BsBm4/JaybyWDiNEa/bs5RXulRrirwodkdVtO+qdI=;
        b=uj2dtfqKyBDugkq42es2LQWCMEu3nYyGFTdoYyFDKd+uxpRuDGDCe2cztlFRvK2xdd
         hkUEGaQtjPJ95EYzPZueH2+i9SDQph5BObfZlINfuCeTO21zzGTx+XlnBnXgDyPP3y0p
         SSzSC80FFY79ZkVTXPS1BkDnN2A7ENEMdM5/umLabY+/g/Xaw/o9vp0gJh2dXWRxpyOC
         uihQsr3kHZ1pywRfC8G1Slh0XAHNJ8rfn7c66VK6UGwvU+06EHgkjqqEyBRQmdIlR3rF
         41OpCpoSdqc+9DBkZJusPhW2KAeN8udj4xN2skQDOoDudAlz6UPW0OoVTO2Pm6qISLYb
         AWFQ==
X-Gm-Message-State: AOAM5320/ATjtuRHe5g8vNp5iRJzFtaVbFGyMpgLfcvhH8pHp4+28NYf
        pRrIFJYS2Ai62QyGtzFfCdOtMgeMefyXBg==
X-Google-Smtp-Source: ABdhPJxrit4zHO6bnmydW0jd4DmXQCkSicuyLWkypCaL5v4gc72JRbDRHD2YelE3hFZHIhLIq2yGyA==
X-Received: by 2002:a05:6a00:90:: with SMTP id c16mr1543782pfj.200.1597996517807;
        Fri, 21 Aug 2020 00:55:17 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id f6sm1622827pfa.23.2020.08.21.00.55.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 00:55:17 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Miao-chen Chou <mcchou@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Subject: [PATCH BlueZ] sixaxis: Fix a crash caused by the return of udev_device_get_property_value
Date:   Fri, 21 Aug 2020 00:55:14 -0700
Message-Id: <20200821075514.20406-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao-chen Chou <mcchou@chromium.org>

This adds a NULL check before calling sscanf().

Reviewed-by: Yoni Shavit <yshavit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>

---
 plugins/sixaxis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 939fed759..996f85dd6 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -411,7 +411,7 @@ get_pairing_type_for_device(struct udev_device *udevice, uint16_t *bus,
 
 	hid_id = udev_device_get_property_value(hid_parent, "HID_ID");
 
-	if (sscanf(hid_id, "%hx:%hx:%hx", bus, &vid, &pid) != 3)
+	if (!hid_id || sscanf(hid_id, "%hx:%hx:%hx", bus, &vid, &pid) != 3)
 		return NULL;
 
 	cp = get_pairing(vid, pid);
-- 
2.26.2

