Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744365;
	b=y1nncxORHQ+LDdr/wzf9e9byNS8zjHvYvPS4lul89g90iyhnXWPwGzWuMxbmXnNYCpjS
	 6lkXL75b7fNs74w36Vs4lbDbwhuhLI4Na6guBHM6YNM5zupUjnTHKgsoulC9jA9OhlREO
	 ROoJmwkvH2mtbYDGrzQeGAk1qOe5IyTvLwTI8l5pltNLOw1xDTZ/FHwTJu9NSY3FUUyJm
	 9D+ZrLi0AZy5pSV2YJhz+IV4GPuRo0wmb5O2Aehp76L+o3h5vc0Vo6bqtaXfXJzzSOwlH
	 ApXMNYXydIFL/enljQwhPH0DYUnbXPBAh0mdkmVyYDBiI4923BSes//oWw4OuM9pnSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
	b=c0aXa31aAe1STR0cV5NfNm1OdqLZN9G/7bvnIQsj4qV53jScQiGa2youA0WBWJm9PGbS
	 YVLVgyph4paGFLn7UFTMt4v56nDf9XhHLo9hCnJJSUWA3u/KzuogOyv+lPf6bgKAmptoz
	 Y9b7qxU4fO+TZ9/zsOSiNm/A8th7EIn4vbeX3fwuuEIPMUol71lkNrQQ2uEHjT0gCO3/a
	 wVODarR7vUocFrQYip5zaHNqyD71Q950VCzLf8CM7pNF8XL9IuJd/OJVqYi9etG6dpyh5
	 Cs1i4lR7syxNCnRCW45F+jvf9nzTlzl6rf9695F4QTG3SxdAQUHamKJN60ZCotygreg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UI7mkBNQ;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08696606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08696606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UI7mkBNQ
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9912c47367cso761802241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744364; x=1794349164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
        b=UI7mkBNQ6nAQ31HOXo0J3AdA7yLa7ez3cQZ7O0F9kuAZZpxfhvNIk7lONb9IhgXzhH
         gh6nsCed4X2x6OtLnzRp9TJ0nWdkqe061rftLYlb/ZzHkwrdvz04sjd1eHq93AjTWax2
         EtGtCALNMUSVdvpBdr+aJKrbC3f6R1DjPQWgqk0i84RZzVCHgb3yFFGvlacUVp8SWdc0
         dwenD8kfqwvKJEwVui9c7Hp8NpVfqndWQyK6FlYL5m42HJICXWZp1BqvhjLlAe4uYunc
         h0XdVO+lkSpEeO5tDqpxD5wfJ+JaAuIi46L+eccmYf5PI620JT2t1bNa0jASxyCrvB8J
         0gLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744364; x=1794349164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1gEpsqS1i+/K0+uv78zfDi7xU2QuotIgijxmoIPRWJ4=;
        b=WxO2xOmN7GOA2m8WASy6o6uiiFqLZ/NboRdNuBUAjUyofsNAb4sWsvjiWNF+KlPuuL
         bQoeH86kOwTyiCvmHnhhpMo3BTVVKFrlv7AXic3EMWSvSfopmcUMpdAx3tMR43ERcCuU
         fItDVPyqqn3j65FOL891kaCRmNEZJWP/YDDq5C2yvNzFiouJuxTvfeFWG/s2JdWQGVbT
         XVOtOiTWVVLx/AmAMbISIqBPaTtnQtEsa1U0XQhjk75SYmXfFQF3YKPKc/LOFDIMJqml
         udfVYhmgzMGpuuv8VTQXKB45m/0Om493yeP8E6K59OlnSbIZHHmkjwHIcfQ96C28H4Mq
         2UWg==
X-Gm-Message-State: APuU4Z/2W80/FTJHUTpvn+ZhMRzVC9Qzaxqj5ePvJSCVhzawTTiE8kkV
	3vm0Y9ODscLYSQtMKeA4Mrdk+0bq9tuDQVd4DpB3MaTV/UmnLqqPBgnDehQzSA==
