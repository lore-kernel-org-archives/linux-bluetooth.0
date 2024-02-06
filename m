Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24824134BC
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707244893; cv=none; b=VLZFaRQibGlqsDjdc8V63RhGQ7kVcvfQj0hZ+wTEooSsSNNDCEm6/zZsQDSzCGuvxoyMMblsZomhuVmjIx8+BkMQYLSWiGrdm8RE97s9nW5DyCrbkIKHiJPbvaJF9pBd3oIE3OTQWWULsA7pZwkb2NNpbM9g9jUrRQj/6InpXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707244893; c=relaxed/simple;
	bh=3vJrwHK85opXt1wm/MYnYki2jUwqGa5B+iVv+WKTWPE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QcJyFmq5mLsrKSCf79xDlDOwsNEmFbhcRPORZ2wwLySXfb4eh7trJGLmmffnO2ZAELxMC5b7ph1ccsLP07EeQd056GuZj824Pk/Hh2sGA4DkDSSVBBjjU8WQPKEiFA0ilkwIuqpGUftB5ZqGmOE42bf50afc90dPVN08nVi5+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mn8m48NC; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn8m48NC"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4c0215837e2so941914e0c.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 10:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707244889; x=1707849689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OP9kM7p60EsYP67APqcBRt3XCsXVGzwGc8dSrFgOdc=;
        b=mn8m48NClRuUtfM/eqvF8DPFYF0AkfENI6nD5OXaWsTg5Pu80kmWF/9q5KLKP3cluy
         L5SGHom64MLrCWHXz6+EAhHBh8661UzYQAZZy7VU8w5uVcLYve8eFBLKnJy6XYyhFpsq
         1fM0dIjcTu8gKbA+RC1WSlrjLiljB36RQho6YWzDg6CF+7rgZZ4FC3sAuANDeRCkLpsL
         pll2iBnxXRS1X68ST8wcGK6QRmoGC4kYbwnaKfhYjmTZ33kbgftAHJVTpek/WXl9ND02
         9C/+Wam6Li9uxbh2e4jVP7hW+pj78qX6xodH1Dp7fQELeZnD7Wn2NY9lmkvBjjhf0gIH
         GC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707244889; x=1707849689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OP9kM7p60EsYP67APqcBRt3XCsXVGzwGc8dSrFgOdc=;
        b=t29bdO0Xzdqfnx3DSYxYmOpk36LiJc+DP4BbaidDjHg9JsY7CFM+d2Pjbl2masSdMC
         OlXYcdLAngDDIG/KQmoN/VGxj+OHPnmsNW+KkNqXwPUwLC2TqkglJWsl6/X0zQfVVjYX
         3L66zBRiGxL8BhgXtSmzMmI51nov950X9Zkfn678XQ0/C9IRZMxRODPTnHwLxYvcAJcI
         iNsjpQe6IxsMIQQz80SyaLi+Kq8DGaLX9k8wDxShwXZPHHJou70Lu6+hyNG2ZW9/2oev
         zo7AuCTP+URGLiB9wk1FCnSK9xuRRm65EhqLvvwsiTwCROf4jDlDyr+DULkMLgCBkbH7
         PZQQ==
X-Gm-Message-State: AOJu0YyhibJUaAqsTlfpwglldJjp8El00DqH9oGMtE4BdfQuXi8KSjoy
	KF+m/zfDf7h76gAuDlFR96SuqJkYJbMSksL0OP5EYyBvBncTdPuScLFZJESp
X-Google-Smtp-Source: AGHT+IHrx5YA+q1N2b6kgyUif/Yhfj2gzKK+yqcl3Uwk+cwUO8IyUZOCFyEbCvWWpk3fcMNLuMksXw==
X-Received: by 2002:a05:6122:1d05:b0:4b6:d4c2:61d3 with SMTP id gc5-20020a0561221d0500b004b6d4c261d3mr519015vkb.0.1707244888660;
        Tue, 06 Feb 2024 10:41:28 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ee2-20020a056122478200b004b72f2093a2sm388220vkb.45.2024.02.06.10.41.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 10:41:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth 2024-02-06
Date: Tue,  6 Feb 2024 13:41:25 -0500
Message-ID: <20240206184127.2538186-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit ba5e1272142d051dcc57ca1d3225ad8a089f9858:

  netdevsim: avoid potential loop in nsim_dev_trap_report_work() (2024-02-02 11:00:38 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-02-06

for you to fetch changes up to 4479efc1f1aa89ac9bcb8ac8420e317eef7d7c50:

  Bluetooth: qca: Fix triggering coredump implementation (2024-02-06 10:13:55 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

 - btintel: Fix null ptr deref in btintel_read_version
 - mgmt: Fix limited discoverable off timeout
 - hci_qca: Set BDA quirk bit if fwnode exists in DT
 - hci_bcm4377: do not mark valid bd_addr as invalid
 - hci_sync: Check the correct flag before starting a scan
 - Enforce validation on max value of connection interval
 - hci_sync: Fix accept_list when attempting to suspend
 - hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST
 - Avoid potential use-after-free in hci_error_reset
 - rfcomm: Fix null-ptr-deref in rfcomm_check_security
 - hci_event: Fix wrongly recorded wakeup BD_ADDR
 - qca: Fix wrong event type for patch config command
 - qca: Fix triggering coredump implementation

----------------------------------------------------------------
Edward Adam Davis (1):
      Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Frédéric Danis (1):
      Bluetooth: mgmt: Fix limited discoverable off timeout

Janaki Ramaiah Thota (1):
      Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT

Johan Hovold (1):
      Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid

Jonas Dreßler (1):
      Bluetooth: hci_sync: Check the correct flag before starting a scan

Kai-Heng Feng (1):
      Bluetooth: Enforce validation on max value of connection interval

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix accept_list when attempting to suspend
      Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yuxuan Hu (1):
      Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security

Zijun Hu (3):
      Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR
      Bluetooth: qca: Fix wrong event type for patch config command
      Bluetooth: qca: Fix triggering coredump implementation

 drivers/bluetooth/btintel.c     |  2 +-
 drivers/bluetooth/btqca.c       |  2 +-
 drivers/bluetooth/hci_bcm4377.c |  3 +--
 drivers/bluetooth/hci_qca.c     | 22 ++++++++++++++++------
 net/bluetooth/hci_core.c        |  7 ++++---
 net/bluetooth/hci_event.c       | 13 ++++++++++---
 net/bluetooth/hci_sync.c        |  7 +++++--
 net/bluetooth/l2cap_core.c      |  8 +++++++-
 net/bluetooth/mgmt.c            |  4 +++-
 net/bluetooth/rfcomm/core.c     |  2 +-
 10 files changed, 49 insertions(+), 21 deletions(-)
