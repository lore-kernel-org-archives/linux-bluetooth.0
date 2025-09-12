Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0C168BD
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639211; cv=none; b=HLXFoo5Qd69AER6YI4T1bzWjvCAVakS5ErDkDH4tAkhae4zpbsnUq3vqBPwJcL+Yn4BVNB+47w0mrtUjAPAnwtHXqqoTctxflBI/na9tN5qgfAe8DnatytFsYU7GAQixoZ+y6Up6VGXNBI+4+/GGjt49w0c7hJVcZEXVMg8eUoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639211; c=relaxed/simple;
	bh=reZixicf+fKhTcvbMpTWxyoAKljwqGsYJQpYPxHWGQg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jGEkYRYYIOkKTulDFnLuwks4khNFQxQF5CrNtmFCAEcrlv/6b/dMG32nmJSjGlr6Jp9TO6df3FOPOSCBQRQZELMP7hKCEKh6+qR4eGVnRiQxkWjVJCbf4VtEFDhC+QNNV2Giew3t0gtcIwJVBRaX0OWYZOcQK6WUBmpJIj604vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EFn8c+ZR; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EFn8c+ZR"
Received: from github.com (hubbernetes-node-46e71a5.va3-iad.github.net [10.48.220.97])
	by smtp.github.com (Postfix) with ESMTPA id 8B6FD4E082F
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 18:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757639209;
	bh=12M0gEXA/aizyxkgJn7nO0oHAMg5Vwx6ovpPYPH/lUE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EFn8c+ZRzKS7m8D0ydnWXGZdCvFi7beiiVEwY7ECFS7Pk8ILq/j3MkPtasDWz7KUQ
	 Qjsmc1u2xL+IYVJ6YTdrNeY2MgtEwC133TTlorTdzW61T+t7iztEReLZ9hakP/eTYY
	 7WQl9dE6Zm3PnlLLCZ085SsZqdXk6Us6K8fZ6HhQ=
Date: Thu, 11 Sep 2025 18:06:49 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001555/000000-9ddeab@github.com>
Subject: [bluez/bluez] 9ddeab: transport: Fix build with A2DP support disabled
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1001555
  Home:   https://github.com/bluez/bluez
  Commit: 9ddeabfc7d7e6228fef78a0b018fb41b99885387
      https://github.com/bluez/bluez/commit/9ddeabfc7d7e6228fef78a0b018fb=
41b99885387
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-09-12 (Fri, 12 Sep 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Fix build with A2DP support disabled

$ ./bootstrap-configure --disable-a2dp && make
[...]
profiles/audio/transport.c: In function =E2=80=98media_transport_update_d=
elay=E2=80=99:
profiles/audio/transport.c:2653:33: error: implicit declaration of functi=
on =E2=80=98a2dp_avdtp_get=E2=80=99 [-Wimplicit-function-declaration]
 2653 |                 a2dp->session =3D a2dp_avdtp_get(transport->devic=
e);
      |                                 ^~~~~~~~~~~~~~
profiles/audio/transport.c:2653:31: error: assignment to =E2=80=98struct =
avdtp *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer wi=
thout a cast [-Wint-conversion]
 2653 |                 a2dp->session =3D a2dp_avdtp_get(transport->devic=
e);
      |                               ^

Reported-by: Arun Raghavan <arun@accosted.net>
Fixes: 0bb66d3d1abd ("transport: fix A2DP Delay values missing from DBus"=
)



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
