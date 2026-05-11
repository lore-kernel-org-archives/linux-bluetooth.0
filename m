Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D739901A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485480; cv=none; b=WRmr/pCyT1EFT26ZEnlE868iF+UZ6rjsgXFhhSYFxR7m8tmPIqLqYVZ2GuBakKhlH5fHZNaLVrfL7u342XsKhlda/vB/bj7Oal+/i5ED+8lG7PMZqjQkO6DU1d00jDbGVtkg181sCw1Xl8oIEaetLy1i2umgFv+LfFEynD8JXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485480; c=relaxed/simple;
	bh=AjXgtlK8eyeOJ3YVWX+CIDLLJHZqZbJqrJQb+or0aCw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nLJOnWNUxxVkNf6ZFWx9PXphHuURVt+ts4WWH6HsVR1KRs6vTy64VdNvbv4ls15GX2Zf9aqex+hmnNINz4fkY6WCzF4fmWjceGIBJOVhr+v4sMK0k8s6okP2fW8pFfXoVc5IYogw505iqVowdVQDB8cT8Taay87UAykJ3Qd1rks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C295C3EC72;
	Mon, 11 May 2026 07:44:22 +0000 (UTC)
Message-ID: <99b4c20de30a2991509b78db7751bd78044ad83d.camel@hadess.net>
Subject: Re: [Patch] support libical 4.0
From: Bastien Nocera <hadess@hadess.net>
To: Funda Wang <fundawang@yeah.net>, linux-bluetooth@vger.kernel.org
Date: Mon, 11 May 2026 09:44:22 +0200
In-Reply-To: <1445e90e.ded.19e159db7d2.Coremail.fundawang@yeah.net>
References: <1445e90e.ded.19e159db7d2.Coremail.fundawang@yeah.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGmx4qsYcC3ntUTv9hT6/RBRw9DW5UYKELMLtrXcCFSehzJgq+6q/Sh5OKnSrYXpIEwXSpOZUt3ylICqUdAS3ePvzsWlBJM3psmIm8CERWqAGJF1fl00zm5nqU9pEieP85jnZ8etxnZVwB1wbyYRXL75BC/pIpz8ugv8atUOhP4I6/mUGdtlbDlGebJDnVAUD2uJI0mUEjhgt4HqUFhd/1r0bLXd1jgFzrgg++cSmqX7wNW06MLSiDYHzVSljqWfP1FOb7tj6OAIybflOPUQNrFyUj3z7g09/56VGyfXxKqy5WNFEiIGOUKa7uJun6/18/OpbeUZ+KZ+1jH2QuUBP8PEXSLY41fWRjFzxlqanNUzJLdGyf/uo7dVyvFjXK1micqFhVFMLOsNOnb8cWbpoCqu2mYFDnlXrtWsYVtKXGl/4uHC3XaNNlAOLE9pvn10mjMeoT3yFajDqXcdEIKa5r4Hrm1f0nDntt/wY2pJUJY4L/iO0tqNpFWcUwLYNcxfo7lZA3xsMIuwQ7nnlp1M95V/vvEYEfqbt1WUXYyGky9cKFFKnj9i+O1Yt9p9ymL5Rc0BDtbQQ8PxjZMzTURficgrdEQKCMF0op7vGH3LWQIpaD3EqqFnyH18zAf3T8W92fYg8ixXG2hWES/e7MEZtvIfAP0mA58s+3IhYf9QOwflQ

On Mon, 2026-05-11 at 13:58 +0800, Funda Wang wrote:
> Hello,
>=20
> Since libical 4.0 [1], pkgconfig files of libical have been splitted
> into several files according to libraries. The libical pkgconfig
> check need to be tweaked to check libicalvcal. Patch attached.

That breaks libical < 4.0, which is still the current version on most
stable distributions.

And please follow the instructions at:
https://github.com/bluez/bluez/blob/master/HACKING#L98
for how to send patches.

Regards

>=20
> Thanks.
>=20
> [1]: https://github.com/libical/libical/pull/988
