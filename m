Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DA33C1AD;
	Thu, 26 Mar 2026 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563191; cv=none; b=I4dHK3S41hWabgOMbmzvU0RlOwM1Hp/tO8219yWuYFhvxJ4RXhyApPvC5P5V6xdM28tO1AHQFcvv6M4+Naj4b4kiDHtrW2LqPg00XU8MP0hQ0XWKQa4exzBaPXEf4PUlDkLJZ3Q6QJeHB+XSHDW5W2NszP+PRoknsPuxAcO6NwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563191; c=relaxed/simple;
	bh=vyqsuG+xMWp5r+4UqeMvlmZYwWcpk/QUCdD0Ktx12jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=m8VWS8328qFmYGT6VuRdXHpSEw1vCf0oXzAMmslEj/I3Os8IkWE4fFVoMeNtDGsnfaPNFFcWdIYL+mQ0VDyvPzjPTIhcEhG0oCFy9vl5A/w4WMib9BcADe7BpZbPYhlXHRKeFd9BqgcGKqCsDjZJSkaZrz1wOjDmBxEtD6yYev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=POa51uTT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bb0HDali; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="POa51uTT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bb0HDali"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 40F311400280;
	Thu, 26 Mar 2026 18:13:09 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 18:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774563189;
	 x=1774649589; bh=c/sc9PqOP5aDWCbebaeriZ+L6SbJzf0pCMQUibPtrdE=; b=
	POa51uTTkWpYhe4YF5HPuyp+E0L2ZV6asCtOxQha/JqZjFd2/GJvg1yt84QpcxuL
	X2FfmrQhFvbf3TCk3WdV7yH8TGDh6iGpZlqO3zUy/Xoa1neLxS4WzDI3qLisMmdL
	Nf/MTFM+AxsRUHwdH5A6DzuNuKcaiCl87qIJLZUhNiggraAnoXel5iXFRSWfTAWI
	QHxOK7R/Ym2jxAs26EVBQDYxvHTEcnbNakpbVCeBqm5AtynRy6uGETuytYbC9bXc
	aL6g5Qi28VR+JZBOTwie7fxh5F1pPjAkiMiUrv9ZafXKGoeygjDn5TdWbIoIRGl7
	0loBmC5TXP2r22oJ7xZ3rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774563189; x=
	1774649589; bh=c/sc9PqOP5aDWCbebaeriZ+L6SbJzf0pCMQUibPtrdE=; b=b
	b0HDaliy1p62b3y/rIoK6c+x51UP3kthW/CnS22xBQGXRi46kruY8YYMUcNuA6sf
	SXAbwizmAR6D4eOJIjDK96u0xFVmQuPJTEqTOD/YnlxFn+RvdN9rxYEFOqs+8oz8
	b8wHV9VzgRNFEJRSKD9+kUHcL/i9nxPDwjXgc5RyghEbpDDbyez3Z4ZozTSXhzKH
	Hp2PAWpkYY/1kq4ojLyxs3FFakYN++V7mVpnXYN98naUcTIH1/8KvZrx28pPvc4a
	V5KIEa9f0qYy2f4xHHCJJeC4m5+zKI8HjngweeIfOwDUzzx78UrwjjC7bP4jmeqt
	RMJeRIiRyat9OJa1eXE9g==
X-ME-Sender: <xms:da_FaYrUSy1BPoVUS8KMtegbSBQzWGjHre3M4X2BkqCtuwkLTqQeow>
    <xme:da_FaZdOBOGhWneYozyhBcS5VJL_adfIQBO2c2KGFY9IAV8F2PnrvsIvHZiaGoWGs
    mUAS4KQ4hC54inIMHvWoYLWEPrAgbbZyb4YfwFTz95tTM22ZvJ6YA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:da_FaUKSyoCXSbHVbAkJ1MyV_u9n7gkhN_Uf-taqmsAO6QNHxbFqhw>
    <xmx:da_FaXOT9BbWrc2ILACv_F0YmmBl_UNSJ9X2ihXh19rySoeR-Fipug>
    <xmx:da_FafXxvYYLG1z6GbcGvE2ysURzRmhA1RLf8MUZW7F6mFRpUYQzhg>
    <xmx:da_FadmaIGORfrBPC9kcyC26bn8SVyREB5C38be5yaQKG1tS-ZGiwA>
    <xmx:da_FaQHu0byvMvrWmtzWleXHIsBj3uE6vTWSSBlDO_eKBRUctRieNd1b>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1B5BC1EA006B; Thu, 26 Mar 2026 18:13:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 16:13:05 -0600
Subject: [PATCH v3 2/8] Bluetooth: btmtk: fix ISO interface setup for
 single alt setting
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-mt7927-bt-support-v3-2-fa7ebd424323@jetm.me>
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Ryan Gilbert <xelnaga@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1384; i=floss@jetm.me;
 h=from:subject:message-id; bh=vyqsuG+xMWp5r+4UqeMvlmZYwWcpk/QUCdD0Ktx12jc=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxa9vnNeIgkcFvVYWCjalmAp4NNE1jOUDr/QL0
 XvgY76y+CuJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWvbwAKCRC17sMLqGd3
 H+n1C/91CTJlh3xtD/NBx/OnfHnX5rITmaoOC5orPA6FwDZnKpKFRvPRQb3QFwboxgiMZwVL1Ma
 6Dc7h3Xuga0HhMCmp/DW4TXzIkg7mR4Ul9ytqTBnuDuRREh332E8cJaeMNaPt8heKksWthfaVR+
 ULGvztC68IGk0J2rlbyIahHH1C1grLr1I+n/AzsegAP0E25wR5Tib8p+xKmlT50/Xeyg/gU+u9D
 E5jPjyEDrU3TiwKSbvgrl0zKsmKrc9X+ubzlc2ZLE2eCb0wJCp1etbD6IqAj8n+7klg/bu24yoT
 N4C0gTDnizDDC4+mLrwpzP2RKU2Mny61CFF3oWD4FsEw3e0O2tEwRHsvbEq4XKRHsFDCKe9uHvk
 ML1+gIS228KHTyaZtICKgbolPOB7U/X1NHuWqp7WG7PUHM3iR+sA2qB+ktHZe1fV0Kj11xbGyzw
 13gLkgytVqScilGi6kVh4UXaw8w4lqMsPBezr5d8inHqaGX/6U1/YM7SdOoaJDXDnfCqo=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>
References: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>

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
index 3f12f2ab6369..95b09b1ea78f 100644
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

