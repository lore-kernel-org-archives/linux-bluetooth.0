Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4541C42A82
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221913; cv=none; b=nMQROz/Cd+HaHbSiNkpdtL7Vnqbf3rNeupVRPZ1n/gVgcnAhYry5kQsFnSpRmMJhTPRIj+fy7CN12w2o5GP4inO8mopgI3cuJALMLFN4Y6VTBXmj+xraZ7EqD/1U8cLwZUUDpWP37gUaxYv1lb7YOIbDwU1bt5KmEYgnBCjlsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221913; c=relaxed/simple;
	bh=VTDFES4vSJYtHCnfpjxmcYRtHXhaOh76zwmXg0eHFZ0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eegalATzYCtzSVy6tD7Kn55qqPF/6GWOeJHt3MlSlDMprgIn6d1MvozPvkptkZuekNY8+vDhCtC+v6DKjDbEXtkpdqXwzZRFnTHNeWenkkTFN8s4po6EhaYcMi50Z7oaKTp/SMc6vfjZiKVB9XfO1z/r4loktbV04IMi01EaFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RbdnfB72; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RbdnfB72"
Received: from github.com (hubbernetes-node-a9cd48c.va3-iad.github.net [10.48.142.31])
	by smtp.github.com (Postfix) with ESMTPA id 5DBD2E0A11
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747221911;
	bh=iDiEPMLqYdMK22drNrAKEPiX5IhzFgVadDBoMrj2hN8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RbdnfB727TWMtclieDhiIZEMNqfVFQMN2r4I3H+cjk80bQ0Ii3ce8OSnUqLoFYeCH
	 06vv+pyCThKVBy9XRP+m8Bmz4ewvvpgi0E4OTz2huzZzrCzP+5zKKyprl6oMqrGnbt
	 AK8NkxOhOgcIv09Ptdr0G40IbJ3CMXH7Kr6dd1V0=
Date: Wed, 14 May 2025 04:25:11 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962794/000000-774258@github.com>
Subject: [bluez/bluez] 774258: device: Reply br-connection-key-missing on
 connect...
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

  Branch: refs/heads/962794
  Home:   https://github.com/bluez/bluez
  Commit: 774258b7f0342514bf5c15a71012516f8410f2f0
      https://github.com/bluez/bluez/commit/774258b7f0342514bf5c15a710125=
16f8410f2f0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-14 (Wed, 14 May 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Reply br-connection-key-missing on connection bonding error

Currently when connection is removed while the client is waiting for
Connect() the failed message is br-connection-canceled, even if this
is due to bonding error.

This commit reply br-connection-key-missing when connection request
fails due to bonding error, allowing the client to differentiate
connection failure reasons.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
