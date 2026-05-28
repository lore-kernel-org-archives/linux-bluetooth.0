Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4453BD224
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974332; cv=none; b=QD6z8X01YFGEkurJR7+qV+qpf8q9yJyJ/QpvJ/2u0fbm+I84U2zA0gus0EPK1SvTY3xZ4XX49Sju9Pql1jafEUxDqRKbzZ6rHZDEzj88ewvyNwAoM0NUkhGegiuL6187uXHBmwNX7vNi9Z42tf8yT8+TJ2QuaGlxUrpwJFBRjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974332; c=relaxed/simple;
	bh=zIvM24MXse+lon+ZHsE1rKlGq4W5y+fx8+rHjDMA/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHoSeAmMiJm0+Yx+R250rnhMlxuLzvVdXO0SLK/5iGmZHMWzEQ0JxO8Ub6612cPe+Shw8bElZ4RcoRF/BzmwHi2fZZCHP6zu0bmLEUlXSUou+UyVn5FaUthAkah3w31lo8b4375rakJ3kqej2areoWbFgA+wTc6Ur+2PHBEVU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYmIINXd; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYmIINXd"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-575eaa32c7cso4376938e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779974330; x=1780579130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsL91HmF9kKGrU3q0nx9KAZTzS34MDYjzDPYUtVrxFw=;
        b=GYmIINXdYI2Now+oRqK2bUsapHGAA06bM9kvBCGW5y+BOjdK++6jDNwbQFdcWs7xwF
         qGUst1a+Q2vxlp4+1fiMgUdtbD1lakRERJgyWPDydRaaMkcmDBu1VUd3fgozy3oBoxP0
         WbJEXyYCrdcKhTXc8ZSb01H8LOo1j4xmNV6+DoFI9O/G06Y7XPZKWqUnSLMYFZxXCmbF
         i3BLH1dxVyl/6wiXbwlBz3nPyrKGG4zq97B/1sAC9BOdRGoHZDrcWoUcDU0NSQKvyzYZ
         QqWq4xBrmzresxOrAeXLSFMkCscMS5r77O+9AQ5PibuE6lfYYC59U4wjQ0ICnSjPP/xd
         YrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974330; x=1780579130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsL91HmF9kKGrU3q0nx9KAZTzS34MDYjzDPYUtVrxFw=;
        b=oK5oYvLTgE2gd5UVu4z4xa+MWtgmD/hIvkx0JKCOE36MU7ZEAfv6NrX5Qth/XF1CtR
         Mrwq+NsEEkFrQ/O3aOnF8ylTNjfeMDGjhDstDWKvc01XhBRqbVSfygjrFmriytE5trHm
         l3/kGNuP0Xkug+qg7U1AWTjrijvlPz9R2gI1h5B3LMblTfeTqsw28If1lrkn0FlnA6T2
         DSuRKJmNnNbOyVZVgToqUrC1e9arMe0vlSXL2R1Li7TpRoujPsKvznJeRddDh7+DPFDf
         4J5fsH6oXkdIxbjxxkQaY4fw+dSDYGWrRK3AF5TAdHivuFEubX3rRufzpo4M2L93yYiM
         XZvw==
X-Gm-Message-State: AOJu0Yz6XYmJN039WurdX3Hr5BraFA1nUGGsK0BInoIanjQRcLllX3Hd
	CHJgLetChyZyI/PWTOJBQ5x6DaeBD0nW92ZPmplLl77134+5P9ja+wDz
X-Gm-Gg: Acq92OEkoXbQYY4uvR+J5P3UclidwfibA/BOjKricqIuJUlWCSpSfqh7ZiTdUPXMCpc
	RC3bgcggIca1NZwMliMSpqgNILZLlm7t5bnjhDVb5ZwmirA08eDNeZ5AgqyIgiPEDtLDenrZqNl
	Fd8Nu7d/oiAN7cT2Ftf9iVFK7nHjZKs6oaxJ4CVogX/ogQaPEprP6BZ+IBQHHQycgp3pFREIQH2
	+Qg3MmHREmlbCZx/BDhRx5OescZzVZWHrIvf4Y3T9y6d4+xrjIH5AOBzAwKolReGjsRDjE6ImxR
	40/dtye5znnMQCDRBh/rXAmlqyZWSoqmUFOMehLeQUaD3R9aeF8WfJ3/BGiUSi1eGJjSDSfFy7c
	rRMKYB7bOXEBYyXt4xEmkj8ToiFecse0xWBB7UX9UvYXODiPY4IawNG+iSw7ARqkmxT8lY46YWT
	GBHgLd4ulpUs11deCmQ+wLmPMjS+n5WRkgUjDkoL9zsq/az5hL5jD090RIPelv7DokxMEm7cMKz
	jh5CQQGVQ0EZqJqA1JKN+5u00CDbA4hIMgktwE=
X-Received: by 2002:a05:6122:289b:b0:56e:f071:d4ef with SMTP id 71dfb90a1353d-586608aba88mr12888889e0c.8.1779974329598;
        Thu, 28 May 2026 06:18:49 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-963909241d3sm1871940241.2.2026.05.28.06.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:18:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-28
Date: Thu, 28 May 2026 09:18:39 -0400
Message-ID: <20260528131839.462344-1-luiz.dentz@gmail.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-28

for you to fetch changes up to cdf88b35e06f1b385f7f6228060ae541d44fbb72:

  Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)

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
