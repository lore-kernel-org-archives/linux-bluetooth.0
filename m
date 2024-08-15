Received: from mail0.khirnov.net (red.khirnov.net [176.97.15.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F061B4C2D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2024 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.97.15.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742787; cv=none; b=FGimEUHY3cuoqfygUUty86pqSQ87KzUSf1k9oGerfy5XapTqTWlqBZhVaVwE5F5KDlgiV/K1Relm2GRL9ZzrBCZjBkxGFH0XHEaeQ7Q3/BKomvKyr1lwswIP05U9C13PQT954DFbwGyl9sNBtbBrbFOTKlrxGrJ8f2bvDmPs460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742787; c=relaxed/simple;
	bh=doz6nAMp0xrB+OCQSu3TlGZYl0hEd9E+smySdBSm11Y=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:MIME-Version; b=JFiulyRkj9+o03kucYlYSugR9zr/FYBozYRqAN7aRh1DyEALwhXyfNT4t/n9DvA+eVzQVofivGIWue3zWHJMfntnf5qH0YOC4YAXd+kJv2sSVbCcxUCnCpQVk90ilzYGMfh17oOiEv3dC/aNuUao2scgt80ppJe6w00QYIumrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net; spf=pass smtp.mailfrom=khirnov.net; dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b=dvElqpfc; arc=none smtp.client-ip=176.97.15.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khirnov.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khirnov.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khirnov.net header.i=@khirnov.net header.b="dvElqpfc"
Authentication-Results: mail0.khirnov.net;
	dkim=pass (2048-bit key; unprotected) header.d=khirnov.net header.i=@khirnov.net header.a=rsa-sha256 header.s=mail header.b=dvElqpfc;
	dkim-atps=neutral
Received: from localhost (localhost [IPv6:::1])
	by mail0.khirnov.net (Postfix) with ESMTP id 85B59240DB7;
	Thu, 15 Aug 2024 19:26:12 +0200 (CEST)
Received: from mail0.khirnov.net ([IPv6:::1])
 by localhost (mail0.khirnov.net [IPv6:::1]) (amavis, port 10024) with ESMTP
 id ExhhcLQ5wtp0; Thu, 15 Aug 2024 19:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=khirnov.net; s=mail;
	t=1723742768; bh=doz6nAMp0xrB+OCQSu3TlGZYl0hEd9E+smySdBSm11Y=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=dvElqpfcOYejHphkz8n3Tlp91c0MOXLTZSdY8zJQOi+pwQc61iI6Bc42m9Qa8WbWV
	 t+QMUeXUmsJXjLte1/PQLp/IVkqEMBzVyguQo9A3IzERs5jQJv6J5CspopcVQJXtZy
	 cBtKpWNviuTyhy3XosrApu6Yi1FDsVVtSGvzNPq2SaPmulum3ttuzs4wuqmYL5eWJm
	 rJBLzNMc66wDZyyXRmBVt7ROU0Yq2CZJC7pjco4/urrw9cJ5gLarFO5oy3Gn8On4D9
	 w0sn//tpImnZ4++YV6v2Z9CdBRHQw8/S8BLK10x0F/Xzt6bnoWBw4bhLvwOBkxI1q2
	 y48O7FLlAwyWA==
Received: from lain.khirnov.net (lain.khirnov.net [IPv6:2001:67c:1138:4306::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "lain.khirnov.net", Issuer "smtp.khirnov.net SMTP CA" (verified OK))
	by mail0.khirnov.net (Postfix) with ESMTPS id 67809240695;
	Thu, 15 Aug 2024 19:26:08 +0200 (CEST)
Received: by lain.khirnov.net (Postfix, from userid 1000)
	id 307F21601B9; Thu, 15 Aug 2024 19:26:02 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject:  Re: monitoring advertisements from specific device(s)
From:  Anton Khirnov <anton@khirnov.net>
To:  Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:  linux-bluetooth@vger.kernel.org
In-Reply-To:
  <CABBYNZJ0OK=yfrzFneNXBD+ye8UF7w_5pLJah+Fyfr+XHefLsQ@mail.gmail.com>
References:  <172362641171.1463.1558884635182654862@lain.khirnov.net>
 <CABBYNZJ0OK=yfrzFneNXBD+ye8UF7w_5pLJah+Fyfr+XHefLsQ@mail.gmail.com>
Date: Thu, 15 Aug 2024 19:26:02 +0200
Message-ID: <172374276216.7554.15339600683100081438@lain.khirnov.net>
User-Agent: alot/0.8.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,
Quoting Luiz Augusto von Dentz (2024-08-14 16:47:27)
> Hi Anton,
>=20
> On Wed, Aug 14, 2024 at 5:14=E2=80=AFAM Anton Khirnov <anton@khirnov.net> w=
rote:
> >
> > Hi,
> > I'm developing a program that needs to monitor advertisements from
> > a known LE device (or several) and take action based on their contents.
> > From looking at the kernel code, there seem to be two relevant ways to
> > initiate passive scanning:
> > 1) performing MGMT_OP_ADD_DEVICE with HCI_AUTO_CONN_REPORT;
> > 2) using an advertisement monitor.
> >
> > However, it seems that 1) always enables the duplicates filter, so only
> > one advertisement for a given device is ever reported; meanwhile 2) can
> > (after my recent patch) report all the advertisements, but disables
> > device filtering - so userspace receives reports from all devices, not
> > just those I care about, which seems inefficient.
> >
> > My question then is this - should my use case be implemented by
> > a) extending HCI_AUTO_CONN_REPORT processing code to allow disabling the
> >    duplicates filter on request;
> > b) extending the advertisement monitor interface to allow monitoring
> >    only specific devices;
> > c) something else?
>=20
> Have a look at scan.pattern, it sets a filter which can be either the
> name or address using active scanning, passive scanning is only meant
> for auto-connect and depending on things like LL privacy being enable
> the host may not even see the advertisement reports since it would be
> done using acceptlist/whitelist filtering which is done directly in
> the controller.

I would very much prefer to avoid active scanning. Perhaps it was not
clear from my email, but my program is intended to be a daemon that
spends most of its time waiting for advertisements to come in. In my
understanding it's very undesirable to spend extended periods of time
actively scanning.

Also, the advertisement monitor interface already does almost exactly
what I want, except for the fact it forces me to receive advertisements
from devices I'm not interested in.

Thanks,
--=20
Anton Khirnov
