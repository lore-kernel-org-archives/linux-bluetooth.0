Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D838947F
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312765; cv=none; b=uX1PZHWkb3d8V5PxYJQq9qd7tsMk7FmigIgsDP7uz4066OOOPm2jHndTFKie6qB0hhscd7qPIbCOhmLU80uwgh+34b8PzXe8a6e6W5N39Jrzl9g5YA77nN5rFQUUss1MD3KhIrc4/Uql74a7Rn0kCyNG4/ZDZR3iqFM+BFciJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312765; c=relaxed/simple;
	bh=J8FZmtgSM37RNzXn+Uy7DFPcpuJB8jWk2wbQx4hB7jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ebs9DUo4kVanRhv5EmxCVq2lWDbfx22ZKW+QkT4tiROkxmFzFjqJZQ2Bf9cnNeeR5MgpIsi7xOWVVLT5YQrnNdVsQ1QY1ZE5a+eWQWwkCqvigDw7IlnJMpv6Lfnbn8uQSDOzl/Ihms/KQoXt6PXVjW0Os2uJ/qhtRIGe33/4WPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrj1DBvP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrj1DBvP"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bea7176c72so81659615ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 04:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780312763; x=1780917563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1yaCrs/RG3cEhV+R3dst7KhkNMCm6jYadJmv3o3t9Q=;
        b=rrj1DBvPzipP9AgR2GfuUcPlFaGakbaVJlQGRJXBB9K/oEZVQoEeh7sYcNBodnwr0y
         ZQuoKad3NqTGAbbpvlhjNalwdYLah2g7S+pGwJzolZMmvFPlKQUwhb4s424uTV9hsstQ
         tDDgJj+QKwl4BvlXMrv6r5bC/egud1TUfveCBXrEyoEqXtzpT7e4iKZYZ8Ei6uT64+JW
         6xC78vDXdPtxcgHALJbFlQG18ES/zQEhpVk98XuV0ggOQ6WbcvwMR9xweAhgtrCk/Z6t
         uHYkSybXJoy9EjPdb9pYaC6RE7JCYRsOAd6cVZlrElsQZ9w948Z4Ae5+xC6CnePDfrIK
         yNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780312763; x=1780917563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1yaCrs/RG3cEhV+R3dst7KhkNMCm6jYadJmv3o3t9Q=;
        b=IDfkt+71qG+/sYW7PE+2Abi3T58mlh1GQGVpMmDWX8TxUA2WOwj7QoOwwMD1WUq66L
         VxbKOXqR79w9Hn5Gbp8agw5UHNgn/p450U7OCSIdQ05atJoT9+KOHcv3z6qtRXBX/FRr
         lNLQCYgH9T0VTYVjysK87XIQJb+5RoxqOIBmRo9zDdl/rrgNu/uw5+atV/Yn6WMwu0uG
         IXvWiuYCfnrr4s5EDMmA5zCIMEwkLtFtB7ABq+9MgUzZoxE0Ndu5OYbp4d1r0vnB/a+O
         v/LviC3FuhPEnERyivvM3ctMNHT/M9E3IUq0RKNrmLe1xeCDDOg82nswwAg2dvjpneyE
         1IXA==
X-Gm-Message-State: AOJu0Yx/w3NU6X6ACn7n5aNlIxTKjMMUCA0aTVopxsARN96HcSesAlLG
	Fet7hPnhHW6cvD7gytKFFOnnF1bDchrQeT6BUoo6CMqV702/yz1cJMQrpX1X2A==
X-Gm-Gg: Acq92OHuwe/v7ahbsUavVW4PfzjIM/i2Xsogfux+fMNuQW/Z+NTru5/iYdM2y0YrI5m
	9y/aW+TiIWPcdj8KxEr5XYaxNu1Rn74j4Uqb4d1wZ87SXW/RMJwwtfyTNDr8u0NqifxvgnHjYz8
	SvelGiXxana4zPA3jPsN6ssMUjzOQKeWRXoroXYTro67yxyXlGI7uyLjx/FhXFud1S0GW+4+rHc
	lnuNnsQcE0ZNBOz3qsif0JauKmppAN1dV7+zZTFLtyahEFOtMRvemW3f2Sb4Vh0/36W2NULiQX1
	YJha5rvhZ5AbhMcugVSyRjWeDxEw+WoSHUmpbAbdADFOFKw8hhQF9vF0qOhb8ZiKXc3z0x4bi67
	EC7+JPjbKGRnYqxEb/2e+PRLrQ3ApOKNBibJ1GLVLDjQwnCzd9BMPaI5mbkc7TzFdAxj3iCUXo6
	J2aHpVwn6+7thPKHWMsl7JBJmDOOq0S3ObW+Qi0PkSlI3nwCMAH/4PdyrVrQ==
X-Received: by 2002:a17:902:ef49:b0:2c0:c625:4010 with SMTP id d9443c01a7336-2c0c625439bmr69679175ad.32.1780312763044;
        Mon, 01 Jun 2026 04:19:23 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e702fsm104225475ad.4.2026.06.01.04.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:19:22 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v2 0/2] Bluetooth: Fix data-races in SCO/ISO connect paths
Date: Mon,  1 Jun 2026 20:19:06 +0900
Message-ID: <20260601111908.232707-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connect paths read socket address and config fields without
lock_sock() and pass them to hci_get_route() and hci_connect_*(),
while connect()/bind()/setsockopt() can update them concurrently.

Patch 1 covers ISO (iso_connect_bis/cis, iso_listen_bis,
iso_conn_big_sync), patch 2 covers SCO (sco_connect).

The added lock_sock() sections are reached with the lock not held and
released before hci_get_route()/hci_dev_lock(), so no recursive locking
or new lock ordering is introduced.

Tested on KCSAN + PROVE_LOCKING with VHCI reproducers on the SCO and
ISO CIS connect paths; the hci_get_route() race no longer reproduces
and no lockdep splat is seen.

Changes in v2:
- ISO: cache bc_sid too, and pass cached src/dst/bc_sid to
  __iso_get_sock_listen_by_sid() in iso_listen_bis() (missed in v1)
- ISO: use cached bc_sid in BT_DBG() in iso_connect_bis()
- SCO: also snapshot src, setting and codec; v1 only did dst
- reword: the fix stops torn reads, it does not close the TOCTOU window
- fix the SCO Fixes: tag title

SeungJu Cheon (2):
  Bluetooth: ISO: Fix data-race on iso_pi fields in hci_get_route calls
  Bluetooth: SCO: Fix data-race on sco_pi fields in sco_connect

 net/bluetooth/iso.c | 60 +++++++++++++++++++++++++++++++++------------
 net/bluetooth/sco.c | 20 +++++++++++----
 2 files changed, 59 insertions(+), 21 deletions(-)

-- 
2.52.0

