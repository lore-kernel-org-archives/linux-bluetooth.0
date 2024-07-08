Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C1A29
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470957; cv=none; b=BGwyLPOe/08WWb21+Lg7R4yGaILviQWarju/z/8PkXlEMKx8SSKk7MVk8wpVaqdmLS24x9bL/loexla7B69ESZ0RvuUWzHcL8PsDIllq/ue3tL2rzNNOrb0NJFnu2Ea5lV4sJUilcWEfiMgERK1PRHbUWswKJFXNH9up2LNz+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470957; c=relaxed/simple;
	bh=714Hj7aK7g+memSDMgZOvieFE6nM/qiLj0JK8nAreJc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jMjHl3aaGTFsRs7mtG9u8UEv6BsDHzh8mQ3CY7vSL1iGsW6eC+xkL36jbi4DGhMvwSYA8jM+q84Q0+DQur9GZCAhdRY5VLBzqfi5S3UUlv00S346jQMRAjrMre6wHm9wjuvpU8kqsokPCG27e4eKBjRytmK+JwyvS9FVQsbOUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P1XYLAVU; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P1XYLAVU"
Received: from github.com (hubbernetes-node-c7b2993.va3-iad.github.net [10.48.146.34])
	by smtp.github.com (Postfix) with ESMTPA id 30D038C0B0A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720470955;
	bh=Z/dx2g5u0ToyxTM1IQHSzhITZWLlweybMOZavWmx9j8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P1XYLAVU411NVrqvw52aa4FT5GwbjBt5TK52QCWSq89G3dr3Z9jYVEfCXSCDOT9Gr
	 XWuHTfsGqGZonIFHl880Ia3LPNwMXl2UicqUXBCeXQGG/sN8tmuEKjTQmrO8ZmUnzZ
	 tgZYOHdr+KFInBWgUIdygdLCIFQfu/2YcxwI1eBY=
Date: Mon, 08 Jul 2024 13:35:55 -0700
From: =?UTF-8?B?R3XDsG5pIE3DoXIgR2lsYmVydA==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/42d43b-337cca@github.com>
Subject: [bluez/bluez] 110a8b: shared/gatt-server: Fix not using correct MTU
 for ...
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
  Commit: 110a8b47a4f159a8239795255b6c1c0edd79e4cd
      https://github.com/bluez/bluez/commit/110a8b47a4f159a8239795255b6c1=
c0edd79e4cd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M attrib/gattrib.c
    M src/shared/att.c
    M src/shared/att.h
    M src/shared/gatt-client.c
    M src/shared/gatt-server.c

  Log Message:
  -----------
  shared/gatt-server: Fix not using correct MTU for responses

Responses shall use the bt_att_channel MTU not the bt_att MTU since the
response shall be send over the same channel as the request.


  Commit: 0041f5e22fe3e865609b0208b53c42f4690f1a82
      https://github.com/bluez/bluez/commit/0041f5e22fe3e865609b0208b53c4=
2f4690f1a82
  Author: Gu=C3=B0ni M=C3=A1r Gilbert <gudni.m.g@gmail.com>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: fix incompatible pointer type

In function 'cmd_send_transport':
error: passing argument 2 of 'getpeername' from incompatible pointer
type [-Wincompatible-pointer-types]

err =3D getpeername(transport->sk, &addr, &optlen);
|       |                        ^~~~~
|       |                        |
|       |                        struct sockaddr_iso *

note: expected 'struct sockaddr * restrict' but argument is of
type 'struct sockaddr_iso *'

To resolve the compiler warnings, cast the pointer with
(struct sockaddr *).


  Commit: 337cca13037fc6f8a1db72146f12019260b892e6
      https://github.com/bluez/bluez/commit/337cca13037fc6f8a1db72146f120=
19260b892e6
  Author: Gu=C3=B0ni M=C3=A1r Gilbert <gudni.m.g@gmail.com>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure.ac: Fix --disable-cups

or else we get:
  configure: error: conditional "CUPS_SERVERBIN" was never defined.
  Usually this means the macro was only invoked conditionally.

Fixes: https://github.com/bluez/bluez/issues/773

Credits go to Lars Wendler


Compare: https://github.com/bluez/bluez/compare/42d43b28428f...337cca1303=
7f

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
