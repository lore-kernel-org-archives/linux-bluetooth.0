Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902630DD30
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773947109; cv=none; b=OVJOYTLscc01S3tcuUCqLIdyDD3Yab3oA0bKUJkzBGvCPuvWbYDbQCMJpIL4MfmWwbNhyqOcHIrN+B1m6vvWGugaOzBXYkZ2xFal6ensH90n/4Kf7xBhYtes3U4dJ0P70N9njEsH69DVbCTCBJ2Gj7pZXKi58hX9vhiLkP85cgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773947109; c=relaxed/simple;
	bh=LJt274V3ht8U3WHbvziiK44X1c37AgSUuKyPU84HBIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZmAk2t76DyNYIbRGyXBrDnHTPg/wHSHthAD75b/SRLe6Iv39fr7xBGMI7vhfdIYX6qmfsos6ZpGIvzDE9NbF9FG+copXfPk2oyRCT486Uy/NPa+TmjO9/6s6b2NM3P+hjmBcmCrsvir+TVkCNr3XLC1kpEDPFOMX1/EXI2wenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFdhzQDI; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFdhzQDI"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56b91ead558so1083596e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773947105; x=1774551905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jr7WUgqLKbTlxBWlZ7mC0hG01SzLzNGqWw7Ddk7e0kM=;
        b=RFdhzQDI9fA0JQHQFus39ZHB19TIFglMmr8CxVE1ywpfddQtFiSeyg3ca/EtBsEACV
         DdXnLD9wFafVn8tSKZYpG4M4xX0yrKnKqFly0Re0Jmh+wq/AzwEPsSF22Avh0HsQxwcj
         uy8B5mU21e8IjJni/blBxI4rYLbckt6073607WKM/3NEuvHFYEM7bCVJHOKS3vs1+peN
         N39P7FY8W+lE7iK1nKRpfnoU/SjhLyQjst/Pt9XxboIffTIKMk561vZ6+f9PF2JyShqK
         XhoEGu6TmKyTraslKq+IUVqZTuoXQyT7CYNy57g6LZt0TigHnq+30eaogZCPLeBz9OvY
         Hktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773947105; x=1774551905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr7WUgqLKbTlxBWlZ7mC0hG01SzLzNGqWw7Ddk7e0kM=;
        b=FAoYSTcqHaQ/kFYiCAx/vcUvy/2BrOd3xXW26BFs9HsCM7Rwe6wqq2QUbk+lTKG4bu
         gsGZ6Ec1aRHzU0tq+TRu2WoHfmdc1EVUAIxGJYL+qPJST94LkQA0/oi5HIP/q5ChCulU
         eeCmwt7sqUhjujvR117U6Wh/nECpOZyx3FHytmAlaxkzWKZotHU0VVrUGiUnN/FFs+fD
         mqTYgAetheIcka2keBFqkk4hfIpikrS9xfPwh3B0plzlpkfteXo7jv8RlRFqnRmphI7n
         DQRZERUewDkDmrbdTMB0Xz1+oEZFMCezn5ORVGzx34oKgiJwLmGNQXWFy0vQBXH8dVFu
         JF2w==
X-Gm-Message-State: AOJu0Yy80nCBuBWjkbhyFBfmpjAkT4cKHMm9u759x/3g36tO7YJIX4GR
	FysswU8p9gMADLFcaCojS/hxwuvFh/8nOuGqfP2cOeoYuLzK7w+C8qxvlZBlBUAwwic=
X-Gm-Gg: ATEYQzzUWwd8e8C1IyH1oyE9IpqP0XQ1Kc/mLMgMdzfcblQ1Y/qo64hVfherWl9SUww
	oTpgL+VDYLn1OQFic+4E0kJDFBWvPUUoWLgde/Ce8evzn1FsUAv2yxp2mGEn6Tm00i5PJlIl1oH
	KMQ8I10cI13MnYg7u71EwauND+OIwDcGksptW9tcOdkpz9wnHwj+R4M5P47XJjmEIIPC8fz5z6Q
	0PB1+aDOO5eUMOpJLyzNszqgioYuGEfqVSAN/gjFHR3E2TeJTLShM45FgrzpNKUGl/IFQxNdd5S
	Crita9pxoqNQ/vtqkwHMgR4qDDY3SmNVGRlRBSPa4XkcWXgdk5LYWi59CyERKJvSushi2NwGa0K
	ThNCRXAgo2BP+STC0mdgoLM9FfnTkYgF21NxiFL4Nbxga7TJad/Gqotn8FgpuRVf7eQ8Tn7m2H0
	xBEsfDR21/vAuKPvXZNIF2CK9ZAzr2xbzTWIVbULid5BiZQJ+iNZhGpWhN4Y7WEykSOZMEGO/MG
	6flTaW9zw7c3dpbSA==
X-Received: by 2002:a05:6122:4890:b0:56b:7f53:9ab2 with SMTP id 71dfb90a1353d-56cde3fb2eemr176455e0c.10.1773947105220;
        Thu, 19 Mar 2026 12:05:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcf1554sm341064e0c.17.2026.03.19.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:05:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-03-19
Date: Thu, 19 Mar 2026 15:04:55 -0400
Message-ID: <20260319190455.135302-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229:

  MPTCP: fix lock class name family in pm_nl_create_listen_socket (2026-03-19 09:37:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-19

for you to fetch changes up to 761fb8ec8778f0caf2bba5a41e3cff1ea86974f3:

  Bluetooth: L2CAP: Fix regressions caused by reusing ident (2026-03-19 14:44:25 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_ll: Fix firmware leak on error path
 - hci_sync: annotate data-races around hdev->req_status
 - L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
 - L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
 - L2CAP: Fix regressions caused by reusing ident
 - L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req
 - MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete
 - SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold

----------------------------------------------------------------
Anas Iqbal (1):
      Bluetooth: hci_ll: Fix firmware leak on error path

Cen Zhang (1):
      Bluetooth: hci_sync: annotate data-races around hdev->req_status

Helen Koike (1):
      Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb

Hyunwoo Kim (2):
      Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
      Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete
      Bluetooth: L2CAP: Fix regressions caused by reusing ident

Minseo Park (1):
      Bluetooth: L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req

 drivers/bluetooth/hci_ll.c    |  2 ++
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/hci_conn.c      |  2 +-
 net/bluetooth/hci_core.c      |  2 +-
 net/bluetooth/hci_sync.c      | 20 ++++++++++----------
 net/bluetooth/l2cap_core.c    | 40 ++++++++++++++++++++++++++++++++++------
 net/bluetooth/l2cap_sock.c    |  3 +++
 net/bluetooth/mgmt.c          |  2 +-
 net/bluetooth/sco.c           | 10 +++++++---
 9 files changed, 60 insertions(+), 22 deletions(-)
