Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501728B4EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420983; cv=none; b=jMfYFoX6dLzFOF2BlcTDEEVW5QR9iOYDAgLBhY/8zWtNUrMGxJf3Rdt028IeaGARP4omUeU9U57KBVDZYg52TlBXfqz+5RbuEEBvfj0BSCXA9WlLyWOSbtGQ5yEkAohU+iC6GmB7T8lnsHKvfU/qlbADJeAM5Uc9dyQgVQUzACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420983; c=relaxed/simple;
	bh=FmVdG6fxrDa+8nSdE0hgLRKyv54WuZdNSrCTg9zfG4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnBUMLEZgBgbAPVyptPKtJHKjg80RTajFBC8eDj559CWx/W4yTJ6EKLEMbQ6yRgb9wKHRTpjXpk68mTHFfGCWmr3VUnuCtxXZrf3hgkjkfgUdoLOGzEbr5YKyM0XayFF12dQMe0hfqdqvEpVXbPXFCBZGVnOWVe1SWdf2rgGPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=dHNnDnQn; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="dHNnDnQn"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476f4e9cf92so48912901cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1745420980; x=1746025780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/QFwvmGiAGtYckBL4Y2qnQqjq1cZwjkIM6TVSLiQ8Q=;
        b=dHNnDnQnNQHxVt9foJ2GVwECT1YgmHrfO7veMSi80awl4a3PVDXue3qWlZ2u3mpsN8
         wc0KTYZWLxUCPpAXRR0PQgT46bQdh4vr2VVlOiP2Bxq0RA4hMLianMNG791NJkUA+o5j
         v/pHa7jnyT0sqA4muP+HiIy5g0HjP32H9G+O3/4lBzkF4GI7IkcywStCHLBR5t5IwhuV
         82NL4S0weEsibaM887ErVRR8os9Mn3lLLUjCodXT+qMH+MJjsAiALTK4K5WbPUfxdJxj
         O6v1KH/TXQbNdOjeBvgVelEPold8JFmo4nHlx+W8GQ8UT3m83RNsZRBfsVukmcuWgn6V
         YsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420980; x=1746025780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/QFwvmGiAGtYckBL4Y2qnQqjq1cZwjkIM6TVSLiQ8Q=;
        b=OMVaLf7IQl8eW/xkM7AgDxOtZPSoYAkr2DulGeYv3FBWVLTz7em4YpMd5qgRw1u7hW
         ac+wfX7Qiq2AvsV1dAH/tauGuXIbOb9Fl14+yjFRwYxUpQVuIgBow1jXv+LtM9tFbZdz
         GexpNK0TJ2X2LG8ery1Z0Sj6KfdeYjFFDCH7YYxPKHCp9Kks4mXVsJ6C8B1wO5nZe56y
         DefqqjZHJ5rZJU/4S+bBnD+Yd2hEjaXaTqn4mprTxnbvlaGb2+JtmRT7aSxB2ryLL4T7
         rNBFIrJMkJffTLtNK2y7s+mTio8lE1i6PCOKCHz1yXTF/gFmJnRs0LxwwNNqJELzGwIR
         wzUw==
X-Gm-Message-State: AOJu0Yw0pU+LPBQfpl9GaqACb4jE4tum1K5VjnYeDqm2hQ75R+eNlyfV
	Ey2rXuauYfluIhEhK2htJNl9zY3+3vlwiye84VFz+i3edlTBRmfVEEEeubFaONuGpQaHUeTqQLE
	C
X-Gm-Gg: ASbGncsnHbu+U0NJj2oeZIUSOvxKLIs7hwqnFyBNBXfWyaaYzYZYQ77UCVJ6v4Ea9ui
	oTUfWfLpnKpq3TzKOtPNVOyWQS8QzhFAXjfIRDlACuzolYznsyXyerkhWPGOzp8YOUqXq8c68VK
	EWxe/2SOCd4u+6vUBsJIYxYv0ZHQKnhO8nGNOQWOWtnOdJVu/qX+4Iq+yDrXSe7Q6uNIwF5CRXV
	RxSxBz/XwHvEWx5eQ3IzcxnJqoeYlwBMdHMLGPXJ4M8lSdJXYLR/xjxems3s1MEGDbqnAOdvtEe
	J17sd8JN/J5hlsw+ujsfC0qkUt6WDYEjmAz/lg==
X-Google-Smtp-Source: AGHT+IEuqwKfCp+6CXIZCYKkgV3HeRJF1UnKB//VERYR8JWb5tubpP5qqnjmeXI1mUgfOjosY1/lTQ==
X-Received: by 2002:ac8:5946:0:b0:476:83d6:75ed with SMTP id d75a77b69052e-47aec4c3d0cmr330182341cf.34.1745420979817;
        Wed, 23 Apr 2025 08:09:39 -0700 (PDT)
Received: from andromeda.lan ([74.15.9.135])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cfa3f1sm68953601cf.79.2025.04.23.08.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:09:39 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	sanchayan@asymptotic.io
Subject: [PATCH BlueZ v2 0/3] Fixes for re-connection issues with ASHA profile
Date: Wed, 23 Apr 2025 11:07:39 -0400
Message-ID: <20250423150742.319463-1-arun@asymptotic.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of two patches fixes re-connection issues for the ASHA profile.

v2:
  * Incorporate feedback from review -- reset state in
    `bt_asha_reset()`, and use "attach" instead of "probe"
  * Add a minor renaming patch for readability

Arun Raghavan (2):
  profiles/audio: asha: Only expose device after we have attributes
  shared: asha: Use a more descriptive name for the state callback

Sanchayan Maity (1):
  profiles/audio: asha: Reset state on disconnect

 profiles/audio/asha.c |  6 ++---
 src/shared/asha.c     | 57 ++++++++++++++++++++++++++++++++-----------
 src/shared/asha.h     | 13 +++++++---
 3 files changed, 55 insertions(+), 21 deletions(-)

-- 
2.49.0

