Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18C21D587
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494590; cv=none; b=FPVDq8e6rgci+PH04NM7P17TVaYfjIX00ttQaJsR+Ie/yHSBNyMeGPXgnQi1r4deZ4opWOEM5HkqWhfBElvl2MzfAjNmtTfk33YoOi00eeQhgnNxY/GLmFSXmfQODpnceqA/IhDhRrokiKkwwA1nfC5nj2m+U04VfKqlWK7cVyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494590; c=relaxed/simple;
	bh=ddPskVUlsu/UzKub5oOeB3XY/vk0uPpnMtSFx3iHAN4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PwrRHiCyBhkyY8FZ5uwdRfgEtDC88jqx+amZEtSb/ZoK9HtXGzEd4M1h2LPyV8aOFFjIeretRPKNcq9F3D+SbEyKhXKHVZLjAHBBC1R89zx1fc+0KUyt5VjouB9YuXOUAqHnkmizPJDyIqeyMjedPcKK/CU6/LNtekfOZ0wXqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FLFa66jH; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FLFa66jH"
Received: from github.com (hubbernetes-node-2a1a643.ash1-iad.github.net [10.56.207.90])
	by smtp.github.com (Postfix) with ESMTPA id 58511921117
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749494588;
	bh=ewz/4qEBelL4qh7NSL/iJ0nSbSQPwoHqr9Byz//BYQM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FLFa66jHNrm//XtHMJJdEfzyWHv9uRYIFoUzZD2k6uwlsvs9NdtpCv68xttFl0Tgt
	 ml9JO59MIEYAX2q31K/GzKNNAQw02szrxGeRS44sPuf5rPkI1dLBkkGbkcr9GiIFKs
	 7yJQG5S31hlp696QTpI6Kuk7xi7KS+HwgXkREB7A=
Date: Mon, 09 Jun 2025 11:43:08 -0700
From: Dmitry Sharshakov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7feff4-dd83c2@github.com>
Subject: [bluez/bluez] 964585: btdev: implement extended advertising
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 964585e3b352e05d4162ea4cad66d380b44c4192
      https://github.com/bluez/bluez/commit/964585e3b352e05d4162ea4cad66d380b44c4192
  Author: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: implement extended advertising

Increase maximum advertising data length and implement
LE Read Maximum Advertising Data Length command.

As expected by Zephyr BAP Server


  Commit: 0f5f6cad205c42752f41dbaf008cb6773dd633ad
      https://github.com/bluez/bluez/commit/0f5f6cad205c42752f41dbaf008cb6773dd633ad
  Author: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: fix LE Remove ISO Data Path command

Fix errors in BAP server


  Commit: bb614960501b66fd5c26387b84521141df13d610
      https://github.com/bluez/bluez/commit/bb614960501b66fd5c26387b84521141df13d610
  Author: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M emulator/main.c
    M emulator/server.c
    M emulator/server.h

  Log Message:
  -----------
  emulator: add option to listen on TCP


  Commit: dd83c2d670dd9578bc8410ee07becd74469c6e8c
      https://github.com/bluez/bluez/commit/dd83c2d670dd9578bc8410ee07becd74469c6e8c
  Author: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M emulator/server.c
    M lib/hci.h

  Log Message:
  -----------
  emulator: server: handle ISO, use BR/EDR+LE 5.2 by default

Allow passing of ISO packets via the socket by parsing their header.

Set version to 5.2 to expose ISO/CIS and other LE Audio related
features when using server mode.


Compare: https://github.com/bluez/bluez/compare/7feff47a9fbe...dd83c2d670dd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
