Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278598;
	b=0qaakJUHyRvDv2EgEdRS1oXTNerPQWfLeSI3sW8y6EnPCVd/iErHsEARcvVztQaNiNky
	 N2J/dlNih97dOW5DyfgBcVZglnVxR8aJTBo0HeN4diGgeTFzM4y5H/bDdY01KZwxqCSro
	 sEOskskGxsdN3WFAxdaLz8GTiYQoPVgVdiFiJymL8oDDkZpQBBML3D/6xCDeEnzil+qH4
	 SpPDxB0fwvAt9kWaOTVJ+vIY3N13nI1dAHA6TYysIbJMzaJqKviiTKC3dqFyghicKU83+
	 WumBcxPQaQ18uRcjv3dU8YGsoySl/AOrHio3U9IV6IiWA/h9VBlIAtcKI2qkLpZsOvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+Ol/RFJFNzqPG9jGCUYTK1DQt5AIzQwOkQlcpeoPIoI=;
	b=H9tOILcOnTJ5AmTswcwUJVEkiBf0D6PNXs2wzTS7L3Wjx8EaKBdiJAirZoS7U1FkY5S+
	 B2w04iakZ2Nu2e1C+d6W3YiGEqHWQW0rU6foKSffp3HWuYn1uC+4VQCbfjsJT+iCsoyDF
	 umL3YayN+QItodAbI5LyXVoyrCFZ8WNga6mqHceE5xVSiodxc3KCF2s20dlKzeJGEL6t1
	 GTM9ED1sEeP11Sslz/+m9XQXqCZtTS5WgAUA991l8FN9Xil5DpUWLUVb34z2Tah/MIbfu
	 OUmQDFnxS++WNfX8OoIx8tVGv1gBRJUk/WonDIGJAr+SioJPcMvIw9w0+T2NuO00Bvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBu9LWnL;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1329606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 02:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1329606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xBu9LWnL
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so1006172e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 18:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794278596; x=1794883396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Ol/RFJFNzqPG9jGCUYTK1DQt5AIzQwOkQlcpeoPIoI=;
        b=xBu9LWnLWf46ZCP0jEtKFb+vag8+4+ElYNpiqCWP9K4TXSd0Q+qLEU7P3j9k6huyiI
         UELrZLzvOPtxI/v6tG3UKpQzpsVD6aWGBENeo5R3BPxLjhv/7Ch8hdjnisN8vuh7u3fx
         bZ0NteATxmHWyhCc2008jryBqnHoCxEnXBhptlq/t0hAIRAWe+3Qn8Osam2MJR31Bd6C
         CsS8qtawC32yWLcayQh8E3/fYSG3pE50coT0iH6pH1+S2aqz2lWb8V/QJFAtFphHXh3D
         JTXlRJZRrMPIfnIL6ejiNXhhANTjjL9wvSq7UqgabpRggIAUTLWXzzkqSo/WbQWIzDRf
         laHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794278596; x=1794883396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Ol/RFJFNzqPG9jGCUYTK1DQt5AIzQwOkQlcpeoPIoI=;
        b=B6I8XYgfkKDbDFGwmRzH5hVRVQTz8jiwHkOn2XSOJu9moKBwAIL3XKzcDgcvbSfogo
         r3Pw1Wjj1DMu6EwM75UHd9e0B0l4k6gPmSZtrKZC3L5BCbDE5RY7ggEBM/BX9FvHJsHt
         TtNdeeEEhAQGDDWQzpE77NPC62MJNmPzCODaBS4KbcWwaB/I78FOFD2aVlNUea3uJyL2
         96F5Hm0MgkEwo+Qb9QwW/Gds7S/gLa75NicDMTOYFV89rrUDGSyRcq5ynsUATgQqe/qL
         F2aPa/dROmHMLekEi7jfSKjtmJs8HySo1PIU7EW5xvJUVKbMEagvU2hJfLrWS/coAKrh
         p0Zg==
X-Gm-Message-State: APuU4Z8tnWtNp5ZPwaIMtci2PQs32Y24s5LXP7+T1TWwd+KJcQJ0XPxu
	mHl9DWjUbRXOTz+jMMo8NXskpGKQcjMgqB2e4yujiR6dCIP60tiDSNqf
