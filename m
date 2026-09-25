Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A812F7F05
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347813; cv=none; b=baA+odNUBMVHLmkSjdOTgdmvchGu0l4mUl/GZ0AaFvwBU5MTyoIOhr82apPQRWsp9xpPE8wM1xy/LvB5Cyh7t9tE12XDRiXaQJv9vAyque1jW8ZJ6ThsN6Jwsms3c/XlZSgPoY5tdE4lZW/zJq+wclPXF+8kOM7ecluhGUUjcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347813; c=relaxed/simple;
	bh=U19f2tjVhlHw9FEHCTF9EM32RHs2VfqrglZcoDeAAZs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aRD4XPVAQ6ktakypAyg6fie58rCAoxxEaRCmlWkU8v3w9OB/D2Zot45P/9Bt1k0MqSbyDLZDuDolAW3qMeHqaSw8J0/WFVknDlpZRMLDlvXn5ODWMh9cpUEeA+L/syI3PVmLWmltMg7IwdbQmPJrJA2a+z+IsGr7BXYTT3n4YZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=NAchcCUe; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="NAchcCUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790347810;
	bh=LOCZmnTe1V5gxoaOsqUrHgLOb+m9V4/XQyGnd7luF3U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NAchcCUeP8JJSYA6dJwSNKTx5+jRd2GuKhr4atf6U69ThfmaRcA4FrVOvCab+16uO
	 AN6NbVP80EtvNtwvqPKQni76zzMLFX76WojUfowhV3jKC80LwhGOW8NTNm8478qo/H
	 XotouVQRL+XAhvZN+OK8H1stwTr55kJZg9cPN4c8eIrM9EeiHM7755BvcAVWfvW+L1
	 jX/CoTZoB4JCBJeW3FOpBbcjfZb5ikOXMF76+4rAQlG2QVxSLPkMVhrPOP90MuEWZv
	 lMTRCotkB4Lyn+ngA9StX745xv3CUqQ2I93t7108SgYs7n6lcn3q200T9wtDRPAfhE
	 3CuWKevYpzFgg==
Received: from github.com (hubbernetes-node-33a0412.ash1-iad.github.net [10.56.192.51])
	by smtp.github.com (Postfix) with ESMTPA id DE4EB361261
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 07:50:10 -0700 (PDT)
Date: Fri, 25 Sep 2026 07:50:10 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173742/000000-9ef837@github.com>
Subject: [bluez/bluez] 256b8a: doc/qualification: Add CSIP PICS file
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

  Branch: refs/heads/1173742
  Home:   https://github.com/bluez/bluez
  Commit: 256b8a2de2c540c3f7d7c5fe1ea6f71e2d6e1138
      https://github.com/bluez/bluez/commit/256b8a2de2c540c3f7d7c5fe1ea6f=
71e2d6e1138
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    A doc/qualification/csip-pics.rst

  Log Message:
  -----------
  doc/qualification: Add CSIP PICS file


  Commit: 9ef837e91e073f2ffd596010837d7be3692a8cf3
      https://github.com/bluez/bluez/commit/9ef837e91e073f2ffd596010837d7=
be3692a8cf3
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    A doc/qualification/csip-pts.rst

  Log Message:
  -----------
  doc/qualification: add CSIP PTS tests documentation


Compare: https://github.com/bluez/bluez/compare/256b8a2de2c5%5E...9ef837e=
91e07

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
