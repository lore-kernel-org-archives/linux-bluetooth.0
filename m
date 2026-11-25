Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625950;
	b=d/VC2bfHW/7psowLa34Ew2leRr9s0BrD4wMS9S1UZNvjZDtWqTrVbMrk4Xc1csyqNedQ
	 /TGO0jkqmQGa/SmLZB2tRv+lk5MNcUI2KBxXw8UHsNZIyESCIsu16xAhSvAV70yvxUIFM
	 9Qoh/hq1DX+BjvgvBBKyPKOT1jTM+s8gLV0IZe8Tr9YJ+qJnvSwXV0Xf8Y00Nr7jKoxBD
	 Z63/DDeYoqwY+EG+liYMUxZQafnbe89PMH6gTLA28+Rh+9FN7NU7N7ZbT7KKScMr0+WcE
	 JntgphqIMd4J3gab71ipM/8vNClcxfUETbGaJoGp5FA5u2KxFN3x/7vyNmmI1HsOWrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rxgzfh4NXL8HBwgxPMDx9c29QBnnLtJvmLc2tkDD2bk=;
	b=RrLLZsu6C82nB6A8zsXLDYenyyOsvlI5O3WHxCVDqTjWwF7qt0ttU+sk+mRNsZAJidOX
	 bNE3ivooNpyp2JFSO/2k7Cw+xPyiGWAW+wkysldXjnBWtEEr6SCVzc+pBNNWFo6Tdg9T9
	 wY9Ca0rP3n7DJTPrBkAjE0wwqVkMKVR1mc5De1NWlxjjEpx4LTx2TGVIsczLS5C2XRW2E
	 dVQC3wbUcNW9gBV7kiF7F8wpTSAkNr76n9TGnveUGUnAIjouqKNUyRylRFUv1HEoyjNtU
	 /k2lRsoArA2rF25nGBnEvkhL2sPCyBDh37n44A+S3iosUANmGFyKHtnGbGLr9lrNMaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="xS5I/Kx4";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DF606A32D
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 16:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F16DF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=xS5I/Kx4
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so8845095e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795625948; x=1796230748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rxgzfh4NXL8HBwgxPMDx9c29QBnnLtJvmLc2tkDD2bk=;
        b=xS5I/Kx4z1VNxWj2rAjpwm9JPxobjzfbs6weFiC0nQ6kLJlnQomAGWz5jl74hJIrdI
         gOtLmfasGRKBCjsaoWYTqnXagYxNUI7QW02Lt83MrlI+zwgZRXKMsv3A3mFh7Gzkmnsm
         r9n4CP/oFd+CTawXZBdIUeS+y7Tcpy6tZhDsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625948; x=1796230748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rxgzfh4NXL8HBwgxPMDx9c29QBnnLtJvmLc2tkDD2bk=;
        b=e5crRyB9Iu9lRC7h22qsDSq4Lp2t6jaa9wlGoTCfHzZgx5TUQcjmkkLurmmg7c2gUI
         Heien6nqWMbZlRYE8nhKKbJlHKmaMhD5fVz9gb2LcpcqdLA2qyivrxGPtWeNV14aFbMi
         /W9qdNOg33cBbxGhpDEULZT7f/fF/DQJXv6xAFRpxCOL6bAvquvoWUtu0JX3fq+e0cHY
         5871/stpy7Db2hVNmFuuckLgmJYQbm0uLIIhfEp5a4gOZXJj3jacUpkKsRq/WUz7787W
         qtXl0bQum3AAmqEAaDro8bc4tx3En09DMzPPpKyEHElRAV8zKPZPQ5ikJec+I4IYNUK6
         OEtQ==
X-Gm-Message-State: APuU4Z83BkyY+T0oOTlMOKOAuoVnXwZR7mbJF4NJEi1cA4tCj7XCsEbx
	DV0xM4xF0BNGTOEXyounUFWqLnHfkId+c+QpnI+13eyBAu5fVMQr5Ax2iUB9IOvMG15Pr9NNONG
	iV0va
