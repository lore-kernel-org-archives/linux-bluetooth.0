Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129C34D90F
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488662; cv=none; b=R9ml771mP+TVai+UW11WrOKLECN4DcdPoyDhhCPjxSoHSYmDuefQTb8dvjaL0/m1VaBLvtom7r+iPzGC+drZM6WDVSx47zlwbLZkAkK4Ab9simpPwozJ0CaYfrUuNGTd0Uoj5VNt9sTsAKwLi/shxa+NLrtd2hZgPZkc5js4544=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488662; c=relaxed/simple;
	bh=zIJYlXPLwgfBZRNEooC/BvMBWDI+vrtgEZZhnHxYPgc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rM/G/eEtUv7O1y3eqN8fDAp6gHlfiSGwdRP8C918+CBU6o04/RV1W4Soy2dogzmhh/DxYowVe+mgPENvcccnZM4tcmtFcskwv1N+UwT4w6X0Xrj6RTgGd0bAvq8oSJ7MDDvNkpif/I1kwo9f3twFj3rfk7k436hlof01NwUIB5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Gotqfaal; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Gotqfaal"
Received: from github.com (hubbernetes-node-81c7744.va3-iad.github.net [10.48.175.13])
	by smtp.github.com (Postfix) with ESMTPA id 2302E3C128A
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 06:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768488660;
	bh=G8dkL3bOiZwbucUo5WWXtM6Z6JsnbuIszdGlsTQE+iI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GotqfaalzJPxCdut2edI+wy6TGgyu3JOyNMud7vQQS3lyrf5o2TK5tP4UvZUBI6LZ
	 0lzYjD8PA9HaGBayxL94KxDO1IHgptKmpieKkMMuxS0b4bbomQzVbmPgUxMsQkDQls
	 0CwEdBp0KZFhpfPT0Vc2HRsIXP64CBLwQbchNccI=
Date: Thu, 15 Jan 2026 06:51:00 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042856/000000-1e15ef@github.com>
Subject: [bluez/bluez] 1e15ef: tools/btpclient: Fix eir data on GAP device
 found ...
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

  Branch: refs/heads/1042856
  Home:   https://github.com/bluez/bluez
  Commit: 1e15ef1ddc1dd080257fb1838f02e4f85dd2e869
      https://github.com/bluez/bluez/commit/1e15ef1ddc1dd080257fb1838f02e=
4f85dd2e869
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M tools/btpclient.c

  Log Message:
  -----------
  tools/btpclient: Fix eir data on GAP device found event

This allows to pass GAP/BROB/OBSV/BV-05-C test with auto-pts.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
