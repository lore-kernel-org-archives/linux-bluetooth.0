Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C711F2E62C6
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2026 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881237; cv=none; b=EADL2AKNkqMfeJxn8ThAFLZtNHQhqga9O13yOWVWSapsnbEAx1+vPk1bAraKu8cri2ONpWvPiRDDbNLf8bCZysCmNL5o6bh00Bey84Or9koU+4zSOpkHz/8SY60iGLIMaDiFwDIyF/2PKu7ECmKuJXg9DD1olakr3qWhhFFsufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881237; c=relaxed/simple;
	bh=1EZadMils4DQyzFsbMFwWkR5pY+3pv0uNYeeazVyAv4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BsqbMRu2/2tP3g8X9NYK7ou/lR21PdN9HD+5AftPbpZrBPIuOeWD8ux1zyorcSgaD0cEYxCfZtRu3goVMiWCaWu/QWh6YSFDc7B2B0eHC5l9dnrz9FiSrFDirxQ8NA9QzG1zGiBhuCVTXBcznAiU+tgRXhe2S+4+j5b9Tj+gCJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B478E3EC23;
	Mon, 30 Mar 2026 14:33:53 +0000 (UTC)
Message-ID: <7bd00a7f42a0d3aaf9d3d0f3a0bb1d9877fc351c.camel@hadess.net>
Subject: Re: [PATCH BlueZ v3 02/20] emulator: btvirt: allow specifying where
 server unix sockets are made
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Date: Mon, 30 Mar 2026 16:33:52 +0200
In-Reply-To: <CABBYNZKt7POxvoJw7k0J2YvH4rpx4rfhrJ8+D9XgQwBFxKASuQ@mail.gmail.com>
References: <cover.1774214693.git.pav@iki.fi>
	 <41d54c33641f8a6004b3cb9a616c746119e2b156.1774214693.git.pav@iki.fi>
	 <ed949f2550f79a4bef19bd482bf8b069ad5b7e0c.camel@hadess.net>
	 <CABBYNZKt7POxvoJw7k0J2YvH4rpx4rfhrJ8+D9XgQwBFxKASuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGYTRiwFMT9R34a9iFtiT2bwTe0jc6lOm9pHNvZhSUAL6xJiVhZM7Qj4CujPynu5jcgcgkGcwa9yWvOJbhRnQvOGBvXynVNX2aONbabX9beWSrnHp5XAgKzm6dNpl1sGGe2aerMFJ0RPiU0ymoiSICeRf5m5j8045bfbeL93Grt6q0jGmhHJR9KSpW0rNtutw4aMFViQZnkxavSDUBle5eUqUH8eL47gN6ysQuzU527l5/TRp6k1W+sEgin2AvoB8sgjM8PozcXiYEP1nxx1tmw98usXKMOvNomBLpPuq48OZt8uSpcBQm43eYBrWmjZxmAk3cLvqq1n1rFlShRSDHiBIfHmeLmL87j0FPrn4iT83VydvREtweH44mimmJh47KwCbeOABBDhGhsmlcuvMcp0eW9PXdloisrExlGY8Df7IiCg5Rdd6RXJe3ZY3Upd6PTTgNS4ciTOSf33owDI3GuIbycvWjpkXRjQ+hwaW7dIPS1mYAXo2iN38qk8T/Pi0JG5TZg39zeNqA8z7gM5K2nDAu6L2tXOSM0WtXVOVup29d7eIxxPwCrg9pHYMq39YoGKcQDnaJ0LSLvW8yVG3NIP4y6SVVVA2Je5I5+wheHk3GBAWRBcH8iZs7XOUdfVJEg7Mg5+hZhmiGGxGPz7PmY1tnplEtFpG0gly8t1Gklkw

On Mon, 2026-03-30 at 10:01 -0400, Luiz Augusto von Dentz wrote:
> > If we were allowed to use new glib calls, this hand-rolled code
> > should
> > probably use like g_build_filename():
> > https://docs.gtk.org/glib/func.build_filename.html
> > and g_auto:
> > https://docs.gtk.org/glib/auto-cleanup.html
> > to simplify the code.
>=20
> Don't really want to drag new dependecies.

btvirt depended on glib's headers. I've sent a patch to remove that
use.

>=20
> > Luiz, could we have have an update to maintainer-guidelines.rst to
> > reflect the current guidelines for using or adding glib calls to
> > the
> > code?

Do you want me to send a patch to the maintainer-guidelines to explain
that glib usage is fine as long as the binary already links to it? (or
needs a robust mainloop, as we've seen recently with btmgmt?)
