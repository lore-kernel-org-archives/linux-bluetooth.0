Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E528F95E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112196; cv=none; b=Tj++5KEDkri/CZkjL8CiiAqQknP7SD80wNRR3eymUaxkvBpk6CB42K9ooXKQZYOVw/xQDtNDsezCepnACpouwVJhpyOLk7sy/RSZm7mP4EXIpPQqJ7byxPpnxQeWFG0de9MPdC+ec6090pGAvQEIa3yxXDrwzsldssftdKXzWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112196; c=relaxed/simple;
	bh=d48kKYRNGN3HGKLZVWw490gMMHug7bi6cQEciiKB6Ro=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HXFRU10PppJv2b3hY75v9TffxwaABQjXEguiY1pt3NfmC2ar+/b8gxnOkuURRuVf+0Qn9M/157g4naEBMSsb13yJsPionmt5LfBAw9d0nFkbkrdgqVrr2+HDFYomCN4nOpvDbbCxF/wnljo/P2nP+z8InoHW1c1IzT9UdgBptfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QDzGJSre; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QDzGJSre"
Received: from github.com (hubbernetes-node-f05bc4b.ash1-iad.github.net [10.56.184.44])
	by smtp.github.com (Postfix) with ESMTPA id D158B920DE7
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753112193;
	bh=G95yUKpmK1xYhD0HD5rfxgPb3KQ7Mf9+htSkW3vUzFI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QDzGJSrervrZ2rOTHr/y0fepP3/v6JaEo0Wun8OFNK5APAJhQ3C/EWS6Oe5iFLL1E
	 QOZ7DfMpoRCg+EJDuWrh85hDMDO4MC2BjWV5Eprb6gyV4+mqKnIJBg+o0ixnEwDnlx
	 vReNhRN70CIGP5oK5UeHov+JY/OI+wx2JCcGFvhw=
Date: Mon, 21 Jul 2025 08:36:33 -0700
From: Francesco Giancane <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/984366/000000-3be9f5@github.com>
Subject: [bluez/bluez] cac2ec: configure.ac: introduce `--enable-bluetoothd`
 flag
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

  Branch: refs/heads/984366
  Home:   https://github.com/bluez/bluez
  Commit: cac2ec3c4b77351a4be9d544c27484d986ed3e64
      https://github.com/bluez/bluez/commit/cac2ec3c4b77351a4be9d544c27484d986ed3e64
  Author: Francesco Giancane <quic_fgiancan@quicinc.com>
  Date:   2025-07-21 (Mon, 21 Jul 2025)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure.ac: introduce `--enable-bluetoothd` flag

Add an extra `configure.ac` flag to individually control `bluetoothd`
compilation.


  Commit: b6ad18020b7586b84f64a5a3b0d797689ad466b0
      https://github.com/bluez/bluez/commit/b6ad18020b7586b84f64a5a3b0d797689ad466b0
  Author: Francesco Giancane <quic_fgiancan@quicinc.com>
  Date:   2025-07-21 (Mon, 21 Jul 2025)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  Makefile.am: build `bluetoothd` if enabled

Keep daemon compilation and installation steps separated.


  Commit: 3be9f5190a76edd3806281220030a5303cb446fb
      https://github.com/bluez/bluez/commit/3be9f5190a76edd3806281220030a5303cb446fb
  Author: Francesco Giancane <quic_fgiancan@quicinc.com>
  Date:   2025-07-21 (Mon, 21 Jul 2025)

  Changed paths:
    M README

  Log Message:
  -----------
  README: document `--enable-bluetoothd` flag

Document how to enable or disable compilation and installation of
the daemon `bluetoothd`.


Compare: https://github.com/bluez/bluez/compare/cac2ec3c4b77%5E...3be9f5190a76

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
