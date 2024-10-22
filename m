Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96651537D9
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600848; cv=none; b=CWtD7fUWSGxxr17VlVTXpOylJjt28L8+6ygsbIpLrbVWVvnaWTmxVV+FpbM1+6akziPoGGYcISoYPRC1OthaaNtX//+0q4FavUA1goGotn9LFsEoOEr4Q4tyt77pBhieSAs/u4CN6SR/EUgAN6cTpYXWETlZwj6C+KezFGZvYT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600848; c=relaxed/simple;
	bh=kI1+uZOioEPRSX/vdG9LZAi3pENhri2kR4tftDIcnRY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxpBJaQXU/c2td3ReEty7qxFyPfO9HQLaj0TodTic5qk6P8tQwJZdKoVCId//gBppOFAARdSqsPwxH8WRAgBq9qGOwu8pqzQAiY5Z8e6vfMOPoFUJ2dUMEEDKe+rgJ6F2x7hZbgJOVHezk0q+fYFbAjzw56XnJ/xz2pZ7YxrLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 275B61C000B
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:40:44 +0000 (UTC)
Message-ID: <013c686bccaeed4984d9f102d9849926dc1df811.camel@hadess.net>
Subject: Re: Fix bluetoothctl --help hanging if daemon isn't running
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 22 Oct 2024 14:40:43 +0200
In-Reply-To: <67179b3a.c80a0220.2e9cba.83c8@mx.google.com>
References: <20241022120051.123888-2-hadess@hadess.net>
	 <67179b3a.c80a0220.2e9cba.83c8@mx.google.com>
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

On Tue, 2024-10-22 at 05:31 -0700, bluez.test.bot@gmail.com wrote:
> This is an automated email and please do not reply to this email.
>=20
> Dear Submitter,
>=20
> Thank you for submitting the patches to the linux bluetooth mailing
> list.
> While preparing the CI tests, the patches you submitted couldn't be
> applied to the current HEAD of the repository.
>=20
> ----- Output -----
>=20
> error: patch failed: client/main.c:3187
> error: client/main.c: patch does not apply
> hint: Use 'git am --show-current-patch' to see the failed patch
>=20
> Please resolve the issue and submit the patches again.

Which patch is that for? The error message doesn't say.

>=20
>=20
> ---
> Regards,
> Linux Bluetooth
>=20

