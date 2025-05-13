Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA781531D5
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747158965; cv=none; b=au6aqlmjotoCWVj+MUT4yqscTg1yivGRVnR1a4APeZn4L+2+d1u58nS1dEX/1QoXIrVOK9ycQ4FBQFtZEUBUiHeETIjFQx3hXBwbX+dpOoEHiKQowEj7725sQu6p+jSDFuuJVCqFS1B+v97Le+muSSDnJT3WWWpSnq4DW2kkKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747158965; c=relaxed/simple;
	bh=Ckqd4HSkVRgnhVrBPnwD40xsnEnap+CYTJmX4AcBTlg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iCkVSuTI4OJph+vEORIDDUQ+2i0+N1dq1z6AsaeLY8+rwm+aGGShEy1bO3U6ZCdgWwxkaJafvLmll8ncGXxzQHGPxwwfT2yK8KGQTEvGZKix3qQhogmCKT8CpWDx4eAoQ0XUhAisebWigX9eNe+9Ng476c94BUGDJXobZlHPxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgNmaTMI; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgNmaTMI"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-52b2290e292so2353559e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747158962; x=1747763762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQn3gAlnj5MIAymo57SFHJ+b9H++7FQBHl/5nRjhETk=;
        b=VgNmaTMIgcxLnCGHMr/asi+qSTQqixQQ9Gnrl9z2+xqMeKOZCZCDDL6+ufSE6rBB8q
         6uJ87wBPMn7zxCszypSEWGATb+j141B9KUeI5VYsIp91bTrdqZKNpLcvFRJF+LGGo8Qs
         OB2Pw/+8CT4YSmuSRCZ/VFFu7zd0m5C2vHFgfXaXL+gkoHxvp6LhRVQ+5LaGl64i9FcU
         ybCFaLUHhdOhQXQ7Xu1SjbPQ2iDtZixjhue9y/l7H6NZNPFbt1KkIkNEtykn0zu5FYqP
         upJQ7YTYcGpQp6q54/hrOy0t23YlV/E0WLpjfuoc0VhKjNWq21IUh4AVNetoN5KNVX98
         5p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747158962; x=1747763762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQn3gAlnj5MIAymo57SFHJ+b9H++7FQBHl/5nRjhETk=;
        b=uE8zslmVP038W8hlaSikQdaiT49H6ZSrhgIk8uVKzQjrIEkEMqxyzXICYI1yxmqqNj
         4cZEDZ+yr34Yz/CGtSVRU2pNV/MNIY3e2HivPP1OLOsvp72uCsUVu8uNFwG7DA/zvF93
         dNP2AB7M+ucHjQTuoCMl1BY4YycYPprry/ukAXQNLLWyFeVb43r+EOsgrwK2yf6q56jL
         VGbWLxvPyS+dGHHdMhgzUA7O7HQHNCEO1wCwpnmS9gt+KxPARpsOdUrNSO/qZUgatk35
         QCYBSzZsGQkZQ64RcJ5CYZp97fMui7iHQ34/Jd9wHLBtKV6DQy8r+JMfHIdsy7buEtXA
         Vg/Q==
X-Gm-Message-State: AOJu0YzbWLct8G4gu8viqXmjIYOORtdrZVwy+UKljbZ8BVpwbeFPdFq9
	4rNym3SwoaW4zwTrjTW0PRiuIxkA7McShKBchzWgQkShual7rYFEkVj69Lub
X-Gm-Gg: ASbGncuV4FG/D9O+Solug739kQnzudtlM5RkWh0Am+/07lS/FwbdS1EPrvOvWgAENGL
	6MKNHmSH8ptRiTvCbO+spC4zrewJyJRBFFP1t1oSOzIVgPCCvNv4Az1fazz7AJOubvw4rD4dTSC
	CGo/PirYTJTqS/CJDH/v/pBb+k5wanAkM8Ou6JXOB1nMRqRuOoafivurDr3YLrIZo5pqBDkr7pu
	xgPQpUCA4yK4Jx1kE6wXUzZm82wVu4eP/5g2WzxzuTsa6xxlEXrvJFBckgtVD2SopMFcJURXI7b
	pw3cr7bLmbYmDegRmm2Oi0i29o8xruBt1IRTLFTkwWkIkjOcY8B+kIZoZtGdAn9jxiywi3lh4U1
	+ZGn7ROLl2Ca2Xeve6UOO
X-Google-Smtp-Source: AGHT+IEHeM9JiglQiE7KJ+FgvRg+ztRUZYYtX5Ly8NGSqTofUmrZt6MRjFksHmMV2o7b/MQa5Z4row==
X-Received: by 2002:a05:6122:c82:b0:529:d7e:d13f with SMTP id 71dfb90a1353d-52d9c6f5c96mr286604e0c.9.1747158962041;
        Tue, 13 May 2025 10:56:02 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52c53726493sm7937360e0c.16.2025.05.13.10.56.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 10:56:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] monitor: Add definitions for FSU command and event
Date: Tue, 13 May 2025 13:55:59 -0400
Message-ID: <20250513175600.1158690-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds FSU command and event as defined in the Core 6.0
specification.
---
 monitor/bt.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index e708e580f77b..bc84d6b947a9 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -2937,6 +2937,16 @@ struct bt_hci_rsp_le_read_iso_link_quality {
 	uint32_t duplicated_packets;
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_FSU			0x209d
+#define BT_HCI_BIT_LE_FSU			BT_HCI_CMD_BIT(48, 1)
+struct bt_hci_cmd_le_fsu {
+	uint16_t handle;
+	uint16_t frame_space_min;
+	uint16_t frame_space_max;
+	uint8_t  phys;
+	uint8_t  types;
+} __attribute__ ((packed));
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
@@ -3760,6 +3770,16 @@ struct bt_hci_evt_le_big_info_adv_report {
 	uint8_t  encryption;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_FSU_COMPLETE		0x35
+struct bt_hci_evt_le_fsu_complete {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  initiator;
+	uint16_t frame_space;
+	uint8_t  phys;
+	uint8_t  types;
+} __attribute__ ((packed));
+
 #define BT_HCI_ERR_SUCCESS			0x00
 #define BT_HCI_ERR_UNKNOWN_COMMAND		0x01
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
-- 
2.49.0

