Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3610C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiCEBXg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiCEBXa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:23:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A823231222
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:22:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso8574461pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TAMJA6rc8NyQ5zesNMZHUQ52CnaUl7RkrULN9uEBqkE=;
        b=dwdQ7sX8n60C6WTUFnrHRNSjA5nUW3O/R4yWqjB37SWmGaCC1ha0sMuJT5f0fxLe9z
         OKQ5FgWO/3/Sg1K09ZHhjWFmWJFhfI+SYcvbmBw/uE4V3V1nrJ2lu6D+13/wXMnM82aC
         OVi81p7lx3r+HtyzMKDQF/93btQd5mVZaHOPTF4MkfgMShBeWEHe59+egkvLiT4Ijm7S
         hCSn5GQtrTGijE3oenOn7a1J2KRvxuKLohdHBJniPEM+0EXim360uKT2OqgASR3mJOs2
         FkyG8snj8DiXB7K0p/MQPVHca6a0i+x/1M57VK/aoqe49IOrHvsiBLtyAeZK2/YAo3kU
         JH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAMJA6rc8NyQ5zesNMZHUQ52CnaUl7RkrULN9uEBqkE=;
        b=JXQs+mV+c/euTtybgQ7XqRXgfMFLhQoAX8afq87PKhREk+Il5mlyAAVjl5DSk2hbRK
         x2qIDy1CFiwj1cgvECbrXQyNXK+qj2K+QuAoNaTuMxGSfo7XFXO37w1pGqjS98Qs56qx
         0u8QebZzbJM1qEIr2pgJtz//s8Ty+acM+Rk14kko+AagGr5AS7Z0GtDsYYr6GZcCteTx
         BGkjhVTQQLrJR4oKOuvzKgrpAdRhZRHf2Q3BI/78rvUI4P28fDd4Ra6hSw0IIe3UavbQ
         iBexi/CSohX7MRCBvJn337ToVUxM32qPcv8VbiCSHNkDZYtm4l1jsPLy9USXmTMuc3AD
         LCVA==
X-Gm-Message-State: AOAM532/YpP7vOWtbeNbSNb0Ra1yobbeToPROmUobcCh9lmJ4w0JYA6U
        d7Mtq+g+CRTyakFZpIW9ytNd0lIlKNk=
X-Google-Smtp-Source: ABdhPJy138CFBD0c6w5DGy0C+BmOV+3Azq3WBbC198h1duECaCsXNCVuQqR/Id/IHqOvPt3r8dBmdA==
X-Received: by 2002:a17:902:7b94:b0:151:bfdc:823b with SMTP id w20-20020a1709027b9400b00151bfdc823bmr1298860pll.171.1646443359944;
        Fri, 04 Mar 2022 17:22:39 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m16-20020a638c10000000b0037c4cf366c0sm5363932pgd.61.2022.03.04.17.22.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 17:22:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 11/12] bthost: Add support for Periodic Advertising
Date:   Fri,  4 Mar 2022 17:22:28 -0800
Message-Id: <20220305012229.853784-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220305012229.853784-1-luiz.dentz@gmail.com>
References: <20220305012229.853784-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bthost_set_pa_params and bthost_set_pa_enable.
---
 emulator/bthost.c | 23 +++++++++++++++++++++++
 emulator/bthost.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 54a2728e0..a45a67d14 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1006,6 +1006,10 @@ static void evt_cmd_complete(struct bthost *bthost, const void *data,
 		break;
 	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
 		break;
+	case BT_HCI_CMD_LE_SET_PA_PARAMS:
+		break;
+	case BT_HCI_CMD_LE_SET_PA_ENABLE:
+		break;
 	default:
 		bthost_debug(bthost, "Unhandled cmd_complete opcode 0x%04x",
 								opcode);
@@ -3073,6 +3077,25 @@ void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable)
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE, cp, 6);
 }
 
+void bthost_set_pa_params(struct bthost *bthost)
+{
+	struct bt_hci_cmd_le_set_pa_params cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle = 0x01;
+	send_command(bthost, BT_HCI_CMD_LE_SET_PA_PARAMS, &cp, sizeof(cp));
+}
+
+void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable)
+{
+	struct bt_hci_cmd_le_set_pa_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = enable;
+	cp.handle = 0x01;
+	send_command(bthost, BT_HCI_CMD_LE_SET_PA_ENABLE, &cp, sizeof(cp));
+}
+
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
 {
 	const struct queue_entry *entry;
diff --git a/emulator/bthost.h b/emulator/bthost.h
index f597d7596..fb7b1431e 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -95,6 +95,8 @@ void bthost_set_ext_adv_data(struct bthost *bthost, const uint8_t *data,
 								uint8_t len);
 void bthost_set_ext_adv_params(struct bthost *bthost);
 void bthost_set_ext_adv_enable(struct bthost *bthost, uint8_t enable);
+void bthost_set_pa_params(struct bthost *bthost);
+void bthost_set_pa_enable(struct bthost *bthost, uint8_t enable);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
 void bthost_set_scan_params(struct bthost *bthost, uint8_t scan_type,
-- 
2.35.1

