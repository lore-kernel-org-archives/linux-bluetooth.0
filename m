Return-Path: <SRS0=XILz=C2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DC9C43461
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31742083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Sep 2020 08:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="HG/p8OtM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgIQIrY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgIQIrX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Sep 2020 04:47:23 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7D0C061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:22 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id w69so995034pgw.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2020 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=TA6OcLEDFUQ9qpFM/VfmsZehtp68guNS6V1Wug38hMA=;
        b=HG/p8OtMNJt3DU2dQ9qbZrDYYfxtJ1yHfmzDGy2+DvKn5KAtYBklDNcgaWqriMJR7T
         QKi/tQrMIzGJUomQakhUysfJPgrC3N/hmHFw+jMpo6aaRYRQU3PBn0OtGDpqVDPaRyV1
         K64lZnsIL4rAsvBvNsjRsRVWVDTYU2UeqxcCAFuloKVKMXiUuaVUAYQk+bWGK0FBpLtX
         qMMxxjVsIn7aEdaeYEDjYGjKJJkdH8hblUgpPbwFrg6UpeMF+MP+4GU+gWDvwGRcVlHa
         IFkTYGGulSgbqwlFsRZXAjoE9Wn81CYYbQfvyhbTZ6WjrETt0igM0XKNY5RWIkQC5Qqv
         fPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=TA6OcLEDFUQ9qpFM/VfmsZehtp68guNS6V1Wug38hMA=;
        b=cqeyp2KAWaSVw5F6QkXTDrOACQ186QZaspfcmrvRCl5YIPJQDz4tpi02v46efPDUrJ
         l6WcIAlM6ItGSNX7xjhoAN8o9Lk+asspbyhX56ZD2jktvRzl/WCKfFM2vvFkVqxkWk1X
         iG/IK9Bxti7q5Qq+WM52/aZaeNCP7kO7nS0UXL8WSHcI+q5+nMli4xcv7TYi5BLyQyBe
         9RnzIpRu0YXwfgLgp5Q24rKjHmjFhEN4lApEsMSeXt3ZZGHdYzYYMPqgLEjZgAc6pY4/
         m9I6Phvs7QORPUDpk9GvZm7ZrnHbAdadq6HIHu9gMbenTvZLX3RtfqKnLxy2MZ1BmhhJ
         Uj1g==
X-Gm-Message-State: AOAM530GWiaNhjXEEKjGrQD4vqCW4nuvtdvu6a6pZgecm0SBbJtDRxQ0
        rr5pxyy7py8XGcDO0zNTqoWK8ezs+m4YrWa8HCAx9h2LDMTWTncm5Bk8tH1EK8Un2uBIur43yOY
        oaKBBZGgHlLGXj0iVupv74xVw1mGjTv75CEg4a7ktTadvCM2rSVq0fM5tmDpl4Rbx1QwB+dtfJ9
        7FLeguJeN08DA=
X-Google-Smtp-Source: ABdhPJy+2YhIYObzfV77phmcp2UmHDPK1RrJqmYemdv0On6uAglDARSoIJlhbey92KAYkU+onC3EkUEhGJ6zxG2F6g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a17:90b:15c6:: with SMTP id
 lh6mr715470pjb.0.1600332441228; Thu, 17 Sep 2020 01:47:21 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:47:10 +0800
Message-Id: <20200917164632.BlueZ.v2.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH v2 1/6] Bluetooth: Update Adv monitor count upon removal
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@chromium.org,
        mcchou@chromium.org, howardchung@google.com, alainm@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao-chen Chou <mcchou@chromium.org>

This fixes the count of Adv monitor upon monitor removal.

The following test was performed.
- Start two btmgmt consoles, issue a btmgmt advmon-remove command on one
console and observe a MGMT_EV_ADV_MONITOR_REMOVED event on the other.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2:
- delete 'case 0x001c' in mgmt_config.c

 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8a2645a833013..f30a1f5950e15 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3061,6 +3061,7 @@ static int free_adv_monitor(int id, void *ptr, void *data)
 
 	idr_remove(&hdev->adv_monitors_idr, monitor->handle);
 	hci_free_adv_monitor(monitor);
+	hdev->adv_monitors_cnt--;
 
 	return 0;
 }
@@ -3077,6 +3078,7 @@ int hci_remove_adv_monitor(struct hci_dev *hdev, u16 handle)
 
 		idr_remove(&hdev->adv_monitors_idr, monitor->handle);
 		hci_free_adv_monitor(monitor);
+		hdev->adv_monitors_cnt--;
 	} else {
 		/* Remove all monitors if handle is 0. */
 		idr_for_each(&hdev->adv_monitors_idr, &free_adv_monitor, hdev);
-- 
2.28.0.618.gf4bc123cb7-goog

