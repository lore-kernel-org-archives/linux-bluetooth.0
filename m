Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E406D27E
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642530; cv=none; b=lAV7lCYiCrqrgAsBwfUAH4jDlFh+DdAdUcsfKN2O6uiy6l2nssvnDlkaCjA9xr6BJpJi7F+JKSL9TvfgLrQlYNXePeZXlASoQ79jSJrHiwWuMstX7i5VyyRotrppU9Qq3jRQVvdAeUyIEfuEsIeyGjYhruztGv01+NFUDKLFcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642530; c=relaxed/simple;
	bh=R8mFVIgsDktyrK8i9dlmwNUHAGHpVB7bw1HSEssU8h4=;
	h=Content-Type:Content-Disposition:MIME-Version:From:To:Subject:
	 Date:Message-Id; b=mLletYqR+B3j0sWEw73eVyK4IfdC8zFkmxY9FU2jcw7jsbz9VDkNkTdelKHjcnay+HgNUma0KyOD9vX/q5l5ckoEp0pt49IwTzM//KgSh9gv1mD+N7DhYXTs6cNx1mkkZr/xIyiVElPA9yjCsqtnFKD7v1masMoo60RoMvPQf1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=neverlight.com; spf=pass smtp.mailfrom=neverlight.com; dkim=pass (2048-bit key) header.d=neverlight.com header.i=@neverlight.com header.b=XX86DvF3; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=neverlight.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverlight.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverlight.com header.i=@neverlight.com header.b="XX86DvF3"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <jason@neverlight.com>)
	id 1t3P23-006F5t-U4
	for linux-bluetooth@vger.kernel.org; Wed, 23 Oct 2024 02:15:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=neverlight.com; s=selector1; h=Message-Id:Date:Subject:To:From:MIME-Version
	:Content-Transfer-Encoding:Content-Type;
	bh=R8mFVIgsDktyrK8i9dlmwNUHAGHpVB7bw1HSEssU8h4=; b=XX86DvF3hkSPcNjaixmfcb4mQU
	PUGY5v6zP//65KMfjdqpAIZqIw0vOCuq+AKl6FmKEUnnBZWsAZhnx4/jjAVWwGfE/9g4HVflrv7es
	tMp+mz4DY26I40nY95dmjA8pho8aiGx85B0kprZEysJsN0m/fhy9NxBAOStd5GF7OiRWE5OBILkjT
	/x6n/0pAQG6/yYOkTwkROB8GiSBNa6TjYEnMxS8bKKFysgPsY7UWiSChsRXSUvBfp16MWiaVpopDP
	mRaEA9cXnRjaXUxgOBnzsNoI8fGt+W4/ndS2ZLXRNTA0APfIDIqp+PthKd7XkMyEGZ3hZfp7Pn7dw
	6ALVDmBA==;
Received: from [10.9.9.128] (helo=rmmprod06.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <jason@neverlight.com>)
	id 1t3P23-00031w-Gi
	for linux-bluetooth@vger.kernel.org; Wed, 23 Oct 2024 02:15:23 +0200
Received: from mail by rmmprod06.runbox with local (Exim 4.86_2)
	(envelope-from <jason@neverlight.com>)
	id 1t3P23-0007iU-Ff
	for linux-bluetooth@vger.kernel.org; Wed, 23 Oct 2024 02:15:23 +0200
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from [Authenticated alias (1090948)] by runbox.com with http
 (RMM6); for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 00:15:23
 GMT
From: "jason stelzer" <jason@neverlight.com>
To: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>
Subject: speaker issues post 6.11.2
Date: Tue, 22 Oct 2024 20:15:23 -0400 (EDT)
X-RMM-Aliasid: 1090948
X-Mailer: RMM6
Message-Id: <E1t3P23-0007iU-Ff@rmmprod06.runbox>

I have a set of bluetooth speakers I share between my laptop and desktop li=
nux box.

It's a simple Bus 001 Device 003: ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bl=
uetooth 4.0

Since 6.11.3+ it no longer pairs. Rather it times out, and I see no sound d=
evice in either helvum or bluetoothctl.

I am a little unsure what you need, but I did build a mainline 6.11.5 kerne=
l this AM and it behaves the same way. Let me know what info/logs would hel=
p.

