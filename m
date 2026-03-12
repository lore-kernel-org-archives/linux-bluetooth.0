Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28B401A34
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346027; cv=none; b=b5xrA2sPd5eNkutQ1UFuENMKIWfVbo353nersLJGwAuV+Uau6ABIiv2x7Ynq1o3Cc8Qjz0zd1Vpj1Fg4likskYyCLdwWHUMH6it7PPU9KCvI0K5HC7bi0bxDizaohc+Lu5ALVKI4MlOurt4fkJ3/BVguhMp41lgFxI/TW65Mb9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346027; c=relaxed/simple;
	bh=9LTfdfEyjL4iMdSHB+Kvse1ywfY0yqyvL/BRU9og3zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QtbMdi1DUzgxgMsd8mi4d9Z/qllVujJSx0Pew3rIaUoJc+W4QLVn45/ffF+hqkzzRAyI8d8g+0OE+RR35LQyS5Xi0DytrW6jW6jnBvYX5H0dRn2WbzaJhBfNEIJEL2NFPQuw99nrDP7B2cOqWAsaIw42Y50i/eM0u9Pq526NOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjVY3MBO; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjVY3MBO"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79860421382so13492727b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773346025; x=1773950825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3HJ0No0Nr2joHFlv9JslreD/RzRYlwKb5xVL/UtKQ0=;
        b=HjVY3MBOsPDlN34tbspbzg1rKSxiOgkfBMf+uQNZ5Y0ltkdMewG9ERmgRr/r+SdKOu
         IdqHewxNrKpIm9CW7RCnUaKNRRNr2fTgmPTAjsi9Hr3jpdo9a7LyAEj9K1GcYSw6oWis
         oGZzbFabF1Yl8KFeYe6sBoz0bqaJXZXj86svU8TqnTYU/PupprK6R3UjBig0yVIwSp7h
         yQqCd1stNtEatYZIYa5wjS0kcpY2rtc5LE9IJ82k6X7VYmxojMcBsA75VoVLAydffUen
         u9LLTZyKAPZwRuZNboSWcYLertWQA7bhy8iBvl/Alf4/j9JsvazKBgzHFPluIRpVsSS/
         x71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346025; x=1773950825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3HJ0No0Nr2joHFlv9JslreD/RzRYlwKb5xVL/UtKQ0=;
        b=R8bnuM74mm3PMfgSzCwXy7bIw7AwQWZYMT2nCh1da+xcZ84SlHgPw2lGohXT7a0M5E
         a4/Zb1KPPf5ttFlRSR5GLtqWUVSoXCTIWjag4iOuRVuERbm8bLiHNCVSe5/qriAt/4Lt
         34HeeHHaqzMUxL7EyBTwrrlLy16JXfLYWHOL9+h6zF6mJJiG+Y5mA581cHV6idMgP/ZP
         8+NTGfY95F5EOk4KyxHdmffD6XF56eTIM4echCw58p805mET+3UfCyJwBwET5fBemGPJ
         tbDDdfGJlrwu3vPcxoQgmCTFx1oI9SAPDX1/xnTUpT1Cb6kc0Mw4ntS+8ilpKEe8J3gr
         m5Xw==
X-Gm-Message-State: AOJu0Yxz9vMocf8FJgl6azwxku1WgcnvInZPMRVBTPUQNhAdWCvh3Q3w
	0nRrva7HltWVjuWZB7rfrE4R1KNbQBTHhW4u2VsoGi6G0jUyIh3vPbokXK9zHA==
X-Gm-Gg: ATEYQzwZ+oTyBcAW3648vpzsL45mNxY/BkWZDGDJcINE9v5g7BKaQ/dvYh0DTaknksi
	r2AzT8nXD95UXCuFeh63/1TaP88TcmlmyksacfOQY56iZGhiybjS46sgPiRHvfvyulpn+cTPnl2
	Y+7RRNNpkan0mnJduovVB7CntLBUzcOcm7REYw/YXlWSGsl9pHzUzzM+PK18op8k1+RvgKGNOfW
	eXkxGRNvTBEWX4TPZ3V1U9YO5z4Q1ttKxZK0PXuX+8tAeazR+dCjkoiqEFF+d/ZO68W9kZNaVNw
	9NR6nQGcCkZpP0UWYA7zaVSJss0w/l/+WZ0WOU/2KerwLfgazKOpDliT86swmKw4vL1HA5Y7IBW
	91gtl5eb4TCnipEwD/Z/2LgCG/cbQR7hjmF+DRt8x63ZDOYIvqZRJHRmixqBEJSBBdoIeyGsD0M
	AFDTHtinDDSWx2LD4bNQPuk6YIzIslo9Jh/hNceNr7hqalBn2+/2wnIlgEbgS8wrgTInhJgJ6TI
	Ft2XbIm6OP8fa8wqA==
X-Received: by 2002:a05:690c:d88:b0:796:2fde:5dfe with SMTP id 00721157ae682-79a1c18d08amr10225327b3.38.1773346025526;
        Thu, 12 Mar 2026 13:07:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1d2f6sm35609007b3.42.2026.03.12.13.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:07:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-03-12
Date: Thu, 12 Mar 2026 16:06:54 -0400
Message-ID: <20260312200655.1215688-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit c38b8f5f791ecce13ab77e2257f8fd2444ba80f6:

  net: prevent NULL deref in ip[6]tunnel_xmit() (2026-03-12 16:03:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-12

for you to fetch changes up to 99b2c531e0e797119ae1b9195a8764ee98b00e65:

  Bluetooth: qca: fix ROM version reading on WCN3998 chips (2026-03-12 15:29:29 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Fix hci_le_create_conn_sync
 - MGMT: Fix list corruption and UAF in command complete handlers
 - L2CAP: Disconnect if received packet's SDU exceeds IMTU
 - L2CAP: Disconnect if sum of payload sizes exceed SDU
 - L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
 - L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
 - L2CAP: Validate L2CAP_INFO_RSP payload length before access
 - L2CAP: Fix use-after-free in l2cap_unregister_user
 - ISO: Fix defer tests being unstable
 - HIDP: Fix possible UAF
 - SMP: make SM/PER/KDU/BI-04-C happy
 - qca: fix ROM version reading on WCN3998 chips

----------------------------------------------------------------
Christian Eggers (3):
      Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU
      Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU
      Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy

Dmitry Baryshkov (1):
      Bluetooth: qca: fix ROM version reading on WCN3998 chips

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix defer tests being unstable
      Bluetooth: HIDP: Fix possible UAF
      Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ

Lukas Johannes Möller (2):
      Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
      Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access

Michael Grzeschik (1):
      Bluetooth: hci_sync: Fix hci_le_create_conn_sync

Shaurya Rane (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user

Wang Tao (1):
      Bluetooth: MGMT: Fix list corruption and UAF in command complete handlers

 drivers/bluetooth/btqca.c  |  2 ++
 net/bluetooth/hci_conn.c   |  4 ++--
 net/bluetooth/hci_sync.c   |  2 +-
 net/bluetooth/hidp/core.c  | 16 +++++++++++++--
 net/bluetooth/l2cap_core.c | 51 ++++++++++++++++++++++++++++------------------
 net/bluetooth/mgmt.c       |  7 ++-----
 net/bluetooth/smp.c        |  2 +-
 7 files changed, 53 insertions(+), 31 deletions(-)
