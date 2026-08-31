Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E93AF674
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160358; cv=none; b=HisIzLw5iuoEMEvmVCYrCNk+l/zAMOBKTwUpvGYhf7hAAM8wppOwKNOMLhx1kgIeBqG1uO5UBAc+w2Nakk8C54TOLC+EWYZW9cRVAbZ0PW99/zzPan38nKIh0dOARTbyX2EE7M1Zs88HYZYM/XMbEajTnxXuTIcVOnA0GM8ZGzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160358; c=relaxed/simple;
	bh=oVyjXhZg8bA40nmeSMp1mrBTdMkGfg2shA97hf573Oo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aubSDEHBfBQftkJEetXauvE0kfoYC594EoWC07F2Y3plUPFSaZP01XIT24UEdz+xRhOWYzuLvc6K/gKlnaJPysfrBaizwJdInegGjq+5NW1ID8JKoOwrXC3wdx2sDJwjsEZua9Yqw7hpaC7eJcGpIS1cDvKFpPHp7/9hK0gDJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XEEH2DUA; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XEEH2DUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788160355;
	bh=wGvpQJ2ocAfzVnB3OFDbH0iMG0UE1mWPMjUfJakVslw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XEEH2DUAZphgDl9WX0unzfk+jgqleevVz6rCm5OzfNKhq9Kpipkt9A9gPkuNgBR8b
	 p1Kz3ae2rWKz4eY1uswtS+RFVMQ7d4IAie/j/uApUUksExr2wAUzCu5B1EnQoNWAtP
	 ZAHPfjlseEmVMMn3jFatUpSr0R8nzj/agSzLUHgk=
Received: from github.com (hubbernetes-node-4976775.ash1-iad.github.net [10.59.93.32])
	by smtp.github.com (Postfix) with ESMTPA id E02A260034E
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 00:12:35 -0700 (PDT)
Date: Mon, 31 Aug 2026 00:12:35 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1154163/000000-13b41e@github.com>
Subject: [bluez/bluez] 07840e: profiles/audio: Support MCS fast seeking
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

  Branch: refs/heads/1154163
  Home:   https://github.com/bluez/bluez
  Commit: 07840e3ab727f571b484e6e60c4b0a93ae7af81e
      https://github.com/bluez/bluez/commit/07840e3ab727f571b484e6e60c4b0a93ae7af81e
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M profiles/audio/mcp.c
    M profiles/audio/media.c
    M profiles/audio/media.h

  Log Message:
  -----------
  profiles/audio: Support MCS fast seeking


  Commit: 510358a8a6f757e3ed0cbe74c1341554fac75ecd
      https://github.com/bluez/bluez/commit/510358a8a6f757e3ed0cbe74c1341554fac75ecd
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  profiles/audio: Support MCS track position writes

This is needed to Pass PTS GMCS/SR/SP/BV-02-C test.


  Commit: 13b41e05092d60d623b68428223d7ad5196e7b36
      https://github.com/bluez/bluez/commit/13b41e05092d60d623b68428223d7ad5196e7b36
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-08-31 (Mon, 31 Aug 2026)

  Changed paths:
    M src/shared/mcp.c
    M unit/test-mcp.c

  Log Message:
  -----------
  shared/mcp: Notify unsupported RFU opcodes

This is needed to Pass PTS GMCS/SR/SPE/BI-01-C test.


Compare: https://github.com/bluez/bluez/compare/07840e3ab727%5E...13b41e05092d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