X-Gm-Gg: AYBFou3AoxDOVZ7v8uAOWVDEvl7fX8lrMlL13DoMtR8j4FwIQr62xuIB07k9jVGBWCN
	B9B5W3+FGaIej5kkZuuf/nqrwwEmJhBydy9igXtWRiNsrk0OxfbMuO4SL6jUpmn/AFLXQkRZ8ve
	beks+7+kLWQrKsrbHMOTvUNnTj2oCmveFn+VIhu1kFPp7nxjHrnxm3Pl/fF3Vklg4p25PHowJag
	20KDomV0JgGIUSQoGuzz9wErS9JkhnY3ajK4O81BSX0DdkkM5iJmqnfO9MqCO4QyMQ9qyz2jGDy
	gbA9uFHhAdH33aFKTlXEiKHx84dWYEifVwCIJzrdD/ALjP/uR/Ysx7Bm0/WuwCdv8hAuLi8QKaa
	jAW4LltVlHW7MM3DDa/aEb1ZacI0udU/ZdIi0mtlxZ4gEGf36qtv1sgntCFqqKDZK1OVT8+B0oY
	1BO9vWq3PW4KlK1yVjz1qphu1w41gS4IFalxqWx0gdbtmKMtnutgDngHbiCcKhduU/ceYOZ8hvg
	TkT5qGFg4lNgK2KPxSLnaFAxjKc1wthmHuNnm3TKXe+zpaB5EU8XNQ238sogUq/mJhWHUpaeJWo
	Mj6++k74+F4G0b3y0Nm1SS4JWcpZ8MhO+gMeItb5GJShmWWAEPg5f367m1kW/dreT8ON3S33T6t
	fX0FKEFx1m5X3UYAVPhIxOBW5Ah0EnRWLdsMTlSioQ+1BaOWKm9iHvWNzgqaAfSm2S59OVJJV5u
	Mztkg=
X-Received: by 2002:a05:6102:50a5:b0:7bb:64cc:1362 with SMTP id ada2fe7eead31-7d072c2b96amr3252477137.6.1793744363947;
        Tue, 03 Nov 2026 14:19:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm306572137.11.2026.11.03.14.19.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-11-02
Date: Tue,  3 Nov 2026 17:19:14 -0500
Message-ID: <20261103221921.4071765-1-luiz.dentz@gmail.com>
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

