Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DA31717C;
	Tue, 31 Mar 2026 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976979; cv=none; b=sTmm+zf4kl+J7IRu6hRO7S96eJ00sb2Fc2z/OKqv3IFTH0ufqjrd7Uo9OPrKGZtmwOnxKjYxZTGhIkSAEFd3AdoA+BPUxWFcQ4ygal0WqxoPSbjakqw4W0b4VaAns54baZvYkeHkr9Z0AVRIBQQey2Gulcfh0DmnHwrvzzx71OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976979; c=relaxed/simple;
	bh=BeW2hWsgHTDse1WiYc/ZGW8ev0c1HREFra5Yo0QtNu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=kRASvi70W6R4jMLCKgnPNlRbw9wa3mi6Dz7rXJCPrWTo4ptmhHgfLn85uHsr3TReT4UmKxnxJRyfECLRUdMoKoVikqHFnvD6WSPPiVMk9r6ttSqJDOR5SvNez+j7qZ9XpJw0mZXi2SfRYJ2KpsV3Xpqha4zEgDlg7CR9nLJE82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=kw3hxDU8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tZAyHXaU; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="kw3hxDU8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZAyHXaU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C03C97A0225;
	Tue, 31 Mar 2026 13:09:36 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 13:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774976976;
	 x=1775063376; bh=JQFTEDrfiAcnWN3PPrmbTznv/cFOH1dKZ+goNeN26I4=; b=
	kw3hxDU84W8i61kC5HUxPK3o84hYb2tEFvUn5TW9LbLg15lgCkglUUunaEZIMWmU
	lyzRzR8Dzo1U9ChmiUnxE8QbmU7ZcC8N6T5qVuwSg54yxN0fvlmxT32lHfF9hKOi
	5VYlqfWsSoX+qBCoOnIHlQFODJJGDy6anknpKm+oL2riWZycsDlTVYdwq2QQPeL1
	V8Z5Nifws6FXn8BNZDkMRr0x5Pvbc90IvZ5xx3FVZKblSW+K4ArO/CFiu/sjcIQD
	j3ZU9byYEEjSsqb1L6pIS9lnqjhnXdFr0IVNrPLPBh13snCbuHs57DESiJB2pnhC
	1GqLvtCqJG6q2M/8IDN0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774976976; x=
	1775063376; bh=JQFTEDrfiAcnWN3PPrmbTznv/cFOH1dKZ+goNeN26I4=; b=t
	ZAyHXaUGjhfW84TBELOJk58II/9WRKB1KHXLwayVGCqEI0D9mA5Lvzfa7pT7z38m
	7wARBLie2aDb0JcfgJJN4PsRZU031ZbtSTn9yyO9LQhN1lFVqZE/a1gB1M/wvKf/
	UfJRoVrRzXKg0VwZ5Flf0HPCi7NggyEnx8W9+Wp4cE84DJZ8rcFTJUparZXNX16o
	TFLC5duebj8wSPo6hqxRjTEqP44iSD49s6ZeUBDqMgn5BKodQZfT1Qv0J+U7JSd7
	cy94fADvN7CON1LvU8yGmZD5zGZ9Z7QvQ3pJlHhujcGvgyQr/LmB1hKPtm/DT2A/
	2tut6xj+SwC6h3pmUpEgg==
X-ME-Sender: <xms:0P_LaQ-8HgAZZm3zNpC3bRkbKyp6q8qhPKIXfgfKUVoOBJyKjrO7Gw>
    <xme:0P_LaThgbuVD3L8TO1i3q_PX1pIao9LmyekVfTTMcjknVg8Gs9wJG4GrxlgKQodzD
    iag8iU0MoHykI938BLotSrlV3v2he0WdNrQ2sJ0lTphWAejWg1veiSq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fohfffufggtgfgkffvvefojghfsehtjeertdertdejnecuhfhrohhmpeflrghvihgvrhcu
    vfhirgcuoehflhhoshhssehjvghtmhdrmhgvqeenucggtffrrghtthgvrhhnpedtgfehff
    elhfeiffevveettddtjedufeeutedvvedvffefgeffleduveegheetteenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhhlohhsshesjhgvthhmrdhmvgdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnghgvlhhoghhiohgrtggthhhinh
    hordguvghlrhgvghhnohestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehluhhi
    iidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsg
    hgghesghhmrghilhdrtghomhdprhgtphhtthhopeigvghlnhgrghgrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgrrhgtvghlsehhohhlthhmrghnnhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhmvgguihgrthgvkheslhhishhtshdrihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0P_LaccGCYQ5CJoLlRP0ZlGbGePLzuTcZ2WGKj0EEF9WCoQTEtV8_A>
    <xmx:0P_LaRSu11XNXF-LzFeJDhf0ApSpZMZUYooGS-El7UXCVV0fdPmu0A>
    <xmx:0P_LaYLuyIED_2_2xcfGu2zQ7scIE8B1W2qL7LULZqMobBCTRgAusA>
    <xmx:0P_LaeLQsD0kyj2EE7vdaK8Vx1Rp_gOLo5v7J1yIvtrtPU6CFYAhYA>
    <xmx:0P_LaU6nLIsZ3qCnPaVcQt9zvZ5slUCa-ucUDj7IyqOO7PJKDlkcomVA>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 64B881EA006C; Tue, 31 Mar 2026 13:09:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Tue, 31 Mar 2026 11:09:32 -0600
