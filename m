Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAF0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98935600CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 20:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbhI0US6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbhI0US5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 16:18:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8619FC061575
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:17:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 81-20020a251254000000b005b6220d81efso16160570ybs.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rzTIu1JoB+uKHekR8/Dw77In6oKArKQgMAGVIKHvT64=;
        b=s2jn2oYi+1Ad+zeEmTxtbT20c5gUTbyaShzfn4zXSK45HWu7K72qcWG/iIbx+gaF0v
         Ee9lNoPvSbBPcfon0J4XwkDtdUnQsmqydEgn5AuSzr4wOzdn8AVcd+JpkSCF9t+okp+k
         XIGKEfHwOG72M9Vg/hZLQnZGs7gE1q5LYxqGeqCv02N0pIxmdPnIzt5RSs2cjCRd8q0I
         tI03/JYQCx6KFbGACu05v9XfTExBohqApvDqe4QZ5Wdrpsmkl/USMpwDEbY7AJp/8dqK
         H7+qkpxbKPN9evPHqtB1i7jFZZkaURShkCvkj3g/R3gD/GrU6EecujWq9fc5wIACM6LS
         +Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rzTIu1JoB+uKHekR8/Dw77In6oKArKQgMAGVIKHvT64=;
        b=g2V1xo3tSvzwAfSRlLShkutg+O5HdRBO8E5MR1tSjcgf+v8xyuLBfmaQeuVTZf6RG1
         bfvvRTltmfLh3o1p4wo1yTL8zNmKBSvLlUTWFhQ2aikukkaSOzx0skJgeVUtN/tdJNI5
         n4IuB9LgCmYFEqFWV/elTpzW+cy0HIDNxE6sGMl/62zfCE4ZcclvNigjAY+beU4txR33
         0pr8G/w9yuXYrryYjfMI1gI0PqoFQNCuq4rO9C2E6ORDJvDllp7EidJFTO71lPBgV+Rt
         CY1W+L+2bhgSTsqzuatC14Fmb+nn1wgpmGPyfDBr3WieJ9SrqjFkq3DOdCxhDz6BlDs1
         f7zQ==
X-Gm-Message-State: AOAM532DguIqGH7gBqgjKYTPmVYdKJd4OqrbFC0MdKhGAoMvRGygQD0L
        PtYPoYnxg8C5qPhnsbm2bLHk7AJX6NXIxQ==
X-Google-Smtp-Source: ABdhPJzUA8rkftMPTyZf7bTELOYcop2naNsntYSW0UOX+AQePVgMOMJS1h0538KvzzgVscFXceEGa1FJFvS+0Q==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:8f29:89eb:dfbc:3b00])
 (user=mmandlik job=sendgmr) by 2002:a25:5e09:: with SMTP id
 s9mr2082275ybb.417.1632773838776; Mon, 27 Sep 2021 13:17:18 -0700 (PDT)
Date:   Mon, 27 Sep 2021 13:16:57 -0700
In-Reply-To: <20210927201657.593569-1-mmandlik@google.com>
Message-Id: <20210927131456.BlueZ.v1.3.I68039747acc3c63f758278452889d6ed2bfff065@changeid>
Mime-Version: 1.0
References: <20210927201657.593569-1-mmandlik@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [BlueZ PATCH v1 3/3] adv_monitor: Receive Device Tracking event
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch registers a callback function to receive Advertisement
Monitor Device Tracking event.

Test performed:
- verified by logs that Monitor Device is received from the controller
  and sent to the bluetoothd when the controller starts/stops monitoring
  a bluetooth device.

---

 src/adv_monitor.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 715ac5904..05bd49134 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1531,6 +1531,27 @@ static void adv_monitor_removed_callback(uint16_t index, uint16_t length,
 		ev->monitor_handle);
 }
 
+/* Processes Adv Monitor tracking event from kernel */
+static void adv_monitor_tracking_callback(uint16_t index, uint16_t length,
+					  const void *param, void *user_data)
+{
+	struct btd_adv_monitor_manager *manager = user_data;
+	const struct mgmt_ev_adv_monitor_tracking *ev = param;
+	uint16_t handle = le16_to_cpu(ev->monitor_handle);
+	const uint16_t adapter_id = manager->adapter_id;
+	char addr[18];
+
+	if (length < sizeof(*ev)) {
+		btd_error(adapter_id,
+				"Wrong size of Adv Monitor Tracking event");
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+	DBG("Adv monitor with handle 0x%04x %s tracking device %s", handle,
+			ev->monitor_state ? "started" : "stopped", addr);
+}
+
 /* Allocates a manager object */
 static struct btd_adv_monitor_manager *manager_new(
 						struct btd_adapter *adapter,
@@ -1555,6 +1576,10 @@ static struct btd_adv_monitor_manager *manager_new(
 			manager->adapter_id, adv_monitor_removed_callback,
 			manager, NULL);
 
+	mgmt_register(manager->mgmt, MGMT_EV_ADV_MONITOR_TRACKING,
+			manager->adapter_id, adv_monitor_tracking_callback,
+			manager, NULL);
+
 	return manager;
 }
 
-- 
2.33.0.685.g46640cef36-goog

