Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4433C538
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964717; cv=none; b=XvaC+S755sAdCs4sfAtbZZOuynD3MLHd0y7FoQG58FrNaQOfEA8OQs696zfnLkz/FiNZTJbcgKHs9J4JQiojDuGb8zl9vDqVPWrxykwzKH4jx36f8Mohk593ObcLn2A0iPqoT8x5lfLLDBUTMIBnLqdoDQ6a/E6XdCgvm1QDWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964717; c=relaxed/simple;
	bh=ahTLuY5UyoTmUQapV7Dvhui/eIjSDp4W1HwmsIUYNiY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PSSnETH3DzTYrYjAMNmLa/8lAfYdZnpThkhYjNN5tQzyJjP+oqkrJWz8760brgha8uqhRAb/YMZBy9s+q0Edg1F8TgbdWk3BPcV/vgC48m2qRmbHE31nqUM7dSTJPY855RAme9jH17QPDMtDHz439lf3kOsn4FUBgOOjt+GtxbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 901595802E5
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Nov 2025 16:19:50 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 26D674439E;
	Wed, 12 Nov 2025 16:19:40 +0000 (UTC)
Message-ID: <5d3f39aff71b4ab1aafb8bd5e0f2a890358371bc.camel@hadess.net>
Subject: Re: [PATCH BlueZ v6 1/2] shared/battery: improve the display of the
 charge level
From: Bastien Nocera <hadess@hadess.net>
To: Roman Smirnov <r.smirnov@omp.ru>, linux-bluetooth@vger.kernel.org
Date: Wed, 12 Nov 2025 17:19:40 +0100
In-Reply-To: <20251105132414.82057-1-r.smirnov@omp.ru>
References: <20251105132414.82057-1-r.smirnov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfffjghftgfgfgggsehtqhertddtreejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuveeivdetkeekgfefffeftefhjeeikeetffdvteejheefieeltedtvdeuleduleenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghloheplgfkrfhvieemvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefngdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheprhdrshhmihhrnhhovhesohhmphdrrhhupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

Only thing I'm not convinced of is the name of that function.

On Wed, 2025-11-05 at 16:23 +0300, Roman Smirnov wrote:
> +uint8_t bt_battery_filter(struct bt_battery *battery, uint8_t
> percentage);

Looks fine to me otherwise.
