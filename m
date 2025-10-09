Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150822848BA
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045395; cv=none; b=lQcY/ZycAKuVxjPcjxhakuQAHi1jUpav9n4zyXEdxGAQ67APDNa8Muk/FR/WrCW+qOTJPFpKbPaSaDB4qTvghr7uDlJPOQUi8Ys7eh+ypzQ7FKsqAMLGnfQmyeGPLQOHh1XFmn+uNvythuVJqm8eqQv9CkGCS8QTILDd5/jEzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045395; c=relaxed/simple;
	bh=f9gjONa1r/ht4GRqSpSpfoDjdUNzkY8vmS9TjL+o34U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQsgq5c+75HNloGP6VGjSixElFFaSTx8rMMYi3H/UkIj0fkuqwCwYKk5IjmOKiIsc4ZNYeUecE/0HplgJzXh5nMkPIZo4WIsmOzTyMd8/yPEa179dgatk70+H8TXdQGDc61LNmd1BR6PPXPB9+zDrkafbFvbBoZdU6oAuZA/WzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTghEp8P; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTghEp8P"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54a80b26f88so487997e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760045392; x=1760650192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJsv8HERSefVmIN7aiQsI63ZgE5L+q0tgwhZhnbEgsk=;
        b=MTghEp8Pc71WC5zCqFVOMn0MBAjI8Mm8iV7CmMe9Z0Qam4RCcy0w7eI3lCfQOLvclF
         eJcDoQQap1T/dk1mL6UTpyI3VynD1n9jQ6olMqNah0Jd+ziAFQ7QbxgV0X/Rodf83Duk
         kh9/9vuR/5z2bR43rMZkVoZyPxmXPqiLVW4WSgu5wxNH9JTIzMDOxktdZzGizDgP3qhJ
         3m8lGP15E1FDq+A5z+h7vnH90GqAncykMEpwmW7+MbSye6cFDnvvxeXg7GM8A6TU2n1y
         NPtsAIowL7L58Zc7RMqu/dyVG+nArjLAEOo5ommBTYPi3wf5gouXe9C01PavO1pe0mUT
         RHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760045392; x=1760650192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJsv8HERSefVmIN7aiQsI63ZgE5L+q0tgwhZhnbEgsk=;
        b=qoEWZqhPl/khx51Zq3at5oPk+N6owtC7TL0RZLFP9W7aSwfkzzEqVJhhHHazXo3Z8z
         5aj6w4fS4/xl/kovHn/pVXAYvv4Wmyl4RiagrNjVPctMwOzjkfeqmqXGPdt7gPgFPkAH
         NW7dHJGTqI5dRPG9FlWjRjo+E65lSiuk45/QNNhIJ2ukAhdgc+VpT7auR36uw9KhLJG5
         7OIxwKSwYiPZdh7NfRizXsb2t4DUKmpfgerRfJPIHbt2Ij/8nYfNM93TZkX8lbuX557q
         meMQuaM547fguJVhwOjcyXUQI4g1aXNCEoBoXCXgn53Q7G8JHBW7GPTQ5kemFFMYlc3O
         Gyog==
X-Gm-Message-State: AOJu0Yzvr/qSfen+eASJFPWMC67uz80Ft9tY3YiwDWWy0HkCwsvzEqVJ
	xgCszRjQOVlQPqVafUGBw9J4fRkJHLBj7wFZHwnbi6YaYEWdb9gng1b7LkJRO2dq
X-Gm-Gg: ASbGnctGdbKVaedZIujEhc9vdjBrlzTwfKcQ5yxFa2TZNdPVTuKOX/Hd73ZvT3WOfJl
	KGO2rUoWWfLEzggEfkJMYfEXsrZQly7PtrR27ytVrO3ZQO7Qs5khoiSVhjKktCBCA4lffvUbsr3
	XQjPifZLPLaW8aeXn6njSSaYWoT+peXDh8WZdC7gKgd4KquRE9JCoa0ahqrwon1Tmw608btfwrE
	xu57glj/HA9ZdGZxiHSnDJgrcuKLeOrqWmkTdJMpNnZQJB0nt5tk99m6K994AMJ93UeFMk1AWAd
	virfJitKgOBuOFVnj0n0vTebj2RZUIIPimrvzRwzeF5h1kqlgaOMbl4lYs5mpOXvg5X8ZNH1ch0
	6SEI5jHIjvg7LL/daMlt6uXZnCAHdC1eCD4/9dOqPm+CM1jSLeVGNh7gVVH4icOnHpWd+MGBaZo
	G7rn9DBBhjAxVroSP3bX/MMuNa
X-Google-Smtp-Source: AGHT+IHqqirQdPgZ5cOjYWpE9ferwAsRJgt/kYxy/PKVNA0upt+Jw1wTEK61LomGnjTi9GbaaFyqWw==
X-Received: by 2002:a05:6122:4f81:b0:530:7bd4:1761 with SMTP id 71dfb90a1353d-554b8b91c9cmr3754814e0c.11.1760045392250;
        Thu, 09 Oct 2025 14:29:52 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7f01e3fsm211224e0c.7.2025.10.09.14.29.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:29:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/13] MGMT: Add PAST Settings and Flags
Date: Thu,  9 Oct 2025 17:29:23 -0400
Message-ID: <20251009212931.445719-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009212931.445719-1-luiz.dentz@gmail.com>
References: <20251009212931.445719-1-luiz.dentz@gmail.com>
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

