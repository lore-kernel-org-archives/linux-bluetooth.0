Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4023B0;
	Mon, 23 Jun 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671732; cv=none; b=ouCJbyoO/hDMECYW4Jz5/FwLMeUh8iV6LDyun4VKxiQIgvefBXj/sNHgTak0edx7ijI04xTYXnuBXzwsCvlPa4kV1AYDeFLsBs98fYhMVbtMN8nxsxmg45QJwQZbYLb49kp1tLKU6aYbRLZKrr4Hz+bhoxgYmKtXGGIeRGVRP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671732; c=relaxed/simple;
	bh=zg8Bm1nJ3n72haYuanW3wHD1OHofFJcCvT5MkcMeXcc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qpD74ofqjvVYoqszR4b1MrWcLl1ZE5JW1XghmRMmnumZywXDQLpVOTn8zvIAHwLAb6ihcPT7JXDZCOSgnbeGKGa23MSEh0wYLa9/fahOBPCbAY1IgvujQSCZlj6OeGoJOMyTeS2ZgraAMKHkkn8hr9roUKqFQy5fSSsH9Rbj8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B792B43B09;
	Mon, 23 Jun 2025 09:42:07 +0000 (UTC)
Message-ID: <4ea897245e112fc5a5fbba3d3f34e6f7f51be8fa.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth btusb.c: Add pr_info() for logging.
From: Bastien Nocera <hadess@hadess.net>
To: "Sumedh W. Jambekar" <linuxsumedh@gmail.com>, marcel@holtmann.org, 
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 23 Jun 2025 11:42:07 +0200
In-Reply-To: <20250622165753.65461-1-linuxsumedh@gmail.com>
References: <20250622165753.65461-1-linuxsumedh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduieeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugihsuhhmvgguhhesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhth
 hesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

On Sun, 2025-06-22 at 22:27 +0530, Sumedh W. Jambekar wrote:
> In this commit, the pr_info() call is added in the
> probe function for logging purposes. This is done
> as part of the assignment in the LFD103 course.

Do not submit junk contributions to upstream as part of your course
work. This is a burden on upstream, and you failed to even run it
through checkpatch.pl which would have shown that you used the wrong
spacing.

This is a good way to get blocked upstream, don't send another patch
unless it is something that can be merged upstream.

>=20
> Signed-off-by: Sumedh W. Jambekar <linuxsumedh@gmail.com>
> ---
> =C2=A0drivers/bluetooth/btusb.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 9ab661d2d1e6..5ecb9a61a33b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3858,6 +3858,7 @@ static int btusb_probe(struct usb_interface
> *intf,
> =C2=A0	unsigned ifnum_base;
> =C2=A0	int i, err, priv_size;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 pr_info("SWJ changed the btusb driver in the Linux Ke=
rnel\n");
> =C2=A0	BT_DBG("intf %p id %p", intf, id);
> =C2=A0
> =C2=A0	if ((id->driver_info & BTUSB_IFNUM_2) &&
