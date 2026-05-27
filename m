Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0E3C584A
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916377; cv=none; b=gCsb1Gp3nR8UxxVgJQ+/Rom38JZBVNglZkWEQRX4inDhV4KlA/8WKUIeHhYack4ksgsu5JhxK0UHrC44rwjzOdO59EPoB7DpFbiqwEi56FE8s6+cyN8VKhb4IyvM3J64X1KeBkPv9FduELJoSPNhTqo8eZHWnW8xpEZR3FGvKxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916377; c=relaxed/simple;
	bh=TKx75lfRzQwMpPduPdt8DhlbT+gkRwHbPfqxMVyUC7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XE9/McXQuzFg1s6dcTz5YC4ViAhCZ1yzl6cCZQgW3vVxhofoMteAcZfiACjkR1R+C1uce5JSWWhLaFdT7DPriNeFguqe9fcJgKfw4cSuZfNysW0YxKEekEKSQE6of0M5aeQF0h42u01s7iL7CN9qJyfJumP3yRtrXsI2frZb9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCqmunMg; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCqmunMg"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-95d0476492bso8897669241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779916374; x=1780521174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyDzNPQ5trU74hgcl42/wUnjfkx6JjWoigwqCMHOUnE=;
        b=eCqmunMgsI7clBi5UABnSHS9GVz5y6GoHfkBEGn/z0gsWNYuCUyxiLbzauO6B63n8h
         +OFl8+eykFgjstdfeA99bq+iJj1KrJvsWy+OJrWPAnyYh1yssICd/58mrBMRf3DJIU56
         UFHB+n6Dvp9L4ZDKylg4zA+I3XisgVeeWiBeErezsLmCshOiRxfX/+VpI+8113/9qgVY
         EzfzR9rFz1JwAkQ/4wHzZiZ3yyGTPEujRir+AURHsDULJED4OGQG0DJCQjv9ph/wBz2M
         LoKyhD5VlBrehQq2X5xUsQoJ23ZVUYB8tZBFEhJBRP33f59BGGJlIwQvtTAmvKKpaHSm
         vyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779916374; x=1780521174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyDzNPQ5trU74hgcl42/wUnjfkx6JjWoigwqCMHOUnE=;
        b=h94C28xwd+VYWiu2aCxgGOexwR9N8L5f/xEFQdG/U9pNA0PJJO6JK/EqEimwF/3ThK
         OzYFhbrNHdbtBlVmAbo16ETZvAAtiF7WhI5HK4dv1eJokCRDvli0WOJBCZp95AKC/5n0
         Grq9FoPumuip1+ls15SYICS56QoJ3RPQCWCmDNjTjPmPDW9Mo6Mv18ZO9yEUS+AAJcJd
         oLa7mjXGb1pMVGAUeSumFZ03E8DWuSv0+XwfET/7c/kdKzxR2MhyCAdd2wYKEBb0K+rk
         SYS1MGW7qEyO8I0plQ4RF5zm6QnasZMX2GfPQi84PiZqbBaFLQwlm5s2hrCNg1xiJkAz
         42Ew==
X-Gm-Message-State: AOJu0YynLgstyjmAgDcoYFYg0oAB7xpI04o/RgTGduYE2su7HPUyholV
	j6YaD/f95RWoyGC1qpGU3wlyGiAGQhb57S/WAG/EQ2k2yPq3CrOUZiv0
