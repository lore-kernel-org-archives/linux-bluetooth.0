Received: from mail-vk1-f193.google.com (mail-vk1-f193.google.com [209.85.221.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75F2FDC27
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801976; cv=none; b=JmLuk1sQj0W1kgl5Egd0GiT6siGAVwg/EfY/Mj/Ylh9bsIMGAnkNadEIPAwu5zMGCQGFAMiAhoDr2jL0JuOBUl+Mc+9eVWDmp3QCMyJK0dr527kTYbgHY8+Gu1/kk1HGGF2WCPazmfx2CPpgGPwhON078KdS+A3/Tm0Le6rC6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801976; c=relaxed/simple;
	bh=CwPpmGN3ApXn86Bg7GaUZVN/wLn7BbwChprXc0U76Mc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgOMHft5ik02Vh9o/OkGRXb86A+vHL2ovruR2Kxwd0nAwi6j9tOhi5Cnh71H2JpKRiRsh/YxtvzlqR5wkbwEYLlBF6j8WBxcICVQtIBYaNF2akmmq9fSmvcmVQwQf7vzcOCzx65y4p88ButkAkgcHpd5FTplzQEHiyYmrlKNOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEteSbRh; arc=none smtp.client-ip=209.85.221.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEteSbRh"
Received: by mail-vk1-f193.google.com with SMTP id 71dfb90a1353d-56638fca064so805361e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801974; x=1770406774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUcAa8npKgiv0Wva9MgYBhAmp71KHi9k6p2Tpy6UWcA=;
        b=QEteSbRhJ8KXdkJAX3xRe+KgTJsnlhzDJQa6C6GeBCq7zQ2nPBkWOMPCM9+p7OwpfW
         E7LQh30jf6A9grmuC0gBJqH6aBamx0MhyqgRdUpu2OaRWYsRHlWbPaFGFyVP8bjwDQti
         2Ll7kI4/Hb06chFzqxlEOAIK06gNnPQXYMAtL+9uuFOMLVsUWdwxXjbSB8BcH1ZgWX99
         3ty2qdB/mXWyh9s4UbgN9/csBVvnwZBKiTgB4GOWp94VehVrbm+GYx3EwA9a39PaPyuh
         gdMrrByHLILeACjrPjzNJhxzMoiwzQyOV3uqmWvUqvKp8IcMQm7B/56IzAakO+jj+KHk
         Jc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801974; x=1770406774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nUcAa8npKgiv0Wva9MgYBhAmp71KHi9k6p2Tpy6UWcA=;
        b=qdY8PVKs+UBtLAXYWsoDymsY8vGPsXSeWpBHyZUOqDhLwOT5aXNqCFPQj/AJJkNEeE
         4wgQdUta5vVi3PyCPS4dgKdVoMd8b7kCVjmkCW/sHwzojQt0zB5M34ae/QsZdNf7nSIw
         CDKjYFq2Ig3VEEHfzBTSyQmCNi6AmICmst+OGVItVE2qf4/bWsQzAKZ0P/+HUMahpCnk
         y+cCzcLOP80mLLWF+oIE2rma3ipBDrTjdQL9cJGSsoN5e70kDnBL4yYO/oEQh4BkICnr
         WKNT6ZYwC/kleC6a7JI7EB07Gy2jvoIkjsGEjQBv+uL9skjGCn0tKvKb3Q1iXcL0Hytl
         tmZA==
X-Gm-Message-State: AOJu0YyZVtcp6Cz+O2vPR+M9TrKNQj0XW6fHIlhMclVK4L7CWdM7Lkc0
	k3gKUpTrTlKUnOorFN1AF8vK/UfjRqo9+ba7QTfoOh0e2xuP+sRBl6/QlgJynyzA
X-Gm-Gg: AZuq6aILWZASCqrseHS3XxhAg99s/u8dKFDJYu/oRQMF3O7rQmJ7HyLELYNf7rAIjtH
	yp4mTqDYd6GOztQscMR5zone/CZZKTWPefInwDxvES6RQ2pPHURbRHZCnikvxHB2pMVdz/Qv62B
	Mr6MUkbrAO66wvxxJGfCj8Vmj6biaC6wEnNG4nezea0u5ht+WlWqwCCl4NYX+6Laag5TlsHdkaZ
	USm6VnXWQPtSxZrRGrKdWtEXMGt1Oa7LWXM0N/uvc0I+e2ASYYefS94fdLmUiJ6ZHpfiBwz/TYK
	EdsCqcKCETxwmwboMZlNX95wc0cYU1LmWwfXLDMHsTBsbf48AO2s4aSrs7t/kVa/VSN25jNWzzr
	wi8CHCTtQ6edI6g3epbUJFaMpjKMgssvRyvMrxJwqmWQvwT/kMphBhm7hTzLWDX52Uxv0CTtod7
	ZDXjTs49p+lsziCgDG04uj7uCdwQPN9DZkGfCMGQYV11yoZ/Q5tKjGWafZdmzx0RjkcjqRJhLws
	hN9Jg==
X-Received: by 2002:a05:6122:2212:b0:55b:1938:9183 with SMTP id 71dfb90a1353d-566a005253cmr1351704e0c.4.1769801974029;
        Fri, 30 Jan 2026 11:39:34 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/35] doc/bluetoothctl-admin: Add :Uses: fields and document arguments
Date: Fri, 30 Jan 2026 14:38:45 -0500
Message-ID: <20260130193921.1273263-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Uses: fields to link commands to their corresponding D-Bus API
methods, and document command arguments with usage examples.
---
 doc/bluetoothctl-admin.rst | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/doc/bluetoothctl-admin.rst b/doc/bluetoothctl-admin.rst
index b0f7f94c18cf..d4446ce95e5f 100644
--- a/doc/bluetoothctl-admin.rst
+++ b/doc/bluetoothctl-admin.rst
@@ -18,6 +18,10 @@ SYNOPSIS
 
 **bluetoothctl** [--options] [admin.commands]
 
+This submenu configures administrative policies using the
+**org.bluez.AdminPolicySet(5)** and **org.bluez.AdminPolicyStatus(5)**
+interfaces.
+
 Admin Policy Commands
 =====================
 
@@ -27,8 +31,28 @@ allow
 Allow service UUIDs and block rest of them.
 
 :Usage: **> allow [clear/uuid1 uuid2 ...]**
-:Example: **> allow 0x1101 0x1102 0x1103**
-:Example: **> allow clear**
+:Uses: **org.bluez.AdminPolicySet(5)** property **ServiceAllowList**
+:[clear/uuid1 uuid2 ...]: List of service UUIDs to allow, or "clear" to remove all restrictions
+:Example Get current allowed UUIDs list:
+	| **> allow**
+:Example Allow Serial Port Profile only:
+	| **> allow 0x1101**
+:Example Allow Serial Port Profile and LAN Access Profile:
+	| **> allow 0x1101 0x1102**
+:Example Allow Serial Port Profile, LAN Access Profile, and Dialup Networking Profile:
+	| **> allow 0x1101 0x1102 0x1103**
+:Example Allow Advanced Audio Distribution Profile only:
+	| **> allow 0x110e**
+:Example Allow A2DP Source and Sink profiles:
+	| **> allow 0x110e 0x110f**
+:Example Allow Serial Port Profile using full UUID:
+	| **> allow 00001101-0000-1000-8000-00805f9b34fb**
+:Example Allow SPP and LAP using full UUIDs:
+	| **> allow 00001101-0000-1000-8000-00805f9b34fb 00001102-0000-1000-8000-00805f9b34fb**
+:Example Remove all UUID restrictions:
+	| **> allow clear**
+:Example Allow SPP, LAP, and DUN using mixed UUID formats:
+	| **> allow 0x1101 00001102-0000-1000-8000-00805f9b34fb 0x1103**
 
 RESOURCES
 =========
-- 
2.52.0

