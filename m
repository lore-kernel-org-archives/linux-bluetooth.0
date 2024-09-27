Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D661C0DE5
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449038; cv=none; b=Ae8PfZr+OxSXJJvv+5Yg6y+LdZNlDi8Odzsk5a6h9LywtfCqctgmW8S12QH7CRKp78QrETGzUguqeivmAPGl1G9WSX/i3GDVxoX5SNT7zyVI0Fovkj7fofCGd98ug2dGGuE3zwiLIMs/Ril7sySMYf/Cetfdj5OJPakjIZhn+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449038; c=relaxed/simple;
	bh=mP7yFIZQwWJ3idYn5CiZaQH9ovNWAvwDJRBJkwc8CiA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rMpihNjtz6RIhFDWA9nCbsit5tV855qk2Jix6yF9vCgN7Qx4tm5UxDlFjCz1TiqbF1+p8uKLA9eveG4wzmpc0v4B6roBoKnQMMHNzWY9QY8axnmO1bN9ognJMZSpt4nrLrLGh6vqdVNu1YkCfX6zutlDDV/Tbbc17scONXO2URM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYZjThn3; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYZjThn3"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-501204753c4so1236115e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727449033; x=1728053833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e8aUwjuxdBaUc5RwbwSBUPS0TknsVddtsM+fn8zoB68=;
        b=nYZjThn3sDhHLGFlBPJ59IBtwUSRzjdKpYVnWJybvD4k9ujSNiCFCqmuhIsX7INZxo
         qjz5ibdh/mGnRUgC0+Oixfo7/4sFkg7yuM1RSjeeYLyTSqPGhAzKuaUk+9ixdxzWKPjG
         7TuA9eCpi7BfOHYRqWbzz3Fvk0kCA70lbERgg2E95iBDRVcEUnaPe96EMDyuE1BD5+kE
         MvRM4ppatffRAQw9iPbQsK/8ITP/2IKd9fiSoVPpn/CWyZG6jOjtwdsM+w96r0gQubis
         x1tkHVwKOBuEaDBRlHhWcUhTexYVjmDgCdxtTqykmwY6DT9aUVU0SI8Kjo9eBUFk3jwY
         +/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449033; x=1728053833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8aUwjuxdBaUc5RwbwSBUPS0TknsVddtsM+fn8zoB68=;
        b=PZuKFsxttWk56A0eXQ8uay8FHWsGdtAJKwmIJ7o8STud8rGfoIAuGxAanvvzMyRrQm
         8O8y+FuQM/PyQ28RjGwS0zCHgDBMHPvYZIDiAWAR6ob5LD4ku+yanYrNaTYpf6Rag9DL
         /FxSTGMoFlfCdedjgvK1uSY44WzKNFBatTTq68Dz1csIgEgMqlbQZMqx8+AbCcd9Ah67
         DyAL1gsjmkLXt1o8pb7gpQlHEBxts0Y1yiGgptOA15sDqyxkC08NS4Eo3LeGBMQrxdT/
         6qtX6YSWY9jXbcgTSsYDLNdB1i+ZnosBRIASY6LHWOmYmCTrcsU+j2bk3cqHkdkKG0EL
         ZvmQ==
X-Gm-Message-State: AOJu0YyF8+/kg9vqdnwD4+cFDbVMkpFCuLXs7xu2cXxx86efvSQQrtoJ
	TEuFPSNGKtIo+z0IndoPjL+TwVRpLRQeYttNu8DrvTquyYUX1259BTMoAg==
X-Google-Smtp-Source: AGHT+IEnhwbwMvhjvjBJb3Wi7khYDzyEXvUms0oWEiKiyc1CZ17rQLZCTBZstFF7cj4/JbzlNBifCg==
X-Received: by 2002:a05:6122:3bd3:b0:507:9165:20e with SMTP id 71dfb90a1353d-5079165043dmr1576579e0c.0.1727449033432;
        Fri, 27 Sep 2024 07:57:13 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-507a6a4f094sm67153e0c.1.2024.09.27.07.57.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:57:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth 2024-09-27
Date: Fri, 27 Sep 2024 10:57:09 -0400
Message-ID: <20240927145709.2452091-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit d505d3593b52b6c43507f119572409087416ba28:

  net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable() (2024-09-27 12:39:02 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-09-27

for you to fetch changes up to b25e11f978b63cb7857890edb3a698599cddb10e:

  Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE (2024-09-27 10:52:20 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
 - MGMT: Fix possible crash on mgmt_index_removed
 - L2CAP: Fix uaf in l2cap_connect
 - Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

----------------------------------------------------------------
Jinjie Ruan (1):
      Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
      Bluetooth: L2CAP: Fix uaf in l2cap_connect
      Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

 drivers/bluetooth/btmrvl_sdio.c |  3 +--
 net/bluetooth/hci_core.c        |  2 ++
 net/bluetooth/hci_event.c       | 15 ++++++---------
 net/bluetooth/l2cap_core.c      |  8 --------
 net/bluetooth/mgmt.c            | 23 ++++++++++++++---------
 5 files changed, 23 insertions(+), 28 deletions(-)
