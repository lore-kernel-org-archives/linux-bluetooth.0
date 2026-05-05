Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61B3D4114
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011320; cv=none; b=fh3Vvv3bk9nYLWCQkkwW9JMoHOYwv3PGLJF2kRAcUzI3tcxBo5oYuvrAcAwNvko+rx1IumOq6PEsohGcfMQ3M7RSXRotsE/VsfiTWrhLalSNjMIBpATlUrXVRWwZ26rd4lt79wqlvvvdurJmzCVH7ova86QCePGsYAAqcpy8zBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011320; c=relaxed/simple;
	bh=do/aGrssmUaTl6yk32vILSh0yZc8GlGxxvuNRnrGmuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qw8XwYArJYD9ofyFOxcZszv0h5CuBmuMgp70ivIaD4B1rXhwdzGQzA1t2WJH5raWWhgR0scST3d8SchLDDZ5zvqjDSbPuaiCyRckioTpDZhvdQNj/ZZiwebtDZtip1C6HCz0ywV3gj+m6wiQApI1ex+kAAwYWZZmUN4VgCUmun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajdzWcd+; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajdzWcd+"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-95699e8e26aso1480473241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 May 2026 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778011315; x=1778616115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1HXetTcB3jJ/4wh09EVc/AJ/7YMGbKDRH9XeEzJcQk=;
        b=ajdzWcd+R8bcfWKmVFX2RFpQZ9W6gOEWBfYzCHeTo40+jqswlgmqKSgv8dzW3iVkKB
         dNCC7Nrg6jyLw+mMkTzM1Ov11X8Cz2LvdihSqmzziPNhT3u9AUH+50eYYkvDE77RiV6N
         iU2xX2wMrTYgZWoaDEa1YoLiGRCP6b+2yqf8wPFbN4kPGvAWpf29CVU4xbvB3sblWmSt
         F4iNh1ARQ0xMWpYq90YGSzJi4UgK6FmVzfkxRcEmXnCNTvrghQH5evJ4+360lqkFSJy+
         hbXtTV6F9D2eZPN0nHKpfWEmpVWchR7mdc8KkEb73JYnwG23lUJRKl7Iq8CbmrmstMs5
         LY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778011315; x=1778616115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n1HXetTcB3jJ/4wh09EVc/AJ/7YMGbKDRH9XeEzJcQk=;
        b=TcjMIUkpXsKwbxV8462+1/VDbjr7CJBsQH9zw4a7eP5qhIg/ivoL5iCQ8WDaY2QiaN
         FsUaYnttD9cu7yMjA9NSjvdBIlHJRHPGjOiIk4LgWcd9jz7aY0G5OlCsgJhSXm/KWU/R
         k3rffe7ri49h8lKcpo+3jwMg7mrdYfGUXQqbVkEJtQDveeZjNaYCg3qJ0xdZQpR7faU1
         ezqal70JP5dKHvD+Z/HMVg3K4X/c7Sao3FL0CGZ9pWnS/GGmirqUOHy4x/pE6a63ZMVl
         vK7/mBoIaDPaJdmjm7k8Vzpnd+5TJlLd3nRYkPxd1h7mxlL3Ke8tg/n0qgJIBSeonLS/
         7j4g==
X-Gm-Message-State: AOJu0YybDhDwjMJIGNai9syS6OgAmz9reZvLeOcAYRFRsEFZeWqDcZ54
	wv5lLLC+lFNo8YyEDtp8DsrUq93XmAa8L/q3+exxMVmOZZLJ5wCOFSZSd/Z6Q9ck
X-Gm-Gg: AeBDieu/T02Y5n1EIcBvbpKGpl9LaYSiCK/oOtu/5o3bfJuTvabLO+fA0FBGkF2aX4U
	l6RT/n7S1WIMZdx7YFhK62i5vMjx+WVrRjHOC6RreVt3Yo5jCPMM/XSCR281Jq7kvL+b23XHtqr
	BAF/H9GsrYGw2hgzzaXCkibqNyV+x1uNF3+n2wjr39cRNYaH3j/qoIQ6IA7jjk4TgRlN1p70BD2
	WGE7LlE6zcrJBiiBKwAkOAUot/ogvIrZvO8RiX17XlbXVbrdn/wrrA+tykd2SCrbR9kjYZKQdPc
	Z7jAhzP3jkMoGQau5Lscmhmn8MV8DFqSy6rty9l1Et96hgOoN77TOo5m8f5FcfGs13PHFclr19x
	anhUDDG+uSincezc7URK1GVNzDt3JRtsfpEor6YBTSKStSVliEUwJ7aLV6B0XYwIbSR0rMIVCfz
	c99v3769jBwa+rF/izOrA3uhVBpaEO3+x0iTMVCzfD54wxSwKlFq70Q3SF9Wsw7Y/Dd3pWP+Mk2
	cp4yvHPTnc4oFhKl1uXV5OOpEUY
X-Received: by 2002:a05:6102:5813:b0:605:558d:c7c2 with SMTP id ada2fe7eead31-630f8ee258fmr60648137.12.1778011315520;
        Tue, 05 May 2026 13:01:55 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95d0ac3217dsm4819391241.3.2026.05.05.13.01.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:01:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: MGMT: Add SCI setting bit(25)
Date: Tue,  5 May 2026 16:01:47 -0400
Message-ID: <20260505200147.1325903-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505200147.1325903-1-luiz.dentz@gmail.com>
References: <20260505200147.1325903-1-luiz.dentz@gmail.com>
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
index cf4860c64f00..c608e544e735 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2094,6 +2094,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Shorter Connection Intervals support */
 #define le_sci_capable(dev) \
 	((dev)->le_features[9] & HCI_LE_SCI)
+#define le_sci_enabled(dev) \
+	(le_enabled(dev) && le_sci_capable(dev))
 
 /* ----- HCI protocols ----- */
 #define HCI_PROTO_DEFER             0x01
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

