Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFC1F30A4
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390576; cv=none; b=QnMwvN692Hk4duBwB7NLfyLeRfB3Y6SxioJeN59tjz73q2wljfvbbJMdjboyrFzA1VmXFwPq5E1skluSUXfl7lqofd3AKZ/FexK2mfL18D18Dbmp41OxADtIUrF6JgRkOhzBhDy4n6OkneDk5BugME5NcLXRgcRWLlg5XipBu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390576; c=relaxed/simple;
	bh=DkvZtxqK/ko1iBOddXha7p3yDM2/bDTBueVuuuyMtSU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=obzd1WUaYNFyQ08giDLrEUMRNLLKf31peX3fgrY4k9fkkpICZqbfywgdg8hCgpcD/XW7VYtUO/VlEbVapLJd5C8p4X9sF1TGg5pkVwe/yiBmXwF/jwQ7AAgkv0dS+1zSmtVu7ZvBq5DeSwCPvXNeAtBvn7flY6fEUr19rv7v4pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRX6mWNz; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRX6mWNz"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523edc385caso935519e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744390573; x=1744995373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iOYAwfs22Vesz6HH9+A8uCIAd57AWRwiituCt3z+RMo=;
        b=TRX6mWNzTE9LV1p+ljbpAfUrx0W0vbykv4muuok/sGc9JPtwNKRZ0IwHiN7nEdPbFB
         2YJo+CXT/KSpVq2tdpuRSxAhac/qs0Gd9k5k0yt7gMhoNnfelMPCgWMJdRn5o/SESfKN
         joVpVqMKHqlwHe5YpWwE5OZGC5yZiivkJn061ZLp5CObX1Y/Y0t43NSnH2HxqGjD96pi
         AUaZdSYHVUnkql8T6qc5FE1177UhhwG5IEJ7F8BJTEGtCr59Qdk/9LdXEW6iwuLmYax5
         8K1ine1VgU2mHkHff6m2TTDpr6TjVctL2gCeJPraGUpNLhlR5vTjUaqa8Es4DXYRCfdR
         nGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390573; x=1744995373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOYAwfs22Vesz6HH9+A8uCIAd57AWRwiituCt3z+RMo=;
        b=wCDFUi+20EMl1mG5ux/Fi52r710/Isn9U5Z3vGBSQARYftTeZmRtW6YEMiOXp9DSF8
         JJdPpJeWzUFsbATMx0JMuuY3+NO0K3DQmy+//OuvOZw/86UnTPimhlSXIElqB36imFNo
         1deLmLEzgCP0zdBYeqpquyevTOLcRvF2JClMEGgZ/0JGinUmKs0uOIGztM2tFavmS2zm
         IRPJwKDUBdMFLfapmDV5qOaUTGkLwWNz9mMJsdQvgzAc0phzQwa1CB1LCOoiAUqdP8s5
         P0Q7RiSqZ6LGnEzLs5ITi7C9wfzQYB4stVc3PG34tFDqUjOrRcq8VbVwx5ilZtN+Dwn7
         0h2w==
X-Gm-Message-State: AOJu0YzgnzH00gBiVPzUhz8RTiW0i00fYUfLaq32Jt07i4LMFnlYjOmc
	0MdysAp8bnDqKE64X6QQTCLnrlqYbSj+mGd/XSnB9fBILJBje1BDc/nmdjDy
X-Gm-Gg: ASbGncvgnuvPavywwqvjM5JjyDgjkcWQlk0Kf+AJIKFLn2dk68Powmfn2E1PSCSXiAd
	UCxjMTXXAnCr//BqZBxOIRj7eN1f2dpHESjkND5gnVsH5td4gSBYYxFefp5A9U3Z6MvQ5MRcp+C
	sgySnnm6ATD6wrgn13IID/pWa8iWkGeh/kg/oKD1JzKd+Hjrbf0maKUNKLzNUgundyHqsIkw8OA
	vCDRFDAJOfw8sZqX8MSnAd+m64ffxN9fPKVZwT7zKq3+quh7iMQhoCV7eZ9N2c6mGYc0hMi2ZQK
	QhoOMjXvc54zS5b64+NKygxNKxbM1t++HWZCcAIX56dsdYEDhc2U3xB7eABxzTFVm7N4ufPPYh+
	kxoWtZHIkAQ==
X-Google-Smtp-Source: AGHT+IEkj4k/VYs7Vmry8YtVIanpk1coljxfhnVookF6G+qWsJvAnjXP8MlqLVql0nHcOxkY+pT7pA==
X-Received: by 2002:a05:6122:3417:b0:528:bd71:8a8e with SMTP id 71dfb90a1353d-528bd719200mr1683869e0c.5.1744390572848;
        Fri, 11 Apr 2025 09:56:12 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abe8d74bsm1160923e0c.35.2025.04.11.09.56.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:56:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [GIT PULL] bluetooth 2025-04-10
Date: Fri, 11 Apr 2025 12:56:05 -0400
Message-ID: <20250411165608.871089-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit eaa517b77e63442260640d875f824d1111ca6569:

  ethtool: cmis_cdb: Fix incorrect read / write length extension (2025-04-10 14:32:43 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-04-10

for you to fetch changes up to 522e9ed157e3c21b4dd623c79967f72c21e45b78:

  Bluetooth: l2cap: Check encryption key size on incoming connection (2025-04-10 13:09:42 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - btrtl: Prevent potential NULL dereference
 - qca: fix NV variant for one of WCN3950 SoCs
 - l2cap: Check encryption key size on incoming connection
 - hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address
 - btnxpuart: Revert baudrate change in nxp_shutdown
 - btnxpuart: Add an error message if FW dump trigger fails
 - increment TX timestamping tskey always for stream sockets

----------------------------------------------------------------
Dan Carpenter (1):
      Bluetooth: btrtl: Prevent potential NULL dereference

Dmitry Baryshkov (1):
      Bluetooth: qca: fix NV variant for one of WCN3950 SoCs

Frédéric Danis (1):
      Bluetooth: l2cap: Check encryption key size on incoming connection

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix sending MGMT_EV_DEVICE_FOUND for invalid address

Neeraj Sanjay Kale (2):
      Bluetooth: btnxpuart: Revert baudrate change in nxp_shutdown
      Bluetooth: btnxpuart: Add an error message if FW dump trigger fails

Pauli Virtanen (1):
      Bluetooth: increment TX timestamping tskey always for stream sockets

 drivers/bluetooth/btnxpuart.c | 21 +++++++++++----------
 drivers/bluetooth/btqca.c     |  2 +-
 drivers/bluetooth/btrtl.c     |  2 ++
 net/bluetooth/hci_conn.c      |  8 ++++++--
 net/bluetooth/hci_event.c     |  5 +++--
 net/bluetooth/l2cap_core.c    |  3 ++-
 6 files changed, 25 insertions(+), 16 deletions(-)
