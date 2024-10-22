Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B619F49C
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608190; cv=none; b=OXrjaVDCGqnVkQz8U7K/OfshEXFjRo63I0q32UYMqAX0pqcl7p+SNLivkt/YqiXAsBHF3NsV1oXap4sLldEAFr/ejLfsNGUlWyVpq8Cke23kH0mHiLh9EBrrm8Rnw85LFapH/1j/kzCVd/2Gji/Akuopj7brGMYHqDi3EzReciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608190; c=relaxed/simple;
	bh=yw5UvG6vPyZrcvdt8qvl9B4dTg4styLPkM2rZpMCJHo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hFKM2YOHRbe/R9oAGgAdrLNiMW06gOA+U4UKlKC8uRvAc79xfp1WuctgYi9OFtypuPfif9jQ3ytq0IGteX7PPhfUG5eb8j6/ZpveztogS+9RhING40taPabg2hm8kmmA2+C45LzXy4EkvyqQteVJ3nr4EmYyqXWxlHvLyVO4T1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CC7F60002
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:43:00 +0000 (UTC)
Message-ID: <3fcbe2eb3daea4bb2978af5c2b5fcc1005c0a9c3.camel@hadess.net>
Subject: Re: Fix bluetoothctl --help hanging if daemon isn't running
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 22 Oct 2024 16:43:00 +0200
In-Reply-To: <013c686bccaeed4984d9f102d9849926dc1df811.camel@hadess.net>
References: <20241022120051.123888-2-hadess@hadess.net>
	 <67179b3a.c80a0220.2e9cba.83c8@mx.google.com>
	 <013c686bccaeed4984d9f102d9849926dc1df811.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Tue, 2024-10-22 at 14:40 +0200, Bastien Nocera wrote:
> On Tue, 2024-10-22 at 05:31 -0700, bluez.test.bot@gmail.com=C2=A0wrote:
> > This is an automated email and please do not reply to this email.
> >=20
> > Dear Submitter,
> >=20
> > Thank you for submitting the patches to the linux bluetooth mailing
> > list.
> > While preparing the CI tests, the patches you submitted couldn't be
> > applied to the current HEAD of the repository.
> >=20
> > ----- Output -----
> >=20
> > error: patch failed: client/main.c:3187
> > error: client/main.c: patch does not apply
> > hint: Use 'git am --show-current-patch' to see the failed patch
> >=20
> > Please resolve the issue and submit the patches again.
>=20
> Which patch is that for? The error message doesn't say.

Figured it out. Happy to send a patch to the bot if somebody tells me
where its code lives.
