Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227782;
	b=TRnFZKy37RUxjwqFXAZWkHh2Ui4O2ACTySIyqkbZVdbt6kFo8QwbxIH/lGla3P2uvIAA
	 l2tIJqpB7YIl2tMdIV3Fa6oKP9L/WENmmUCu2VCoBDi6qsfZkjHRnlufnueMdnqScYo8l
	 kTykW32IcKfv52WNiHhHc5t3ijIzy4adX31hkAvImvyqzbiLIlh5OL5LUhaNMSFfDerJU
	 wkdsMQ+a0LGgQP75zYT1K+2Yy8HHk3ZC167HX2eAigKAwp0+fRXcVDz6ZRSADwES/U1Dg
	 AS9NXeADGa8z4P9ce1z67hVLZ3AoJaL+dnWjRU2sH3Gam1rC6SrgxyAY701kHNnmMnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227782;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Date:
	 Subject:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZabFNkWAWqv4s1QhbXT4Kzc6A3MJogz6MVSfuPt/7B0=;
	b=x81zEN94Gf6v/5CBCC9TRhst+ygp6cjsT8KUsxywpx1tgMaFz+V7E+c0MW5/7EuugqxQ
	 sVuTKS3HuUrydarbzKdffiT1D/RBEgfyhVYsa5RG2WzZ7IVMNfW354cBq5k1EL/9pVgAu
	 WbC8sU1yGtN2hZVoXytVr0w6/3xI3n5o9TDpRrpaSgbDRhZu7N6Iz8OX71LamdGtc6cVm
	 8EpI+Jp0QHKdO2Sdrq7awQdePDp/rd8uLusFXpbCJCbwNJXsWBcwjOwD6avBdBHsVAekP
	 tgSP2wMOvguj+QDVYTyI8vBN8xcFxnZsn0YvFXf0e06kCcbgxGYENKMpdeVOMw1s1ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=michaelmcallister.org;
	spf=pass smtp.mailfrom=michaelmcallister.org;
	dkim=pass header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=fXTETyX4;
	arc=none smtp.remote-ip=185.70.43.171
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2060A2608;
	Wed, 28 Oct 2026 22:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD2060A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=michaelmcallister.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=fXTETyX4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=michaelmcallister.org; s=protonmail2; t=1793227774; x=1793486974;
	bh=ZabFNkWAWqv4s1QhbXT4Kzc6A3MJogz6MVSfuPt/7B0=;
	h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fXTETyX4ecYTFx8kkm7a4FDc7TpVPxCF0aBXUPREb7Jp4x1Oa2Mun2Xwxj5XpssdV
	 wj5FT2b9awaQy9Q14PlhTaZeSh8IKjEw3/lgCkLRS2xr6BVfsP8vHVYcTzLh/wIY4y
	 dqg/NF9SdjNZieADoy9TD0gHSeubr6/SFCOfCdZydlPMk9af+TSfZCniGilO6KE0+j
	 dLaB9ppaqE1mozSygQkIFWjwQSlDLR4hYhhCgh0eZZ1Zfsl8ARu9I1ijhyErs4cY0W
	 5uYWPZppDYQfG4L9AKSGhWdVkBtMwvahXodKQsULHOOLOPCrWVZcplFhhYshfR7026
	 H4oR+beCvTWCA==
X-Pm-Submission-Id: 4jFMxS2dkMz2Scmh
From: Michael McAllister <me@michaelmcallister.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-bluetooth@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
 Michael McAllister <me@michaelmcallister.org>
Date: Wed, 28 Oct 2026 22:34:38 +0000
Subject: [PATCH 4/4] Bluetooth: qca: Power off WCN3950
Message-ID: <179322687811.94538.13174359204402286337.wcn3950-poweroff-v1-4@michaelmcallister.org>
In-Reply-To: <179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
References: <179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
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
index 3d688ab75..540014182 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2249,6 +2249,7 @@ static void qca_power_off(struct hci_uart *hu)
 	power = qcadev->bt_power;
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
@@ -2269,6 +2270,7 @@ static void qca_power_off(struct hci_uart *hu)
         }
 
 	switch (soc_type) {
+	case QCA_WCN3950:
 	case QCA_WCN3988:
 	case QCA_WCN3990:
 	case QCA_WCN3991:
