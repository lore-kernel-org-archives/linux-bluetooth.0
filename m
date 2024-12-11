Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F5195;
	Wed, 11 Dec 2024 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733955226; cv=none; b=e02Ll8DTDm2nJw1Vyx8F36r4KchpnyeslzrZIlnI8VauRj3rB5Q922jOMqDyLnb7IkdlsX/McxXilu0O1qmNmCftr3Y2f74S0Dzyy0fGdkZO4eNG6VTkFKT8sqfPdX8GPcVK12+hWJdUo4PgBwBnimGS8qveTGkePAsw5xBNPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733955226; c=relaxed/simple;
	bh=q+FOrqG3gG1AxswsUGDqpOSt7PBcwIFozsaIYehD2eY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k8t10umuy4JgXPk1IthHPDvG9mxdG1ELvYGj3VzD/sacf4MfXAvr0W43fLsquAE0FNKJbdtnpha5fRMWoh5Y0t4ZzG4MBpawO2RCw23N1crwE8GBdvcp3m2ozut8IFclqek4w1uYkA/yWylyMgZIAkCoaY7MrWmg+MMzJjGbOl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=doridian.net; spf=pass smtp.mailfrom=doridian.net; dkim=pass (2048-bit key) header.d=doridian.net header.i=@doridian.net header.b=mcIleZeM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nr90kPZ1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=doridian.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doridian.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doridian.net header.i=@doridian.net header.b="mcIleZeM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nr90kPZ1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B33D1384134;
	Wed, 11 Dec 2024 17:13:43 -0500 (EST)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-12.internal (MEProxy); Wed, 11 Dec 2024 17:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doridian.net; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733955223;
	 x=1734041623; bh=b5blImECO9sDDWUloaXyT2Kn2WUa1fpKbi+hSvk9AsA=; b=
	mcIleZeMv5gY/LlGEwQRIW/+WExJinMuQQvoyqV2CMSo6wxr6nctY5vi51PFUzEo
	L6Pcv9s/qvLj/ylFZDkjAIW5cR466B813KFoOZxcp1cJjOzoo7Uf+M1JLY1UHnps
	lQ1bBbzaEelJjPHb3aaePscUxHSL0qw/FeZ/ZfX96CZm8enestM+Gdxy8k8h83FI
	25nFZGDxk++cgh7vpJkYUllmdX5I6bEAW5zk1rLwg++euQ+FT8/hrrvMHeDJSEZR
	HcDN4G+og04hHAemdIZ2xan0OyNU1q8SYGyhCzrESsDFOuH3EScgooEPl+JPIdWz
	4qoNHE4vxQoKEDyl25Y+uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1733955223; x=1734041623; bh=b
	5blImECO9sDDWUloaXyT2Kn2WUa1fpKbi+hSvk9AsA=; b=nr90kPZ1/P6778hT1
	8jm30+cdq+vHNbHOSIKGh0UnUGnr82FH+Ny14r/Jic0kqVnZk5OSlIA1226rb10P
	ucFnWOGfDriHMHbQ7iO025FyZ3379ROHs9k8i4lm/Rn4RQyFBDfuTsTzeRoSjrJr
	wTQLueG32g8Y/J9ElA86Da+yhfyWRQqb+T86c7FgAqD+bh1LYKD3MEff2EvEsykP
	64JwFX2n+r5jvL3Da2nYq52TA6TDzJFTaeZ/gFOWnULqaKnjEJ21jGpkAIKsdfAG
	ZubSXXI/8SxkjlgKN2oCKFV4/xON9Jj5YRjgztM7Up+cx8fRRcT/fKsNN1vqlo84
	6uu9A==
X-ME-Sender: <xms:lw5aZwhgprbYCqkKrGfJIeVZhmu4TRXf-Mo1IGuV0wnSM13Jj3IIxQ>
    <xme:lw5aZ5AvdP6-CaxE99LsU_2pyL_sauKYO94V8PX-m0WdKcOGj8Y4KJHwZMap0Kd0g
    gmlGtW5AKyZOu3uErQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhkucffihgvthiivghr
    fdcuoehgihhtseguohhrihguihgrnhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdekie
    ejteelheegtddvvefhfeekffeludekjeduhfelleevhfekfeegvdffgeejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithesughorhhiug
    hirghnrdhnvghtpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:lw5aZ4H4U2qrHw4gFVwv_Linv6XzagTlaMNBynpKkLrYlGqA859RjA>
    <xmx:lw5aZxQh1PBkqUYBd4bazTv97CIsy3TveT0B-IZ1aR1EziqasNoutw>
    <xmx:lw5aZ9zRvTK9NEP5jq96MYbf6nO3Zyv8ke-A7JZB_utso9MPDY2N9g>
    <xmx:lw5aZ_6eFOXeTGpXRblqceEZUpxFXBPOGmhxQoWHNKvIWzxTd5z8Eg>
    <xmx:lw5aZ-q6HhultHn3-45J4U15fPHtEs9YxltgwooFxzbE7284JNJT8NzX>
Feedback-ID: ie91947d0:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 112A829C0072; Wed, 11 Dec 2024 17:13:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 14:13:22 -0800
From: "Mark Dietzer" <git@doridian.net>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ef1099f8-077b-4580-9edc-2c0db2ebf211@app.fastmail.com>
In-Reply-To: <b67656e9-2111-4f36-950d-48fe64f30fb4@app.fastmail.com>
References: <b67656e9-2111-4f36-950d-48fe64f30fb4@app.fastmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add ID 0x2c7c:0x0130 for Qualcomm WCN785x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorry about the previous patch. My E-Mail client first tried sending it as HTML and then helpfully removed all leading whitespace.
Below is a working patch with correct whitespace (I hope)

Signed-off-by: Mark Dietzer <git@doridian.net>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 279fe6c115fa..20ba8ceff7d1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -377,6 +377,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3623), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2c7c, 0x0130), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.47.1

