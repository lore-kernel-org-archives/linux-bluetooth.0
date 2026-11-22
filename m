Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795344634;
	b=hXj5RjhxIb2PZaNjowdM59OiJuwkTVTbHyaX0idcFfjgz1GTruZF4eSYXhQ3EHmKUplP
	 qfa4wyVQHqgH3v10slkcbkGk54JnWEe6H+I/AvYcpwIAo8LSSgKCbKHYQW0BBMWX2BeSu
	 X07gRYrkH4BXNbrD/TB9xB6i53D+GX7gsmC7dAq5mtqrvKbJu8+dimZpPjvbtR4GXWpMm
	 nUVT8oeEmnOIIxTY3tmHKZQ1Nfhi1EenqJHWhF6hTp8W/QBBErRst9CsgK60EZyY4/s2N
	 vgCdYCjJPTT0YaeEl+I3KijUVqM6ONni045A9BVutuwpQ2M4FQiwZkVW3lVFaSNdBCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795344634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mmSWuZe4I20vQb16mwQFwPmdmma90AmZItq7fAkb+e0=;
	b=T4TLfupZoDCM28TterL58VEtYyycDpy1fdQtVBRreQgEAfHMtX2f4IXHi+X7UxgUzKMA
	 mMnNKBEhVcn0TaZRzmZdBxMFJms6I1WMl2lm1hYpq7vu5yiYFDnSSp0lKGXRHnlMR7ZoP
	 rKtie7pLtFiHvHi10X5Fv3pkpZLucUwV0dAOvONa67Ku+CsmA8/Z8LzuhAbUBc3BV6fDO
	 ZlcOXzr7sGttEceI28U5nFESCl/zB451tPuO1wfV9GSctlFk+lkvVUv7qOsBb2+f8FHq5
	 1H1tcogEyvtUNQONXjFlWyq1+v55j28v79gEzhnhp+kg57/kHNhT5v5KSXHdchw/KVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=FjC6Dtuu;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14A606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E14A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=FjC6Dtuu
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1036324f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795344632; x=1795949432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mmSWuZe4I20vQb16mwQFwPmdmma90AmZItq7fAkb+e0=;
        b=FjC6DtuubIWQ5QVdkIrOE3h5e+zQbVKF2OuyCk1GAdGp+yFXREfLhF0fdRI0a4T6Al
         tPB8uuEcU7xQWA1IY04HmFwG5ybxBFZ9+pF+R6RzWNe5j4E+NVGpy5U65PFSecaq+87S
         wgQrwUJaS8+BQNnB21TkkZFH2h1eSyK3rSB70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795344632; x=1795949432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mmSWuZe4I20vQb16mwQFwPmdmma90AmZItq7fAkb+e0=;
        b=rnwODNJI2b6FZGxOmPjeJVX13e1D+PlRC06vzWL0KtZ3XJmWFOd62prBrVrxSYvz5t
         SOyrzjPRAdRdOP5xV9/8LjRZ9SrgySWu1iuV7uqfMjhgQQPYs/viLwGMQN7jWwoNpLjh
         eSd69++haABX08Pglbi1pHFtdpcAAW1czEbWVYkD5kSHatHr8qnZMNVveP135zMRlvAk
         c7PNRLLAbP3Ak+fNMxah/ALXwuGUL6dCdobp2Cqt+LhGILu7K05zvmsyIJCnsSDTwsC+
         WU4wjMo5LIHkDwU+68d/7dNLpXvzlue5GoDF/gC4ShZSgblbqJmfqzNs73sFdxNyNYoH
         2U3Q==
X-Gm-Message-State: APuU4Z/PUDAT7YoKnsU0s4xm5jP89cy8FHVpI4K6yR0/eZCo+2G4SgoE
	ImbG7Zw1CVwsloiAbnSjp3zf55Rf78XrEDkKE6BIL8Btds9h8oTlxVE/d0dajos8tKYbsaFafM0
	UGhZj
X-Gm-Gg: AZFdTZcXSojTvaZTgtP6eaki3dnbRMxJyPFl3CTVyqkrG5CnIcCD4qEtW/kQc1QmH5j
	PhONLqGbjglqcfJx3uClTLCwMto9tOvqAa/iHw0WWEh8tkye/gli2PlKb16BY3bLxfjjOr8hOOz
	upKi1E+ccCX+erWizBLHiNZJlHLmurRonFkOTiL+Zf8MVAWVAU9U3AUUYFYjmWy5mGN0Ymkthsn
	yUog9syEoyP1jm5UbQ3Y3YDklX7rIi7uyH9wvlKBBhuPSe4M3FM7p69wcfrZCYDRAQpbwH2ERVt
	iPx5tAyvUZA1otZqMIfYxWs51Ku6GZi/YABRI1zD0qsOBTuDmmwxjjywbQB/ewvUwo+LAC7fO+I
	nH8z0TuQqCmBsB72ofxxiF7xCd56zg7P90ulxOx/luyCFEi7AYytA6Qxc1vVgTpmXA/s7eCSz82
	t6ML7Zl1iWaClxZfTl5sXLhw/niVMYxU86Bihycu/hTB/968Ws0yy8hfaZm3wCbGGa6//bC/TiS
	jj+OGtCFHM8v0mYxk2oVOG88/kl7G6UJSw9BESGz17cPhFzhxkd9IuFxztQ3JHaj0lHf/wwnhyD
	X06nGOdhI2YEqugalb5Kuun4DB/L7nXtv83PvcylXzoQql6GWA==
X-Received: by 2002:a05:6000:29d2:b0:4aa:2afc:ea30 with SMTP id ffacd0b85a97d-4abb3c37a38mr10368419f8f.19.1795344632556;
        Sun, 22 Nov 2026 02:50:32 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm17959915f8f.24.2026.11.22.02.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:50:32 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/2] adapter: Notify adapter drivers of settings changes
Date: Sun, 22 Nov 2026 11:50:25 +0100
Message-ID: <20261122105026.753191-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a settings_changed callback to adapter drivers, called with the
MGMT_SETTING_* bits that changed whenever the adapter's current
settings change. The media driver needs it to follow the CIS and ISO
broadcast settings, which the kernel only sets once the controller is
up.

Assisted-by: Claude:claude-opus-5-5
---
 src/adapter.c | 11 +++++++++++
 src/adapter.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 1439642cb..112312651 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -688,6 +688,17 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 
 		trigger_pairable_timeout(adapter);
 	}
+
+	if (changed_mask) {
+		GSList *l;
+
+		for (l = adapter->drivers; l; l = g_slist_next(l)) {
+			struct btd_adapter_driver *driver = l->data;
+
+			if (driver->settings_changed)
+				driver->settings_changed(adapter, changed_mask);
+		}
+	}
 }
 
 static void adapter_set_power_state(struct btd_adapter *adapter, uint32_t value)
diff --git a/src/adapter.h b/src/adapter.h
index 18e6eaa78..63016c8e1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -134,6 +134,8 @@ struct btd_adapter_driver {
 						struct btd_device *device);
 	void (*device_resolved)(struct btd_adapter *adapter,
 						struct btd_device *device);
+	void (*settings_changed)(struct btd_adapter *adapter,
+						uint32_t changed);
 
 	/* Indicates the driver is experimental and shall only be registered
 	 * when experimental has been enabled (see: main.conf:Experimental).

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

