Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB74C147
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014716; cv=none; b=FbVOagOf0P5ua8KFtkdspX1zTWQuNkmGR/qPSedfgETXgGQrLeaHTlIg/dvYvWHarR88fXT+YZ+/2Y8re5FdhT7R68S42eoJXQuJFzDmTPH+tCcmXcUvQiJExcukYW+DFvlEgx1ozsJxcMs7IXKfZVo6tpQZ+6ezmfsARIM5IVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014716; c=relaxed/simple;
	bh=+wvNNBX6wJZ40oU8KLTTcgphEHnnHLxQ+W3m/br+J1A=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=SPmR8BPB2HzzBaqDTEcT41/0MDkj0jhDjNY4+byhXEcBup7lptBKF7mP1pEotfQhesttmLhVjd6Z03cV8PwbnQFjppB6ACI3k0hOeejkXbGKOIKmKe7tBQDfD2kdNHucdtcTHbmlp5VznmXAEyPaDWvByapjmeSbAGjh2Zjbb34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhD/xaMy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhD/xaMy"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso5323991b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726014714; x=1726619514; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APxsom1IH5usnNv1tsclE1zZOb9HGVbfoatihNhryMw=;
        b=NhD/xaMyPu3wxHPgUubrdN56xCHOjPidobr11pNFUY2sz6qMtzRyEdWx77KZz4nTOD
         eVDv/8OA9xbtuH+s4x2E9ixY0EXXLBIr2S0wOhBnttrTrjtuENnKfCg8gXWguK7ljyvO
         xrXZlDXzZLiuXtQLYf+PTpT7NgCBHGwxYBxT4+pIJ2W/yOjwPVzXfSU5a9EcxkK/pLu9
         Xx6IGERNzrfjDgsjpqCnHk4DlppHr33MY+AwZwjgRB/2e0cxKc6piPY9FtT0x41+FyYR
         Z/c0a4ai3MkRkgRJ336DrlCTlwZ3xzr3/qZsF+x3oAksQK3dGpM32Yyz9jFjL/sr5Bj3
         jJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726014714; x=1726619514;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=APxsom1IH5usnNv1tsclE1zZOb9HGVbfoatihNhryMw=;
        b=AL0TlaFhH2i1GSLJ8ugLrfjfDjjZ4SiV/fDjADW5P1juVneZBZB0R9w6xIaMDKik4l
         CXZFJDyC26MzEhNBDvSFWntxePX0cO/CcGMH5fmO4r8H/rXuFXVGgt9XUB2J7nc0BkJK
         9fFN42tc/5Wasq3/J4BUumlrATuP55LmFa4Pln6KshDZSXPL6qIyrzq1Gv6CTGSfJkSV
         y4SmSfu1ULZwgMjMNtvGRm/imSCHS3RHmddEyckY5pNHjk7wHroEyNe/nrRBoXYGXMM4
         UGANGq6A+eaKbB8V2zA676mBz+Nm6PWcEwYjW1DTg6g4I0mSOz5nHeS12Mv9NaE7uuKb
         KiDg==
X-Gm-Message-State: AOJu0Yxrl1BqeIq7ig1Uof4oJQU5VgFHAYE1MwJBRx2bHka27TTuAMGd
	IkB8HsG/IUkrTGw4N4Q7auKpq811MFheQ5XjrrjU1KidBk7Vcck/w+JE+A==
X-Google-Smtp-Source: AGHT+IEvxKdQYKaGJcrbsqa53BMCo344dAPuRNPMN/Q/5dQbAll/SwMYn+NKvdinukjhnOzDmLCvEQ==
X-Received: by 2002:a05:6a00:845:b0:717:8a87:7d02 with SMTP id d2e1a72fcca58-718d5f068a4mr27781819b3a.23.1726014713952;
        Tue, 10 Sep 2024 17:31:53 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8f86sm1984603b3a.12.2024.09.10.17.31.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 17:31:53 -0700 (PDT)
Message-ID: <66e0e4f9.050a0220.385dec.8d26@mx.google.com>
X-Google-Original-Message-ID: <ZuDk9tojennJV9FG@JUNHO-NEOSTACK.>
Date: Wed, 11 Sep 2024 09:31:50 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Remove duplicated init for mesh config
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This removes duplicate initialization code, as ProvTimeout and
Algorithms are already initialized when the data structure is created.
---
 mesh/mesh.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 7b670e40a..49d252e5e 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -266,9 +266,6 @@ bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 	mesh_model_init();
 	mesh_agent_init();
 
-	mesh.prov_timeout = DEFAULT_PROV_TIMEOUT;
-	mesh.algorithms = DEFAULT_ALGORITHMS;
-
 	storage_dir = config_dir ? config_dir : MESH_STORAGEDIR;
 
 	l_info("Loading node configuration from %s", storage_dir);
-- 
2.34.1

