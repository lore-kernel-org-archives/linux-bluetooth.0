Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E4845DF6E
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051084; cv=none; b=bTTdQUQ/FKkaeQTlPiPrJOEeKEEX+Ul8ywUJYW1MtKkui5VpdSWkjmBnpOdV2EUVvv5Cf3AO1vK4euiOHDclxirxZWyILOWgShbY+oWJZiVQsvlMi//71jQuyJxwNNjotcFUU+3Ur5tPhlv194tnzOZOQoOJscdOwL7sd7q24Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051084; c=relaxed/simple;
	bh=A8BQeDXvl3zW0UsfQiN/q+NLyDRNpSxcvbVPBeHfuTw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uaSrUw3QbQmA8/NET90rI92hgtqzqP28zIy2TGu+G/oAtBxKrtJHMrkgbDgV1V0cEBZNO61qmphaRG0KpKqlaEQxluli3uhjKAzMObQgd378eynyMX/tIpzQGV0ooU7T3cKc0MEyU5qsLOStW1eb6ULMRb0KsVIz8vUseZc+CsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A350A3EC25;
	Tue, 18 Aug 2026 11:04:33 +0000 (UTC)
Message-ID: <4a1bb85f481bb2fc0d863cd2c84e9b03d00d1c14.camel@hadess.net>
Subject: Re: [Security] Patch for stack buffer overflow and heap OOB read in
 avrcp.c
From: Bastien Nocera <hadess@hadess.net>
To: nathan auvray <nathan.auvray60@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 18 Aug 2026 13:04:33 +0200
In-Reply-To: <CAB6rVYfCF5+jpSTtZ8u+S4LxCZ+kGudm3OWU=-fCMbZJnYDZUg@mail.gmail.com>
References: 
	<CAB6rVYfCF5+jpSTtZ8u+S4LxCZ+kGudm3OWU=-fCMbZJnYDZUg@mail.gmail.com>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTFlqnjtmC5sgNXayHfjyoube5kxoCtOixcpyBXAjZKuASIMmjQAhM/tQI/JAcmuJ/ZVV4gV0H+SwMxiQ7JkDnyESpJt4uY2CJL7rxHhzh0vGd5rtahGxu2lb4quTnZUWTLa6nZ8DgqYd+zlcFq6VS2BJ8ry/xPsVMYA2BTE/UMl8w6errzNa5i96J9XFzvfRcvAD7iNCi90040BSwKV3cuz46BlgNhZVcxkrrAgh+XON3n4/914PIpWaIZbQEbJrYjQ1F4br4/nizdW6sOkM7pT4Uv39iauA7IbdNwK8oAUer6ryAXGzcAu0j4YKQcenaLTwonzZPsBNlWY/UnR+kOyBug6Rte7kmJP86a4Y+Idx4yqvwAtaSxAXZbzqG3f4IcVyBKqod96Of82uXmZZjXMIYP+9X3UrFdrCuVLN0ixsUZ9KNA5jPi+KuVlhNyn6mtOYhkCzN57NYNy2eK2RYnYZSSA9oxlusdtuixn5F9eBQNtfpQ5cIke+i4qfCHVZ4Fhr8Scy/GRcYjRYUDy7tcnEmGiOOoOR+9EbyQfYRvHCaCH9Hn8xiytI6JK93Nz9TXIoh5ZFSFzjQS86dOGqt3NtWlfktlcFZgrWwpk7W4jSSrkoXbA9trWhET2aPHrZ528Jkosue6ch2vUFFmbGIpIlFp+yFUwKq5qx9YajdHJJg
X-GND-State: clean

Hey Nathan,

On Wed, 2026-07-22 at 19:53 +0200, nathan auvray wrote:
> Hi,
>=20
> Here is a 2-patch series fixing two security vulnerabilities in AVRCP
> profile response handling (profiles/audio/avrcp.c):
>=20
> 1. Fix stack buffer overflow in avrcp_list_player_attributes_rsp

This was already reported privately before this patch was sent, and
more comprehensive patches will soon be made public.

> 2. Fix heap out-of-bounds read in parse_media_element

This was already discussed and fixed upstream:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3Dbd8989620ed=
6e80755f06cfdb18f5b4a3913493c

In the future, please use either the security advisories functionality
on GitHub to report the security issues privately:
https://github.com/bluez/bluez/security/advisories
or email invididual patches with the [BlueZ] prefix, following standard
kernel patch submissions, to report them publicly:
https://www.kernel.org/doc/html/v7.0/process/submitting-patches.html

Regards

>=20
> Best regards,
> Rapido =3D)
