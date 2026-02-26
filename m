Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5A309EF2
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099331; cv=none; b=eTH560bIGmGdxwYLmk8QfKBvnWG0MVPQdTAQSrra7n4R0/qEVpF2ZIc/vpDj8nPbMGRbes+74CnEBvfhV7gfuaK5lO8Ub9DAlFTyt5ObSDe2bqzeZG71wob5YjibwpixzYxh9uk6zVQN5UAr4IUNNKRKPC9o7mUAzaabRIjOjgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099331; c=relaxed/simple;
	bh=VLgToq60hL5uPvyF0fL91/695pPFEbqKAe8NB72y8WU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oy0skxIINMzDVSrOmrzCm6z7Ep3YjgwR00XbhKH2Q4W4tvPjRsDcQWMW86ZAgjzjth5a5Rgvg6NLHUYBDLUo+FlNjamnD4carcDGAxrUZVC0abrwA/YdbOocFRseeqlzcLFwekNaXNOA1PvdLSHmv+maHrKnOPiJGCvvYFst3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0CD441B57;
	Thu, 26 Feb 2026 09:48:41 +0000 (UTC)
Message-ID: <67a5cbd53a7b03bcfcbffd10916bec528087e645.camel@hadess.net>
Subject: Re: [PATCH BlueZ 11/12] agent: move defines and parsing for I/O
 capability to shared/mgnt
From: Bastien Nocera <hadess@hadess.net>
To: Christian Eggers <ceggers@arri.de>, Luiz Augusto von Dentz
	 <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 26 Feb 2026 10:48:41 +0100
In-Reply-To: <3672959.dWV9SEqChM@n9w6sw14>
References: <20260225161715.20394-1-ceggers@arri.de>
	 <20260225161715.20394-11-ceggers@arri.de>
	 <CABBYNZLgQWy_+gZmWXRmQx1g7P3pT3=ZLjFa7FuUnpWH4Huf3g@mail.gmail.com>
	 <3672959.dWV9SEqChM@n9w6sw14>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeehjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepuedtveffgeegudeuheejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepfedprhgtphhtthhopegtvghgghgvrhhssegrrhhrihdruggvpdhrtghpthhtoheplhhuihiiuggvnhhtiiesghhmrghilhdrtghomhdpr
 hgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

On Wed, 2026-02-25 at 19:38 +0100, Christian Eggers wrote:
> > Perhaps this should be an enum to ensure things like switch
> > statements
> > do check for unhandled values.
>=20
> also done. But now using an enum in src/adapter.h requires also
> including
> "src/shared/mgmt.h" in every file where src/adapter.h is used. I've
> made
> all these changes, but maybe we should really think about include
> guards.

#pragma once

should be all that's needed, at the top of the header in question. IMO,
there's really no need to start adding it everywhere, but it's a good
time to set an example on how it can be done when needed.

> Shall I resubmit the whole series or do you want to pick the fine
> commits
> first?