X-Gm-Gg: AZFdTZepydymTwr1bx+2vIOA18XEPlSfcvdypB31mG9rt5sCaGOTCzUC7HPm5r3LHpi
	ipIsaoWjou+JubQHhMR4iOH6krEodG7DGd7o/rCXDAlUA4coIQ68ctLy9oviAPSF5idZARllY5b
	ry4FuSrlE7z/OrgWPpm70Nn3mGqzAzz64U6YF3pZGhc4KfTZzypEXrHHF+WOxhNxH6hCaVX0pGE
	e4fvZ5+sfW/yWl0keOUkAdJLpdG6vPxsIMEqoekUBGpkHcxCg0UkGWaTVcmsbpXsfsAebMqufxx
	NqlTPNnrdmzQM53sjOkzoZLGqwNFb+fPIztBt8j4P9Zx8in6FjEmx3ZOUm+Pjm4vNImhakvaZNw
	7trsq85tcQBuEXtzEzZHPvLpmbQxttcZxihhRlFqOWvB+Wm3ZVtP2bo55atZTS7/FjRWQxaDxe+
	RZkSlHJMTK4yIjW4PmBf23mhQKj82mAgRyXzi6LIyANZEwNz6EXnlK0lHPs0htxZy1XIz6xelgu
	Z25mCEr1SdwK43S0rFJ7SQ71340AzSdpjAbGXOCCCBws0FCQAPdziu+M4E42EN8WyC2sMgTGjOh
	MYqCXP7aWhIUGhacXAoqYKA1I9OAyhhyn91N6iTu0tdKWDe/AQ==
X-Received: by 2002:a05:600c:b90:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4bb8892cb02mr366911555e9.21.1795625948313;
        Wed, 25 Nov 2026 08:59:08 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm754943945e9.13.2026.11.25.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:59:08 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 0/8] Fix GATT over BR/EDR
Date: Wed, 25 Nov 2026 17:58:58 +0100
Message-ID: <20261125165906.1645581-1-simon.mikuda@streamunlimited.com>
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

We need GATT over BR/EDR to pass PTS qualification of a dual-mode
device, and bluetoothd only handled it when the remote opened ATT and
both L2CAP MTUs matched:

- the ATT_MTU was our incoming MTU instead of the smaller of the two,
  so a remote with a smaller MTU never finished discovery (2-3)
- GATT discovery marked the BR/EDR services resolved before SDP had
  finished (4)
- EATT was connected to the LE address next to a BR/EDR bearer (5)
- LE only profiles (BAP, VCP, MCP, BASS, RAP, ...) attached over
  BR/EDR (6-7)
- bluetoothd couldn't open ATT over BR/EDR itself (8): it now does on
  ConnectProfile with the GATT UUID, Connect() is unchanged

btgatt-client gets BR/EDR support (1) to reproduce the MTU case. Tested
between two BlueZ boards (Intel BE200 and Broadcom BCM4359) over BR/EDR,
next to A2DP.

Changes in v2:
- device: cancel a pending ATT connect over BR/EDR on DisconnectProfile

Simon Mikuda (8):
  tools/btgatt-client: Add BR/EDR support
  shared/att: Use the smaller L2CAP MTU as ATT MTU
  device: Don't override the ATT MTU over BR/EDR
  device: Don't resolve services on GATT over BR/EDR
  gatt-client: Don't connect EATT on an ATT bearer over BR/EDR
  profiles: Set the LE bearer for TMAP, GMAP and RAP
  device: Don't accept LE profiles over ATT on BR/EDR
  device: Connect GATT over BR/EDR with ConnectProfile

 profiles/audio/gmap.c  |   1 +
 profiles/audio/tmap.c  |   1 +
 profiles/ranging/rap.c |   1 +
 src/device.c           | 161 +++++++++++++++++++++++++++++++++++++----
 src/gatt-client.c      |   4 +
 src/shared/att.c       |  43 +++++++++--
 tools/btgatt-client.c  |  53 +++++++++++---
 7 files changed, 230 insertions(+), 34 deletions(-)


base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

