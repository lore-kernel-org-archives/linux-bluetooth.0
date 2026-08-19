Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8FE3A1A22
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146966; cv=none; b=BKjvyo/XExyhi2Jy0fy/+hJQqXDR+CfyJKa2FNHG6Gc4KkhM7Ta2BTYSg06gAeDl+C0NfeyXg22+P8E4GHNFTqnygi1JJKiTONKcSYL5ImcFDq53mXEpgaFFpz3iWcEntPGEayKU6tNxGkUVH/7jwDXMFCEOQFiSnM1ezvV1wvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146966; c=relaxed/simple;
	bh=R0wX+2LiySZDmv64dZkMZ5MCYzZJcLLMC7e9O2b9igI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f4pBqtU4vnd9RMPST6UlITmoV5SewBmH7U1KvAJVY2CyhdMlxH+Rmodl397T+G77nbRAJpbtln6FId8WnTcmDPKgYb83/t1tJB20mpwTznNTzv+n/6nHYMvKOScm/9nrnIg4cJoVO957606lF0iMO7yN9vAReufzkqjs0bywJiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A5931F416;
	Wed, 19 Aug 2026 13:42:41 +0000 (UTC)
Message-ID: <d1caf599c4dcfb863553293e443ecb8aed3ee9f3.camel@hadess.net>
Subject: Re: [BlueZ, v4] avrcp: Fix Out-of-Bounds Read in AVRCP
 GetFolderItems parsing
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org, shahbazovelman97@gmail.com
Date: Wed, 19 Aug 2026 15:42:40 +0200
In-Reply-To: <178672800963.3885098.13548471500210922609.git-patchwork-notify@kernel.org>
References: <20260814140155.3155081-1-hadess@hadess.net>
	 <178672800963.3885098.13548471500210922609.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTEdN2zdJxSsLLRQ5gSohRBaOYGi9ArAn30OxFHMeIV3TPlIdJwgbpUqZVpjlUECuJaMVcgWDUgQf4nED/zZg6cl58i115CG+wR8G5OdC/Ag7iDnLttGx18PTAWRKYDSsxhDLE1Z5YV/RvFOAcEz2heewU6Xwj2BGSWlSu/KmNc0AhWevDTW6NF7Vrs7uP/c1Fv2EYxucquITIgVq/MGKQH0KE4emF6DMtPM9nMJMGwHOkOswT1MrJ5twhaWSz+rDhmhCKw1R7SS5ixn2XPS0hfx7svWGmtDBNcBZfmxbKOOSr6Y6IxRNhtBpTmGAbz1m3Ml59PYK/ckPXGcYzxvzsiccGpIBtolA0l1cZJK6TiB3jhxv4dq6THgbbylLQZ2bNdRc5p907lYe3nnao/rqo4z91nmMmeI4F8hE64IHyBfRE4Gec0gI/1nd7b036nppS4H9grsG8fivVAprLlFTOwcw17fy1XNGq0vJCQBoS7WvGWOeLZ/icjLm8Thswu5SDUSPKzYDAOLR0/JPCv2jEvsrG1OJkWQIRw9Y1sYsynZf8Dsj+bfShZK0Qm9MHwxG6SC5AP8BnjbGGWTlVmsRUkixGg/YJvt8SNe7WgQvhY2wusubyqvsLTwCRAQ48/dJoT5Zz2yBvg0hlyIyvtANT7bKw9iBcoFNz11O4nTN3JKrQ
X-GND-State: clean

The security issue that this fixes got assigned CVE-2026-75032.

Distributors that want to fix=C2=A0CVE-2026-75032 should also consider
applying "avrcp: Fix media/folder name not being set", which is still
pending.

On Fri, 2026-08-14 at 17:20 +0000, patchwork-bot+bluetooth@kernel.org
wrote:
> Hello:
>=20
> This patch was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>=20
> On Fri, 14 Aug 2026 16:01:18 +0200 you wrote:
> > If the "Displayable Name Length" is much longer than the size of
> > the PDU
> > packet we receive, then we might try to memcpy() past the end of
> > the PDU
> > packet.
> >=20
> > Be careful about clamping the name copying to the smallest of:
> > - length specified in the PDU
> > - left-over packet after the length field
> > - size of the string we'll copy it into
> >=20
> > [...]
>=20
> Here is the summary with links:
> =C2=A0 - [BlueZ,v4] avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems
> parsing
> =C2=A0=C2=A0=C2=A0
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dbd8989620ed6
>=20
> You are awesome, thank you!
