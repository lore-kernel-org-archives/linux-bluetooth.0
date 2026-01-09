Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72C359FA0
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961237; cv=none; b=eF13fErrTSL3qnV9yF1qGk/fzZG87Ju0VV/34IaGHBjXGJmJdnb2EByi6044Zsv+Qh4sGqf6wSRAfZrF/lOLixBh4kYcnhSZoX5G/8HC1KQ6nIBQGVVmnyFnDq/k0gi3UsYRTFFRUXO2xyQgk9ewwTeJ0LvkZ7pjmZaMuaKiWQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961237; c=relaxed/simple;
	bh=qDe+OLsAKVXuVbj0hQTpwTVN7JjlnC8H7asOId7zQGI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBOuo7N9vHophzzqTJ+pDnfeq+O09kqd4/2HKPXSGnznHDI6VNPqdCRpMxvMJuXsQWoXdMDjSauBHbt1Yj6zPoIriYShkLpwA/XH7iU0xrONL/jEFAhx4pOQRi+seKABzX/kiduDfAy3m3JZ4isPr+bddRit8Nxq8izNodoGyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 85D6D580AB8
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 12:13:57 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C985442E1
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 12:13:50 +0000 (UTC)
Message-ID: <899ffb43f3e2c5e7ebc96e520c8cde34d8bf982b.camel@hadess.net>
Subject: Re: Unit tests speed-up
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 09 Jan 2026 13:13:49 +0100
In-Reply-To: <6960d7e2.050a0220.19a744.39ee@mx.google.com>
References: <20260109093602.1224918-2-hadess@hadess.net>
	 <6960d7e2.050a0220.19a744.39ee@mx.google.com>
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
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkffuhffvffgjfhgtgfgfggesthgsredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepveeutdeludetheefhfeluefhfffgledvjedtieefvdfghfdtteffleefvdehhffhnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepieevleekheeggedvgfdupdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

RldJVywKClRob3NlIGFyZSB0aGUgc3BlZWQtdXAgcmVzdWx0cyBmb3IgdGhlIGJvdC4KCk9uIEZy
aSwgMjAyNi0wMS0wOSBhdCAwMjoyNiAtMDgwMCwgYmx1ZXoudGVzdC5ib3RAZ21haWwuY29tIHdy
b3RlOgo+IAo8c25pcD4KPiBNYWtlQ2hlY2vCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFBBU1PCoMKgwqDCoMKgIDE4LjYzIHNlY29uZHMKCnZzLiBhbiBlYXJsaWVyIHJ1
bjoKPiBNYWtlQ2hlY2sgICAgICAgICAgICAgICAgICAgICBQQVNTICAgICAgMjEuNjQgc2Vjb25k
cwo=

