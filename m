Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CD049E5C1
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999097; cv=none; b=qHz3GudTMP0a1xCaLBvtOu1W8kvKLPpT1+7LXRI1F7Ofut7ipXaUu30PnL1fIwC/VU6kKhknmEmGL4qF/zdXxnOQhTUqlSRsj6ojdMtxOVsMe0hJvtC6oC01EuNuRy2DLlCiDa456Q/HYGL5qExcFgqO2kfDIP1q83TnirbP8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999097; c=relaxed/simple;
	bh=yKa/C4reZmFaOxAQ9geSl9LHte9/jgL68Qyv5mezAm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmNjtEUajU0IXHp8Q0Nkc45Lh882qjCeuMNa/0YfCnkiXl6TmJ17EIB7cthG7wHQasUpIclWPsspFiBDYDMWP3As8srHptu8RA78a7k3JgQJu7pu+upO8VDyA4STUloRT1337B5zlXbSUrTnLfkJKF4T1LS2e0njzSouDS93c9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/61Jf9v; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/61Jf9v"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e2ff27bso1832629e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789999095; x=1790603895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/Thi6xBcnnvJkPXGTyDu12w7QnPPNQqCF3O40BVJc4=;
        b=k/61Jf9v+yZJXtn1TudlmLOLsKLXlGgzC1cKeG5n7eDTzpyxu1qna22gKkhJJW5FEt
         L4/R3ifafesHOzSc6Rz2dfWaCa/rMlG3FOD9SG4KpLFvpvDKNsFAu9rNiHAjEvk4stPY
         gEjRNdMizqR8PeOPpCZ9l0SSQyo4/vqMprZz+HQmGmMWomw8yQkdEKNdbE0Ubh3bG/As
         jJEG/Fr6zisfXEtXSeqI5hc0wQyiCdicquI9iJZ5hrUP6DmQrtiYpwehOftLQeO6XyHf
         ieQkF7es169VDSSLwDPyGjuxIqZNlJ/cEeEm2S425qWpwsSYIFe41LCQ8+1OyxwyKc29
         oDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999095; x=1790603895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/Thi6xBcnnvJkPXGTyDu12w7QnPPNQqCF3O40BVJc4=;
        b=WmFSX2SuvoSKibpPBHIJjn5gLzpzVNGf634Rqedxe8VZS8rxZBDli6hwXzzVKcDHxA
         2FhBbM93plCADbFMXmPuicMkeVS2Q/6sLyeHiNZ0Y/v4tr+DnwzZ9mzbqL+nFsNbg1+T
         UbeaalSsjoKjh9Xh9Y7zwLw9Rfa6ka6xx31jrOIpGHMuI/opTQdvBb8cfBogRVjAKRhZ
         j2QlIKuRPlRUCfOU7p9k+Amtg32ow1Ztw+ZAW6kTLfkCDUD/FMjOnI9EvKrUXIn32u2Y
         ZA1DtqqiQ7L5MPCqPJRVNk6TC+M60pz0Pb9+1EaBjH0EpLrwx/f7dVS1o7lt/v0npy9e
         ocXQ==
X-Gm-Message-State: AFuF++lUI8xSeKmkVggJ+RUjjGpTIXuEDttCUxOevQ2d6/Qlk8qrKSWS
	Iy1qYPbcaZUnpeJkeZZhzSP5C77/8+nxl4Zw9gR1JcHLvNb7ipZhXJRB
X-Gm-Gg: AYBFou0Sh1QpvDMSfmKDJTIQAV6mwbgEuWAsp1i2nIFiU5DOo2MCW65a1RWR0rveSET
	FQ3qqeL4V2DpPTwVzquZVk7PzcJVwiW2CWIorumNbg8YnpSJ2IODY9X1w7Ek4+T5ebRuFQLWAKF
	9sHO/CN21x7RzTvOh7bCWko08129VUW9bTFh7bMKJvnX5ioGkBVniLWMgcF5XV68OV8m89b9dFO
	s9gvX60c3KNWbQgOL4lv8U8AvvAVGWu4JuE+h8fdfCQZr12AxmLF5W+UrEd/wMEBzLZ6noD/uWq
	qH6mlM+SH7NBTRmw6eXPlfAb9UqJr0BM6qaneAFcI/LzehwdYzpQzJ9StQ801jiphI/z1mwDYiE
	jNR8P5pFJg13r4qnXGN1/GdKFg+2B8ZKAUKo7jCd+u4KuXNIDjOuLaZNqfQI8olEkHG8UrdokX/
	2cAT22EdKiCQ5IOl0mqxMFiGalZm7i4vG4x/aMAxsKZLcCUm1iLt1aHizRy2rs9a2UHYeESFgW0
	+xK6nADdzEkl5ic17BHjwFRt1TfI6es80Nb7conWn5nl/kuB08KAm3OikYHXpUhfA==