Subject: [PATCH v5 2/8] Bluetooth: btmtk: fix ISO interface setup for
 single alt setting
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-mt7927-bt-support-v5-2-6f31b4342daa@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ryan Gilbert <xelnaga@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=floss@jetm.me;
 h=from:subject:message-id; bh=BeW2hWsgHTDse1WiYc/ZGW8ev0c1HREFra5Yo0QtNu0=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpy//KzLI2ynp6LnsK7ukxs6g0PhwfnyavYRq+x
 qePMXxP+DOJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacv/ygAKCRC17sMLqGd3
 H+5VC/9d1bzG0rXRi9zr+mdywb2NSyf/kyrAMN1+7jfSnBFw+QNqHnQMgVlKvHNySuZAmCSgKgl
 QFgTHlamlpFClp8sAQJagpXXPyq6RUzSMGqzx9lQMsKzkzXp8NrcoryevkC/wGFP/HYNnXyiunp
 ADbThnvo04NlieYpWoQMThvcfHSVKCrVnuWzkTrBynhzxyjS63b5iJudBhD4zULx49BaDvJ10Vh
 faQJmRtjxmFn+xuj8M7PQe8S+NDyafNG7wDJGMm+ygMynHreAsNYqREOMmopjkDBYePXhSfovLL
 letHGPvEUVs/XD0NzxI0RSS4uv1sfhRZdvnVO2RkbLy8aoR8PUiUgsnQQU7HNNaYJF8wgQ9YNq5
 gDIMMy3EgZ8Chl0VLoSp5idokHHA6NsqKI13brgGVRONst5WBZPcypvtXFmkyCLXzLvtE40OuB4
 3EXLjCPcfq8ZVfEFAIIb4jY7GUGxSgD+F/4X/E3KGSU97jcYQn6SBSCAIVBC+qek1ZsO4=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>
References: <20260331-mt7927-bt-support-v5-0-6f31b4342daa@jetm.me>

Some MT6639 Bluetooth USB interfaces (e.g. IMC Networks 13d3:3588 on
ASUS ROG STRIX X870E-E and ProArt X870E-Creator boards) expose only a
single alternate setting (alt 0) on the ISO interface. The driver
unconditionally requests alt setting 1, which fails with EINVAL on
these devices, causing a ~20 second initialization delay and no LE
audio support.

Check the number of available alternate settings before selecting one.
If only alt 0 exists, use it; otherwise request alt 1 as before.

Closes: https://github.com/jetm/mediatek-mt7927-dkms/pull/39
Signed-off-by: Javier Tia <floss@jetm.me>
Reported-by: Ryan Gilbert <xelnaga@gmail.com>
Tested-by: Ryan Gilbert <xelnaga@gmail.com>
---
 drivers/bluetooth/btmtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 4af19b86c551..f8cff895f14c 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1029,7 +1029,8 @@ static int __set_mtk_intr_interface(struct hci_dev *hdev)
 	if (!btmtk_data->isopkt_intf)
 		return -ENODEV;
 
-	err = usb_set_interface(btmtk_data->udev, MTK_ISO_IFNUM, 1);
+	err = usb_set_interface(btmtk_data->udev, MTK_ISO_IFNUM,
+			       (intf->num_altsetting > 1) ? 1 : 0);
 	if (err < 0) {
 		bt_dev_err(hdev, "setting interface failed (%d)", -err);
 		return err;

-- 
2.53.0

