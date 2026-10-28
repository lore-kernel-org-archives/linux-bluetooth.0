Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227768;
	b=yyu768qRW4CyDkbIP8sovq/fphBSbK4aaU8R9arljuhVEFinN6dBFS9PyuUUqdBjmxgq
	 3h/sCBcx1VUJkKTy/8B0iVY+5J6gZX0YQvQrQ/3qyinwtHtvZXF07R08aMTl0lFDHgfrq
	 Ikl69gBRc1pK/fcadOyhNoxq/55cQHROjFd7bhFwDFYjsn1otO7azh5PX7omVSwuBigAG
	 NTskHcwBnsU6PkGWb/kuDcQdmz5c2eZYA47zWBfKO3fUnUpQNHQygmSkkepSt+B926Dev
	 GMrsGmvq0cAmvw0TW73TQa1yCz4SGWrkDhUTcdXi606i8YyqePrbINKXInF/xA7Ovzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227768;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=eVgWB4JaqOznGkXuQhaLJs4u9MK1+zgwhbLa6/qCGmc=;
	b=bkHu90WEFGqWaAqeLntGAZgm5hb0alyrbjzba2h16GKJEdRCAz2xzsSj9lm60Hj/V/li
	 NCjtDHbdTLvBIdvlcD/KoHq5tVgbSdV7WMUNGSfhb28Gar+dar2yuhKUNXnbrhvg92gzU
	 tG6skHSeybX+XjMUrPprP6GE/dH4qoeccRwxyYuaBT4XLXGm9r+/tKLaXZbcAq2D4/h33
	 reNlEMFjrC9gccbC9xOo7IIqEi7jFhuCrsPMyumDmQI8MJbpNAp2Eoqi25EZvJHWJykzD
	 PmUxncJjAGbmurHr6w84RQUrZeluGlP/v6GwxMQY5gtvXfcMXW0pgal5ESIgrlQV2aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=x6vMcwHd;
	arc=none smtp.remote-ip=185.70.43.172
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C7606A31A;
	Wed, 28 Oct 2026 22:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE3C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=x6vMcwHd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1793227766; x=1793486966;
	bh=eVgWB4JaqOznGkXuQhaLJs4u9MK1+zgwhbLa6/qCGmc=;
	h=From:To:Cc:Date:Subject:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=x6vMcwHdqR9THpZlKI65QYeonFAAEg8C2HIRj9Ho+zOg15UhhBx5+6XBnv/lQ4pBC
	 6JzIwUSmmcI6+MG8DZKNsN+GYGDNAUoiltc9KmJGDr80/+GSKXF3M8E0Dp4+BXRcMQ
	 bWRAjywipy4Div3K+uGymwbd8nDzMIgOPea/g1jwsqEN/er98m4M+K2RN9G4QAgvf5
	 e8z+JrPzuyoorB329h2SVH4gGhWodUWp8yy7425k0S0PS+8GG0Ugi9mxjMDfjAiB48
	 b0SctSo2TbEAibNEZ+lKQmPOZ+w4lGoxIdaVCk+goGVxuxhkfrkHWsXT5Yib9bVUKc
	 ZZrz3ny+eww+g==
X-Pm-Submission-Id: 4jFMxH6f4lz2ScmW
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-bluetooth@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
 Michael McAllister <me@michaelmcallister.org>
Date: Wed, 28 Oct 2026 22:34:38 +0000
Subject: [PATCH 0/4] Bluetooth: qca: Fix WCN3950 power-off
Message-ID: <179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

Turning Bluetooth off on my Moto G10 leaves all four WCN3950 regulator
votes enabled. This series fixes the shared UART cleanup and shutdown
ordering first, then adds WCN3950 to the existing power-off paths.

Thanks,
Michael

Michael McAllister (4):
  Bluetooth: qca: Restore flow control after a failed power pulse
  Bluetooth: hci_serdev: Track whether the serial port is open
  Bluetooth: qca: Power off after unregistering the HCI device
  Bluetooth: qca: Power off WCN3950

 drivers/bluetooth/hci_mrvl.c   |  4 ++--
 drivers/bluetooth/hci_qca.c    | 38 ++++++++++------------------------
 drivers/bluetooth/hci_serdev.c | 37 ++++++++++++++++++++++++++-------
 drivers/bluetooth/hci_uart.h   |  3 +++
 4 files changed, 46 insertions(+), 36 deletions(-)


base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