X-Received: by 2002:a05:6122:20a3:b0:5c9:c60e:3a49 with SMTP id 71dfb90a1353d-5c9c60e3de9mr2975687e0c.21.1789999094895;
        Mon, 21 Sep 2026 06:58:14 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-984d52bcbeasm8032669241.3.2026.09.21.06.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:58:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-09-21
Date: Mon, 21 Sep 2026 09:58:07 -0400
Message-ID: <20260921135807.3459373-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 801fb950cae7048eb7d83b18857d1ca37b8cd5a4:

  Bluetooth: RFCOMM: avoid socket lock inversion in listener cleanup (2026-09-15 14:55:41 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-09-21

for you to fetch changes up to 6d91041bb38b97e2feb625123cc0529d7b83a0e1:

  Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame() (2026-09-21 09:37:20 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_conn: fix CIS hold ownership on reuse
 - hci_sock: reject out-of-range OCF values
 - hci_sock: validate event length before filtering
 - L2CAP: validate frame length before control and FCS access
 - RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
 - RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()
 - ISO: release unused CIS holds after channel attach
 - ISO: balance the parent hold in hci_bind_bis()
 - SMP: reject Security Request over BR/EDR
 - MGMT: fix race in read_unconf_index_list()
 - MGMT: Dequeue pending mesh_send_sync entries on cancel
 - BNEP: fix out-of-bounds reads on short RX/TX frames and control fallthrough

Drivers:

 - btintel_pcie: validate device-supplied DMA indices
 - btnxpuart: Fix skb leak in nxp_process_fw_dump()

----------------------------------------------------------------
Aldo Ariel Panzardo (7):
      Bluetooth: hci_conn: fix CIS hold ownership on reuse
      Bluetooth: ISO: release unused CIS holds after channel attach
      Bluetooth: hci_sock: reject out-of-range OCF values
      Bluetooth: hci_sock: validate event length before filtering
      Bluetooth: ISO: balance the parent hold in hci_bind_bis()
      Bluetooth: L2CAP: validate frame length before control and FCS access
      Bluetooth: mgmt: fix race in read_unconf_index_list()

Christiano Amora (1):
      Bluetooth: SMP: reject Security Request over BR/EDR

Hui Peng (3):
      Bluetooth: bnep: fix out-of-bounds reads on short RX/TX frames and control fallthrough
      Bluetooth: RFCOMM: fix NULL dereference of dlc->session in RFCOMM_CONNINFO
      Bluetooth: RFCOMM: Reject short EA=0 frames in rfcomm_recv_frame()

Lee Jones (1):
      Bluetooth: mgmt: Dequeue pending mesh_send_sync entries on cancel

Ravindra (1):
      Bluetooth: btintel_pcie: validate device-supplied DMA indices

Zijun Hu (1):
      Bluetooth: btnxpuart: Fix skb leak in nxp_process_fw_dump()

 drivers/bluetooth/btintel_pcie.c | 16 ++++++++++++++++
 drivers/bluetooth/btnxpuart.c    |  8 +++++---
 net/bluetooth/bnep/core.c        | 17 ++++++++++++++++-
 net/bluetooth/bnep/netdev.c      |  8 +++++++-
 net/bluetooth/hci_conn.c         | 14 ++++++++++++--
 net/bluetooth/hci_sock.c         | 20 ++++++++++++++++----
 net/bluetooth/iso.c              |  7 +++++++
 net/bluetooth/l2cap_core.c       | 10 +++++++++-
 net/bluetooth/mgmt.c             | 27 +++++++++++++++++----------
 net/bluetooth/rfcomm/core.c      |  3 ++-
 net/bluetooth/rfcomm/sock.c      |  6 ++++--
 net/bluetooth/smp.c              | 17 +++++++++++++++++
 12 files changed, 128 insertions(+), 25 deletions(-)
