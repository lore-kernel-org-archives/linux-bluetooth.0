Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15741373
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355617; cv=none; b=YhLx/R6madcSYWYg6s17pg1RPq7saxTR4c1vkIlXMmleAC/0Ml5nZ+uSosCs+9Q3Ayrqtme3wkYtHP2pL1UaSaUDmhOgs69YjuX3qcT1xtYIVr6xCCd6k4idmHzq6d26t1zkWhFFuOiXeuI2AqOC2gL9WrrJhgaH2o8/59QbS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355617; c=relaxed/simple;
	bh=4jwwWw9rMl/LEHZBQZdzomqHu5QBbRy+HnFXMVUINqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hg2C1uRLxcBjMaJ51bFCLcJ6FX2xgyuToChUpnvzi9bQBytWZXZh3nR3D3NXZn7uKCnjQXxwsjGHDeLXeZeSI/es+bSnwGYkqkLOz1e/eEjWRPz1QesDgrRGSmFapxjzzu0BGPw3pSA/m4cl42w5EpOa7GxC/wAhrmJCtzWK/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B89F443272;
	Wed,  1 Oct 2025 21:53:26 +0000 (UTC)
Message-ID: <eab80b6e8ac12df899391b08692676b4a5f27ac1.camel@hadess.net>
Subject: Re: [PATCH BlueZ 0/3] Keep component `bluetoothd` isolated
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Francesco Giancane
	 <quic_fgiancan@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 01 Oct 2025 23:53:26 +0200
In-Reply-To: <CABBYNZKz=EbmNcux7BkrbdvhSfQamDpt+JAJx16_i1nUYxvQng@mail.gmail.com>
References: <20250721152219.517-1-quic_fgiancan@quicinc.com>
	 <cb652fe10b31e3b8421df5a85a9151839598a3f0.camel@hadess.net>
	 <8ab1a298-c519-4013-b808-e707ff6f1a6c@quicinc.com>
	 <863117cb7a91e2ed7460f24b1b8b25b8b031829b.camel@hadess.net>
	 <CABBYNZLNTBinoOgaeZ3+i2D6tRXmuB=KGXxCrhu=3wOsPxFyrw@mail.gmail.com>
	 <4243f713-3bee-41a1-b718-ee0cdc2d8e9c@quicinc.com>
	 <CABBYNZKz=EbmNcux7BkrbdvhSfQamDpt+JAJx16_i1nUYxvQng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Wed, 2025-10-01 at 15:47 -0400, Luiz Augusto von Dentz wrote:
> Hi Francesco,
>=20

> <snip>

> I guess we should probably create a github issue or perhaps update
> the
> issue https://github.com/bluez/bluez/issues/989=C2=A0to avoid having this
> conversation lost in the email threads, also I may take the lead in
> doing the uapi conversion if no-one has started doing it already,
> since that may prevent people from using the kernel interfaces just
> because they cannot use the headers due to improper license.

For what it's worth, I modified the bluez meson port this evening,
fixed the client being always built (my mistake), and implemented not
building bluetoothd:
https://github.com/hadess/bluez/commit/f0e75d1a07efef82538c1b85d35a76b3a881=
8a2c

The branch at:
https://github.com/hadess/bluez/tree/wip/hadess/add-meson
can be built with just the library and headers by building with meson
using those options:
-Dauto_features=3Ddisabled -Dtools=3Ddisabled -Dmonitor=3Ddisabled -Dclient=
=3Ddisabled -Ddaemon=3Ddisabled -Dsystemd=3Ddisabled -Dlogind=3Ddisabled -D=
datafiles=3Ddisabled -Dlibrary=3Denabled

Cheers
