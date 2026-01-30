Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAD3542C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810587; cv=none; b=GNTKaIVBKSYH5Ah/9FxiiKVzD+y+sQUyCSwqfr8LZIPL1vrWAZ2+4LAoFqiom2DCZcdohoRJ93yYOwS+PsSfdK5cUgWyIgSIXbIGI3xBtWRbwfQlrDPJAhU4CG9lJ+Jm94Sk+c1pD+p34lTvaiE7rMumNEDXuNIxnje0sO9A5YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810587; c=relaxed/simple;
	bh=2WJUwud4Oo18KqPGs5B1Z35GG8qQBMCKMy3G9i4B7HU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjwzUrZ8xv5522oAxUOYSSSZl8qM5goDnQ4x+zR8pmm2VaZYz7U78e95RXnQrYQ0iXNhLoiuIr+Fefq6/RgVLHQ43bVtT8FVeHiRxJO6bMS9ZANBWjKtRkgtFTSJwsILSLpsGxJc91Eo/hg4zwX+Tfk0OIyw/JjrpP6L2Iej8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh8qGqZ6; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh8qGqZ6"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56635de8acfso826249e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810585; x=1770415385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cFpL/swKZnEGreY0rfFeXi+dB5lnofejhfp5kQkcNc=;
        b=Qh8qGqZ6tuppymUblrPmsmZsn/TrNYt5MH/uGD6MhZv54L7E0VZl55PCo6WT5bSJeF
         YqoEE2m/fY3wo/6NKt6Gam03QWzGZMGWED3maeHm1OyfrvhRd2LoNwh1dqGfbn2neHRk
         Da2PG62v7mOnOT3s6uuZVT6mMh7sVl25wX3noqrL6W1FCOy2rinekImdGJrK0Vb1csAe
         xxm2CmuIJ5kCpwlbwwB6JnlXPSJQB1urX9Zt4CvlFQ4YuU2tqKveecqB6pbdzEyogzpT
         eAiz90cxlGAswL1vFcEqL2wUcFO+FfBZEHdc78Pkdie+KONFou7BPMcQ0u1Hh7HKxFpC
         jjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810585; x=1770415385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4cFpL/swKZnEGreY0rfFeXi+dB5lnofejhfp5kQkcNc=;
        b=jBo/d1Z6oTl6orT9uPbdVBA1lF5AY/XxiieQ1V+/hKkO/aTowPCwAdeu4ZjJ87nMSo
         xuiMD0mqIukgZYjMPOcZLxE0hhUtAhD7v5jMo87Mo/7xxcbU7vk77wIQjTZ11tKmJ34b
         pCbvu844sK1wk2xepyLoWV2UO9kuOxcfw0dYtHtQzrGzq2XU+7ohnxdUlGCuzK1aiSaV
         lvB4rKbU1K4gLwdgsIBnBzdTKhhVeWS8pP5cGgciKBaX4yRW0f6sdPfs+szA4hhYgqvz
         frI7XJItju8CXxW8ncyGoKkI8G8Qe02vRP5D3Ff4U6eBDTqRq8kaXXrXoxnVzK5Sl2Ye
         2sjw==
X-Gm-Message-State: AOJu0YxzdTbmtOOYsLdy9Cl8s60jdlumWmCZIcJsxlgaJsYYTsIrGlTT
	RgqOUlGET8R0t1mlKyHnaLcyM6I6rHaOtb0TfcDinw8PvFrtnPKZ5lxzfohUIw==
X-Gm-Gg: AZuq6aKpoXWnoP7If28yZf18+42r489pvui6NgRR1rOcJsFc5TVilo2rm4ZoZ7y3+gN
	M/Nhg4lUZVG2cHPlI6sBSFqh8GUJGxq4mWqUGAEh0F1dIoy6rNCt89pDlY3S7DOiZjLtjRephx7
	7r35s8DlVAundwlQGPA55qibAB+t+gAyPN6kCfIS+RtIQhelAgT5iUU1WfCppOXmy08OLNXSKR4
	znCmk1lAfhoxZ0LlJB55TsuFx611XRf/Fr3hJGLOGaUabksx5C5OYU24kmntXNA2+11viM5JL8/
	M/UBtTdWDpd/PWbTzFkVx8Y/0fZc+nBihVL0gICj6X81DP25jjnrTPpHm7drHuIhSjdcPGCPfR4
	VQsgiMbHuXXGjSJ7PU3Xngw6hgVr/y7qw0BYcJKipZhi/mD1Pi7i+ii+FT6uKpa5n4X9B3MIhTO
	Z2HyoD9Qj/G2FfehitX2CRWUZj4ddsIyNWBEStuL8bJ+sXO86tOMqJet2bpKZpYVuVTJZ9vQdRj
	UXPzA==
X-Received: by 2002:a05:6122:2a4b:b0:563:62ce:b28e with SMTP id 71dfb90a1353d-5669ffd8f54mr1168107e0c.2.1769810584668;
        Fri, 30 Jan 2026 14:03:04 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 20/37] doc/org.bluez.AdvertisementMonitorManager: Add Used by reference
Date: Fri, 30 Jan 2026 17:02:11 -0500
Message-ID: <20260130220229.1346261-21-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-monitor for this interface
used to register advertisement monitors.
---
 doc/org.bluez.AdvertisementMonitorManager.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.AdvertisementMonitorManager.rst b/doc/org.bluez.AdvertisementMonitorManager.rst
index 3860429b0cee..efc1c12ba7c1 100644
--- a/doc/org.bluez.AdvertisementMonitorManager.rst
+++ b/doc/org.bluez.AdvertisementMonitorManager.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.AdvertisementMonitorManager1 [experimental]
 :Object path:	/org/bluez/{hci0,hci1,...}
+:Used by:	**bluetoothctl-monitor(1)**
 
 Methods
 -------
@@ -43,6 +44,10 @@ Possible errors:
 :org.bluez.Error.AlreadyExists:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: [monitor] > add-or-pattern <start_pos> <ad_type> <content>
+
 void UnregisterMonitor(object application)
 ``````````````````````````````````````````
 
@@ -59,6 +64,10 @@ Possible errors:
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.DoesNotExist:
 
+Examples:
+
+:bluetoothctl: [monitor] > remove-pattern <monitor-id/all>
+
 Properties
 ----------
 
-- 
2.52.0

