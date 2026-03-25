Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FC38D692;
	Wed, 25 Mar 2026 23:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774481425; cv=none; b=i7BUJ7qoc9zLv8+JAqWbgIvWDKt6jPwKHlkx6F/bk4ShHUQu1CwvX+664GqBCr5jOXdX0kD5Vco+F74SjkMOaNFNWfYF5nznQtFf0vRR9Lvuwi2zkleRNUi12pKk4f1br+/r8WA6ezjAsdPFOH7hp2IQbXaHbk5qB3h0uChQfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774481425; c=relaxed/simple;
	bh=PKA6JAuHhBofd17Peep9P7qPZLwQxKZ//Y7wX8WEbCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=T8ThbHlhnNw4kD++jSQhi/ffkgskXlakAL5dVB9QsMGv/nNZw8XRpaU3wpsTWafhyQRmeHWcZfU3llHX2Y2BTyhWsdeoUcf7yEivJkXqyi/bvWBWWFGPAET2Jzq2lDSiWxNA78c2KuOTs7+x9QkcQHNjAWCTqWeQaiv3tDr9lHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=AUfx6m1s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZncT+Hns; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="AUfx6m1s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZncT+Hns"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F0451D000E8;
	Wed, 25 Mar 2026 19:30:23 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 19:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774481423;
	 x=1774567823; bh=tm2ZuqonHhwc/DZnu4lLR/17g2z6GdlfDUz3wXwZcYY=; b=
	AUfx6m1s1UrD/hxxU85wqzRwIsLOPY6d8zUx6WS2ELengu+FiqoQKj8XR5zV7T4o
	G/vd8JxM6xqLAN2BhosYntWQmQ3xQDkIVeAHjrvMyRZGu2WX4o+MrCuVA5bKkusX
	ZrMeGiCkNNg6BJFiAL89qdAO2EtBKM/ckeJZekiVICQ5yeQl7vFTZ2y5J7gtm5s+
	9gqPDO5CwXt3uaH1PzR1nvpWFpJUFVEZHEqPP0dcolw9//JD0QZFjcwX0q1Z6Q3Y
	vSYvAbbCbHopF3cgJa2pPAPOxBz5lSEikOndF+5LfkaFEekwRtLBFQcHsE8ePU7Z
	QzLwTkU7lZzVXRhuzDWAhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774481423; x=
	1774567823; bh=tm2ZuqonHhwc/DZnu4lLR/17g2z6GdlfDUz3wXwZcYY=; b=Z
	ncT+HnshrXyD3B/FhrkPEiG05cZYIcZomErJCr/l3AqLxX6BB7k/Oqer/MGfoM4u
	aJ4R9uxq8y8nZAAKSfkVthk3IIEdkvd+KgsefXU2b33jJPxvRZvOmIIrQ52TzpYX
	0cGxk/yBD5fuH1PHQvMZp5XZPzFrsvp2bqqSe1zjpxX4NKV+GvL+HUOSt/o0L2s/
	EB0VsvFLce+A8MG1qRTOijnS1MiT2uTXBmG6if7zCBBKB6ll8jQjPBJ3zEoMZKJU
	wh5vBAJalQ20Yt30ufr+VmleLzK3L0b6F0G/PHzb10nK7zXn/uqM7Dzp7MzymVoh
	bNzfBmxK6emGECgJYglqg==
