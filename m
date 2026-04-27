Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA453DCD90
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310465; cv=none; b=BAtlqF/FVBWnJG1ZRjsKd/Oug5YRQHKXWZDerYceygz0lXkv+6GgJBE/cAHASKc8Cknqz9xcFIKOuLqPD1HkD4cbPb+d+8AhtxPOxeppL1FcfYcokymtF8/X5X7A34RZmI3sJ4DFoHmbCujM2FHWM+hgJx+bAJzkYwmKX28ZHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310465; c=relaxed/simple;
	bh=1raFbv8lQq1yMl63qW4tYf8XFqT7oCleJwCkidcBbBk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=AoKssbnrgs6uj34FrUqHMvR0PO+0nmcuLnqXd2oVe/3rpcGBgXjixs+SF6OjUPX93Z+Vg46sxE9svSqg8PdWZg7ZkkNxwyT3c28wKeD4PBPai/NbX2SBWM18hKR4dYcaFfHphdgjuLfmbwBJ7U+M4f3XSE6M7/XkZjXfMQGkS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n3lTolBV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n3lTolBV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777310462;
	bh=1raFbv8lQq1yMl63qW4tYf8XFqT7oCleJwCkidcBbBk=;
	h=From:To:Subject:Date:From;
	b=n3lTolBVME3ZcVgqxkmhV2G2eaaqLiE4YZveqSIRxvWmIK4QUJbkWeQ3FJAN8ogwd
	 6/tE0VYJP33SvnRBJ6dkSigqt/EseQAUX/5yccDuXLnF5t9iDdHJBZN93+8r92B0Op
	 1bWaxlu7JX/qKuE9PbfuV494eooci5JdZfEQVyIJeU0qCYksbmFtcQRsQtcaCEgETs
	 8h20Lb/85MpPULrcvALJHDApKLLgW2LCY1ywhHryBk9aKnLO4txpv4zdktishW4U0H
	 B6a5dvLbcvm4mMXtNy0nM8jzqGsxnioddcVwUx0hJqnOyXqHXVIseKO1aqNny2jOeX
	 lRWoEaUJ40PVA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EB9D017E05B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 19:21:01 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/3] Add ability to desynchronized transports for PTS tests
Date: Mon, 27 Apr 2026 19:20:53 +0200
Message-ID: <20260427172056.148115-1-frederic.danis@collabora.com>
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

Frédéric Danis (3):
  audio: Add ability to desynchronized linked transport
  doc: Add documentation for CIS transport Desynchronized property
  client/player: Add support to desynchronize linked transports

 client/player.c                  |  76 ++++++++++++++++++++-
 doc/org.bluez.MediaTransport.rst |  14 ++++
 profiles/audio/transport.c       | 113 +++++++++++++++++++++++++++----
 3 files changed, 189 insertions(+), 14 deletions(-)

-- 
2.43.0

