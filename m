Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E152E5B32
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534774; cv=none; b=qO/bLSSqvTiK+KV+6737vRd3q7RyBU9DrgsSK3Krz9fesdnzvqfMBCGjd2Kc/qmX62Vyb+4tlzfgpUhUr9iwJFdii6Teyk0We0FhkIwp+flvk3f0ezo5AgbGn4nfpK8I834aocytecSKNFeUwnBh6fyBrPOu/xZE8E4UxK8ffHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534774; c=relaxed/simple;
	bh=5JjiHw5MtGAlDjnRAACEzBqlV2nykuBX3ce7g2dQ6nk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bgyWGeKwGRa43S7GXspTJzfZlE1+iUODyG+v1DRWOc6CO+p52QQURS/f00NNPziurFtv4XEHdYA6sG0yM9P5sNvWPE799pGzM3f0jlJRMB4/WpYumMOn5Z3gV9bAuhccxII2wr2DDWrU3Y+aaZNXb7vV6MreEzqmBOM0H7toMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M2Fxju09; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M2Fxju09"
Received: from github.com (hubbernetes-node-ccff0d4.ac4-iad.github.net [10.52.165.16])
	by smtp.github.com (Postfix) with ESMTPA id EC6A4641171
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769534773;
	bh=/kNznihqVgFH23Dk+KSLR9qx+lex1vlQBvW9hPGLN5Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M2Fxju09t8qrAEq3w9YiqunZnvsOMgS4oBYUF8QfOLEyPdOMVnUD4SoF/Pjwa+0ZV
	 ZYYWubngX6giJiaU9nfqU2xxzrYt/EugNxxL8Wr5wCbRoBPFXyHZcYEgBRtEf/qdn5
	 1XAKzrBD1PSrpfEHW+P85OKYSoxgdq/vM+0AmreE=
Date: Tue, 27 Jan 2026 09:26:12 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047685/000000-4df918@github.com>
Subject: [bluez/bluez] 4df918: doc/qualification: Add PICS and howto for the
 A2DP...
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

  Branch: refs/heads/1047685
  Home:   https://github.com/bluez/bluez
  Commit: 4df918e3df6a5dd29c88811ac0ff01859db1315a
      https://github.com/bluez/bluez/commit/4df918e3df6a5dd29c88811ac0ff0=
1859db1315a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-27 (Tue, 27 Jan 2026)

  Changed paths:
    A doc/qualification/a2dp-pics.rst
    A doc/qualification/a2dp-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the A2DP qualification



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