The following changes since commit c3e67bd82b9b9b1a5118f09a429ccefe2aab0741:

  ipv6: reject wrapped temporary address preferred lifetimes (2026-11-02 22:31:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-11-02

for you to fetch changes up to 60b10121db602a43ada3dbc39792bbf93d25991b:

  Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery (2026-11-02 17:09:03 -0500)

----------------------------------------------------------------
bluetooth pull request for net:

Core:

 - hci_core: Initialize IRK before publication
 - hci_core: Initialize link key before publication
 - hci_core: Initialize LTK before publication
 - hci_core: Fix queuing rx_work while workqueue is drained
 - hci_core: Keep link-key filtering inside RCU
 - hci_core: Initialize advertising RPA work only once
 - hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
 - hci_sync: re-enable legacy advertising on resume
 - hci_sync: pause advertising for the scan address update
 - hci_sync: Update the CIS host feature when enabling LE
 - hci_sync: Copy the LE accept list under hdev->lock
 - hci_sync: Protect resolving-list lookups
 - hci_sync: Copy the resolving-list IRK under RCU
 - hci_event: Clear explicit connect state on LE connection
 - L2CAP: Hold incoming data until encryption key size is known
 - L2CAP: Ignore connection responses with wrong ident
 - SMP: Protect link keys during LTK derivation
 - SMP: Protect LTK encryption with RCU
 - MGMT: Return RFKILLED for Set Powered on a blocked controller
 - MGMT: Clear disabled connection parameters when loading none
 - MGMT: Fix discovery stuck after a failed Stop Discovery
 - validate retained LE Create CIS command length
 - validate retained LE Set CIG Parameters command length

Drivers:

 - btintel: fix buffer over-read in fw payload
 - btmtk: drop zero-length ISO packets from endpoint padding
 - btmtk: bound the ISO payload length by the controller's MTU
 - btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD
 - btmtk: fix error handling in btmtk_usb_isointf_init()
 - qca: Fix the WCN3950 NVM baud rate offset

----------------------------------------------------------------
Akhil Arul (1):
      Bluetooth: hci_core: Fix queuing rx_work while workqueue is drained

Binbin Deng (3):
      Bluetooth: hci_core: Initialize IRK before publication
      Bluetooth: hci_core: Initialize link key before publication
      Bluetooth: hci_core: Initialize LTK before publication

Catherine L (1):
      Bluetooth: btintel: fix buffer over-read in fw payload

Cen Zhang (7):
      Bluetooth: hci_sync: Copy the LE accept list under hdev->lock
      Bluetooth: hci_sync: Protect resolving-list lookups
      Bluetooth: hci_core: Keep link-key filtering inside RCU
      Bluetooth: SMP: Protect link keys during LTK derivation
      Bluetooth: SMP: Protect LTK encryption with RCU
      Bluetooth: hci_sync: Copy the resolving-list IRK under RCU
      Bluetooth: hci_core: Initialize advertising RPA work only once

Chris Lu (3):
      Bluetooth: btmtk: drop zero-length ISO packets from endpoint padding
      Bluetooth: btmtk: bound the ISO payload length by the controller's MTU
      Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD

Ismail Tarim (1):
      Bluetooth: btmtk: fix error handling in btmtk_usb_isointf_init()

Jinwang Li (1):
      Bluetooth: L2CAP: Ignore connection responses with wrong ident

Kevin Dewald (3):
      Bluetooth: hci_event: Clear explicit connect state on LE connection
      Bluetooth: MGMT: Clear disabled connection parameters when loading none
      Bluetooth: MGMT: Fix discovery stuck after a failed Stop Discovery

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix invalid Supervision_Timeout in LE Set Default Rate
      Bluetooth: hci_core: Convert hci_conn flags to a bitmap
      Bluetooth: L2CAP: Hold incoming data until encryption key size is known
      Bluetooth: hci_sync: Update the CIS host feature when enabling LE

Michael McAllister (1):
      Bluetooth: qca: Fix the WCN3950 NVM baud rate offset

Tobias Wilken (1):
      Bluetooth: MGMT: Return RFKILLED for Set Powered on a blocked controller

Valentin Kindschi (2):
      Bluetooth: hci_sync: re-enable legacy advertising on resume
      Bluetooth: hci_sync: pause advertising for the scan address update

Yifan Zhang (2):
      Bluetooth: validate retained LE Create CIS command length
      Bluetooth: validate retained LE Set CIG Parameters command length

 drivers/bluetooth/btintel.c      |  24 ++++-
 drivers/bluetooth/btmtk.c        |  49 +++++++--
 drivers/bluetooth/btqca.c        |   3 +-
 include/net/bluetooth/hci_core.h | 104 +++++++++---------
 net/bluetooth/hci_conn.c         |  92 ++++++++--------
 net/bluetooth/hci_core.c         |  54 +++++++---
 net/bluetooth/hci_event.c        | 212 +++++++++++++++++++++++--------------
 net/bluetooth/hci_sync.c         | 223 ++++++++++++++++++++++++++++++---------
 net/bluetooth/iso.c              |  20 ++--
 net/bluetooth/l2cap_core.c       |  26 +++--
 net/bluetooth/mgmt.c             |  51 ++++++---
 net/bluetooth/smp.c              |  53 ++++++----
 12 files changed, 609 insertions(+), 302 deletions(-)
