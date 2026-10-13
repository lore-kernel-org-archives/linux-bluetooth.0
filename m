Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E05651C066
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932745; cv=none; b=Voo31tyZedhAYhGW6pqyggNgqQ6Tsk8vve47Elt8H1RXfznwY/dMuza42W9Wu9aFkEOjgJ23ozNpeSeX5jSq6jAYoUMESfAPc+T/CluvSyXWJyjNl88Rb8bRwQB84McbTNVpheFhgYqYhsgOgQD5PF5DzOb0jIgqFLHQe7cJ7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932745; c=relaxed/simple;
	bh=8+ZzsnXVWMn92Qb0kvT83XdKbPB2Fr4B76Snp6Z7ZXo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WEU+MWd13SzFvKJmFXu702VbrXba1Pc5ATptw0WS+YBmOmdA/RjmtHPTjvBv5ML3kKxAwvi/z5ulB3FkIJA8cMCCmz8tRBAn3mlWzkQwEWQpRy9nKsN7FlqGdRP9KBtx62QJoO8VFpFBU43c0S7rA/8dn8hLA0yKicOjWobOy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=QRfJ5vPG; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="QRfJ5vPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791932743;
	bh=cOB7Pi8ss/5AcVkFFWibnES370v4GSo+A2WnaZ6Pglc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QRfJ5vPGojOGQkoE43qhHYDKC9pq5vPYcUxCuiCBm1DJIztLqplK4w+VQAd3crdM9
	 ZCH7WOr6BV/P6FVGub9gTMwH1NVlRbyysUDhWHKQduRSzsG1JoCkcun3rHRXgtG1VL
	 M1wd4dfY4xp/kaeChn9P6QWTf8gZKJ5PHfkpEDE2BZxSXG0sLjxRLPmkFkutFFFftv
	 ODkrFYFsiGxekiZ1wae+7PnBylr7IyT9km/0n74HBBB3C2ADUOsYvYZHdP1ncYUTYt
	 G+NMjJCeL8ASHPPBim7IibuQ4TLTrbU8b0IQDc4roO4CPcsz4ugGXg41XCyPbTNRbL
	 oufwH74sWMQ/A==
Received: from github.com (hubbernetes-node-8fb7d75.ash1-iad.github.net [10.56.200.65])
	by smtp.github.com (Postfix) with ESMTPA id B88EF8405A7
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:05:43 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:05:43 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1185114/000000-eab7a9@github.com>
Subject: [bluez/bluez] eab7a9: asha: allow LE 2M PHY on the audio channel
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1185114
  Home:   https://github.com/bluez/bluez
  Commit: eab7a9c9bcc0c655389a043e6bff4244448b59ba
      https://github.com/bluez/bluez/commit/eab7a9c9bcc0c655389a043e6bff4244448b59ba
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M profiles/audio/asha.c
    A unit/test-asha-phy.c

  Log Message:
  -----------
  asha: allow LE 2M PHY on the audio channel

Allow LE 2M on the CoC socket to increase available throughput for
capable peers. Retain LE 1M fallback and treat BT_PHY as best effort
for older kernels.

Test the PHY mask and continued startup when the preference is rejected.

Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
