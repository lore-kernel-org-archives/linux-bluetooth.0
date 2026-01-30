Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD092FF144
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801993; cv=none; b=c1h7J4MEBKQZemjzfZA9SALZBIDJd/VQkHOpyxpLe5jgNnBGSZ6hkNfRFEjbNEN611zckjixYnbHhVaBlfzB5eIwGBacTjDqmf65EkTEx8SASeSpN2S0zztoX3GIEvNdCbAns/eJzlyxpzolb0d0kyuHnShtmBAyxpqQ3ddQd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801993; c=relaxed/simple;
	bh=BSgnFGS72HGvic933JJo1JvmBfFo38ewSpGi8NqFzv4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mG8SaNEvKgXU23+VtNDb9ei9pmMFvop1kDJx6uyBMSHwyW8TSzHdrRjBkuDNQvc1sXusvkyxoqYREItsWiUFaXs1ixv+0DNgVBUFo370XDl82N6h/IdEhlCdWPsHzvaSZ5i3QFP9SiLKgWgsLIzkKRVwmbTVOWMdFMRxRteRoPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQQuzIS0; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQQuzIS0"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5636b2fde95so674699e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801991; x=1770406791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyhQdSfoulExYxfXRCKcjdrwSfBSqZU1fYWwDsMPPc4=;
        b=hQQuzIS0lPAWMjvgmxqJ/HMkTVcGlZP5nfb07MXVLZ/CuMc5fMIq9YYbM24kZRZetA
         K9tGBVUAFrs4wNZYHuEFeSaKqbN6/kOmRwqvRgaIdDfq5pV86VAOLc2BM1PHvODxTLeC
         kpt2YT4F3aJbGd2Kzw/NlKCZFxmr2Va9MQq9XyY2SXYtBa2hIYZLgSizAlOLZOInskYY
         IPXFDBARAdrnJoMKylkRpAgCe/N4ulQm5sf2luiInjCEutvIyRYFUcmSJfHB1qT8C4nS
         5O/8IXOG/R/N1UJsBSq/1FyWU1NCmstsXU6sckna79k+t0Ytdoknw7Dk9IPiaDsFMD1d
         Ax+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801991; x=1770406791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IyhQdSfoulExYxfXRCKcjdrwSfBSqZU1fYWwDsMPPc4=;
        b=IfP2TO5u62CN3Y7TLrYnhHZe4h5Wc7QcmbVklFXUTQDXSAgBGkpW5M0LPKcAg+EplC
         WEegBJ8yDdXZP1jBcSVNVVuF0nPloW+unmfIEP476b5cjhRdTwy8rvkHrffdgbKG9kjf
         d0rGMDJBCyt/aJAXVBUCy9JlXk/kIP1hoX0vTEGD1PfYLJhYOBfGiQBQPBzbIwxv7aK3
         7BHCoQZdFv1hW095nP8jBxDFatVt4NDkELguG8xJ17Tgsi2JXKGsF1vzg+Nbm948G5cO
         IclJ2+zVnDb/soKpy+1oe3E7WSWgTcLmYm0dnXphoYwA0vjxUG0t5+I7go90wyeQUvrA
         uZlw==
X-Gm-Message-State: AOJu0Yzf8V0AzYWA6T+5ykFYXUvr+HD8Eyf6UC17TZSmSxgrYcHDTMIz
	Oz9IDpBFG6rFqKb1MUVqmUQp7ixKgp1L0cOOmtHOvZJg6SosdFHGp6VEnQjLZw==
X-Gm-Gg: AZuq6aKrTFen8QN+RTvwRs+P64susBvVLBL3P4Gj+pTcThmcaE6JT9Iq9rzbWH0hIyZ
	Oh8t0P3/Gq+W3PML6mjNCJIgiCFYekBtHyu8JreJzTgjEb2N7TDLD8Tous4XkYxIkv8ZbVMkTaw
	qwm/BTvsWca/B+H5scekzLUygxMIGZovL7pOPCaIN2KpcNMWY0QuJ4mrzjF18zGWGsq5qJwqU3A
	hyjZpzez1NsUEcpy07SIBh1FfGRzzJu/l+nIdZI3nA4G28hxyvZII6C/DDljuTptZahAKg5wkWl
	KFPud4aNSnLXhXtIjwe1CSczqAvQdSvFlq5y24hXhtuq0GU7u58YngdcuPs/KCo5kPBG0+wocco
	NNxEQDNBuWZpPM9YcXc8qOn980o6WgXeqP0dXLbpiYCrqgeY29lvuSBUSKCAoJH4JyP7I3FvjDZ
	MFfNhfyv0PcNVspmp6Y8OUqEW3C3dN20FaqCELq3Mtl4P58FEtj1YzJeImyIg0ydow6JXMiImHa
	QBrcg==
X-Received: by 2002:a05:6122:ca6:b0:563:6df6:1b8 with SMTP id 71dfb90a1353d-566a00018ffmr1468707e0c.1.1769801991025;
        Fri, 30 Jan 2026 11:39:51 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:50 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 21/35] doc/org.bluez.AgentManager: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:39:03 -0500
Message-ID: <20260130193921.1273263-22-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for agent methods.
---
 doc/org.bluez.AgentManager.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.AgentManager.rst b/doc/org.bluez.AgentManager.rst
index 77373c0153fd..23e4229adaf1 100644
--- a/doc/org.bluez.AgentManager.rst
+++ b/doc/org.bluez.AgentManager.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.AgentManager1
 :Object path:	/org/bluez
+:Used by:	**bluetoothctl(1)**
 
 Methods
 -------
@@ -57,6 +58,10 @@ Possible errors:
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.AlreadyExists:
 
+Examples:
+
+:bluetoothctl: > agent <on/off/auto/capability>
+
 void UnregisterAgent(object agent)
 ``````````````````````````````````
 
@@ -79,3 +84,7 @@ Special permission might be required to become the default agent.
 Possible errors:
 
 :org.bluez.Error.DoesNotExist:
+
+Examples:
+
+:bluetoothctl: > default-agent
-- 
2.52.0

