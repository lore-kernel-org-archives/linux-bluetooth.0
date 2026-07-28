Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB1142125E
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262827; cv=none; b=tdM19VaSMKTIUjn0h2/9PC5gOYpxYYMGbg+DxzR2H0epHSFzUQcD5ihpjd7t1jvinkaHFq3e69fLDmFxOlKNQoW3ccfpDrCoWS7REMH+JdbQ+PyjZm2l3fayh0OtJw4ulcu1VmPd38bjRrAudhAXs9h5FJIF/vxZBTtd/ZfM9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262827; c=relaxed/simple;
	bh=5EwjkWzddoJ94wjpMS5B33NV9JnBUXQoSst6v+OS2Hk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft0M7itv6EmNw+VAUvihD3HwRabJkATpRqYaxPf+KNayr6SK+JvlPcllBvame6WF0l1PDSn7MXAmX6mW90djEHjl2r7mlHcjzw/f6mnbfBsdzAf5d1WU8LVYxksYaeQ8xObtJe12yD18S7khOkU2R0DFfmhy+c3jPdIHBrPI7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIHfCprW; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIHfCprW"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-973b676e5f5so61484241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785262825; x=1785867625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k9Ul9bTy2PKwcHcPAA0e5f+PiS5bIXsbx0j7GArtEuE=;
        b=OIHfCprW05hRv5yNJh/ONef9Edjve5yLcATGHWAOyHrH5GgOspXgMRTED/TmxEgLv4
         pcZPanX+q0aMb4n7ZT5w9Ha5J63eJYcTiqQTgekfvjW5J79NnFzYoeYBGR+8tFQY4TH6
         zpiZ0pvhmeFHuXcAi65UJ2XeuvLW9uQFyDBXv0tioIaUBBFW8Uo31h7dCc1k37kj2tZT
         r6bYeVX863aRJTBGWehRA+P+SYPDp0GXcE12Min77ugxw3txkXAwooUM1mf9dHaLfEIJ
         KuQCpvSgrPPcjafnNvqjSSGpb6Y+W3qqhtK7K+pSYrEc2X10Elc2oQf8LmkwOiJ0pe8+
         tFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785262825; x=1785867625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k9Ul9bTy2PKwcHcPAA0e5f+PiS5bIXsbx0j7GArtEuE=;
        b=dmuiN8E51MYbtGuGOAdSWY6FxxwxOJKHt84php/zWpVejxxqtmS1y0udQ4mDC7GT9G
         HqExKaRmC5MTvrdmecBQ1EzaaMMKebIS5V5z4xA6Xrzo3CD6KuSYVl+F3lbhyLjbAoRR
         XCsWxAtUt5CJE92bsZaEGNYxXx6PZh0dBI+THYiF/FfG6wT77HRHtdwha3x7s5TjXSnr
         P5hO5ml9TB1UjCnY839xuApXy8pcOUiU60mgzoh9jg7Dy0DLZ6KatJbZ+4Wv1fOI6vK2
         xFkv/P4yqXHwjeA9PlrAWTTnwA5Tlm62Meuc7ipleN33rHDaSVFNb/XykIL7NhaGHzqD
         7uYQ==
X-Gm-Message-State: AOJu0Ywfn8N6HeUXccAlKX7qL+6D8KwI0p5LM2uTRYrqXTf5kCSGyHvH
	2Vn8GLlt+FMALNHpX3cj9RRz93c3KPFV94uqUs82DYnQNn+QNI7PoncZxEhvsdl2
X-Gm-Gg: AR+sD12dkAQypEW+H49ICKNer486o9d6jcoGKpOEyHwkswk9S5jfN73QHMTbaxTyIpt
	Y0YJFU7cnWyJ6ufH5kBu6KmE5W/RevH9hNne++1a+7nGIBHckJx+S8u8nos8yuuvGOcpAj7aCKS
	eDbmT4iM64uPYhc+CazTiDCI3hkOpSLPsdmiogF53p9zfwgPjqVhRwbCRezmOA5QcbXE7nM8lv0
	YMaNr3A8Rm+oowh8F8McxhPFn3Ne01D2JEAHCFUQ8J2yMGXoGQrf/WvC+aJnak3HuPxKST1bAAY
	J7YgY/jqeBeE4li9AN00TS6j50qktgM9Lpu9DydUzojdIfWJ37rh/cCDpa/YVq//UZ8qA8/Mqrr
	dPC6vemnAr38a/O/A0x2xraWiY9xWwnHo2dataFOjbI0JqxXXjMJ8MfzwHnMwBNhj8OgI844UCU
	7nI/b4Tl9SDuYJB7M8VJZUFmueTGjzY/KWycOhgHSdN7GwmeNVyYI9JQlAKVQBHHIpP35Y6Wz9
X-Received: by 2002:a05:6102:508a:b0:744:a3fd:410a with SMTP id ada2fe7eead31-754a14a7a0bmr1973713137.14.1785262825127;
        Tue, 28 Jul 2026 11:20:25 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-977b268a5cbsm360688241.9.2026.07.28.11.20.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 11:20:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Add MGMT Shorter Connection Interval setting
Date: Tue, 28 Jul 2026 14:20:10 -0400
Message-ID: <20260728182011.2334554-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728182011.2334554-1-luiz.dentz@gmail.com>
References: <20260728182011.2334554-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add MGMT_SETTING_SCI (bit 25) to advertise support for the Shorter
Connection Interval (SCI) feature. It is reported in the supported
settings whenever the controller is SCI capable, and in the current
settings whenever LE is enabled and the controller is SCI capable
(SCI has no separate enable command, so it is a passive capability).

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 ++
 include/net/bluetooth/mgmt.h     | 1 +
 net/bluetooth/mgmt.c             | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7e58acb65f48..de0eb0ca5918 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2079,6 +2079,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 
 #define le_sci_capable(dev) \
 	((dev)->le_features[9] & HCI_LE_SCI)
+#define le_sci_enabled(dev) \
+	(le_enabled(dev) && le_sci_capable(dev))
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 08daed7a96d5..b285441db55b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -118,6 +118,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_LL_PRIVACY		BIT(22)
 #define MGMT_SETTING_PAST_SENDER	BIT(23)
 #define MGMT_SETTING_PAST_RECEIVER	BIT(24)
+#define MGMT_SETTING_SCI		BIT(25)
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4fd37ac79986..58f01fbfcf71 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -861,6 +861,9 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (past_receiver_capable(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_capable(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	settings |= MGMT_SETTING_PHY_CONFIGURATION;
 
 	return settings;
@@ -952,6 +955,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (past_receiver_enabled(hdev))
 		settings |= MGMT_SETTING_PAST_RECEIVER;
 
+	if (le_sci_enabled(hdev))
+		settings |= MGMT_SETTING_SCI;
+
 	return settings;
 }
 
-- 
2.54.0

