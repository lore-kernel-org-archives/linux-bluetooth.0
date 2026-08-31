Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC84470134
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200332; cv=none; b=e1HqmNJBHG0TsaXGBmkRD0dOmwxmp5L7dRNLCFMgFKx5IXzzAYD0y5u8UUZ/P7IrwN/LIs33fYuniRgpQO9xG2W2haXLbQ7NjskwR66He67o/dnyCpVReVdAntpWZI3EchQcNS+lqHltW/yXefdyM8HQwsCbpKubkKY8QR5QhGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200332; c=relaxed/simple;
	bh=g6MX+Fm5AEr7O32lbCH8xw6i4PM0zA4dZIAMIDl+8Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlEp1Mo8aJfpeLvlagvkNjc9km9pQdg79E2x2z3Zu88vyJe588OlLdg3SlLDPgn6QT5+foiphR/zwuFxan3h4TuWCDSwi8D2tMEzag2I5jm1n9gBeSexM3rYWTDHvMMmaoeTbhQ426zauw17JtThV4RUTGPmQ3rMWJSPEJH5MDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc61FbKK; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc61FbKK"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97ea365dd5cso40387241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 11:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788200328; x=1788805128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VTSkPnLnj+rCK/r3SoMMp8mtUCO8jXcltm+9dQ5/UVo=;
        b=Kc61FbKKD36Q6nCcttRUN0kqMbUg7iIuCuAlpcMGeCPVhg88LcwQ9bF7le/u7RIbI+
         /LzBC76ocHMhWlXOu/u6R0vps5QlbAOj0HUfTTmkKvPVoNuxuyIgT8oo8psMXzP4Dd0n
         ewylsn2hssB19wVOxM0p8+P2wBulKMKmF46W0v0B5rNDbzY6cQnCoc9UFwmMa8v+wVrI
         ieuYfvzw+QEC9YRTtyvGJsiwECEqZDdT7UxlOKzHTtFHyh1Tx30sVvRKkkdSrCCM2Cxw
         POVLLmqvjE+gk99RJeooSLSpCIxnEvagdTzNirDZ1RDlL8UFICOetODnKmuGP50nDOQa
         vzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788200328; x=1788805128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTSkPnLnj+rCK/r3SoMMp8mtUCO8jXcltm+9dQ5/UVo=;
        b=JQhSl9YfjVullvXgxW8CBYKDoWgRKaUFQgCevEsnxpvqhjxwOMph7hQ0FjCh8N8FxM
         bAtE97zQBDIMWQC2h9FxjaLZOyvBstLY7vnViT5Sy5pKSX6hlYnbdGkKQChQ/JKNbob5
         loZUqkYw8ghfheyAJoN6HTS2Lr98CxdZbJ+e8JD1dyRQmWUzzECXibQQFau3IT/d0BZx
         ogYtJDJzkb31bFXztfkTmzs1ifj2pwzyLjLeG0cAMfm61KjcZRDSVzG5Y6551MPN3Dgi
         0QQWFR/ql+I1xwQGw2L12BrYPV9yV/ofYQQEl48AMMsUTKZ9uTqHSJbtELEXrDiJ5xbZ
         qJYw==
X-Gm-Message-State: AFuF++mfnbCiDFKcS95qeeXtJ1sn6MczJS3BnHNJLtVMqOuBVHJ2dQaI
	0Tt1yK9B70t+mY4jJLg5jNZGvUpXZUcV8YridQhLuJVlbD5/k6ksfMnG
X-Gm-Gg: AR+sD12ygMs7L4McFf4gYPrzYGcM8MApYMAb6BwKJDykBJvfQW70aMgIFs4KOQ2q2zm
	RzUjv9UU+nmlwmKKtNjSL/Ed6cGE2J5G6xrzINgwK0B2MQDGsWdFnV8cmIirBflyTZ3h5ncMluv
	eZTRIoi99xziFB4v3sPQwLFh3sxfCDx3UxxsUUWc4T78dovTvaO4VSWAzjt01YfOuh5KOoOoGI8
	5LzfG/8V2e073MsRDx9itymrTWrdwkR4aUDWR0hnlrSFszKvMcGPnwRNs+dF1HbYXoZombzSNNt
	uV4k0n5pvq6czgCrw/rd+E/dawbQ/1wLbLJTQKITZEWlJseCsxGK5RyhqFNzPFN0WuikH84OHPA
	qgnrbjriE/Qznl0TqIR9sKChGo8zW5R4RcDhv1jtWHenxF6F9UtjphDXqr7t7n9WUL6Mg7uhedI
	YrbNUyWahsAulfq0un84pDJ6h8mtjUVr4NadO9jzfTgj4AtBYAyM0BSOPUQRD1R/nLOyYbEdp2X
	ExiY2R0L2qvSm8ur7j3jQqvZne7TRunz7Rk1IKvMEnJ4cIM7UpBd9w=
X-Received: by 2002:a05:6102:580f:b0:786:c86c:4f5e with SMTP id ada2fe7eead31-786c86c569emr7883170137.3.1788200328011;
        Mon, 31 Aug 2026 11:18:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7893f43666esm4329503137.9.2026.08.31.11.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:18:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-08-31
Date: Mon, 31 Aug 2026 14:18:37 -0400
Message-ID: <20260831181837.946230-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1376afc7660bad2a1a5ee0876898312a486cf8bd:

  octeontx2-af: fix CN20K default MCAM rule removal on port cleanup (2026-08-31 10:04:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-08-31

for you to fetch changes up to 2deb76c21b81e42b3282224f7dd2046fe73fd1e0:

  Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout() (2026-08-31 14:05:27 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: Fix race condition during device registration
 - L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
 - L2CAP: fix out-of-bounds write in l2cap_ecred_connect
 - L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

Drivers:

 - hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()
 - btintel_pcie: Clear automask on spurious interrupts
 - btintel: validate version TLV value lengths
 - btintel: bound firmware ID by TLV length
 - btintel: propagate version TLV parsing errors

----------------------------------------------------------------
Aleksandr Nogikh (1):
      Bluetooth: hci_core: Fix race condition during device registration

Gongwei Li (1):
      Bluetooth: hci_mrvl: Fix wrong return value check of wait_on_bit_timeout()

Kiran K (1):
      Bluetooth: btintel_pcie: Clear automask on spurious interrupts

Laxman Acharya Padhya (3):
      Bluetooth: btintel: validate version TLV value lengths
      Bluetooth: btintel: bound firmware ID by TLV length
      Bluetooth: btintel: propagate version TLV parsing errors

Pauli Virtanen (3):
      Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
      Bluetooth: L2CAP: fix out-of-bounds write in l2cap_ecred_connect
      Bluetooth: L2CAP: clear FLAG_DEFER_SETUP only for same PID/PSM

 drivers/bluetooth/btintel.c      | 44 ++++++++++++++++++++++++++++++++++++----
 drivers/bluetooth/btintel_pcie.c |  3 +++
 drivers/bluetooth/hci_mrvl.c     |  3 +--
 net/bluetooth/hci_core.c         |  4 ++--
 net/bluetooth/l2cap_core.c       | 33 +++++++++++++++++++++++-------
 net/bluetooth/msft.c             |  2 +-
 6 files changed, 73 insertions(+), 16 deletions(-)
