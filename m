Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846403;
	b=Et9rNNYB+uyRPEUt5h99tAPIDHZbFSwGjwXnnkZWKJM76/a7XMprrM4r4i5Yz3m9d5fP
	 ShEQJou/XfiKZZJmRFZXUoZOW+HL69nlMbolZ+M2YBa5dBGnx06kNATj7wvqQf1/semho
	 0s7QAxP6e4i4e4646z75OOrIo1H4KPJfGMd0uZMQm2xjpPlPrjBBf7cj2WkZiVP22VSwU
	 OV7X7TtqEIM+TyU0qYqBRbD+Winf4FRqgw1fTbMsab7gbuuzcudmwWpGcAfnDFGSnJ+D9
	 oNRtdIY3NqhycWGYXxmzMwWQiAa9wYVU7p7c3mKaZDWvNHUyrmtzk/t1NGlfX9N71KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846403;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3D0u6TnXn7cU9TzO0Oe/RHRjfSNFZVI4UOig4klv+f0=;
	b=xB1ZVwc7sndyaLRU5kI5fwUMto/lExXEXWX0Z2lyBb8b6PBWOtM8I2tFAWkTD4oIV0MJ
	 xLtq8N/9C2gdXz/ljJermfLbNsCOmjPv89gmVBYhSlZH6B9jhWbkvobMZv+SbmUS5114h
	 Vc9pRkC0Ug+MCJ+0KYBvFvjapDNhDAPuyJwB6X+ZNk80z4ti+PZyW1FpKH7gmG7kH4Qo7
	 aw2ju+Lf9YEE1PX/+mR7+7xMq7phw7na4eeXvRXtX9HktSFR2PoemmASKys2E7hEows/f
	 QbkUJBaNLAdSso3q6m9aAU3x7OyCT6GPO9hkeNRX+6XuW4Pc6wsbo9o9YYuFQwTVrOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=B1m6Vh56;
	arc=none smtp.remote-ip=185.70.43.170
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A9606A885;
	Mon, 16 Nov 2026 16:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D2A9606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=B1m6Vh56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1794846401; x=1795105601;
	bh=3D0u6TnXn7cU9TzO0Oe/RHRjfSNFZVI4UOig4klv+f0=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=B1m6Vh56e8ymf0dhDN7YDNu8Oe4KQCLHEl/MtoxqARmmDc3mFff7CLhekWpCXkVEn
	 pCxCLR7B57iAepjHA3/S9/gyEpWv2oJHdtAUZwvlpOFEOLO18rIx8CgeN9OBWwCH7s
	 ox4oNIpPKPdgCqYpoMy2zX4lBQETNo0mb5ynw8ZkjqtO1yUYO6mRvBoDds48z3sNN0
	 pNZSHDzuWFE0AsCKKhzykiRus/JIj4s4kHzoEJTbQrlGooJrW1BFMtm5uZrP2UZOqm
	 XmW8Lxzhz219UTqa+PSmEHpXUicySWAevm7LBim0hjUg0J6TSi0Hx4yVXbuojf9QTA
	 +otlRjF2xu3vA==
X-Pm-Submission-Id: 4jStXt6ttdz1DF4s
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: brgl@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_bgodavar@quicinc.com, lumag@kernel.org, mka@chromium.org,
 me@michaelmcallister.org, markus.probst@posteo.de,
 shuai.zhang@oss.qualcomm.com, enderaoelyther@gmail.com
Date: Mon, 16 Nov 2026 16:26:21 +0000
Subject: [PATCH v3 5/5] Bluetooth: qca: Power off WCN3950
Message-ID: <179484638195.54009.16877279504978739528.wcn3950-poweroff-v3-5@michaelmcallister.org>
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

