Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B780C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 04:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64FF208E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 04:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJm0CjaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgHUEfn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 00:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHUEfl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 00:35:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DC1C061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 21:35:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so329656plp.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 21:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOJTXZQPaj2OGZIiejwIYG5vJGEX+qQf5BT+/1KgjFE=;
        b=UJm0CjaSFkOzg56uLjvFWNjhM7HporMyv++nrHK4lgfNo0QbBf84sHlOpJ0GK83Xg/
         LV6orMEN7nZTjDEDeCCWm5cHZPBXZaQvl6tUnEvW9hx3cbxojyYsdgj5mDJI06PyuIjc
         100YNueQmhKFvIvkEHYuy8s/51M3xa03dYgSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOJTXZQPaj2OGZIiejwIYG5vJGEX+qQf5BT+/1KgjFE=;
        b=TuYajAgHqYNkDS4swwj3RytomgmbrAxyg1iNwKMDy4O+XGMvJdVL3hNZCBiOEPv8Hy
         4W9B0DwsNJ/vJaL8YVhbPBJhDCic4MpbLlV/pLvWcHIF7p0s3pE1/Uh1OFetuPP9BV0a
         S2DpnwP6evTVkB1VqHO92NUvFHMaOkGRZlnmzZRoXyAfjM7kT6r85Oi74Tr5gYImxJHJ
         wBA7rkRELA1D7KTgXGWraXSvLLnRJe3JaH+MK0qiJW4Rundcz9fPKxfYv6TAQuKmvXvO
         IxC/XhA/AP4XYvIR9F1OBxPlcLD0TEO53xx6A9esAh9uYJh1366CadIcRMSafb/74m4g
         6xgA==
X-Gm-Message-State: AOAM531KeQpAqMJW7q8pomvOVMONcIRmBleKPeaaMeiAm51yHYiqQTIV
        wZm/ClgF2QPAOksSMyHLgjWMK4kK2NIzCg==
X-Google-Smtp-Source: ABdhPJwfdPdAWpACOEJvAVLC2qyMf5vgqDyJQmWjDqERgTZ/9J9w6jl2bI1akPhhqpQZdAvIEHOJPQ==
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr1047405pjb.29.1597984540086;
        Thu, 20 Aug 2020 21:35:40 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id d13sm557480pjz.3.2020.08.20.21.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 21:35:39 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Subject: [PATCH BlueZ] input/device: Unregister all UHID event listeners at UHID_DESTROY
Date:   Thu, 20 Aug 2020 21:35:36 -0700
Message-Id: <20200821043536.15332-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When destroying UHID, we should also unregister all event listeners so
that they don't get double registered at reconnection. It fixes a bug
where battery report is not available to kernel after reconnection and
also prevents memory leak.

Tested with Logitech M535 mouse:
* Connect mouse to the device running BlueZ
* cat /sys/class/power_supply/hid-{addr}-battery/capacity # works
* Disconnect mouse
* Reconnect mouse
* cat /sys/class/power_supply/hid-{addr}-battery/capacity # still works

Reviewed-by: Archie Pusaka <apusaka@chromium.org>

---
 profiles/input/device.c | 2 ++
 src/shared/uhid.c       | 9 +++++++++
 src/shared/uhid.h       | 1 +
 3 files changed, 12 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 8fc04be37..f6823b7b6 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -982,6 +982,8 @@ static int uhid_disconnect(struct input_device *idev)
 	if (!idev->uhid_created)
 		return 0;
 
+	bt_uhid_unregister_all(idev->uhid);
+
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_DESTROY;
 
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 685f90243..71a4e04ba 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -219,6 +219,15 @@ bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id)
 	return true;
 }
 
+bool bt_uhid_unregister_all(struct bt_uhid *uhid)
+{
+	if (!uhid)
+		return false;
+
+	queue_remove_all(uhid->notify_list, NULL, NULL, free);
+	return true;
+}
+
 int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
 {
 	ssize_t len;
diff --git a/src/shared/uhid.h b/src/shared/uhid.h
index 459a24900..dbdca852d 100644
--- a/src/shared/uhid.h
+++ b/src/shared/uhid.h
@@ -40,5 +40,6 @@ typedef void (*bt_uhid_callback_t)(struct uhid_event *ev, void *user_data);
 unsigned int bt_uhid_register(struct bt_uhid *uhid, uint32_t event,
 				bt_uhid_callback_t func, void *user_data);
 bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id);
+bool bt_uhid_unregister_all(struct bt_uhid *uhid);
 
 int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev);
-- 
2.26.2

