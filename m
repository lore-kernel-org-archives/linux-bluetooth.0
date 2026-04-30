Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E122A4E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559224; cv=none; b=NdZVVaEU6lqvDe/D7QgxW+ROz/YGnS9RDEHNJsMwq7AgjyDIQ4yLd8jmhX0khnZAafywVh4DZVp5inEQNIrFJewgj63+p0AkVKwTMx0O9WYfhqa4DlNOWEssvEjUPXU5ZIzYvoxkOgGBSiCoM/a0HVjoXENMf+Hcz1yIAJSh9V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559224; c=relaxed/simple;
	bh=VDEaOCjyejeH3oUpQONJNdChIiAxZpK2BYW/uZuHIQw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HjK4oJR9+fFHqHXWk9LbEu4s/nUl+CIBJby3+tfEafBlF3ipPLJOOlY/MKypyJbiI5cOocZ3m3QedWW09ep91FDTjz7m+9V4S4C1uWQnvFHDemdf8q0e+SK9RiPs7CmcXf1pJ3sRW30zs2F6H2i3+xIpSJzOa9X0lhaoOqw/cZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Gwsir7F6; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Gwsir7F6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777559222;
	bh=L41a7b9HisluRGnGmpMx42Op1KL3v/q4d2qrd1RMGlY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Gwsir7F68YX9jWYKmfS5ZMGbgIPcvNCxkKM6HNNENB0g1Q+5M5n8mcBrzLu2Ljm2M
	 jjvCpYE754lbUpW2+8qorr0Zxeu95ZcguvmWaknnAPBQxbpEx1xdXp8eSOU2v9hhrq
	 2z2J5zciXIgKRYhUDpwrUoMXW1EctHksWXX+Jbnc=
Received: from github.com (hubbernetes-node-508fe24.ac4-iad.github.net [10.52.201.66])
	by smtp.github.com (Postfix) with ESMTPA id 8607721110
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 07:27:02 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:27:02 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/278f34-304bc5@github.com>
Subject: [bluez/bluez] 1db065: audio: Add ability to desynchronized linked
 transport
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 1db06505df5a4c8f6626de76f1ca7ba33207df59
      https://github.com/bluez/bluez/commit/1db06505df5a4c8f6626de76f1ca7=
ba33207df59
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio: Add ability to desynchronized linked transport

If bluetoothd is started in testing mode a new Desynchronized property
is added, allowing to prevent automatic acquire of linked transport
objects.

When desynchronized, each transports needs to be acquired separately.

This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


  Commit: f8a2e6124b3635e52073c16bb4a8238ac2610e53
      https://github.com/bluez/bluez/commit/f8a2e6124b3635e52073c16bb4a82=
38ac2610e53
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc: Add documentation for CIS transport Desynchronized property

This is only supported when bluetoothd is started in testing mode.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 304bc5b78a3c94af32577abfcf1e5489c5360062
      https://github.com/bluez/bluez/commit/304bc5b78a3c94af32577abfcf1e5=
489c5360062
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to desynchronize linked transports

After linked transports has been desynchronized, they should be acquired
separately and read handler should only be started for source local
endpoint.

This is used to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


Compare: https://github.com/bluez/bluez/compare/278f3439c45f...304bc5b78a=
3c

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
