Return-Path: <SRS0=vtF+=5N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20986C10F26
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 00:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99BE2076B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 00:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y9GWKv6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC1Adf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:33:35 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51658 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgC1Adf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 20:33:35 -0400
Received: by mail-pj1-f66.google.com with SMTP id w9so4584612pjh.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 17:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kKshlVtPK/i5aoOvtr9DXwO8XdpBwa9/c+UGMUDDAvI=;
        b=Y9GWKv6EYAnG832k0igCzlvY0PxMl78P/uumYIn6HrM/2GlbK1QyjvEPv2tUS05MZ9
         4HYwG6czoyVi6K/HV6LwgE+4pSxGirvnuqZp/yRI3Wz2+hlZZ2yr74BVPnNrA2zFoYsU
         E5mRhLGX46skQ4H+8MrcwwKf5+FZk2/1D7Ghw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kKshlVtPK/i5aoOvtr9DXwO8XdpBwa9/c+UGMUDDAvI=;
        b=kvLBNSluKLMAMk4i8sW+CVoj6L6I3OJLf95SuPyjq998mfrbHvuhsRPGCTHqXY67G7
         aFsVmy9qI3+z3BRBeOMvYIfOdQqsVD8QU3ifCA6bAqwGoebS46wJ6/zzVK/gwPlSTmMV
         U8L5q2X764deLkSAfPiyn5mQ3CbHGmm4Bj5QbKtiXS9EHrF4CdQLVVp5Qb1OVEcTOwp5
         kPGdiegLcn8h16SSkJCx0EzEIt1CDzvtL7HzifbZQIQYnDsby5+gJyMS+eJcvmQdgkBN
         Rgs8zhO8jbcQ/OJc5+pVWVasejv1G6Z1H+scZWK1oqKYteEdj5kC39YibBdZdFNcwQY4
         pfPw==
X-Gm-Message-State: ANhLgQ1/tVNDppM78toOLAEp9LBFqia/+Qvy66/rBLW4zFBf/VbWVEgY
        pEdBgfWG6DLS8lECxpW6YDQURbc2Tzc=
X-Google-Smtp-Source: ADFU+vsveRHTYHvf9sZ8V5RnmgTyLJeuPvSMnTo5F34CLxB0Ak4Ewc4aGKPIo+w79+4b3SLAPsI4bw==
X-Received: by 2002:a17:90a:cb14:: with SMTP id z20mr2089015pjt.170.1585355613609;
        Fri, 27 Mar 2020 17:33:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-41-185.hsd1.ca.comcast.net. [73.231.41.185])
        by smtp.googlemail.com with ESMTPSA id g18sm4771575pgh.42.2020.03.27.17.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:33:33 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH] core/device: Handle Just-Works auto-accept
Date:   Fri, 27 Mar 2020 17:33:18 -0700
Message-Id: <20200328003318.13937-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The kernel starts to always request confirmation to BlueZ daemon for
Just-Works pairing. In this patch the daemon does auto-accept if the
client has clearly indicated a pairing intent by calling the Pair()
D-Bus API.
---
 src/device.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 69f98e488..db14cc129 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6168,12 +6168,22 @@ int device_confirm_passkey(struct btd_device *device, uint8_t type,
 
 	auth->passkey = passkey;
 
-	if (confirm_hint)
+	if (confirm_hint) {
+		if (device->bonding != NULL) {
+			/* We know the client has indicated the intent to pair
+			 * with the peer device, so we can auto-accept. */
+			btd_adapter_confirm_reply(device->adapter,
+						  &device->bdaddr,
+						  type, TRUE);
+			return 0;
+		}
+
 		err = agent_request_authorization(auth->agent, device,
 						confirm_cb, auth, NULL);
-	else
+	} else {
 		err = agent_request_confirmation(auth->agent, device, passkey,
 						confirm_cb, auth, NULL);
+	}
 
 	if (err < 0) {
 		if (err == -EINPROGRESS) {
-- 
2.17.1

