Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166B61A724C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765312470; cv=none; b=PgfkdMWwAPELVUex2GYZe4ItHzPDVcIAbiNTB2lrQsxswkmGJ5YoVO6HMOgRLpY0n9lqnCabg1bTJ8b0U23MAzT1Xo9WekaVYt0lSuDsfMhdtkQOCd1Wdy8397LhKUPR4vRpzQ1M77M3riRX9eo87XuO+ccU/IIq+qKALCxR96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765312470; c=relaxed/simple;
	bh=8kZUyKO8TCzrjPIn69PF+j03Jep8K0C9aPdLelwVUOo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ga0WiqlNP9Vk/hncprljRUwMZv7Ou2IbJ+1tnVyg8w9DxAaERboHCAAdA90S0/cKEJKzxPgTAbqELBtWi4lFa+81DX6S7GLby4nIkKoPs9pRwhQffxBFtdtY9lPOSWgECaIrggfV6oOSPLWCAiYR/UPgrX1bcMu2ESFdT/1fNjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jdrFqEVL; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jdrFqEVL"
Received: from github.com (hubbernetes-node-9ead334.va3-iad.github.net [10.48.209.52])
	by smtp.github.com (Postfix) with ESMTPA id 0C457E0447
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Dec 2025 12:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765312468;
	bh=YZYK8luYUhchZKqyA2s1uahlJ6fRR5iEx1ap44qGhbg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jdrFqEVLUdRfdqMWXE35sgg2BnJRO5rNOJlYNIhdvjyCgs7vkJ6o9k0f8f3YQXvvs
	 Kiwl800vxqqy3mvB3py6YbB3qqXNC2S2TuTUeI0gSTpuFFyjSrGoiq8IPAUOGMtpEu
	 Gm16XGD2WYLcSp/53onfH5r7zH+ZcWCpbmG1fLFc=
Date: Tue, 09 Dec 2025 12:34:28 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031813/000000-bc2488@github.com>
Subject: [bluez/bluez] bc2488: unit: reduce macro expansion volume
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1031813
  Home:   https://github.com/bluez/bluez
  Commit: bc248875dca1b7a72827bb68031710e7b2f020cb
      https://github.com/bluez/bluez/commit/bc248875dca1b7a72827bb68031710e7b2f020cb
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-09 (Tue, 09 Dec 2025)

  Changed paths:
    M unit/test-bap.c
    M unit/test-bass.c
    M unit/test-gmap.c
    M unit/test-micp.c
    M unit/test-tmap.c
    M unit/test-vcp.c

  Log Message:
  -----------
  unit: reduce macro expansion volume

define_test() in some of unit tests expands the long command sequences
three times.

Make it expand only once.

This reduces preprocessor output e.g. for test-bap.c from 23 Mb to 5 Mb,
for faster compilation.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
