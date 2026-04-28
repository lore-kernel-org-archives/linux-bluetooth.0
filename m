Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA2331A53
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363444; cv=none; b=UbcPMwUKFdlz1HMG3q6HRcYAyjH8NqQvDZGEU3/D9G4vDqQUFehflQjEmZfZxdIVhkIb0OjHGp1SYTtn1bNhq7Z0dtI78QqXvT1jkRKjRbG0SDoVkpP1diAKMJtmcqV8zV6XboZm7/3kgl3Uc/qRmNuZ8N6ROZS36JasMjzSGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363444; c=relaxed/simple;
	bh=vXQQ5EX0L0+X+rd9O0pMx6weYIV5t28yxI8DzhwPahY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=qtegrEvlFeyiGx0vCpeBvqfAnuD6kyXZpH0tWje3zLTSkNRsMJCAwdKAoPiTw+5dhc+YxFzJ3L6+X0IktPvTV2dkJQBMU+KYPwPdQki4ekwKeUwnrJ2k0hQvQ70bu2GIFva47kH5okfdlUJWhc5OouGShLFzJY4OqdQNrdyGjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MHUvMb7u; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MHUvMb7u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777363435;
	bh=vXQQ5EX0L0+X+rd9O0pMx6weYIV5t28yxI8DzhwPahY=;
	h=From:To:Subject:Date:From;
	b=MHUvMb7utKEpa0AQmV0qy3m8Woxil/837+NM69Oqdjku8sqzFLVVsfLzMUNpCIL/n
	 77pI67300nb78SjKr+CsoloanJSbI2+7uwSNf3rz2L2pUFH1lv0VK0npSePbS2VM3V
	 knwsrsDlP+HNRuUvn4EWt1cWZnxGHYolKu5XVk0nRhmMaHmscAPkKIOOsqzAH1rSri
	 jDdD4kgjXnKkokyhDhgBGyI8Vpa1b5X9Syfih7T9HFdiZA2bTKTHz9+koPtSPeQhL3
	 eXg0uMeuzFCI4M8aoE+lRnX5M34YSmNJvLpuKaLxHJLJ7HSSEQGuqHMPodhrkneqMH
	 lE4dDUnewrZoQ==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B1FA17E1318
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 10:03:55 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/3] Add ability to desynchronized transports for PTS tests
Date: Tue, 28 Apr 2026 10:03:11 +0200
Message-ID: <20260428080314.180777-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

If bluetoothd is started in testing mode a new Desynchronized property
is added to org.bluez.MediaTransport1, allowing to prevent automatic
acquire of linked transport objects.

When desynchronized, each transports needs to be acquired separately.

This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C which
requires to connect the ISO streams with one ASE in "Enable" state
while the other is in "Config QoS" state.

v1->v2:
  - renamed 'desynchronized' to 'desync' in profiles/audio/transport.c
  - added a comment for the 'desync' variable of 'struct bap_transport'
    in profiles/audio/transport.c 

Frédéric Danis (3):
  audio: Add ability to desynchronized linked transport
  doc: Add documentation for CIS transport Desynchronized property
  client/player: Add support to desynchronize linked transports

 client/player.c                  |  76 +++++++++++++++++++-
 doc/org.bluez.MediaTransport.rst |  14 ++++
 profiles/audio/transport.c       | 116 +++++++++++++++++++++++++++----
 3 files changed, 192 insertions(+), 14 deletions(-)

-- 
2.43.0

