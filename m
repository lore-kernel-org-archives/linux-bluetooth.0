Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AA43DA5B6
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370628; cv=none; b=o53hQUDrQ032L1ffqFkVtKMYDofyMbFjVDNKakJEuE+gDXDn6uCqfG7msjbP5g4eoOwfFO9SKdl0jeHsCa45QHtbfiWt9YYAN5UeYN8TwPrW+e0dxNCbc22Zjjz8uNAXtPtaUVhTAs56LNHXs3ySVCcJzr2qoelJ+cKQ1Fm2ywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370628; c=relaxed/simple;
	bh=Y7+cK2Ee3MG6ZaFUsbrAmWqeSYmiPMM9LtqUsFCRJFs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BW8CnyqKtmH1//M4SA46fEJ3oIVxt4DGuvK3mGFORm0shZu7FwacdGW3HJYsgNTT84c8drJzW7DPsRvpjYQjpVYLT8gcMtx4boIZziWNVUf0eAO3VJBOFj6LxMo5ppE9phEEmrTKAMrY2iNU4xk8XrRVFco45KuSFoR6eDMknGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Y6pMXh8k; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Y6pMXh8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777370626;
	bh=X41E1iMY7hnebwolmDNnCqhm2cNWPjkTtfXmncrNeco=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Y6pMXh8kpAvjr5CeR1mLtpeypCyG1YoQV4bnp2EDgcPkYf741FEyH4f1mSjiSG5ev
	 Hnq1WPjXkFNnj7TXNH6w5mWmAwXg2cYk2HFHqSszGD7IourvsZX++MuceoNaCBFNIj
	 rgGVI8GmHQCcNtb8SrWCZFwKTRAQjsKpHm6wYCik=
Received: from github.com (hubbernetes-node-8581678.va3-iad.github.net [10.48.82.27])
	by smtp.github.com (Postfix) with ESMTPA id 69567801178
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 03:03:46 -0700 (PDT)
Date: Tue, 28 Apr 2026 03:03:46 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086648/000000-37e808@github.com>
Subject: [bluez/bluez] f7a9de: audio: Add ability to desynchronized linked
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

  Branch: refs/heads/1086648
  Home:   https://github.com/bluez/bluez
  Commit: f7a9de3726b2ee7f68be28b0b1c4b1afbfc24c4f
      https://github.com/bluez/bluez/commit/f7a9de3726b2ee7f68be28b0b1c4b=
1afbfc24c4f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-28 (Tue, 28 Apr 2026)

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


  Commit: a4a58b50d3fd1cdccc2a0e68c43fa3af4ea55d0a
      https://github.com/bluez/bluez/commit/a4a58b50d3fd1cdccc2a0e68c43fa=
3af4ea55d0a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-28 (Tue, 28 Apr 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc: Add documentation for CIS transport Desynchronized property

This is only supported when bluetoothd is started in testing mode.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 37e8084672bfead40e0922abfa1683ee0878e10b
      https://github.com/bluez/bluez/commit/37e8084672bfead40e0922abfa168=
3ee0878e10b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-28 (Tue, 28 Apr 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to desynchronize linked transports

After linked transports has been desynchronized, they should be acquired
separately and read handler should only be started for source local
endpoint.

This is used to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


Compare: https://github.com/bluez/bluez/compare/f7a9de3726b2%5E...37e8084=
672bf

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
