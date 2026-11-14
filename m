Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681665;
	b=XgAr2ly6ozNPG9+TTHpQP5gGE791PFnTvHeCfMMovzOXXDgnsTebNFZnCsAiieUI/LaN
	 tOONKK87EFVkYtIHThnhuDCk5qq8nMLkwJ58m/PQG2EvScEWcpn5mAOL0f03YjrmAEHkv
	 HAz0/40Nox5wRmy94UwNHOwuEEh8LY4zWI1kdbrFhHCIjGChlNLu/n+tOQUp7RCN4Q9c6
	 WVc39rv2/trDf0SS+BfmMVmoYwXxLtXd/AEwaA9DxTcY+gJIVp1wFRHDFAfFRY3I775Ik
	 Qzcd04QMLDyrJ7MBbdRCZH/ftVECm6MC+F+2i4LX0grNZudOZw1T4OBaqxtN2FvirNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681665;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Message-ID:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=dmDChotEha0iFqm+8jnyADjXLoziwfDG7A+l0ZouVYg=;
	b=hbn4I6Li0GnAfroRr9Rwmyp1YUfqgvlGbbZErQ2qv7KaK4/gWHkYpI43buSGfCURBN/i
	 1T5q2XLWHorDZHerjAR+LMm9TxwrENFaThhgQi1wZss2YDenLIULC1UBcQUuvyekJXp7d
	 VKruF+z2KfrxPwxPHMec5eOcNu2wDH7rIlEFkhHCuU0dh///1GGGuibiMMf1JhXedwW3g
	 NzKbfiLjANuDmVQXSr7ixOE4tsiGaRs/R/jK73ZokJl6PKRk9ThMmbo/FJbXvNDU3EstU
	 Ax2oLBXsSjlpowBMZyqGawQyWLe1eWxazFDTLHu0tvypFc66Ian0LI8yzjwPA9FNl2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=NNu8OilY;
	arc=none smtp.remote-ip=109.224.244.107
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF5606A8B3;
	Sat, 14 Nov 2026 18:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DBF5606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=NNu8OilY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794681662; x=1794940862;
	bh=dmDChotEha0iFqm+8jnyADjXLoziwfDG7A+l0ZouVYg=;
	h=From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NNu8OilYSfmJv3scRXsVU5WQCzlFMwrhI3MpjKlReU2gLF2YdA4ufxaRJp0eMd6eZ
	 oD7G8aLcpsa/S73zv0zh2eyLepzgLQz1FU4n9dYjlQpjukoQ5S1mwrfLxAEEz836dl
	 1/aOqC7l2O4xr2xyp23wvwcpygKyyutrSBMsZTXlUImDrVpsvP/j8jv1RpbiERuv7C
	 L4Azm0vH6nEQAZezMDvXd1alf8kfRoaXs57y+IDjKNoZM/Wzvix/oG0XIzJt/djzlg
	 rqTyY4z9mFDXelx3FbXYOl6oclrA/10fuA545mFLbeq3zlxfpaCES98VvEPflgg6ou
	 p1u2zQG4byXdw==
X-Pm-Submission-Id: 4jRjcs0Y39z1DF5G
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com
Date: Sat, 14 Nov 2026 18:39:54 -0000
Message-ID: <179468159400.2456.12123448176300132161.wcn3950-poweroff-v2-3@michaelmcallister.org>
Subject: [PATCH v2 3/4] Bluetooth: qca: Handle failed power-pulse writes
In-Reply-To: <179468159400.2456.8302096233933976388.wcn3950-poweroff-v2-0@michaelmcallister.org>
References: <179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
 <179468159400.2456.8302096233933976388.wcn3950-poweroff-v2-0@michaelmcallister.org>
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

