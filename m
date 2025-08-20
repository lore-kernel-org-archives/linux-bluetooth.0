Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354E36CE03
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702043; cv=none; b=LW5rFRajIcFBMOuSCaYbumAnSne/yuF+qZbUtX26fk00wefE8gC3xqROiC7ytW0R/67MX3OBjQei1YawyNOmS2EhUyWQN0GStz1Q6ebow1ry8Ks5sgsn/BwiL0RKOfdvQ0dS+9GWnedU0iRNyztbejugQQlJ2Y6+FjC7cthdbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702043; c=relaxed/simple;
	bh=QlL9wClr2bd0PoS1hl6fOnSa5pmM2nCIH7c7ZubvJf4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KXapva0weK1EeWXDu07H07WdALZ9+A6wPLJNOjWxa072Ofua19NSQoX499PIUw6ZgXemy6SQ80VaroLJkzL1bzHCTm29gN9N4tMpVf9kQmuZ1avZLmYzeo3QX7VatQ8bmeb/a8xvKhBTiQ/BL4dKv9KvGugLgXn88zxeavnUA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UThkR9sn; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UThkR9sn"
Received: from github.com (hubbernetes-node-2b9a817.ash1-iad.github.net [10.56.172.31])
	by smtp.github.com (Postfix) with ESMTPA id 0E415921302
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755702041;
	bh=GhtGkart2AWo79OJOke3ICTe3NJiS11aU/WAVHZwY0E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UThkR9snj+KSvVe0NZK+HMl4e0ZyEcNdQe+Y3AZyddCiDtLaPTIu89hftd2Rfbo+H
	 Wz70kDhJnnLv+pknwZx+0FRiWk/DtnWA/2otwDdsZy9B/gcJvtTL+Rnp9rEuCTGKBh
	 tiHXkw7/x+/lnHDsaa2INpUQWmN55Ohvx9ViXhOg=
Date: Wed, 20 Aug 2025 08:00:41 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/00eea3-ed2da1@github.com>
Subject: [bluez/bluez] 56b483: shared/hfp: Add HF SLC connection function
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
  Commit: 56b483c7f869358ac8bfa6d92d5444f39ee13181
      https://github.com/bluez/bluez/commit/56b483c7f869358ac8bfa6d92d544=
4f39ee13181
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add HF SLC connection function

This implements the minimal SLC connection exchange, i.e. AT+BRSF,
AT+CIND=3D?, AT+CIND? and AT+CMER=3D3,0,0,1 requested to complete the
Service Level Connection Establishment.


  Commit: fb9b5c04fc3c9ba2dbeb735c6c39731b53ca7e89
      https://github.com/bluez/bluez/commit/fb9b5c04fc3c9ba2dbeb735c6c397=
31b53ca7e89
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add SLC connection test

This adds minimal packet exchange to test the SLC establishment.


  Commit: bcd94e3e327dde224417aae67338e71202bfdda5
      https://github.com/bluez/bluez/commit/bcd94e3e327dde224417aae67338e=
71202bfdda5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M src/shared/hfp.c

  Log Message:
  -----------
  shared/hfp: Add +CIEV event support

Register +CIEV handler on SLC completion to call the update_indicator
call back on unsolicited events.


  Commit: ed2da1a3786d02a4ffca601228f318a276a457f5
      https://github.com/bluez/bluez/commit/ed2da1a3786d02a4ffca601228f31=
8a276a457f5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-08-20 (Wed, 20 Aug 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Add indicators tests for HF

This adds the following tests:
- /HFP/HF/TRS/BV-01-C
  Verify that  the HF accepts the registration status indication.
- /HFP/HF/PSI/BV-01-C
  Verify that the HF successfully receives the signal strength status of
  the AG.
- /HFP/HF/PSI/BV-02-C
  Verify that the HF successfully receives the roaming status of the AG.
- /HFP/HF/PSI/BV-03-C
  Verify that the HF successfully receives the battery level status of
  the AG.


Compare: https://github.com/bluez/bluez/compare/00eea35722b7...ed2da1a378=
6d

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
