Received: from outbound.pv.icloud.com (p-west1-cluster6-host1-snip4-6.eps.apple.com [57.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE32D836A
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583234; cv=none; b=scke/Wyea4MCkhUfI8wldSDSQ+eTBJ7BaODl6vjX8MWAsqMY1IyFuKTheSEOYlKTGJ5aEJ52CaXGUvhtTkjIiruegCD8yb4VIGqdCLbrBSq86ndUndnK/aSpv57TdnERW6EudMOy/lBr38y6Es94PzRRodwbMpouvJhgU8xNNZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583234; c=relaxed/simple;
	bh=7UX3x/MHm8ZjEhi614uxqFA/BFt2lbZMabMPCyvqYC8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RHfzF7vUvUBcyldk+enXYizOUL6wqqSr1G5rokuuwondr+O3VGcrVFVSsEYj/gLmpvbskHq+hEwVXVYYKCpsbJLPhmp/nnlnWT0OpTxVWafn0Sjkev2324VA2lzueuNtEWXyaMX/+D+4/0yWGOxouUI/gKYk5kIwuCcozS+tfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uL4Fdflv; arc=none smtp.client-ip=57.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uL4Fdflv"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 2805D18002DA;
	Tue, 15 Jul 2025 12:40:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=Dw3ZIYMTrBoGuRyeavT9Yda8JQaDT00t/bCnCZ4BBVA=; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:x-icloud-hme; b=uL4FdflvoSA7DzAZbknWEh5PYleiTxNLrRQGA03K275gTNIoxlGrv0p4bpZ6t8tpumfAzwNFzmtyhnQ3HMvK4tXWfGc4f2F7U2etWlcHiSkqI8qFC5cJL99sdNl8MU11/dnW/Y+ISMPYrXumcyhFY6Z4IbVJrLj8t5wGQ8W6DWx9qH/Rp46H2hRTiCY5OQz1qcj3lQzGBuYOlPSEIbExstsRC03VDz3DoxpzJzB7w0oi6P9ET7yaNamZZuw0sHFmJV2htHpn8ocV25onp61Tyyr5LFreeqY5FGEE/dVkJYHppRB+veuOfGFHOdeiPGNYGUbT3FztbgNarUOsRmhjPw==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 0BFF018002E4;
	Tue, 15 Jul 2025 12:40:28 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Subject: [PATCH 0/2] Bluetooth: btusb: QCA: Fix bug and support downloading
 custom firmwares
Date: Tue, 15 Jul 2025 20:40:12 +0800
Message-Id: <20250715-bt_quec-v1-0-c519cf7a0e16@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACxMdmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0NT3aSS+MLS1GRd01TD5DQTg7REQ9NEJaDqgqLUtMwKsEnRsbW1AMo
 5xn1ZAAAA
X-Change-ID: 20250715-bt_quec-5e1cf40fa15a
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Kaehlcke <mka@chromium.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: u8f0fj4FADDj7nPwDL99JEKDPLzhnxSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDExNiBTYWx0ZWRfX6mbJcuxB4kRH
 Dla9Yw6lbxVcvhyXjlLz5nAAGkixiC9yX3tUcqYV/rFz6Yyu7C9JGBvtfoabJTVnO4gO77CxTXz
 HZ0LvWY6sKqfVzUsONv2GG5RMebaocS60ZKyL5tps5BVrdi/NRATcSnyP05L/hP3UkJuQmm6WvO
 CcQ8Lxk7Cy007SUQ5CkRPYQpj5/kBOO1PRsfKqSrX4MO2yXIe23j3S4mqOThMSXIkcVXFIiLj1A
 /uEKDoZXCMlD2rDi4GR+6ItetGZ4CBi3X6v2SbA8PfmLzwQ1fkjeOR3eCkg+i10V8aGWJ27II=
X-Proofpoint-GUID: u8f0fj4FADDj7nPwDL99JEKDPLzhnxSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_03,2025-07-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1011 mlxlogscore=776 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.22.0-2506270000 definitions=main-2507150116

This patch series is to:
1) Fix a bug
2) Support downloading custom-made firmwares

Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
---
Zijun Hu (2):
      Bluetooth: btusb: QCA: Fix downloading wrong NVM for WCN6855 GF variant without board ID
      Bluetooth: btusb: QCA: Support downloading custom-made firmwares

 drivers/bluetooth/btusb.c | 128 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 91 insertions(+), 37 deletions(-)
---
base-commit: be736f5f89d519e58057ee40c3e09fbfc711d4dc
change-id: 20250715-bt_quec-5e1cf40fa15a

Best regards,
-- 
Zijun Hu <zijun.hu@oss.qualcomm.com>

