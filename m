Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDB2DA76C
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446978; cv=none; b=JHQ+qhjX8QMuIeTVtJQOltA2dtJ+yuAXaU86iF2zMYJf7QgyCbFziW832Nl7yX6+rEkm7fuHYU+eyVNc6hCUn6G5WB4QYRZJZb8mgE7XHulJxgKRg+SNV2a6F1WExD66XERPCu9Z36hO6X0f07CGgQNGtQTMRkJdk8Uxru2PFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446978; c=relaxed/simple;
	bh=C2oYyKUfeoZlSeyvz68Hz/Yug9iS76rfrpUI2Guj6jE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=okzHimW1gHekesl8izJXW+VUp468tjASi9zzbWQf0HtW3maeNGDhCmdRyKtJzvDc06T77bzOqLEZoN198E375oOjiykNeHxqyRsGHQeAXhG1ZG/sEga0tSTmshN+GS8rg99BQS0HpaGHM5SacU+t3rOZK2ExHETQj23rR3lspFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kT47ZjkS; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kT47ZjkS"
Received: from github.com (hubbernetes-node-2afa137.ac4-iad.github.net [10.52.83.28])
	by smtp.github.com (Postfix) with ESMTPA id EEB234012B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 09:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769446975;
	bh=SmwamSnmi+s7A8AyRCnfEG2f506DocqSyPxkBBXynxk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kT47ZjkSMaJU6YTbpqP/HFfSe/8HOFdE0YZIjHfwjOAVEraibdK5wyJygX1Y3Hvw+
	 1qGBnagBuyG/cUeTlB7T/XmGXL0rtoS6d5NBjBunHx7Hn7Isw0bPB8T9biH5JWVnVJ
	 9JYEuRG5ytGuFc/5DphBUg5KO7/Ds67s3QkwEeR8=
Date: Mon, 26 Jan 2026 09:02:55 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047202/000000-3d429d@github.com>
Subject: [bluez/bluez] 3d429d: shared/tmap: Fix TMAP/SR/SGGIT/CHA/BV-01-C on
 big ...
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

  Branch: refs/heads/1047202
  Home:   https://github.com/bluez/bluez
  Commit: 3d429de6986bf09f609b9782e3546559e3e1104b
      https://github.com/bluez/bluez/commit/3d429de6986bf09f609b9782e3546559e3e1104b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-26 (Mon, 26 Jan 2026)

  Changed paths:
    M src/shared/tmap.c

  Log Message:
  -----------
  shared/tmap: Fix TMAP/SR/SGGIT/CHA/BV-01-C on big endian

This fix the following error cause by not converting the role value to
little endian:

TMAP/SR/SGGIT/CHA/BV-01-C [Characteristic GGIT - TMAP Role] - run
**
ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)
Bail out! ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
