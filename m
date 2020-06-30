Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6531C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 22:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C3220722
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 22:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JB5A5Jb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgF3WuL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 18:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgF3WuL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 18:50:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DEFC061755
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 15:50:10 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id bf1so8104657pjb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2020 15:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cVROIil0P6Me4UmNrUmy9jeA88aHofdQBlO7lyf+/O4=;
        b=JB5A5Jb4NzllbO3m0+J+h8eiJURMMGVIg8h38t7RXOLWdMsrzuYRffbM/qDQngEqTl
         UG+PX6i0+sZd+JDt04t2SNIQIEkMlniucDCCEWbKibfXbCiSg/JmkLXC2CI7Np9PekGs
         kQQDrXnIK+btDZNy8XZ1ceh3Eg5lB1x7rEESWjINfys+GFaUIT03pmpLbxIbOwL1aMOa
         inh9VYk4uA8F1VM0Wq+l4dAwAZ9PDf51kgN9HDogFVPbSW7AVs9GqXj8NJXVYBsM8yFO
         A4BRYCAAwUc2/300YO1Lq3RnruZ+95UhfMob0dxGNthQyVupegOiTtn3rDM2hNEJLyJg
         abFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cVROIil0P6Me4UmNrUmy9jeA88aHofdQBlO7lyf+/O4=;
        b=m5vz85Yvs2aJ2Gw/eabf2msDvliemihwnU+/UAgoNu4w54BgD1ot3P9koWY6rTZ0lF
         K3/0cRJQIn0vGVfPXsRKJOcdL+4pANy1DFsSvZpD2oDi2RiONexSyPQCNWp++7fXEnFd
         HPtYDn/hic1hkte+9/c2m0csok+l9HWoX1tpvfJryZiNo+TaGiNNpoNV4WNKcvZre3pr
         YTKDqtp4Gac1ggzouiaa9Ww5X9agjXdqHQmkc+J20IW67o+uxLSQuLBP3k3enu6Is6cI
         yqawMlFfWeu3OX5Yu+D60WIxfwzx+PKOG6NwmRQh56vayBSx+03chO9k6C8tp+x58Nvv
         5LSw==
X-Gm-Message-State: AOAM5336n8xfazDsRfIXQ+axZj+1AjM3enplRfwVjCRv8DBmHkipTWvE
        xiJjgPDSjr88niOIwfZ2YoxbzpP9UlSPWGr2/w1y06znZtFGnCkqHsx8EMud5/O+G9VZ0NlYtyY
        hxuml/XO9dR986fQhN7O2Ly9IrOJZdpw7pgP88a4vi1wSvU5ujs076qybc/btQimNOo8T5VFvnf
        kA
X-Google-Smtp-Source: ABdhPJxGTayO9mHc2L7BN83AOy4exVzxM5TTUN0K8NJUCMXZRLcaLVJ+HDlkjIyGVI8zq78hdSCnDyKW48qs
X-Received: by 2002:a62:2c54:: with SMTP id s81mr15503821pfs.252.1593557410362;
 Tue, 30 Jun 2020 15:50:10 -0700 (PDT)
Date:   Tue, 30 Jun 2020 15:49:34 -0700
Message-Id: <20200630154855.Bluez.v1.1.I63c3ddd54189c2ad9ca9aba2c08e0925d7f0aee3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [Bluez PATCH v1] device - If HFP is supported, ignore HSP
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Hsin-Yu Chao <hychao@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Hsin-Yu Chao <hychao@google.com>

For a BT headset that supports both HSP and HFP, BlueZ creates
service instances for these two profiles and connects them.
It's uncertain that which of HSP and HFP eventually get connected
and being used for SCO audio. And we start observing some problem
because of this uncertainty:

- For headset that supports WBS, we need HFP connect for codec
negotiation. If HSP connects but not HFP, WBS cannot be used.
- For WH-1000XM3, if BlueZ ever initiated HFP connection but failed,
headset won't have working SCO audio even HSP is connected.

Fix this at when device probes services, if HFP is in the uuid list,
don't bother create one for HSP.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

Changes in v1:
- Initial change

 src/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/device.c b/src/device.c
index 7b0eb256e..4036bfd81 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4370,6 +4370,11 @@ static struct btd_service *probe_service(struct btd_device *device,
 	if (!device_match_profile(device, profile, uuids))
 		return NULL;
 
+	/* If device supports HFP, don't bother create service for HSP. */
+	if (g_slist_find_custom(uuids, HFP_HS_UUID, bt_uuid_strcmp) &&
+		bt_uuid_strcmp(profile->remote_uuid, HSP_HS_UUID) == 0)
+		return NULL;
+
 	l = find_service_with_profile(device->services, profile);
 	if (l)
 		return l->data;
-- 
2.27.0.212.ge8ba1cc988-goog

