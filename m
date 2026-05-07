Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504282DF6E6
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175738; cv=none; b=Xg0CRUIgKkNLytOob6Fu6LAw4AmGy24NQf8TQQtqaXEG0SNsrSgArxZjBoM8cc3QCjQJKiALc/M33015f1nMtbeh8R12oMRT0iibA+W3i/e//fw+zoVZfEGYZnLjpul2Eg7y393ZEVZ3Oj0AM4VUth7pV0+cVNyU39r5c5XhdJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175738; c=relaxed/simple;
	bh=eBbC4rOLWN5aQfG6y2cU2iXBByyWUVvx7VigW59gmtM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFwEqksAbIUylGClTdSuEasAKa6OeWEpF3ts0qy2Q+f+weS/7L1DAqRcTy+p3h8sesEWMy8D/22IpGHgm7aldrV3iZuJ2XM3gLV4+7+lV+56QMshQTBIkOKBCLPG3pkYs3n/0Xp4Y5Ne8gBd8NeJcBvy6B4VsoJnS9l2Xv988A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKqasRfc; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKqasRfc"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-575320e6f2aso807411e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2026 10:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778175736; x=1778780536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/L4+rAdBKl1Eds7sZ3hL+bakZfSB/FndDJYiGTtkV8=;
        b=OKqasRfcir+0gj/2n/otwJCB8S4nloJCF/BmSPwYHzo8eY+/5K0UXAdaq5KMKvb+W9
         FPCiR0gYIANXS5RPTRvlLc2Okgj/l8uDEe3SZ0YwKp9FG0PBMInecDU8JKeismpHMXDr
         P53cZBjo6rY7irv0o2Qw9Mpbqam/lkmJRLS365cK9K7JTfTIrhmodyA+5w3XqUXGhXny
         kH7gvF18kcLG83V2p3lMlZZ5QW/DKfHRtJASZJXukvb4eCGItvywsXx4QqT1g8Mre6J3
         +4zYwro2e4QQWkLNVQs/SegmJTE1dK2+xVyXIYog+X2bSru1hAIZ7T6nepZM4N9bEj60
         KCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175736; x=1778780536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/L4+rAdBKl1Eds7sZ3hL+bakZfSB/FndDJYiGTtkV8=;
        b=GhuT04UaDEfrIYUvZUVJl/4JXhyqmH8baVdKVWrAMLbEdoVdMTEBrwQqHKLnsXhm7D
         Syrvvukd4vTY+mXSnVrwq8FAdkO0LU/LGNe7MAtuGqT7R4LQZivtu6NjUD+xL6beGXND
         0sN8YVeb8Qj7nI29QZ1qQDl+Q+oPbFXg/zR9Ji/x9YiQrOMQb/J8hWQi4o6WEo2hV6ac
         c2K/WVxGEyB2Q8KOr6iD9au+6MdWMusLyylK6R/3XuzN8ESVlc3hEA4wVtrPfddyBvnR
         tRQO5t3CvrMhbNrK58VwwHceuRieSEV2wxSk9gUncQhxRuHr3ZHqDmbvP2Ue4Me8bpLs
         P4kQ==
X-Gm-Message-State: AOJu0YyR32uNyYvKMPx97gd8/HnKjJqwE+fN9Xxegj9pjeSFRt+IzPCf
	5M2D2h6r9gs2o4lwIuwq7POZZFZwZWGodJbxxHW2+d+pcYop3PtDq5JRP586KGcc
X-Gm-Gg: AeBDieumJ3csOfzx09FjBrkeNRp3rWIYYHDcCiSRRAkINMH6YwcwUn3BU9iDwtJqNK9
	WgH6kVSGEaiB83I+9mkRyy5QqG/+ZuCa7TuTmiSqkcMFQaTpFUF1apS1CPbxqq8rtLFmDk8DkIh
	mz9bnw7Pfk1pu2a+5c2EUKby4mdgaEyM/9JA+yZ3HsRgQ+Vol9lYHzQpFa5qb9Xbh/uXk+M/db5
	yum+sJnt+hlxQVv0GGwQYyjOZbGo/SkQZd367p+NdS5zedFbSDqik6CN5OR20EFgNJ+k1kK+kT4
	iYcmwpOZYPxq/BGoMf6OCrYfoeWreoD00ee1w1iqjv78u+5s5/IK/a+LqKU/OTju9/e/IihJfjR
	UN0nf0ej1VDASycWfFvEvzWDAQ0F0W0+ke/Uht62iq/KjwYUcnO5qcXLhxWYk1qzwpNMtU7Jcq+
	AVF+9B/Eju0/V4+L2ctZYqQtmP2bna+US3Oa1GAUl5Avvpg7JtjLCuypLJSwvdjZBXgjZehPjwP
	sIdDb+7aATzx0PkAqcn0MpHfdng
X-Received: by 2002:a05:6122:da3:b0:56f:b0bd:2276 with SMTP id 71dfb90a1353d-575591f7b22mr6072912e0c.0.1778175735919;
        Thu, 07 May 2026 10:42:15 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5754dc8b662sm5355317e0c.4.2026.05.07.10.42.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:42:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] Bluetooth: MGMT: Add SCI setting bit(25)
Date: Thu,  7 May 2026 13:42:05 -0400
Message-ID: <20260507174205.209488-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507174205.209488-1-luiz.dentz@gmail.com>
References: <20260507174205.209488-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds MGMT_SETTING_SCI(25) which indicates that the controller is
support SCI feature.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 ++
 include/net/bluetooth/mgmt.h     | 1 +
 net/bluetooth/mgmt.c             | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 61872403fe65..84a1ee798da1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2094,6 +2094,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Shorter Connection Intervals support */
 #define le_sci_capable(dev) \
 	((dev)->le_features[9] & HCI_LE_SCI)
+#define le_sci_enabled(dev) \
+	(le_enabled(dev) && le_sci_capable(dev))
 
 void hci_sci_groups_clear(struct hci_dev *hdev);
 
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 8234915854b6..dfd264f0bac7 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -121,6 +121,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_LL_PRIVACY		BIT(22)
 #define MGMT_SETTING_PAST_SENDER	BIT(23)
 #define MGMT_SETTING_PAST_RECEIVER	BIT(24)
+#define MGMT_SETTING_SCI		BIT(25)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b05bb380e5f8..1ea06ae1efdc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -864,6 +864,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (past_receiver_capable(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_capable(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -955,6 +958,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (past_receiver_enabled(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_enabled(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	return settings;
 }
 
-- 
2.53.0

