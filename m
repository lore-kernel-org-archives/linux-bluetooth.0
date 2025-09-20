Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13F287516
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758380706; cv=none; b=FZS92ljavbYu382NobnYuzO+xOD9xgAq9f6zCLUKbnenG8XFOw+pv7ljqPWPiQ8+zP9+RMcFFHQ7Bk+7Hy2d9yPoIwpG3jZr7qYbRWcLkKIKXteQsc7MjCCGZEk1+uqJUTEpw66SNbgc2lzuHQbUBakObvxdSXbuV/aAjW6mIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758380706; c=relaxed/simple;
	bh=E/YB7d+c8dmbLmch6sh9Xq3SGjrruR5SExr7kvL2zCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIfc5088dint2uXDUpQylbwrytra0nYfHYEaD/CcKIBlr/B+H2VxRY5L3HeSi4ZYuXiOWEDvTGRNf3sQETAIiXUPHxA3S2+ok0xbiylKj6u9T7MohIqCE3HXIhpx92WCWCfD/iBlc+IC9AE4r8gB6fECpTv6Cird9Kfc4MX2i/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui81TneB; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui81TneB"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8e3d93c0626so1960524241.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758380704; x=1758985504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3dBRgSHKupbJFLCFsbsGrY5tLDAt1cXE35m3k1egDc=;
        b=Ui81TneBGYDeuyFwtjGDoH6dt5l7WG3K8Hh48djeJWeXtPAfwWTp2wb8oUqd8Chkw3
         LBBsuv7MAnKGSsyVgq1So1fBAd5wqZv+pL+nYftGhbEcCVtMvEFacOx0VO4D1aeE0IVc
         XUucK8LFvPAl8OKwtDZsq6H9XsSH2POsp68tR5L1asMNhOOCBzi3iesHBcO211PuxdgT
         Al/X8Uvav2kWhkMZuTUx5AzhSIDoj4j1ojPc2/QzTvMHeSrVzWsYUXFwdQvVeuZsCasS
         QxDvfjaF+hmrUHO/pC+a57Wv6tXe5pobVs7VUKDtER5upef1goi1yDvoC0Qi/eOkLMBJ
         /PyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758380704; x=1758985504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3dBRgSHKupbJFLCFsbsGrY5tLDAt1cXE35m3k1egDc=;
        b=gTjSMX0umBW0jOoE2uOsekq4u0Hdvvnz/jb6naw6Kj08Ayxx3KZMAVKj3KRLp0Owyp
         ksyD3uJU/JpcoW7Utq0+lRVC4ekiXzeP1ovgTc7OfnU21czBqedf6YcQQBzEVgmL9LOa
         RDGT2KsUNZgmsKi6tSXJ9192CO5WrFv/UZvqKVMRAgf3MDVyscJe0cOXdWkIRywQTSip
         iq4lCT5rFvUcxTN0klksB2yY83bywJ5+FjoQYIQgaFHwTXAzgBWafYJmJq5fdd7hf2Pn
         6PGAVfXXnv9M8jpS6CFbLlSPXLXlxm+xO59mWPRCECIWkm3sghpa628LNQboerSYvuiF
         mbRg==
X-Gm-Message-State: AOJu0YwlQ0iBuiA2elLyGekzNpLBEaMbv3ViL44Pz4vm68apzwqdBSVR
	PJ5Zt8HveGzu8pQ5FKjPJJbh+Hj4BXGwqRzwD5O/RuCUf9McG0n9zzUB
X-Gm-Gg: ASbGnctqBEryESfLzRcy5REbfQ3l/BvhFkZSFiTv74V4UewOOjR//IR9BfdZCBSX8nL
	9VzBIkV69bUdEFwU1X8n/y5esZHzGezUK4lMYPy47B89jukazbrsdqMLnFNaSP4h6JR3cGiU33P
	tAlG3GbyrD5i0JeMBuugVk+jLaZW05YQas6KyQa1Y8HTU6GcDkwK5Rkf3jG6BY/MtMuPVjv13su
	SWAnyZz/IIirw5x1wzza2zh8GfgFZ3U0WSXR7JtZcTTmIDXNJMEY3uv/PWw6GANezkRoE60guwH
	JVTOv4wGuYlfXniZhqZLbsYV+uFkFhCAigCEIcasbq7iJZh8YewWbcyoZ7D55mkBdFsCU+h/lYK
	ok2gcI8xlge28GBIukTBEFa/0hv3tBZBEsYEFUoh4j0lYjxo/HBi66y6TJAqyBoe6Bg==
X-Google-Smtp-Source: AGHT+IHMMVJvSgtodzJ6WmmM7Kc+LV5Dq1bi4xHDem2aWXRjp7TwS8Jpusd8EkZWKe4gbIoODXqysg==
X-Received: by 2002:a05:6102:6050:b0:57b:bb59:4dd9 with SMTP id ada2fe7eead31-57bbb597465mr3888675137.17.1758380703928;
        Sat, 20 Sep 2025 08:05:03 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8e3e75254casm1266947241.11.2025.09.20.08.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 08:05:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-09-20
Date: Sat, 20 Sep 2025 11:04:53 -0400
Message-ID: <20250920150453.2605653-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit b65678cacc030efd53c38c089fb9b741a2ee34c8:

  ethernet: rvu-af: Remove slash from the driver name (2025-09-19 17:00:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-09-20

for you to fetch changes up to b683725c679a2a30852fa40fa1196d5f7bb4998c:

  Bluetooth: MGMT: Fix possible UAFs (2025-09-20 11:01:42 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix build after header cleanup
 - hci_sync: Fix hci_resume_advertising_sync
 - hci_event: Fix UAF in hci_conn_tx_dequeue
 - hci_event: Fix UAF in hci_acl_create_conn_sync
 - MGMT: Fix possible UAFs

----------------------------------------------------------------
Calvin Owens (1):
      Bluetooth: Fix build after header cleanup

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix hci_resume_advertising_sync
      Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue
      Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync
      Bluetooth: MGMT: Fix possible UAFs

 drivers/bluetooth/Kconfig        |   6 +
 drivers/bluetooth/hci_uart.h     |   8 +-
 include/net/bluetooth/hci_core.h |  21 ++++
 net/bluetooth/hci_event.c        |  30 ++++-
 net/bluetooth/hci_sync.c         |   7 ++
 net/bluetooth/mgmt.c             | 244 +++++++++++++++++++++++++++------------
 net/bluetooth/mgmt_util.c        |  24 ++++
 net/bluetooth/mgmt_util.h        |   2 +
 8 files changed, 259 insertions(+), 83 deletions(-)
