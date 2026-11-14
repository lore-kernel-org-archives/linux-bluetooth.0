Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681667;
	b=RIEX4Ea0aA3dz7YFkLumUfBftlm/rVixbXKybVuTB3aqzPy4Jm41oNiNeFt9QaKA3fTE
	 FFYh3vSTmyD94IuZNH+U8IP8Lsk1ZzJcqbXdpPtPaftiYnU//u7JlWzZdF6oUMbG39YKp
	 7D+HyJMgb0h3cR5X5+9Ua3VyJPP8cq9TiXzO3ywtX3q4TcQXhgdwhbdwQXvNwZ5Nr7cPr
	 7ZjYdy2Xnewi5e+RLMaHbHBtN8to9iElicOh1qoK3iG613bQ7mhxf/cWv40AHHHJyyENh
	 3kirJ/u4P0SjrTg8nOUBzwpyzvEVUy630hfAoJwBdCNWe3NbZVi8jeqOD2zZJ7FAiWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681667;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Message-ID:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3D0u6TnXn7cU9TzO0Oe/RHRjfSNFZVI4UOig4klv+f0=;
	b=3BsNvzdHwLIkl9wLcuEhFrRMlM7/M4G5RNINbeI7A7NpzOSLySvIDi3dmOcg8oV/Za7f
	 /pfdwWCLkSOa2cySUD76TMmBtaNjXaPLZ531IBGIfsEKCcdRm7ACDc2T1nnNTP7sKokCt
	 +OWfyJ/NOBbpveoHw6V73BSgogga0m0Wo7BVImVRmeE7/ZTIqTUtlLtsq430S4n8VE3Ht
	 EvuWNwh/if1Ltt3BxPf5BPAZ4Prf5vh+O5gpHGhombTC5ZCD+TZujRdvp88Y7kwmlLFXn
	 6Nv19udQfvOEbFEOTiMs1SPNoqmTeYtCfsUBxs1mfYUZeczwmv3GuP3fwFuckrCcK/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=owvH1950;
	arc=none smtp.remote-ip=185.70.43.170
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38060A2624;
	Sat, 14 Nov 2026 18:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE38060A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=owvH1950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794681664; x=1794940864;
	bh=3D0u6TnXn7cU9TzO0Oe/RHRjfSNFZVI4UOig4klv+f0=;
	h=From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=owvH1950Gqqr2UFMAo0Hjg/0UDn94Sg07TKdsNAvSoUTMf4uYxGZ0tCIRK1XaWKbN
	 Z3fv3Yk8/5+D+G0lPhmjVPYTQNnGDK7P+/y57yqpBbko69HMJ7qYc44CUVU+JgOQFL
	 llxiAOskad7t2ckuJo/0YYBKMvM1fw/4WShHrzlButnNEMY0fvG+GYO3JAVoTHi9op
	 l30Wdn5S6pl9SBXaz9JSbhoG+/qIt3pTQqv/N/zxrZi5/bc4Aykna1MhgkRxNu9XXZ
	 BhttytXMVt2C3Par2PaOTVhD8qaEU8s5QYvVS3bsD0LfcP+KwO8+KB8IS9eaYtBT0Z
	 i6L1rHwkQzs/g==
X-Pm-Submission-Id: 4jRjct4MJWz1DF4s
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com
Date: Sat, 14 Nov 2026 18:39:54 -0000
Message-ID: <179468159400.2456.1620455624350858393.wcn3950-poweroff-v2-4@michaelmcallister.org>
Subject: [PATCH v2 4/4] Bluetooth: qca: Power off WCN3950
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

Turning Bluetooth off on the Moto G10 leaves the WCN3950 regulator
votes enabled. qca_power_off() handles the other WCN39xx controllers
but omits WCN3950 from both switches.

Add it to the existing power-off pulse and regulator-disable paths.

Fixes: d5712c511cb3 ("Bluetooth: qca: add WCN3950 support")

Signed-off-by: Michael McAllister <me@michaelmcallister.org>
---
 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 6642af781..bd8cfe95c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2283,6 +2283,7 @@ static void qca_power_off(struct hci_uart *hu)
 	power = qcadev->bt_power;
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2303,6 +2304,7 @@ static void qca_power_off(struct hci_uart *hu)
         }
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
-- 
2.39.5

