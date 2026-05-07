Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F3640FDB9
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164935; cv=none; b=HZB58Cn8IB7laH+dFeI678Vt+TkLm5hmhasSZF8FbNm6AxzEwdzkQaBj3kiFyoqEnjruCOQyyWRXMsytLMph+iILeUPzt616fJoA4QuyaPm6aEakv4StHRgrpWGZY7Z/I8SWW2iLFwd6UgIlcCiWaz20jAEwEWLwvrtQIqM6iCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164935; c=relaxed/simple;
	bh=V5hBfq45tH/SIvhCC430voTt5/GySH7aYt2asGUKnAA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNDNWs0cEB8XBKuBrWubeFACGErZJbuuYvBDv9hRh9nd+cyoenuUg1GnU7cvEoqcrGR8rjbOFukUc0lA7QMJgOgjQbZDiWQ0F9h2jtgrAhkY/HeDjX036+QrgEQREOKEhAGd+JJxDhAgRPU04yt/M/oSOw5Zoz9NMRv9d/66i2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA44F3EC05
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 14:42:04 +0000 (UTC)
Message-ID: <1bb345cc415a9718f7b51ec708dbd71af7eb2200.camel@hadess.net>
Subject: Re: [BlueZ v2 0/5] Add helper for "cleanup" variable attribute
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 07 May 2026 16:42:04 +0200
In-Reply-To: <20260506143220.3076135-1-hadess@hadess.net>
References: <20260506143220.3076135-1-hadess@hadess.net>
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
X-GND-Score: 0
X-GND-Cause: dmFkZTGl3oJylydonhk1DA9yuw16oltRcrXYrAzHHtnjewn9j/585FwBFh+hQQV+7P+ycCEEyse0nQrRv+XbB73mAAY98H8nuMnFbsk2F88Tq2IKvfzbt76+KVJXihzJZNN7Za2oEfhJ4EnAQSdvuSeIZhaBYIow9+swboP+1l6jiFbKVMgV7uOwMSmIT/xtzjQDq1abv2B4ZMVPFzR1gAiSBvJqw6s0dMhtjpLL31mS/tyjHX0WZSQrBniOggONSXb9nIgwmZqiSNUUPtdGQ62kuH4xNlOjoq+cWoDEWFSzvybJHwPgY/gWcSQkIsnNMOXqHqdoLrQAl+eIh6EzkBc/e/z2g3LHerBcvwk0hz5j0CIGKlTsyTV5GTukp5DtpPX7jjqlweFUe46bs5A2hWc0GW1bP+LNr1LKYjDyLJ0NtcDpCelBvzKHQGOV7bTzNz4zF/SXvVP+uRRgWWfXMdiADMo5mykl7f6hswHfZCNWDosVB2ceWPEknNb044Q9n2hy6xp61c3ppSWjOK6Pd8BukAsnmp57iQHyhveDxUd1p/8ZgB5KFILLh4aEIDB9wZL7MCupe41gCZPG/4xkTULqeG3UbQziQmAfKAAibrVSTg+J3I2qYs+SnTY0N9vEPTZABTh4s/gzYzr2PvvWCoc7xokTUOEBwVURypCRyWZ7dRc2Ww

Hey,

I've made some changes to this patchset locally to make it easier to
use, I'll send a v3 next week.

(the MIN/MAX changes are still fine to push right now)

Regards

On Wed, 2026-05-06 at 16:30 +0200, Bastien Nocera wrote:
> As discussed in:
> https://lore.kernel.org/linux-bluetooth/ed949f2550f79a4bef19bd482bf8b069a=
d5b7e0c.camel@hadess.net/
>=20
> Implement a cleanup helper.
>=20
> The MIN/MAX fix is here because it touches the same hunk in
> src/main.c
> as the other patches. Feel free to pick it up straight away while the
> rest is discussed.
>=20
> Changes since v1:
> - Fixed checkpatch warnings
>=20
> Bastien Nocera (5):
> =C2=A0 all: Remove more unneeded MIN/MAX macro definition
> =C2=A0 shared/util: Add helper for "cleanup" variable attribute
> =C2=A0 doc: Recommend using _cleanup_ and friends
> =C2=A0 main: Use _cleanup_() to simplify configuration parsing
> =C2=A0 main: Use _cleanup_() to simplify GError-handling
>=20
> =C2=A0doc/maintainer-guidelines.rst |=C2=A0=C2=A0 3 +
> =C2=A0lib/bluetooth/hci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 4 --
> =C2=A0src/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 102 +++++++++++=
---------------------
> --
> =C2=A0src/shared/gatt-server.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 8 ---
> =C2=A0src/shared/util.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +++
> =C2=A05 files changed, 43 insertions(+), 82 deletions(-)
