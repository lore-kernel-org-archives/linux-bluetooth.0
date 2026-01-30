Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com [209.85.222.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7213542C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810601; cv=none; b=MfPNLDWKhpSAczWJeDmtuF6PiGR3J/VnHS4OqT1lB3vQwMFgQCypQf1nQoE6QsSruWebfC4Z9zDXWgvg7rAfDkyO30AzToVMrGi7UhcZATtL5EHqQY08PYqoPzhZ2FIOwkg/uOB8TjFToCcc0XuQSbYZw+lbB7xz9hjHzlEz+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810601; c=relaxed/simple;
	bh=cdtxns0AAbk/X7fluIwMEY/JGpxVcQgeMwogGDuITec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azv30rM3NH6ToGX8tVAAuGVbVXTATERVi6FTjNhEAlDDBSwZFMFxTeRA2baKKZ4OVDNv5P5JWVOXmd5jfm+YPDNX+LgDpajEpMfjyEIGH31p9N7OUtX6TASwYntkzpDRnYbKGtX0Vgt7rVtQLq9ugBFZBs5DexS8tti+QcUxbEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ77xWV7; arc=none smtp.client-ip=209.85.222.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ77xWV7"
Received: by mail-ua1-f68.google.com with SMTP id a1e0cc1a2514c-9489d087bcfso298734241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810599; x=1770415399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dl/LGTPwiwxL//5coSNOB620xUnclD+MBHY4V0vXxv0=;
        b=eZ77xWV7DhF3WAyiVBLFmhvgTW/IRy6gzse/UrVIKMEEGht+tJHIsWgWTKHi4PGZbh
         Ga88XgCZrGjY0/Y5+LBZim5tXLBqkFeF7xAW+X3w8R4kV2JQsDl1LHaA4WOaYlW4k+j7
         +yDlE1cTKiIdYW5+rP6UexOBkffcIueSTFJq82pxn3O2uPDDkLtKk/qs4/qj0RVq3XKm
         CCsysqu5UjxWGdjwC4089kdkbsQILc4mztBz2m10Hx+C0YcExD916eq4QTynfn3m8kNV
         czB8ql7ppRF4E9Me2ONyAu5NtreKo1RJHCr5/Jr4krv09ccN/oIWQAK+FqKcY9uljlFn
         7JZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810599; x=1770415399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dl/LGTPwiwxL//5coSNOB620xUnclD+MBHY4V0vXxv0=;
        b=RgZtH6ow2nJQQbP/UQNLHXtQCbpZvIKJF51Qgl8JxQDlCSU7j4NBLuYV13ZFIn9wnq
         XDmY3pA6sAzL9ril0Ms1RLEcRB5bT/IuWPG4ovPbbwkDHXvaRHrChW2XBfeKHFkAHtyG
         TVefTqkpD9e4Kb46mE2QUln6Tmu8cpV1MLi2QfBOo+YuVBR+0qjcg19D07qFYPtrjm/A
         UUE5WFf9gqh+6+3JxCcZf53/JpUcChq/uv9T6xJAPENRwU4kKLf2RX3FfouObzB7sj11
         W+A0vfuub0HIwMhEoCzPukC5hSxWWmIYIP0Zw2LsHIKAsf6tTjRBpBJRGp/3Leg9WLfq
         GS/w==
X-Gm-Message-State: AOJu0Yz9gA8HYM3E8TKhdpXd7upeXifRRKcfGKzaiUdiM/lVTzrCT8/D
	4PT71uMB7dHP+NkGdo+Q4s036JftUAcY7wswXXuzsyyd23jXFiNSPqONsAZuUn7e
X-Gm-Gg: AZuq6aJn0ChajZ4dS20oKs9u/UWNzkxSnDmEvAXztF6B5oMI0au/jDxbWNIusuT7EvG
	U/gpnRSo31p0huGm/lG0asSXZQ/tUAZ+ZeDQuH1FpYeCl70qYjXPN5booACvCXUwwgvYFo6qMGC
	VVmX6hfIvS9VZuTtMbWHLuPg/pRhRaaEPNRhEPTeOknYQymTv0YiLxUy1vLNuvezNC4sRoZRYFU
	6FnvNDp4jUQxoBT8Bq8ykQfakx6gnqyOcjYt/4WFacMxoPkw0gL1zoKl0w8GHHtyrjxc/yRrhrx
	Rma5O4ErDrwy7iSjgfNWfESvhotkjJKeiPJ4HMtegX3sEfZIiinNOlf7+Rdkri0Yyy+ZHX8MKay
	SeIxDk1F4fo4+D7G6mIwyTkEGChMGed+PhobSaSCSL8SWPk/tBWu2eMuUUJ3nDX/RU+qb6oZsXl
	ETdM+uVr/ZknqiBwKTHeUfQTImRR9A8YHNI6ZoehI8Q+N070o3GYPvQh2plGzWETAie7XaQCpvq
	dIKeg==
X-Received: by 2002:a05:6102:1606:b0:5f1:4fb8:6b92 with SMTP id ada2fe7eead31-5f8e25eab88mr1443288137.22.1769810597357;
        Fri, 30 Jan 2026 14:03:17 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 31/37] doc/org.bluez.MediaAssistant: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:22 -0500
Message-ID: <20260130220229.1346261-32-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-assistant and Examples
sections showing corresponding bluetoothctl assistant commands.
---
 doc/org.bluez.MediaAssistant.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.MediaAssistant.rst b/doc/org.bluez.MediaAssistant.rst
index 8650d8abb379..45143cee8dbf 100644
--- a/doc/org.bluez.MediaAssistant.rst
+++ b/doc/org.bluez.MediaAssistant.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.MediaAssistant1
 :Object path:	/org/bluez/{hci0,hci1,...}/dev_{BDADDR}/src_{BDADDR}/sid#/bis#
+:Used by:	**bluetoothctl-assistant(1)**
 
 Methods
 -------
@@ -45,6 +46,10 @@ Values:
 		Push to a specific device. Device must be connected and with
 		an active BASS session.
 
+Examples:
+
+:bluetoothctl: > assistant.push <assistant>
+
 Properties
 ----------
 
-- 
2.52.0

