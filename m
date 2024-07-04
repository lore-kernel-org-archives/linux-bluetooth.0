Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A031A3BB0
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720081208; cv=none; b=oJeR6olQJvZK2zt8O40KZKFlEXD5/1k3FYsdj7feyoE+qPFh7O1Lx63/LpYzZJH/udohtT7ZMRhLybVk7Hdt3KS6ZL5/3wKa+38xsSqeeDZIVI8mt0SFcvXsVuKIOPx2wH57+IyU/7coycm6/TqQcx4mKwZN5p81+2a736aaihQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720081208; c=relaxed/simple;
	bh=ktr3Ivhr+PI1sj8NgM36iawQcE/mCylj63pWN7LDSaY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZF1Nf3TpB+TsMKN5tyt9oAgyJBkVD0QiZCd6HeV++MGemzMsy/+Zzbwwc6Z35ntkMCa+zuJHnpJVLoPohY/pxQLZILHF96/6RRvrqPcLfw/UoqpVedv8GmcW8jJKeMf1gOrVgxkUsQ2fKk05DJ8X6+sc7JtLZrw1XOXdMIAZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7E9B20005;
	Thu,  4 Jul 2024 08:20:04 +0000 (UTC)
Message-ID: <d7c41cc6422da3e024280c055661833411c6e847.camel@hadess.net>
Subject: Re: [bug report] Reproducible pairing loss after reboot / Mediatek
 RZ616 [partly resolved / probably not a Bluez bug]
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Jonas
	=?ISO-8859-1?Q?=D6zbay?=
	 <usul@gmx.li>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 04 Jul 2024 10:20:04 +0200
In-Reply-To: <CABBYNZLrATLZaE756Guu9K3nGxGc3aVzSuxOiLw9icsO5+QXww@mail.gmail.com>
References: <4cb7ecc4-2bf0-4403-a995-7ca3817be4cc@gmx.li>
	 <CABBYNZK2xgDZ-bkxE6L-5Yt9x3PDKT_swDpN1=HAD9PC_6QpVA@mail.gmail.com>
	 <c0b60ec6-08ef-4391-856d-14f60f33af9e@gmx.li>
	 <CABBYNZLrATLZaE756Guu9K3nGxGc3aVzSuxOiLw9icsO5+QXww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Wed, 2024-07-03 at 13:31 -0400, Luiz Augusto von Dentz wrote:
> <snip>
> @Bastien Nocera do you happen to know why gnome not register a
> pairing
> agent? Ive seem quite a few reports of things not working after
> rebooting lately which hints to No-bonding pairing happening or
> perhaps fedora uses main.conf:AlwaysPairable?

There hasn't been a pairing agent in GNOME outside the Bluetooth
Settings panel for more than 10 years.

I've never seen this being a problem before.

Fedora uses the main.conf shipped by bluez with no changes (except=20
AutoEnable to true, which does nothing as it's already the default):
https://src.fedoraproject.org/rpms/bluez/blob/rawhide/f/bluez.spec#_196
