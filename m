Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93908946C
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776719115; cv=none; b=P+pQpIRbRlxqLONjwUIGmA2t0PpnyP1hqmdV58uJqXvwblt+jrjWZxKPhJ6ZzkYQSLRgk1VWnbMotHm/88TbWhNEfNfYfBkShIYnjJHPue4/9UcLuYH4FGA/Qb7U0PZBsrehkr8PwPCwPR8O1AnqwjszSPdIVZB2r//AQSxt/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776719115; c=relaxed/simple;
	bh=ZmK+7bPtRJ/dnIPdp05tkO2ocWYFIFqTBZiYZ0uVkno=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Is7ewVk5El5N+ND6MlM316CSqrHdAoUmFjrufGf/lJ0Zux6KftlUetrCcgDUNvqC8lEBad/2xF49MIJ4bLEiw3TDtNdfsI5dFOoZLQd0jJAv+cP35U2tgaj5CGq9ItWKQbYc408wa/cq7RT1rFBHXVr6WJHZ9WHpaNQ96f2rTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YFJUbzKe; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YFJUbzKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776719112;
	bh=kP2lXjhsMwNjRE220Lf1fJD0IWLM+Q3qzZDXxTnCBk8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YFJUbzKenDdxwDA7uGEmzOqOV66NN3CRsNzRIZQajSaqNB4Q9+GaoikBoxVBdUGut
	 lA183CIqAMPDK2RsxUJs7FgLxnqePYvhegCwEOnfBaZQMo3KmQ5F1fWWAVzKIRQORB
	 5SIGPoT+9QRIOqCg1JWF3b61Dei/iQ5UZVKL2edc=
Received: from github.com (hubbernetes-node-8200203.va3-iad.github.net [10.48.209.52])
	by smtp.github.com (Postfix) with ESMTPA id E5238500188
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 14:05:12 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:05:12 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bc0a83-0fdf34@github.com>
Subject: [bluez/bluez] b57658: client/btpclient: Add BTP_OP_BAP_DISCOVER
 support
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
  Commit: b57658668c7c2c862b4cd9525d2417e5d0d82c3f
      https://github.com/bluez/bluez/commit/b57658668c7c2c862b4cd9525d241=
7e5d0d82c3f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-20 (Mon, 20 Apr 2026)

  Changed paths:
    M Makefile.tools
    A client/btpclient/bap.c
    A client/btpclient/bap.h
    M client/btpclient/core.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_OP_BAP_DISCOVER support

BAP/CL/CGGIT/SER/BV-01-C expects IUT to discover the services before
continuation.

This reduces connection time for the BAP tests.


  Commit: 0fdf34b17d41e77ae860aaea0bbb1c1e1dac0cf0
      https://github.com/bluez/bluez/commit/0fdf34b17d41e77ae860aaea0bbb1=
c1e1dac0cf0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-20 (Mon, 20 Apr 2026)

  Changed paths:
    M client/btpclient/gatt.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add GATT discovery supports

This implements the following BTP GATT services commands which are used
by BTP BAP service:
- BTP_OP_GATT_DISC_PRIM_UUID
- BTP_OP_GATT_DISC_CHRC_UUID
- BTP_OP_GATT_DISC_ALL_DESC


Compare: https://github.com/bluez/bluez/compare/bc0a839fa383...0fdf34b17d=
41

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
