Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B09259C94
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767730724; cv=none; b=at6TiPbHBnxpVQJewiyp1ED6Dq7FG0A0aQxEkkHOyrSo9TCSgJkKEJaYePi+QY0agXADbWPHaEQQmDXtm2gYPSjJr4dTIhIJ8MhJ8w79lSQp6e0MlB21K/5blKq4u+OKuWhLarxnc33n6a+DLTLz8X3z25MdbnakO13c0lTalCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767730724; c=relaxed/simple;
	bh=TjrbKS7GsrM39jb5fycJBda5T4pORIAZMXJrn4fJLDU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UTq/zrn3BUfakuj8MaMqG1Cx33mO2zZiElAf4ZIjlElB61h3H9ErTCrCeZ8dSJKW9kXZVXFi9f1qJqR8mlhkPBgsqmeHw0Ujr1shVxaqedqA2Dn5RyjqiPMVNPKCGw1cyOkzxYfYuxwaVTRyBf2ANF9ePT3it+VqSJ7srK/edzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fQ79lwKB; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fQ79lwKB"
Received: from github.com (hubbernetes-node-6c4cf0f.ash1-iad.github.net [10.56.209.104])
	by smtp.github.com (Postfix) with ESMTPA id 51C58921239
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Jan 2026 12:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767730722;
	bh=Kom95bVvYHDy5DOmLwmTBJMDUYP38CREM1DcrLW5WM4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fQ79lwKBnVS1IE4tMhovvoBjs/FFYvnQ0mTruM4gv3B8zHlG5ghA5sN3/djG7f3Sb
	 +480VkdXyOXqElr2tFngJl3AMAEnbetn34PiyyD2+RXdjF7AfcmBLZYrFdrE35OYyR
	 C4CpRWc0mnPEhaMfT+Pn1DVS8bt/IypBjXS+7IlM=
Date: Tue, 06 Jan 2026 12:18:42 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1039131/000000-e00b1c@github.com>
Subject: [bluez/bluez] de006d: lib: Rename bt_iso_io_qos phy field to phys
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

  Branch: refs/heads/1039131
  Home:   https://github.com/bluez/bluez
  Commit: de006d15f1c30ec02918d8ca56c593c2b415f473
      https://github.com/bluez/bluez/commit/de006d15f1c30ec02918d8ca56c593c2b415f473
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-06 (Tue, 06 Jan 2026)

  Changed paths:
    M emulator/bthost.c
    M lib/bluetooth/bluetooth.h
    M profiles/audio/bap.c
    M profiles/audio/media.c
    M src/shared/bap.c
    M src/shared/bap.h
    M tools/btiotest.c
    M tools/iso-tester.c
    M tools/isotest.c
    M unit/test-bap.c

  Log Message:
  -----------
  lib: Rename bt_iso_io_qos phy field to phys

This renames the bt_iso_io_qos phy field to phys to emphasize it is
actually a bitfield rather than a single value.


  Commit: e00b1cf0d21debf6ed14c2e1dce56403a9ed61c8
      https://github.com/bluez/bluez/commit/e00b1cf0d21debf6ed14c2e1dce56403a9ed61c8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-06 (Tue, 06 Jan 2026)

  Changed paths:
    M client/player.c
    M profiles/audio/bap.c
    M profiles/audio/media.c
    M profiles/audio/transport.c
    M src/shared/ascs.h
    M src/shared/bap-defs.h
    M src/shared/bap.c
    M src/shared/lc3.h
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Fix PHY fields being treated as single value

BP PHY fields always refer to bitfields with the exception of target
PHY field in bt_ascs_config.


Compare: https://github.com/bluez/bluez/compare/de006d15f1c3%5E...e00b1cf0d21d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
