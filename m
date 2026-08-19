Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B222480335
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168554; cv=none; b=n/X2TmtjSKOf1F/7NPmEywFUxJ0FlMjEATmlZEqVekcxEUZ/CScu+f6nwzjL5zS/EEQoDnqqI8nqgJ8MZpd3XkyEFFKMbnlUq1Zw9WnNLF5u+kEJ5LEIcEBKZeLqLoIs0T/NIsfLv/NywYYdmLrR6YpbN4HfbK8LEU9xC+cK6Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168554; c=relaxed/simple;
	bh=B8zrbXysxiIrw+JmQGJ1hYCVWaVdvUlWBvryUfdkihY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=n2SmejqPVUK1sGmBaX3c4ej8gIyYdvjp/7rqlukJbrYalUuwqQCMto6QfImfAkTDPUXGwMu/cksKOTV55cEWlqFuNPp+bdCbg+BIysiXLYSpDqdn4hfoSkJML46CScs75hqa99Li+XFPHGhvjAujwqgakDiUClYinFRVY5N++Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SdimYD2g; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SdimYD2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787168552;
	bh=aYSXCTbAIHl3j9+Mif8hbrSD2oJLzQUfF/Inw3XL5RY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SdimYD2gzixxmsg5ybhVVSX1Mipp9KOrkmZ/wdtGIhCB2guwGZ/JgkINTxpi8WwJT
	 qdGIELrrn/KAeVKXenraFgz6Je+04c6hWMjo8kqu8/ERvq2z1rG0wqEomjA6r0DCEK
	 +ZhYEkutwutSYSDA4BurjVzTmVrH868ahy6LDq1o=
Received: from github.com (hubbernetes-node-3861535.ac4-iad.github.net [10.52.221.89])
	by smtp.github.com (Postfix) with ESMTPA id 54BE1320AF3
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:42:32 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:42:32 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5abc00-c73fa2@github.com>
Subject: [bluez/bluez] 44f6fb: avctp: Fix typo in comment which contradicts
 the c...
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
  Commit: 44f6fbc4e3b10582ffc5728685c9a267766eebd8
      https://github.com/bluez/bluez/commit/44f6fbc4e3b10582ffc5728685c9a267766eebd8
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-18 (Tue, 18 Aug 2026)

  Changed paths:
    M profiles/audio/avctp.c

  Log Message:
  -----------
  avctp: Fix typo in comment which contradicts the conditional below

The comment says "If the request set a callback send it directly" but
checks for whether "the request did not set a callback" using
if (!func)


  Commit: 58088149872d014684a582fdb7ad01a5180c9bc5
      https://github.com/bluez/bluez/commit/58088149872d014684a582fdb7ad01a5180c9bc5
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Fix media/folder name not being set

*namelen was used before being set.

Fixes: bd8989620ed6 ("avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing")


  Commit: 1280c6f9d00a96ab2a513a347eec467fdc2ceb99
      https://github.com/bluez/bluez/commit/1280c6f9d00a96ab2a513a347eec467fdc2ceb99
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M doc/test-runner.rst

  Log Message:
  -----------
  doc: Fix typo in test-runner.rst

s/lunches/launches/


  Commit: c73fa2f9ae2d366cb8a4f101fa9a5ccd9f33a4ea
      https://github.com/bluez/bluez/commit/c73fa2f9ae2d366cb8a4f101fa9a5ccd9f33a4ea
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: "-a" option also stands for "--all"

In the options for most command-line tools, -a stands for --all, and so
it does for test-runner. Add --all to the option description before
--auto as it's a more common option.


Compare: https://github.com/bluez/bluez/compare/5abc0045b84a...c73fa2f9ae2d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
