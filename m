Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702530597E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474066; cv=none; b=G5WX8IYxXtfeGiRE/30kHXjcRtxQZPueVyt+Gv61uqSu+CBZZ+/BZu5p2r2zJywzdmAYAH8/YphCNxAw+IwDvYpvSWmGePwPDxxVzewmivENKSZlB4J/IjlSDt9DApder9xBC62qPb9ZZyzSzM+NlUnr+NXywk7EG3YUp+sqKBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474066; c=relaxed/simple;
	bh=f9gjONa1r/ht4GRqSpSpfoDjdUNzkY8vmS9TjL+o34U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUQ+Ezo3mSfQUcTdjdq544NxThXEcVVyCdegl0ot74wSJY+O1zvh3yfTB6DOXLoGWkrZ/77VpFZClUrENJmQbr+gzF1yLX9htsLC0ExbAZG4kE7JlNMnnxUFwi09zm7kt/mTXqLJuxM79RO1yBQJn8pqdfJPSqYscyzTXS9YEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxjq6FsN; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxjq6FsN"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54a8f6a2d80so1952329e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760474062; x=1761078862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJsv8HERSefVmIN7aiQsI63ZgE5L+q0tgwhZhnbEgsk=;
        b=kxjq6FsNMXkNSHiRUQyZq/dHngC1zUwf9w/54zaTUptfRAVRqH8RxtnpvV9xKsVXgu
         goCK6PnlTMyS9dIGZk+jaio3MCqEZbw9CqYArxcTH2AMpzCGUAYtIK6V+hYgnAWm5WR0
         Puc5bauzb8oVM9ufEC/Jjdc8fBDqxzH8cf3Lc2c591r8onfq6SCemDetemAocBgR8+AZ
         vNOJxjsY6t79pfo9GgCK71wtVBXpXUp/dsnVQm4cC7h7YapzfrpNffghQojJV0tVdjjF
         TKeekqzcda/gwgiGDKglB24KiXNGpe6HKwyAZxHRPrKI2XIfO9/KNhsGdauKD7QpMyT8
         Sbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760474062; x=1761078862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJsv8HERSefVmIN7aiQsI63ZgE5L+q0tgwhZhnbEgsk=;
        b=vNzoSbrfGcb9j/g41CRGBG5gmIO0tyBBShwbNm/xpiLVFsMSir+DUs1UivmGK8smIp
         3QsaxlZqphvToTpDCK3z5CBWzG1nukJrRA6E9zmCeZ09R9wHdhqJ14FoGNoywfOZM5s2
         XPvIdFrBJQbFkejjEJrACUOzb7Ndj+kaKV/TmAM1mWfSfnuAFaWGBWb+TU3b84MnyMWk
         lN1cRi/c+XtOrLsdlIdyt+e6K5SK9oq+/YOTwrLfPSiVGkCHS9lNuXWCktrbrbLhSy3P
         LP6eYabru+MTNnUmt2L4tBm/rNnvyWbLQ1qt9KkK5BLRB6AmaN5kfnf0U7qXEO0YPBr4
         hRtQ==
X-Gm-Message-State: AOJu0YzHx2URDyC8k8NF4EHP895jifZt3TAU0gJrhke4g9PvVjin7s7y
	1/FQMwFRtyg8jFwBKb6p7PcB+N27uF7VRl6aWfPRgE4aUSSSyTdgpjUHuVSx54TN
X-Gm-Gg: ASbGnctxvnmW3EjtXyk5u4ddwIiy/uPKTWKa6QTJNqUxoslkuGiWa++RTeExdG12SIZ
	YqfAmqiXX8IE+GEsrufbTclDjnQSIblQxPG1U8c/5cwC1py44RglmWJqWnvvIKUK87R2JjoXJjL
	ZJ1Uk5v8FtMoXWBlxVKDX12A0pqRUmjl/44ZucQGtrqBfqgrmk/4y0ytUrS0k6Olc0+qJmE2fY2
	rRxl7vp9ASPaVmG3QLZZ5IDeW2KSwGYHQj86d7bGKDy2cWUsxmxBfifHiBz9KY5RZfbysqMZzz0
	TU7RKmaFoFekJZ6ADT5E+HTssUYFpvWJlJs3tvqLdZL2Y6N5ZJKmpE9bp9ei8Cu6YdIjTIRuzU8
	WqK3Ad4PKaWRbyAe/+ACxPH5c6Iasmiw9HU4HWHWpGEWq49r+jjBpVJtCanEaBbUKDw==
X-Google-Smtp-Source: AGHT+IHi2JLqyVMyoQj64v8EHJXOZD6hDEyLkWbfg7pkxwYMyEzAiTaNkoXAGniqb8MjDxob001JwQ==
X-Received: by 2002:a05:6122:46a6:b0:554:afee:9a83 with SMTP id 71dfb90a1353d-554b8adccdamr9339347e0c.4.1760474062388;
        Tue, 14 Oct 2025 13:34:22 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80a456csm4434116e0c.14.2025.10.14.13.34.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 13:34:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/6] MGMT: Add PAST Settings and Flags
Date: Tue, 14 Oct 2025 16:33:59 -0400
Message-ID: <20251014203400.453454-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014203400.453454-1-luiz.dentz@gmail.com>
References: <20251014203400.453454-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds PAST Settings and Flags definitions and documentation.
---
 doc/mgmt.rst         | 3 +++
 lib/bluetooth/mgmt.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/doc/mgmt.rst b/doc/mgmt.rst
index 5ffc766bddc4..3fca69ed0b6e 100644
--- a/doc/mgmt.rst
+++ b/doc/mgmt.rst
@@ -319,6 +319,8 @@ following available bits:
     20, Isochronous Broadcaster
     21, Synchronized Receiver
     22, LL Privacy
+    23, PAST Sender
+    24, PAST Receiver
 
 This command generates a Command Complete event on success or a Command Status
 event on failure.
@@ -3581,6 +3583,7 @@ available bits:
 	0, Remote Wakeup enabled
 	1, Device Privacy Mode enabled
 	2, Address Resolution enabled
+	3, PAST enabled
 
 This command generates a Command Complete event on success or a Command Status
 event on failure.
diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index 2b45010d1b0b..1ad52529f0c7 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -105,6 +105,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_ISO_BROADCASTER	BIT(20)
 #define MGMT_SETTING_ISO_SYNC_RECEIVER	BIT(21)
 #define MGMT_SETTING_LL_PRIVACY		BIT(22)
+#define MGMT_SETTING_PAST_SENDER	BIT(23)
+#define MGMT_SETTING_PAST_RECEIVER	BIT(24)
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
@@ -680,6 +682,7 @@ struct mgmt_rp_get_device_flags {
 #define DEVICE_FLAG_REMOTE_WAKEUP	BIT(0)
 #define DEVICE_FLAG_DEVICE_PRIVACY	BIT(1)
 #define DEVICE_FLAG_ADDRESS_RESOLUTION	BIT(2)
+#define DEVICE_FLAG_PAST		BIT(3)
 
 #define MGMT_OP_SET_DEVICE_FLAGS	0x0050
 #define MGMT_SET_DEVICE_FLAGS_SIZE	11
-- 
2.51.0

