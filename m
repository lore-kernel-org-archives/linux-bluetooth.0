Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AC33E37A
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641089; cv=none; b=rya7A20Gms2WpmSm5arTfm7AOYpp3ZrbrAe/rk8GI6BFcFT7Z3povciOw5Tno+FBkw0jaOjlARYPoH97xUzMX5IH0CsVZMBnv9NSIfNEmFqezzpnoygMPTZXfrvdlXKdrg1ncHAENxA/xrajv+EzPAeZGHac1/cwhtSIWlPYc+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641089; c=relaxed/simple;
	bh=8tQDN7OnssdhWV5VueG4126AqmDU5gfkRVMSoeW8T6E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfK7OnbNbjPhNUO+bdDfzQ1YBwZUCdp2inhTlNIOhC+nq6NAisNJpfwFUVLGWSEpPWOH1K1xDrp9jPTg4tEEvK0NocA9Xu2FfzsuFGzCRkcs+rhhFHdN7yLL/DWkFks0+OgIhZJyu3vGNcUrkvk50kJSjK+HIDvTcvf756dZdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7F9541C06;
	Wed, 28 Jan 2026 22:58:05 +0000 (UTC)
Message-ID: <a19a6b2cc4b6639171f9c0588b2efdd99101259f.camel@hadess.net>
Subject: Re: [PATCH BlueZ v1 2/2] build: Remove health profiles support
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Wed, 28 Jan 2026 23:58:05 +0100
In-Reply-To: <20260128183454.545066-2-luiz.dentz@gmail.com>
References: <20260128183454.545066-1-luiz.dentz@gmail.com>
	 <20260128183454.545066-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtsgertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeevuedtleduteehfefhleeuhfffgfelvdejtdeifedvgffhtdetffelfedvhefhhfenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmeelsgdvleemtggufeeimeeikehfugemtgdtleefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeevjefhleehgeduvedtiedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhuihiiuggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvg
 hgvrhdrkhgvrhhnvghlrdhorhhg

T24gV2VkLCAyMDI2LTAxLTI4IGF0IDEzOjM0IC0wNTAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOgo+IEZyb206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6QGlu
dGVsLmNvbT4KPiAKPiBIZWFsdGggcGx1Z2luIGhhc24ndCBzZWVuIGFueSB1cGRhdGVzIGluIGRl
Y2FkZXMgYW5kIG1vc3Qgb2YgdGhlCj4gaW5kdXN0cnkKPiBoYXMgcHJvYmFibHkgbW92ZSBvbiB0
byBMRSBhbmQgR0FUVC4KPiAtLS0KPiDCoC5naXRpZ25vcmXCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEgLQo+IMKgTWFrZWZpbGUuYW3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoCAyIC0KClRoZXJlJ3Mgc3RpbGwgLS1lbmFi
bGUtaGVhbHRoIGluIHRoZSBBTV9ESVNUQ0hFQ0tfQ09ORklHVVJFX0ZMQUdTIGluCk1ha2VmaWxl
LmFtCgpDaGVlcnMK

