Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795375804;
	b=QA5z6zmdyb9ildKbCohdZzsf52jBPfowrILOqWGg2PVIBZZpKXzd2U/okzFVPSnJno+m
	 hXoTqy0+P+pe1O7J+GrZ/x81254jK4eFmMipNXtlhN4wuUwcE3/Z8V9VPZafQAD4vDbCG
	 BRx2Kt2srXvtef/h+c+MYbsy5Ox5R1Dc6mA3wYcDUBuTD03VQKaIVaqaLoVu0xQYbLwxD
	 Uq0rE9l5ZR01hLOJl5HLVIHypU2+LgqrQWb8UUNhGU2jPLfmFwqJ+g0UX3SPdXQsYXHRI
	 nkjfbzokQFJdSVPMvJpSq6PPLmSI1Fmzx+g5tGAjyDUr4HMp1A0FqEP56vIlNuo9F4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mmSWuZe4I20vQb16mwQFwPmdmma90AmZItq7fAkb+e0=;
	b=nBsknz5XXkABHbOigjcO5yA8SfkZj2K1dxJErB4cnmUxj4bFttwH9295MNoNOrJZwRzC
	 ZHvN852F7MSd2Rn6Z3jRAbJOPaZzOH1uzDL8FwsFA2G0GdDd9QsJ3ch5fIUERZR2pbDcN
	 q6c/2m9WELQYWMDCk1lBGoWpCUmlTJ2/6DnEFHKwjwsHDuTdByMDye7y9WG2VDJWUeSD4
	 /4+xv+bX9dwheuABSUo5NUtsAduYqGhD1TBEIdkz5qL/Dg3WOqOhXhHH3QVoZj9CG5BEZ
	 63sKJ5IKSro+Hg/tWIvHdg35SClSbaHEX4xccRM2+CL5KIOuMKOM6bvp3HvshOKmMog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=FSyqVC5d;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E9606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 19:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C01E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=FSyqVC5d
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so20912695e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795375802; x=1795980602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mmSWuZe4I20vQb16mwQFwPmdmma90AmZItq7fAkb+e0=;
        b=FSyqVC5dRpFg2jbaPxydiZPvtx4zrj+S1fTLSvaZkHr2JuUfbkdbrtjwItwNJveVPG
         GYyHUmq5KLBGj3eNbpFLi1+HlY7yuKIW0xuc13BVZRSnulsmMItNz1eEmetkmNE/W21R
         nT45hgecoLod5H/2WQWWcQiXAPKJBUV606eMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795375802; x=1795980602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mmSWuZe4I20vQb16mwQFwPmdmma90AmZItq7fAkb+e0=;
        b=tok3P2mVevKcUw8R/pZAd7Wbdd0l5+9ADISoI3O3ZB1Ommkap2KREKllDPwSektciL
         2XyvbwFgHv/BgoDh/DUd70Jv4h0EUECnLIdvbP6EFuESZR9rmXklZ/cJUWA7hHazlRnA
         +QnPaui7wICkDYlEKbTNj5R5dPqVVsmbcOWnm3jV+WmgClUIhTRV6P/ivhh4bBm5DKpO
         /JUaRHVXBmrtLpogYTmT1Ri3CQHfOwAcIiqeKjayHGZwZ1WUD+oZiBfB+aI87eLu6W6a
         ncUsrHnLov8lrk0Wtaa5gDEN8FOotADjeJ6LYiq3rHceODctRcjGtxhl6xRygKl6yp9P
         aI4w==
X-Gm-Message-State: APuU4Z/8VgtbXbl99rwu9tDA5w0vQsH449a70TSdeJLyLmIcVkVpXRVK
	HPaMBp2g9HUOOLxLcArlkG2WXjaYDSMmB8XaXYlb7B4M/hko8XQ8fY0Ns26rClax1TK3aw+RNbb
	SYKki
X-Gm-Gg: AZFdTZcSq72ETLNhb8lV1uA3Y8DLf9x1Rg+ai0luFstqk772m8xvzHSksUmWdUq8Wdv
	fC5sBf16MdBwsl+0kYhsQ//3gtSgGd42IHMbiCVMAroIYOXVnMCaE+cMI1j2iVmdNPGB9C24zpN
	dGWJJ9NjmwSa6QcXfYUGSJ2QowqpuveJuEv9zXVFmtTE8kFwjGKbecoa7AJAwIw/icEWRpXOJ1U
	T/StKDr1FQ28c0vJpbvzDrun04fkKkunPoItHiWEPZvwJwhOTXR7nJKx8AHrbIAMZ6/nOsyU6B7
	kV6vS7gWPxbLiVtgxtVj3kZKHZblfGlwjJ6EHGSUi74/3IY/HCox+uRkaXUjxBn83J/HpSUsLEw
	9e9rgtat7v/o4nvs61GuDkuWc81GDWTrWHxev6YY48U35FXV4tRoZprVcHoOHRV6FENNA3m7xD0
	lfoehwURDhy/6lokp+/+L363uN+0uNdISTV8Ks+tnoOEpeZoxDCHouTjPYywjm9n7qjXNVqspg6
	DXX9PFADnEdD7cqu9KCIbrnJDfdR1bEdnVTOUZGB1F42f9F8IZ2F+ImZKCe/3wLEO9F0krs//Jj
	q57Ede1eVrbDQaWMmMOzIl/o/L1Cv2c0iscW4XVdBUpmR3lC2A==
X-Received: by 2002:a05:600c:46d3:b0:4bb:5c92:ce12 with SMTP id 5b1f17b1804b1-4bb88812200mr212267135e9.17.1795375802039;
        Sun, 22 Nov 2026 11:30:02 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm238371825e9.4.2026.11.22.11.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:30:01 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/2] adapter: Notify adapter drivers of settings changes
Date: Sun, 22 Nov 2026 20:29:54 +0100
Message-ID: <20261122192955.2329174-1-simon.mikuda@streamunlimited.com>
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

