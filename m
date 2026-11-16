Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846402;
	b=qzGdBnDF5HIj+wPOmUk312DoZtf2rsgeLvMG0qsa4+Ev+mWtaxJIKI6luIw1DhTCW9/a
	 s6N0UOpgEsV5lb1tMqqaqH250Fix6Awc0/W5ngKxUy2HDh0YVpcsHJYJy1dL6weIOWPe8
	 c26kmA6EBLXWM09k4YzJUFA3G5TBERlxaSlrKJaRRYCbOCyCo5lkSpopqrb28ifzbsulu
	 xJuAKfcQv9j4wgfJ+wAHY8L78EoWP7cXF/BZjZin8+gXEbfuPUFhKKvdoqZ5EZ50K3b5s
	 CxWhZdfK65SkcSgntTg/J2gwzTq+UFQDc49dF0lm8DqYP4k0YaEir+rRxz4lAGg7Nvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846402;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dmDChotEha0iFqm+8jnyADjXLoziwfDG7A+l0ZouVYg=;
	b=UYx0UFk+wwb9SYd/ZeL55oZh1zRUfHMJt8yCS854mbMtSiO09Kt8MpVXpAgHdCumJgZy
	 G0F31DfGHLVsKhih6SWX8OiI+MB0QG7ZCOfQOTRTudvHtiAqxoperjHBBgT00dDQU5uPe
	 FFFUQttQdB2SlHQpF2QJ7zyeaJ7AlFnIt23lUNg3PyLCo0eO/cxaTXyZuL7XAiSZKRY+h
	 fcaQVjASGStiBQZg5GolvU1bjsSdfBWzw2/yu5U1u2zrhZ1K/l0iKxIea9J+PVduqXgti
	 ZES3vZZGqz/uf0GHRw44psAni7+KGPtm6h35ODqZspyHc/pyzGeTzPJy9wbfU0W3ULA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=sTyVA0aV;
	arc=none smtp.remote-ip=185.70.43.171
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACC606A330;
	Mon, 16 Nov 2026 16:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CACC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=sTyVA0aV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794846399; x=1795105599;
	bh=dmDChotEha0iFqm+8jnyADjXLoziwfDG7A+l0ZouVYg=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sTyVA0aVUz4LmdT0TlQlZlGGqbuFziWiwo1RpgZeGEfcv5DbH4dsDgJQK/N6v8FDa
	 oxdnj9vohi4sOUXKEvb9Z2V6BYtTswGzeuaTy5HY7bwM27raYsV6d7DORmD8SYr/cv
	 sVrR3nCvkYLVnsnx2/x8jgjAAnuLDELAUGgeNVz/o4yzAK+oHG6j9iwEwhrF9LjH40
	 y+BA9vmrtwB6/KgQ86lsVFL1PoFQv1aAEMO1WbL54Kiel+Oz7f9WHVY5GFhmCbl3VC
	 e552IHHBPak2JYIG4Jd7rTXirYb1r4JNNT9MPOoxLxCJ0FkRR8OgMHZBjymzx8FrV/
	 fdSY6abCXoVPg==
X-Pm-Submission-Id: 4jStXr49zgz1DF5G
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com, enderaoelyther@gmail.com
Date: Mon, 16 Nov 2026 16:26:21 +0000
Subject: [PATCH v3 4/5] Bluetooth: qca: Handle failed power-pulse writes
Message-ID: <179484638195.54009.8260068189701829762.wcn3950-poweroff-v3-4@michaelmcallister.org>
In-Reply-To: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
References: <179484638195.54009.1916641645532262287.wcn3950-poweroff-v3-0@michaelmcallister.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

A failed UART write leaves hardware flow control disabled. A zero-byte
write is also treated as success even though no pulse was queued.

Require the one-byte pulse to be accepted and restore flow control on
the error path, returning -EIO for a zero-byte write.

Fixes: f9558270b85c ("Bluetooth: hci_qca: use wait_until_sent() for power pulses")

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_qca.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ddbeb0787..6642af781 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1430,9 +1430,10 @@ static int qca_send_power_pulse(struct hci_uart *hu, bool on)
 	serdev_device_write_flush(hu->serdev);
 	hci_uart_set_flow_control(hu, true);
 	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
-	if (ret < 0) {
+	if (ret != sizeof(cmd)) {
 		bt_dev_err(hu->hdev, "failed to send power pulse %02x", cmd);
-		return ret;
+		hci_uart_set_flow_control(hu, false);
+		return ret < 0 ? ret : -EIO;
 	}
 
 	serdev_device_wait_until_sent(hu->serdev, timeout);
-- 
2.39.5

