Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FFD38837D
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077131; cv=none; b=CAvjrr3Gn/eu3kYKvg15LLw80j3M7Rsf7L++V374uRz5I2x2f5P7fykgaSrDz9KTOePhfaEspOqlPi8hsxYautbJiQZapydqTjl4s97kwIRpb/hE3JslYiMLuRyvJbcMjqqiz/t8pR5iLW2//b4v6czFjUFsvCBN4fB55hs71Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077131; c=relaxed/simple;
	bh=qVghazcM/ujABQBOn+t4QpGfd/bCMsuw+XiepWqiDfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f281ttUW83ybV4cVnximl4F2jMSqKOOYRemo187vXNxZI2SwKPQrL+d5xY1BYbSqMd4fpVgaglVbgyQrfnr9MKMc4J1mjUCvKtoND1DWQu5jBcP2Y1vlsZJz3BoYlxsm9jwRiTYE9Loyg1H/xy8nun0FnCizmflL2s/4XqTXPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+55nh3X; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+55nh3X"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9539d9f1675so115935241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 13:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775077129; x=1775681929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W9783WPdOIZD13GkEthAh/0zwn654ungnFdFydPCPVw=;
        b=q+55nh3XegRVDDEGOsOfHVYIE1D4jOhzVy5QS2KiUOrRQBYJR8OWdo0h4njv4tuo1T
         lNakF1iup/oKFVT02pqJv97s6MKqYnrtjNji2mwWdYU7liXngpdfkdwk/2gZl8JV3aDu
         Gp5tMWqLWnkQHx0ST6NdHHN5FI89QAQFDXtq4DJRLzSLEBgGzPO2rJdJmvOlBZO2dRDG
         EBuso4Is/iVZ6AFJ+X0kUsRFDZhFbmprPvtY+E8icmDhVolTqibVT1HZdDuAnVTp7IzW
         Ac2BLQGyI3I+rxKfRPvvv1V11fpkFVkxsx8Zxk1FHCacWnhdNEj5xczK0xNNKO7HfL7T
         yq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077129; x=1775681929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9783WPdOIZD13GkEthAh/0zwn654ungnFdFydPCPVw=;
        b=qEKUoxt8DTUyabw7ZyRDvv3hs8u7RqgJiKY+v6y3wkj4pJHwAxiTeZJFb0c6j7hYkY
         E5rUADFF9CdHiwuNwjjd8zx1SHFAd+bQRP253xJsn1ntOycKXVZYAPvhTiR9k47upa3T
         pHAp9Zj82iCrVNLROPnNcvg0nCY208PRYcuzYn32NlTo5sC+oDJeAK9UaQZGVKz8mxzt
         XMpL8Y2lMA+efl0F4n29/7ry9pK/jYDCzI08jZ9Ve1aAm918XPFVPcmj0TICsIHfH+LW
         3lRpcpYfENmN2t5Bgf/Vmm4JppOu4ULh544yoN4wYRhmT0r5m7guRKZtGGujwZ+Gjn8j
         qnpw==
X-Gm-Message-State: AOJu0YyQn923UTXOiwoRG67oVJL9D6EZyqr+mFwC8hURsCLeL61fQn49
	bJ0p4pG5PEDsL8TlDMoi5Tq01h2rozsykzeqWsrFahiuWcl48S9vd+OB
X-Gm-Gg: ATEYQzw1Wn1c8dvZgQjhRSgzZx2owz6uvNW3bxsPPzr/njT6PTMtFDhcOS3TrzAmrcu
	le5/OfU1rsfV3dgoXOF3gp9/GiCByycl1dUZ/by+TrU4Ji/KaFtEKKR9GfjPx4ja3UmETOQtfZN
	9THjFfcC+3+LxO3I0r3j3TfKd0zuIb0EW5+bZVZSd2X5IwOU+l1GYh9FVhIuf3j3mKAMLWGG3Rn
	NduE9WXjdclsg29ullC0PNfFZSbxYXABRS2mayHqKjAgPMO2S96JCrzqlVUL9WBSihnXoMkV9y4
	7TdZdHzg+X6gCZf8872rsNMmc8HMGGXvU+0tdM/E2KaLkfS7s5CEu2ftie7N9KmclEg8JqmX2rl
	/gscWeuZE1hflpQMyYnOhVoiusQJ6/NFmoEfOFQ/7uFL/fuseqOC8jtFaKBhW3+iujEV6YZu93g
	PyWQ2v0bdip0dHLCAicfi+M5HcSFRtydj3AoVPtujefH2doKIuwB3bj2HlCLNlr3rTuwuNFW4Ue
	8rAywRgbnuH6pm8Y1CZbGfRFG5j
X-Received: by 2002:a05:6102:952:b0:604:f640:301e with SMTP id ada2fe7eead31-60567e96320mr2379277137.12.1775077124275;
        Wed, 01 Apr 2026 13:58:44 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6058304a726sm1367642137.9.2026.04.01.13.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:58:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-04-01
Date: Wed,  1 Apr 2026 16:58:34 -0400
Message-ID: <20260401205834.2189162-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 48b3cd69265f346f64b93064723492da46206e9b:

  net: stmmac: skip VLAN restore when VLAN hash ops are missing (2026-03-31 19:45:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-04-01

for you to fetch changes up to bc39a094730ce062fa034a529c93147c096cb488:

  Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync (2026-04-01 16:48:28 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Fix UAF in le_read_features_complete
 - hci_sync: call destroy in hci_cmd_sync_run if immediate
 - hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
 - hci_sync: fix leaks when hci_cmd_sync_queue_once fails
 - hci_sync: fix stack buffer overflow in hci_le_big_create_sync
 - hci_conn: fix potential UAF in set_cig_params_sync
 - hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt
 - hci_event: move wake reason storage into validated event handlers
 - SMP: force responder MITM requirements before building the pairing response
 - SMP: derive legacy responder STK authentication from MITM state
 - MGMT: validate LTK enc_size on load
 - MGMT: validate mesh send advertising payload length
 - SCO: fix race conditions in sco_sock_connect()
 - hci_h4: Fix race during initialization

----------------------------------------------------------------
Cen Zhang (1):
      Bluetooth: SCO: fix race conditions in sco_sock_connect()

Jonathan Rissanen (1):
      Bluetooth: hci_h4: Fix race during initialization

Keenan Dong (2):
      Bluetooth: MGMT: validate LTK enc_size on load
      Bluetooth: MGMT: validate mesh send advertising payload length

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix UAF in le_read_features_complete

Oleh Konko (3):
      Bluetooth: hci_event: move wake reason storage into validated event handlers
      Bluetooth: SMP: force responder MITM requirements before building the pairing response
      Bluetooth: SMP: derive legacy responder STK authentication from MITM state

Pauli Virtanen (5):
      Bluetooth: hci_sync: call destroy in hci_cmd_sync_run if immediate
      Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
      Bluetooth: hci_sync: fix leaks when hci_cmd_sync_queue_once fails
      Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
      Bluetooth: hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt

hkbinbin (1):
      Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync

 drivers/bluetooth/hci_h4.c |   3 --
 net/bluetooth/hci_conn.c   |   8 ++-
 net/bluetooth/hci_event.c  | 127 ++++++++++++++++++++-------------------------
 net/bluetooth/hci_sync.c   |  88 +++++++++++++++++++++----------
 net/bluetooth/mgmt.c       |  17 ++++--
 net/bluetooth/sco.c        |  26 ++++++++--
 net/bluetooth/smp.c        |  11 ++--
 7 files changed, 165 insertions(+), 115 deletions(-)
