Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94B500969
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767990584; cv=none; b=KKnqz6vNJA1aBVFl/gnwzWgHpJEV/e4fAJZ4ispcP02NNOYtAltaHFahfwWegLSzNOFiebyX9dVAFxPhtQfmGdy5bYZw3M29QoRRpQkLuZCS352nehNLpsqKkbGo05undDZ/vFLnY4gWoeCM+1TNmIjIgsJivk+8EF5YZL0cYdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767990584; c=relaxed/simple;
	bh=Xom+rkXT/+fCjODqmL+3ZKGeVak6Ni+6P1iMqP2+g7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJshlwvgSVOqBH1AWbZ34Fd1uHYh/3HHLoCVUa0UBI0ZF2raVYCYYtjX6xxgU0Dibjy2ZI/7smeSbKukLs4jy9gz8dvG2K1VeSJmGe03Npv6KzSdX/fT750nFAQeuGGMtH5/Ul8f5mriujAFeDa52j+skfOwlEpRALbVqd9MbQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZWlndax; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZWlndax"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b86ef1e864cso3766366b.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jan 2026 12:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767990581; x=1768595381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9O1PsgoKzDT6sdr7P5AM3IJaKyb/sfxXIRINVjYFB8=;
        b=PZWlndaxRb17qmR683EIlswHmHR+pKJistAhZFXIiE4qbE36gwnQxOJ/H1IBznV/LW
         YjYL4/tUFEx4oJGwpRIGhv5plHRb4srpl20S191yTkES3QcpHnksroA0ge7Bn4KjT62B
         9Rw/KBwQ9Nlcz6WOm40cEqIf1ejbFoHFCQCBNfY3LwlXSR7z89XOvn8hEVAGDQFoBVEc
         a0963YxbpCcX6Ix8qlMylR9Wa8JFQZvks4AhuHxONpkP58GKn4+zINHMv677wnIAOTAp
         JevpSIa4sgv44fvEh16nqt4QNAWNBjkzViOTPqutqIfU3j0S0FU7zCJEaJ4sJvS7dwEk
         PKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767990581; x=1768595381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9O1PsgoKzDT6sdr7P5AM3IJaKyb/sfxXIRINVjYFB8=;
        b=nWDcBEX6Aqp6xTeOx2u+wA7O9BazoEgUwNbCS1d2v4RRoqZSe4iVWNPO9XHe0my/7F
         4wj/B8BrrpAKTRNiNurjpZs+7lwbkOS0X87RFTSEcKrvx41jQhE3WW5bsfbVl/he6hNw
         d1nK7ZBHZnGAY4X2uVzrjw9bVe691/APM+5mEK2uLNMXKBKC962X5Q+UBJdGFYcfQUnV
         PHqf1N6sz2CuPr5vcBDXbZgdPnipLhv+WrXfsN2y4lgdjUaIY2CquaW9ceUsMm7HGkpu
         3EghBovVan/4/6vJxdicGOEEKXUDXi9g1Bu3RX8YBazT6qP+p628L8MSvwtrhbRcEJCg
         XNCw==
X-Gm-Message-State: AOJu0Yzo0+hFs3O+RQxOvg57cukaEj0iJSdGvmT42bhsKyA9/pIHtMCB
	bM/4oewp4r48lBt+3Mkjrhb6csYL1gHODBwn4/wws/xIEAMcWiqzfyq+01w0cM7y
X-Gm-Gg: AY/fxX7nZDZWJ15QlYrvhVWHQDJW3By3GkMkyvtUww44pG4BA4emGOaE+3k5mKH4ltx
	5zQsF+CZm8odzwA+beRWSHbJsBB9KE8vlFgDujIPjycC7r8yK5cfn2qxiNjVnqS190zTAS2Pwc6
	D9/jfPlahSelNo54lS31tKbz9PEZ41UCK6TcGcIuherJta4CuJ3Qx5XCLdLlxB1NPLsWDBqqW8n
	7weEj7emK7uNws92CKR/3DdoWLfxtER6zdmjp5k0QuOZHJYAN6drXL/AsfNfP4KUAdFSM3CCK9D
	ntRi3+Xtbnbc7DkxVHrjBqrg+sTLueg43vx1ykO5u/gzZm7SwcDxE6vdl+/L1HHcbBO3k9kIaTn
	2Z9p718RWNawFuahYXTQhsXEbJKc3V/txA6cAeX2+v92ErhpzCYa+f9R/Ix86o2KxeYVsFXUiIa
	zzvkYdkpsAq/rUa+BV1vvd84Oula5RKXWL
X-Google-Smtp-Source: AGHT+IGTmIQWZLyViW42inCu6LgLnsOwSEUpejWKDPWS5f7Zr2eGOXnQJSBSJ2+MAwR7ZBJBiPhsPQ==
X-Received: by 2002:a17:907:3f1a:b0:b7d:1a23:81a0 with SMTP id a640c23a62f3a-b8445460664mr1018468766b.63.1767990581151;
        Fri, 09 Jan 2026 12:29:41 -0800 (PST)
Received: from devrnd0.tailf8d75f.ts.net ([2a09:5e41:e74:6400:1e80:613f:f534:6580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a51577bsm1191918366b.56.2026.01.09.12.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:29:40 -0800 (PST)
From: Lasse Dalegaard <dalegaard@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lasse Dalegaard <dalegaard@gmail.com>
Subject: [PATCH v2] device: fix memory leak
Date: Fri,  9 Jan 2026 21:29:25 +0100
Message-ID: <20260109202925.774809-2-dalegaard@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_add_eir_uuids creates a list of added UUIDs, but it was never
freed.

This was found with LeakSanitizer from the following backtrace:

==764182==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7f3c7db20cb5 in malloc /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x7f3c7d870afa in g_malloc (/usr/lib/libglib-2.0.so.0+0x65afa) (BuildId: 8b07c017773317c7341f72bb8ca4a7a78b323f37)
    #2 0x7f3c7d88e31f in g_slist_append (/usr/lib/libglib-2.0.so.0+0x8331f) (BuildId: 8b07c017773317c7341f72bb8ca4a7a78b323f37)
    #3 0x564fa6ad9153 in device_add_eir_uuids src/device.c:2451
    #4 0x564fa6a6b2ec in btd_adapter_device_found src/adapter.c:7481
    #5 0x564fa6a6c5cd in device_found_callback src/adapter.c:7607
    #6 0x564fa6b9b73d in notify_handler src/shared/mgmt.c:337
    #7 0x564fa6b91ad8 in queue_foreach src/shared/queue.c:207
    #8 0x564fa6b9ba3f in process_notify src/shared/mgmt.c:349
    #9 0x564fa6b9c899 in can_read_data src/shared/mgmt.c:409
    ...
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index c8aaf042f..0842becde 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2453,6 +2453,7 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 	}
 
 	device_probe_profiles(dev, added);
+	g_slist_free(added);
 }
 
 static void add_manufacturer_data(void *data, void *user_data)
-- 
2.52.0

