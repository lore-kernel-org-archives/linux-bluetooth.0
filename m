Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643803CE0A1
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654218; cv=none; b=Y/A8bAhJgHtbclF1cjuj5Y+/E1cBiT4wgdU9XQgrqRKweGy7dY9q4YMkcA0aW4CkANccVUpwS2PwLPVascxuLP612U6Y3svQQ7ib55JyhrTHRq/AugZP0ocRXFngEnGR3Vg3v/NGN9RcYOm69Jr0y6QCr11Es/PXX1+OGOFh7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654218; c=relaxed/simple;
	bh=JvDm3ISq/iCQmd2PIlLQIC3YPtBgZ7H005Sw7NeiZRA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDgMxxGnUwfY/qInNBxET1lexdFOsXsK/f3fXIixnb2T6Zswub1bsQGNzOQQaEDigLv/NY7P2aQWLC2AQYHB79A47TmfUGJsSJXrsJ3Wc64nyvmW66KBKZqWkPYYZYG0/3oyK6KvqLNW6lo6EMlIY2EjU1fEQYtMPRiaoXXpHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3C7E3EC22;
	Fri,  5 Jun 2026 10:10:14 +0000 (UTC)
Message-ID: <57c78e324bee2845f565144ab2203c309ca6fa4b.camel@hadess.net>
Subject: Re: [bluez/action-ci] c1b86b: ci: add verify_fixes and
 verify_signedoff checks f...
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <noreply@github.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 05 Jun 2026 12:10:14 +0200
In-Reply-To: <bluez/action-ci/push/refs/heads/main/80ebbf-c1b86b@github.com>
References: <bluez/action-ci/push/refs/heads/main/80ebbf-c1b86b@github.com>
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
X-GND-Cause: dmFkZTF8ySJMYgj6C9lzqDZi70jywdskRly8J7/3ajYCU0iM2xq696om/TowQWlMeP2buwHZ4PifqO91sEekcGXlggan9VniLAwrBu4XybGajSoTlfNmz2ovC6oMf6hgGyzP2YqkHSR37xXMhfU2BztsXVoQfM5DXjzNGPhv/Q8z3fAud/cbtG5jOvW0WS5GJRFm+0OJPAIOYL/XVu/sSvj3ag9ckiMOcl/dU49GX8P6Oys3XBcdD1/9z6gwlILramH6P60ZkLQVOsiY/nUBcBkWTj5DI8vMQry6LqoKzylcjGpUOboAdnBOSoaCVrCw0lWKlGgpImtlnRVE97hFMa6Dk9kQaPeCWO/grjQCr08b5MrleJ/QvP3afII1AOwhwyZrQSMt7hkL5l2+0O/O1uX4XFlLr7J6stYqfxJ5JJJxbFxQheRNdguxL0WOpBOWxSvPnTvbEcru2U8FOPs8xMG66KPXR3qdtJx6V6fq/IrTB921advFxSkRuCVTo8kV3lzpot4C1I6HJOodZCPM5OzsMsZ7kfiwBdulHGx9i0OPW52AL7sb1mXEIyIGh2UsfWZuc8ploY2JeNfqSxXgc74d3rhYyOnkqyEHbHgNSEHVRr0INmoFriGcyDt1rvl+gGJE9lYumGe5ATsqDM5xJs+nP6MVQp2pQOJ3pYstt6gV+ELHPA
X-GND-State: clean
X-GND-Score: 0

On Thu, 2026-05-21 at 08:48 -0700, Luiz Augusto von Dentz wrote:
> =C2=A0 Branch: refs/heads/main
> =C2=A0 Home:=C2=A0=C2=A0 https://github.com/bluez/action-ci
> =C2=A0 Commit: c1b86bca7cacc936bea82b3ca8b2ee4b4fcb6e74
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://github.com/bluez/action-ci/commit/c1b86bca7cacc936bea82b3ca8b2ee4=
b4fcb6e74
> =C2=A0 Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> =C2=A0 Date:=C2=A0=C2=A0 2026-05-21 (Thu, 21 May 2026)
>=20
> =C2=A0 Changed paths:
> =C2=A0=C2=A0=C2=A0 M Dockerfile
> =C2=A0=C2=A0=C2=A0 M ci.py
> =C2=A0=C2=A0=C2=A0 M ci/__init__.py
> =C2=A0=C2=A0=C2=A0 A ci/verifyfixes.py
> =C2=A0=C2=A0=C2=A0 A ci/verifysignedoff.py
> =C2=A0=C2=A0=C2=A0 A scripts/verify_fixes.sh
> =C2=A0=C2=A0=C2=A0 A scripts/verify_signedoff.sh
>=20
> =C2=A0 Log Message:
> =C2=A0 -----------
> =C2=A0 ci: add verify_fixes and verify_signedoff checks for kernel patche=
s
>=20
> Add scripts from gregkh/gregkh-linux adapted for GitHub Actions:
> - verify_fixes.sh: validates Fixes: tag format, SHA existence,
> subject
> =C2=A0 match, and ancestry (removed external Linus tree dependency)
> - verify_signedoff.sh: validates author/committer Signed-off-by
> presence

I haven't verified whether the functionality matches 1-1, but gitlint
already has support for verifying signed-off-by:

$ gitlint -C gitlint --contrib contrib-body-requires-signed-off-by --
msg-filename example.msg
1: CC1 Body does not contain a 'Signed-off-by' line

I've tried to integrate it into:
https://github.com/bluez/action-ci/pull/6

>=20
> Both run against origin/master..HEAD after checkpatch in the kernel
> CI
> pipeline and report results as warnings to patchwork.
>=20
>=20
>=20
> To unsubscribe from these emails, change your notification settings
> at https://github.com/bluez/action-ci/settings/notifications
