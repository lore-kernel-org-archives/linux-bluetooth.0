Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25FA327C05
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771405203; cv=none; b=tDHsU0m4+bQAMnTw3h+PBLNeLOzk/MFTnPvb9eAMVwrOqRjFcnn5Z6rvamtYwLNQ0gkMIu32kju4fwoHI4P48wLNOIjlW9XH0I++QC+SG36nKrOhS23oAoMS080WzTG3Po593GbkkoZspreF3E33KyK2exv3SwDWKzboPRuapQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771405203; c=relaxed/simple;
	bh=wyIARcxkXnMeREtMtUkXE7DROFzdDNa/ktfzH4JC8Ng=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gH+t8uO6v6+UmA38auTSJm4sH4/VpcDZF3D1Xo48IkPIBYGHLadGpJk0Z0sYZ8QVrpdW1UqNhm3yP/NoUaR07dAi57EvyivScdQqv8MFTQAmQZWHptXOAKK2+afUicrYTWqUCkqpoDrJ328SfWYHWloONqP4/75r6yXBN6LAHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OWHEynjP; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OWHEynjP"
Received: from github.com (hubbernetes-node-a4ac5c6.ac4-iad.github.net [10.52.159.31])
	by smtp.github.com (Postfix) with ESMTPA id CB4EB401255
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 01:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771405201;
	bh=FOO38FZj2yW/YppXSbJ+39vpKFYdhhPqrCsRsgZJ83U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OWHEynjPEgpnGdx8UaGcfOadHMaD2B+VO+1RbDHSSt/W0GXYV07/SnwUrpnP8RwOG
	 YIit/GaKxhiZBG+DCdzMqcKkdYn9nCLzg83u+8HhSc3/oAfw9Wbv1PFaM8sG5gdgnx
	 9KvixH0uqHNQLnPsxSwJti0c71J5YDZD5EVtCAG4=
Date: Wed, 18 Feb 2026 01:00:01 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055133/000000-3890e9@github.com>
Subject: [bluez/bluez] 3890e9: client/btpclient: Add GATT support to get
 Device name
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

  Branch: refs/heads/1055133
  Home:   https://github.com/bluez/bluez
  Commit: 3890e9a0db3654cd7b6df71b9ef83d58ebd1886f
      https://github.com/bluez/bluez/commit/3890e9a0db3654cd7b6df71b9ef83=
d58ebd1886f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M Makefile.tools
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h
    M client/btpclient/core.c
    M client/btpclient/gap.c
    A client/btpclient/gatt.c
    A client/btpclient/gatt.h
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add GATT support to get Device name

Add GATT support to btpclient so the it can read the "Device Name"
characteristic (UUID 0x2A00) from the DBus interface resolved during
device connection.

The device connected event is postponed until ServicesResolved property
is set to true to ensure that the services, characteristics and
descriptors lists has been fully populated.

This allows to pass GAP/IDLE/NAMP/BV-01-C.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
