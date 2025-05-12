Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03751E520B
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060459; cv=none; b=TSK6bjZcfPv6Q7TdZcKRSev1y2JOLctNUP3/hhREykV/69rZiVXJYB6Vx9gm1u+yQCJwbO4AMM6XGy3V4MmVZhz6pxY9MWpDHJuRWkD+EBdxSf/tiRrkoTVXEUd4Xzf7EFxRFj0RsxZF0nhmADxfuhh4r5uReNs9qDmZzk+q0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060459; c=relaxed/simple;
	bh=uJrh6WcStcNohbHU0X/dilLDj8fa9ftb/wpmOeSoRLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3CrcGgMhG0UgZ2o0NObxSowGahniCK5s6iZSohFg/Oij8jGDBHR2tKjO3ZSCah5xF+S1xeQfG1qygP2ydpsVOCKmDt5eBfvppHtHfOK5+2R+XfdpYg++GBCE9h+QPF/nPZ2UbzL2WlsSilOxP5PVtvZ0pEcymI6pZxgfJpLQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=NYb+o3Oe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="NYb+o3Oe"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22fa414c565so32511575ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 07:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1747060455; x=1747665255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+kKo5JOeVFaFhHXXIfHCnytR7vH3FzhWv6+m991xF8w=;
        b=NYb+o3Oe4prP6Ido3iKsIlTPE9YCknhUqd9FPIcaca6BH1qI/SSsMgqufc0e4/92KQ
         lZ4FnC6swWNS17hSvjQ9nY2xeaRwl0HCOrCmHxIRtspBIl4pRPMNk/3Ft9sCGRalJKkm
         MVmgwpNcVHHM6WAN8p8caerO2yK2/bh7dyZwdxLRLB1ngAP7R5tMIAMMa00RLET7j+cv
         v3lZAgQogaliMdRwJpe1HGkfr3zwYw7z1XBQHL9GwfaLbcK/UQvAQ7h31H4qNqGjKE6A
         RBLaUkbjbOSf0AO7DGMIhO2mKldeFpJNgNdtq2yR/glrGReFScDZoQ9++PSrJ2PZohVR
         0JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060455; x=1747665255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kKo5JOeVFaFhHXXIfHCnytR7vH3FzhWv6+m991xF8w=;
        b=QjvBgtvniilS2cpsn3ljb5wKlitCoHBLpRlp7UjdYFHtptW9Y0SSXo5B9XuP2ytajr
         DmcZHNgonh7SDN+kE+Od0/P8kAbr2nbOSI4MkZH0jgeJM6zWA2rXDTkpdepGRpinFiAa
         wDVYUJYgC3weTkgNI6RwWgUDrf2Z+Q8S8ti2MSCxyKUhuVauZgUd9GgWcmkuTw1pLIss
         dFyFT8YnT8pWOnDW3ocQse2vqgzaoOZPDySVWJzp7DZtjttr+/12wvb3pvBCq8uKs6M5
         92+ZkaICSIpkEHALkIzpaC8itvKPKnN8b8/ZLnPjHOydEDfRZRzcEO+mjMgOS0DA0fBx
         s5Zg==
X-Gm-Message-State: AOJu0YwRVjDp4FRo90uGsoHYY4306f1hMBf5fhNDSXG0+6hhi1X5/HLv
	jdrARXDvW9grjnSjOGnHsJi2MHzQZTF+fUY980swpS83eUNcKYE1oawoPeMq03UdD0tGvvvUIDc
	O
X-Gm-Gg: ASbGnctcFdtDzsBZjsQhuE9TYwXVLITdi8IMvIASkmxTHBBfSI7Is3TPRjm7uiI9gF3
	NRIoupZHmX3aW+RvsaQNYpoK8lwwaL3iU0avQ4UakGjr/3H5bHsuy2NJg+8A6ZezGgoye61OrlU
	49AG+pCnv/zymw9zsFMGiqyifT5kCGSRWzH57pUj37O/dwzJjjIbyGfOls0szRqGRoPFHgJXMp7
	bJj/MJIzP8oZtNRI6HegRs3fzyk4PMHLdLQx5ZCevsiU44XQHu+CXbzPhh0LYo5tLgckMKEO15x
	+jV61lArlSF9DiE0GUPl4D4P+J8mDaGxuVXHzDW+sex73h/Z1r/NGLpc
X-Google-Smtp-Source: AGHT+IGvAhCBr6Oa9tq5j9EvqQZbiVDIbJKW9KlpCZf8n/ScahfX5Om57CrmsHOKCIh1JEVj3/aMaw==
X-Received: by 2002:a17:903:986:b0:22e:50e1:744 with SMTP id d9443c01a7336-22fc8e96285mr192628835ad.37.1747060454778;
        Mon, 12 May 2025 07:34:14 -0700 (PDT)
Received: from localhost ([2401:4900:1cb9:9be3:2edb:7ff:fe58:f2f5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc828b242sm63278205ad.185.2025.05.12.07.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:34:14 -0700 (PDT)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ v2 0/2] ASHA stop handling updates
Date: Mon, 12 May 2025 20:04:06 +0530
Message-ID: <20250512143408.283938-1-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch in this series changes the stop command handling for ASHA
where it does not wait for response of the command any more. This brings
it in line with the Android implementation and also the observed device
behaviour.

Second patch in the series fixes the callback handling during suspend.

Changes since v1:
- Fixes the second patch in the series which was completely incorrect
  in v1.

v1: https://lore.kernel.org/linux-bluetooth/20250512101952.70203-1-sanchayan@asymptotic.io/T/#t

Arun Raghavan (1):
  shared/asha: Don't wait for status notification on stop

Sanchayan Maity (1):
  transport: Fix the use of callback in transport_asha_suspend

 profiles/audio/asha.c      |  5 ++---
 profiles/audio/asha.h      |  3 +--
 profiles/audio/transport.c | 23 +++++++++++------------
 src/shared/asha.c          | 19 ++++++++++---------
 src/shared/asha.h          |  4 +---
 5 files changed, 25 insertions(+), 29 deletions(-)

-- 
2.49.0

