Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71E3C32771
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 01:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA77520715
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 01:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIetSZU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgAGB2h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:28:37 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:40078 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgAGB2g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 20:28:36 -0500
Received: by mail-vs1-f54.google.com with SMTP id g23so32901429vsr.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 17:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2irKVE9or6kW5TmY2QFUe6XZGKluZ9hMUOOE/em8VvA=;
        b=AIetSZU2q+oooxsw57vIYYdYWXPM416UVwv0vuvNvWLboBoxTlOybSloqMw50BpUGu
         HaVef1UycjK9BZSbms1n8ghtCQpIoJ4WzD3uSF2ZKegH43AYTfSk7EJJWpxQTuyjcfMu
         YNh8cqHW2rghKapOVcNrgcRaTSij35Lm6LLCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2irKVE9or6kW5TmY2QFUe6XZGKluZ9hMUOOE/em8VvA=;
        b=FSblNDmaSL/d89Xa6dFICfhnjOzZHiq/xZOHy+eINIaP0QVfwoW4sxkdi7YIVv+SJz
         wcyFDUYcniBr7ELW/q4+864TzK+8/378uMSq0hcBhKKENm+fIVwObL3/JP74iNLkKgmM
         nNUvyg5QR8wDCRUgGB7VI9MudDtagRzT7/8Sd8ugZRrJLZxE8BOOdYYGegIF93wqJhOQ
         YCeI3iwlTCF0MTqOI0jLpY0GBtCnukk/ybTQvv0//SIryqulnBlKx661Lf4GzjPxYDkH
         JgWHNC0TZ+QBWLxkJF55XWVQdoMu3KNKYiiusmsJ1o+rgGDRntv82/STxhIecRgODCyr
         zATw==
X-Gm-Message-State: APjAAAW03Zwx5bh4PVGM9L6ROCpS0TZAkYcqR+USH/ysBBq1BrTXOkYn
        82pzEkvVG4r4RTSRC6B0YO1GZlzC9oY=
X-Google-Smtp-Source: APXvYqy+MbSW/eYvJ87jugM9SfyZVHq9CUG457x2oCuDVGb9vnP9F5KwZTrr2dh7LDmxCuycjkxGiw==
X-Received: by 2002:a67:b309:: with SMTP id a9mr48214562vsm.97.1578360515371;
        Mon, 06 Jan 2020 17:28:35 -0800 (PST)
Received: from alain.c.googlers.com.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id y7sm18784079vkd.38.2020.01.06.17.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 17:28:34 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, Alain Michaud <alainm@chromium.org>
Subject: [PATCH v5 1/3] MGMT_OP_SET_BLOCKED_KEYS Api definitions.
Date:   Tue,  7 Jan 2020 01:28:18 +0000
Message-Id: <20200107012820.158721-1-alainm@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adding the required definitions for the MGMT_OP_SET_BLOCKED_KEYS Api.
---

 lib/mgmt.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 570dec997..276445d0a 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -583,6 +583,21 @@ struct mgmt_cp_set_phy_confguration {
 	uint32_t	selected_phys;
 } __packed;
 
+#define MGMT_OP_SET_BLOCKED_KEYS	0x0046
+
+#define HCI_BLOCKED_KEY_TYPE_LINKKEY	0x00
+#define HCI_BLOCKED_KEY_TYPE_LTK		0x01
+#define HCI_BLOCKED_KEY_TYPE_IRK		0x02
+
+struct mgmt_blocked_key_info {
+	uint8_t type;
+	uint8_t val[16];
+} __packed;
+
+struct mgmt_cp_set_blocked_keys {
+	uint16_t key_count;
+	struct mgmt_blocked_key_info keys[0];
+} __packed;
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
-- 
2.24.1.735.g03f4e72817-goog

