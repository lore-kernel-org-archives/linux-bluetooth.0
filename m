Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0E2FDC27
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801989; cv=none; b=LSJKmcjeBBDEY7W9nWPtfPmFofET3gSn46l7CqvxGjpnOik8YVthWFrtBvAyuIFWK3WLSsbBhdG8sEmC20nQ6b+4t730wdKvn9n6d4SoU0pIpeWDu6fQT6vgfqqOeExcFXnMhe0nycm3U3Lg3aIgrSADwBg+mYJgAZ13CdX17Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801989; c=relaxed/simple;
	bh=r2AeauBkBwNG30W5Ly2CJqNTcsWtPETyuNPQW/3XGBg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5bvz2Cvbx8QSXffsbyulMQTjJ6+R80bhRt7XToFT+Mn0THzpOqPukCv0JgGovkP3/Bbob4Vvc7VAH4ltbHgDdJeteb/v5T2/Woe8vg9ErJFk9GkqedQzcUlYjUZYdvBfH3a3lCNAbk894QsDhGcjJlRU/bnklZMw8lH0KxHnC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au3cl6Jd; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au3cl6Jd"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5662c2937fdso1888175e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801987; x=1770406787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zE50WPGa+Mfsk2R9m1VuF007wPEgp9iph2qWa9KkcU=;
        b=au3cl6JdsWZvJcx8vkFU95BspgeEA9jpgnDtGj66Uw+VpjVC9d4F7IDE44ibCq0I7e
         df6BhMRu+Z9yysZyY5MnJz5l4S0UXTJIQQfj9l2hdFVOFn1/GSawCQzCU3WPxVMPsyeX
         zqPMexQem0LN0kpxvhOzy1I1yagbh8/04KyJqa3CzrLFOTJG05DwjeGNNUck1/hHMhhc
         P12oQ/gFrAiGEqRUQoInXg7FvpNgccCkibVxUTGebnOaVc+i3RCAyC1hAPBnIbSI8W1L
         0PgGSlkpXLqFtGLsV7mPJXTUmyRQNrhYRVpe6pjt+9p7DHI1Ktk+K0GM08ZMVjoyDJef
         8OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801987; x=1770406787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+zE50WPGa+Mfsk2R9m1VuF007wPEgp9iph2qWa9KkcU=;
        b=k9mW3DJGu7fxch3rINrxxK9rkeruxBzXxF5vZNf+UZQAJTwh8G1OqI73j3kydb6my4
         CjDrsa3zj6X0ntjeMmZPn5ZDw0EVzCGEFNJKt5VcmkvewLewP/NX2LVE1/b7sI8RkwiF
         OxqZBHXlVuPnusSuzJUByu+2jOKjbZWlnm18SEPPIr5gAXQWJIwXrdi3sKOgHWHtNPSU
         gKCN1wwI9z+Y71V2GK7Xk1rowhO3JJb3XOyYkGiL+fthmRj4KPxjgmfXAiTGaZtEJPEH
         7mLuM125JvxW34/Y1fWjnC/NVRANnJqs5CMmrd6263FRm+0bGnTNz2yju5rHE5s9h9GJ
         gSDg==
X-Gm-Message-State: AOJu0YzYUAwF1pdOtpcPio4Evkct7ysnzo+EW9G3wS76LzRf486kAXcB
	UiRgr8EZvXLPtD+QIp+NXD1B880jTYEGq9s2xKAzvZ5aiJtYualAf8xqUyQ/Kg==
X-Gm-Gg: AZuq6aIdONvZQTUTsAh3WMLbovdXiMMYdC7qpoSm9MTmD/yk1j8Vek4607nD6nnIAzd
	i84xhzYfhINhedsgD0qEJ690kmGaD86iY7ksgAS2X0QDn3A4PFKo1lJdxFe3F5uu818T8ckNhqj
	udR3QWNhUvrrIbm/zd1V4WQQRcfsfalv34qw5T4O0EmVpOPq/yXBPv9SI4s3eEIpnYb3Furt0c4
	Q6cNGXO3JPAXMRBj1q7oQ4jIv5WDWGX/JS/vyvIVeT89rzECea1G52rcvnHv/BhGINbXRq2V35e
	ZQHs5gzAy6WQBkr6wZgLLIUzIFBWWczYw6+K69yz7Hra5DwfZCs5Y4aySyhIPZGwXKOsYP6jC0s
	PYg20/pzFSTnNWLrhEw/YyvpyPvVxbQrGaCPh/k7/Dh7Vmihy+1ssPtXmQU5wshpdz9YX2krjPN
	M/PTFKc+bXXWRO554k8zTYhYkNj3pa3B9QBFB/dCZkow7i35mPAuj5RWd40okJ6xMdlYyy5xon5
	UlPyg==
X-Received: by 2002:a05:6122:d0b:b0:55b:9bf6:da7d with SMTP id 71dfb90a1353d-566a17508ccmr1060834e0c.2.1769801987293;
        Fri, 30 Jan 2026 11:39:47 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 17/35] doc/org.bluez.AdminPolicySet: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:38:59 -0500
Message-ID: <20260130193921.1273263-18-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-admin and Examples sections
showing corresponding bluetoothctl commands for D-Bus methods.
---
 doc/org.bluez.AdminPolicySet.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/org.bluez.AdminPolicySet.rst b/doc/org.bluez.AdminPolicySet.rst
index ff4cdd2bae8a..db132b7de4cd 100644
--- a/doc/org.bluez.AdminPolicySet.rst
+++ b/doc/org.bluez.AdminPolicySet.rst
@@ -28,6 +28,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.AdminPolicySet1 [experimental]
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl-admin(1)**
 
 Methods
 -------
@@ -50,3 +51,7 @@ Possible errors:
 
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.Failed:
+
+Examples:
+
+:bluetoothctl: > admin.allow [clear/uuid1 uuid2 ...]
-- 
2.52.0