X-Gm-Gg: AYBFou1P2XIxxYYC/DknNjgrbcUsNF7gRkiRBWXOOCIO5LAMhvAFKJfRm/M9vVcML5d
	Op/Lhs1I9z5x9X/oos2hxTHWXGAAt2fwAsDfMSp6NqQsiSSb3tTEYvM9hPUzz+S4syvXp60Umfh
	evTWPX7j7ISfoSJERX3PEUHoNdFGQPliNlHIdbZ99PvpKPdam2UYB4CkLCveFJuJ72aJ7328Mp2
	wLxr/k7v67DZVKrEtm7YaaehAndmAxy3SoOR1yMN36WT7ABuoryOXnP66oZANJmDHOs31AYgP3j
	nkWJaWXlPPcuQZg2RNchOzV5YERs3o5wkr4rUH/qKmxDh9vja+1Ak/Oihka33rEqCKjwrtCKpI0
	MYr8q8j0Qo+cmtIk/+YLlUeGGXy93rh1ICNK17Zc/SFJDwowC7/xlQjoab4yR9f6HiGYRHij3JK
	aFkZGrdl3e3Mr/t4Tfrlyt5SS4Eq+dggJq6G0Z5ZBwnNIbH+gxLDnhZd1FRPgL9ZnZVs5jtpe7h
	NzEmA1A69dPWn7KIEtOwnc/4ensQdYQBHvjMrlUcD6GdD88iuxLeBhdCwX1CsMKWQs0k4+jLbGx
	ajMYE/FG4gsea1SOgx/pjOqOphxiKyKWDE+u0ygUjuz5W4YeJu16STeAECCsrsTS/UEiTkX86fC
	e6uIRrWLpAZ8oPqr9pR4PqFvAb3L06poHfK7RtWp42aa2GKbCODBXNU5ClwYbARM/i8+79I9wLU
	/OOqg=
X-Received: by 2002:a05:6122:d28:b0:5ec:3e18:a8fa with SMTP id 71dfb90a1353d-5ee0d1ccb43mr460169e0c.20.1794278596491;
        Mon, 09 Nov 2026 18:43:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58e5d1sm938947e0c.4.2026.11.09.18.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 18:43:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-11-09
Date: Mon,  9 Nov 2026 21:43:13 -0500
Message-ID: <20261110024313.2023223-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 60b10121db602a43ada3dbc39792bbf93d25991b:

  Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery (2026-11-02 17:09:03 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-09

for you to fetch changes up to 1f2ac56137c51be0601e18a163d817e02a15913f:

  Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel (2026-11-09 17:04:21 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_conn: Fix SCO/eSCO Transport_Unit_Size for HCI data path
 - L2CAP: Only accept LE responses to outstanding requests
 - L2CAP: Clear request identifiers on incoming LE connections
 - L2CAP: Keep recvmsg from resuming a closed channel
 - Fix not updating of hdev->commands[] after reset
 - reject invalid LE supervision timeout relationships

Drivers:

 - btusb: fix use-after-free in force_poll_sync
 - hci_qca: fix use-after-free in ibs debugfs files
 - qca: Disable SoC debug logging for WCN3950

----------------------------------------------------------------
Kyle Pepper (1):
      Bluetooth: reject invalid LE supervision timeout relationships

Luiz Augusto von Dentz (1):
      Bluetooth: Fix not updating of hdev->commands[] after reset

Stanislavs Nilovs (1):
      Bluetooth: qca: Disable SoC debug logging for WCN3950

YuanZhe Liu (2):
      Bluetooth: hci_qca: fix use-after-free in ibs debugfs files
      Bluetooth: btusb: fix use-after-free in force_poll_sync

Zhao Li (3):
      Bluetooth: L2CAP: Only accept LE responses to outstanding requests
      Bluetooth: L2CAP: Clear request identifiers on incoming LE connections
      Bluetooth: L2CAP: Keep recvmsg from resuming a closed channel

Zijun Hu (1):
      Bluetooth: hci_conn: Fix SCO/eSCO Transport_Unit_Size for HCI data path

 drivers/bluetooth/btqca.c        |  1 +
 drivers/bluetooth/btusb_main.c   | 10 ++++-
 drivers/bluetooth/hci_qca.c      |  5 +++
 include/net/bluetooth/hci_core.h | 13 ++----
 include/net/bluetooth/l2cap.h    |  1 +
 net/bluetooth/hci_conn.c         | 18 ++++++---
 net/bluetooth/hci_event.c        |  4 +-
 net/bluetooth/l2cap_core.c       | 87 ++++++++++++++++++++--------------------
 net/bluetooth/l2cap_sock.c       |  3 +-
 9 files changed, 77 insertions(+), 65 deletions(-)