X-Gm-Gg: Acq92OF/0P4FFqOYQ4SGQO4xh0il9IcasuIkpV7DXpOb2xIH1VL5cDMkkmzcj26Xr6g
	CcuM+IrGAJn8vc+1KMr+/zZUf3JaZ5PbhlICJQIIFBbK7SEjSY2LhcYRBDP/ENkGl2MwzEgtf5L
	G8GxFzMhidnRYK5p4KHMOI3OIFE0QrDnBwOUPHXWNcy/LfHV06oK7wDV9i6RkPfKz7S5oJf2LbD
	QCKwQyHpM+sKJjaVakArOsMgaAvfaeZYK7QfgVd/FUUdYkyQaH7Vb20cIItJI+YTi97jx3AKbjc
	l8V7Bxv2HYlGkobxciZVK3XuTQgMA6Flaok37ovVe162h17GAK5lMMUazIbi6ZzFRgQznWiCXG0
	1DGWXa4JSyXvpiOyVP23rGmc7B/uZxgGnSHiGt1KyZFScgZ9lGmf71+GSwzAC+bCMShPtY/AIac
	l7Ia3rn6v71E0bMV6RWD4eL2JZ65SMXuYLAizXbqfKpZyH4rDYwikQLD2ZePbj0uSpdX8Rf+ibo
	uv9TId4lgYM+69Y/VRBCzxPt4wY
X-Received: by 2002:a05:6102:5e88:b0:631:8665:350c with SMTP id ada2fe7eead31-67c8a823e5fmr12979477137.25.1779916374516;
        Wed, 27 May 2026 14:12:54 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-961737bc13fsm18631182241.3.2026.05.27.14.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 14:12:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-27
Date: Wed, 27 May 2026 17:12:46 -0400
Message-ID: <20260527211246.371451-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:

  Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-27

for you to fetch changes up to df35e8e0c8c4160c881bb673e3c7ee010824fbd5:

  Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-27 16:44:02 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_core: Rework hci_dev_do_reset() to use hci_sync functions
 - hci_conn: Fix memory leak in hci_le_big_terminate()
 - hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
 - hci_sync: Reset device counters in hci_dev_close_sync()
 - hci_sync: fix UAF in hci_le_create_cis_sync
 - L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
 - L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
 - L2CAP: use chan timer to close channels in cleanup_listen()
 - L2CAP: clear chan->ident on ECRED reconfiguration success
 - ISO: fix UAF in iso_recv_frame
 - ISO: serialize iso_sock_clear_timer with socket lock
 - HIDP: fix missing length checks in hidp_input_report()
 - 6lowpan: check skb_clone() return value in send_mcast_pkt()
 - btusb: Allow firmware re-download when version matches
 - hci_qca: Use 100 ms SSR delay for rampatch and NVM loading

----------------------------------------------------------------
Doruk Tan Ozturk (1):
      Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync

Heitor Alves de Siqueira (3):
      Bluetooth: hci_core: Rework hci_dev_do_reset() to use hci_sync functions
      Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
      Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync()

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp

Muhammad Bilal (3):
      Bluetooth: HIDP: fix missing length checks in hidp_input_report()
      Bluetooth: ISO: fix UAF in iso_recv_frame
      Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock

Pavitra Jha (1):
      Bluetooth: hci_conn: Fix memory leak in hci_le_big_terminate()

Shuai Zhang (2):
      Bluetooth: btusb: Allow firmware re-download when version matches
      Bluetooth: hci_qca: Use 100 ms SSR delay for rampatch and NVM loading

Siwei Zhang (2):
      Bluetooth: L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
      Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()

Zhao Dongdong (1):
      Bluetooth: 6lowpan: check skb_clone() return value in send_mcast_pkt()

Zhenghang Xiao (1):
      Bluetooth: l2cap: clear chan->ident on ECRED reconfiguration success

 drivers/bluetooth/btusb.c   |  8 +++++++-
 drivers/bluetooth/hci_qca.c |  4 ++--
 net/bluetooth/6lowpan.c     |  2 ++
 net/bluetooth/hci_conn.c    |  4 +++-
 net/bluetooth/hci_core.c    | 43 +++----------------------------------------
 net/bluetooth/hci_sync.c    | 16 +++++++++++++++-
 net/bluetooth/hidp/core.c   | 23 ++++++++++++++++++-----
 net/bluetooth/iso.c         | 12 ++++++++----
 net/bluetooth/l2cap_core.c  | 41 +++++++++++++++++++++++++++++++++--------
 net/bluetooth/l2cap_sock.c  | 16 +++++++++-------
 10 files changed, 100 insertions(+), 69 deletions(-)