X-ME-Sender: <xms:D3DEaQ3CrYHmLaAqE7Z4TJzhCNJZLU1iyBN9iC7iOE-ljby0gHGPyw>
    <xme:D3DEaV4h3ljUHiZbq17LAH3MutSTzHj1FbZboXsGTNiImw2wcp2HEtHI0Iy2jf1IR
    q6qSNb9BNYXO56qxM5YcjcUtcssx4D77NPyGqycFOKZTH5pOwQ8yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthejredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnheptd
    fghefflefhieffveevtedttdejudefueetvdevvdfffeegffeludevgeehteetnecuffho
    mhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehflhhoshhssehjvghtmhdrmhgvpdhnsggprhgtphhtthho
    peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhgvghlohhgihhorggttg
    hhihhnohdruggvlhhrvghgnhhosegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohep
    lhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrthhthhhirg
    hsrdgsghhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgigvlhhnrghgrgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggv
    rggurdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgvughirghtvghksehlihhsthhsrd
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohht
    hhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:D3DEacU6EYrH8JbYYkD-MdgkrTAO0x0mdi7R5efC3bhQsIAHSqc1Yw>
    <xmx:D3DEaToFNHiD0IMO20sKM_5yxm-L0PTYSSmwtF9vy9lHqHRyt1Bxxw>
    <xmx:D3DEabAtbmSc62SW3FkeZNTso0H28NGzZgN_VjNlpzKbMJn0KHIa-w>
    <xmx:D3DEaXgLOFfOfEZkEAczEuhRC6AvFB-J-RwW_QXEuFDTn0ozWlcUKg>
    <xmx:D3DEaQcvSTK6LM5wGYem9PJIhvpYgDgcZDtYdqubJiDZajN2yyHTCMPj>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 52AE01EA006B; Wed, 25 Mar 2026 19:30:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Wed, 25 Mar 2026 17:30:19 -0600
Subject: [PATCH v2 2/8] Bluetooth: btmtk: fix ISO interface setup for
 single alt setting
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-mt7927-bt-support-v2-2-b892a3252880@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ryan Gilbert <xelnaga@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=floss@jetm.me;
 h=from:subject:message-id; bh=PKA6JAuHhBofd17Peep9P7qPZLwQxKZ//Y7wX8WEbCU=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxHAKikqVsqs90XfI7kOR65NCQmIpNqC4i3mJV
 u27IvXeY9OJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacRwCgAKCRC17sMLqGd3
 H6fTC/9K1VUX6xnS5nqN3/Wh1LeBdDDKZcuoO9OKzpc0/NRBMCq4MiKh9nWAaPikN4+IDtYCk1a
 Fo7fzwM/Ad/kj2x5EsZ3iVAD3WCJCz0+/e3BQ6M9NubY4vkvlHk7/3U6btTHmRN4aSorlxUVpLo
 nbPesfbMxVTIkMK88qKJsRfUluUu0u1wUbAmludcooUPuptw4OL27JIA/uP3NkURoW95z8ya+V8
 +sIywaFyqcOsHAzqg6dBIEfAYK31wipBaFKr19Gh/klvfIQ1vSoXnTdQscLWQ3XlB+Q+BwLGfmL
 VUcG1XxXEOl1P7e4btSSlZlL3NjgUGOYGB5G7R38wpdS7JfVYuqV54oadKQjt2+ByFnpuiJJVQa
 vcC9jDY75GRDTzb3fYckL45qXM4WFdIugcmKBafWno1dGLNKcf8Q2DdWLEtR10zBoTvP6zMUJhm
 bbDdoeVSElZ17wf5W1F1dXpT2k0DWhkPrOKF+eMcrpjSIewu0Vcn7ZrpJmM7w88WASlbc=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>
References: <20260325-mt7927-bt-support-v2-0-b892a3252880@jetm.me>

Some MT6639 Bluetooth USB interfaces (e.g. IMC Networks 13d3:3588 on
ASUS ROG STRIX X870E-E and ProArt X870E-Creator boards) expose only a
single alternate setting (alt 0) on the ISO interface. The driver
unconditionally requests alt setting 1, which fails with EINVAL on
these devices, causing a ~20 second initialization delay and no LE
audio support.

Check the number of available alternate settings before selecting one.
If only alt 0 exists, use it; otherwise request alt 1 as before.

Link: https://github.com/jetm/mediatek-mt7927-dkms/pull/39
Signed-off-by: Javier Tia <floss@jetm.me>
Reported-by: Ryan Gilbert <xelnaga@gmail.com>
Tested-by: Ryan Gilbert <xelnaga@gmail.com>
---
 drivers/bluetooth/btmtk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 13c6e45deede..06ba0dcd6527 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1013,7 +1013,8 @@ static int __set_mtk_intr_interface(struct hci_dev *hdev)
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

