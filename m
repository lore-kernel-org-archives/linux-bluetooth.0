Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7F238C29
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441231; cv=none; b=VJ3s5SVqSPLevdYcAP4UxiAMsnIHY0wXUc51HWIMq4G7oGsvLqk1P3IpKejNMcSv4dVujp7ymgM95yxZ/xk7vwcjgfiihFz18q92rUn9cZwreKXXTe7ByqemLFesGpTpf4sQFH3irpLmnxreoWhed0H8BiZIJ3bXblbgf5rI2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441231; c=relaxed/simple;
	bh=2V57Qum5UOpfKe6Ex6d8qDMc3zp85S64mzzZgUYanng=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AWx3oXH6N9NOqGswA7fH0H0XBcRKUVfOxs2ig86T5YGooTG0K1icl/Tk095ZHXzMXke17ufIVQl0Oa1xCA0Db3KopF/iebzhWeNV6NNn2fq6XoFTD9qI2xKxy+wRloJm39a/kZEjIXjiuIUF4+WZERmp2y8NIZYrbpnYtHAq6Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IhcuLG+6; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IhcuLG+6"
Received: from github.com (hubbernetes-node-af1c7d9.ac4-iad.github.net [10.52.13.44])
	by smtp.github.com (Postfix) with ESMTPA id BCD34215A0
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 11:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771441229;
	bh=onDMRdk9hTcm1Bnbfs4Zzc70LLKknX8nAROGZGm1PSI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IhcuLG+6sk4hUEva1pLj7ZRoxSb6Fn84N1HI4UCf/71NiYx2rCOAK/pO616ZY6E/O
	 soDW9pg+5u/fwqe2TYQWlfWXyBjTjTPLSj85f3Xxci6EHqxh7gi/LZ1j4LQjaVNDZX
	 TFuzo44b3Bc5bhCxIh/DHDtw/hz01am1y7j/5HZ0=
Date: Wed, 18 Feb 2026 11:00:29 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055296/000000-d2476b@github.com>
Subject: [bluez/bluez] d08697: doc/btmon: Add missing documentation
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

  Branch: refs/heads/1055296
  Home:   https://github.com/bluez/bluez
  Commit: d0869758cb3931477c7b3c8f5d739e7337393856
      https://github.com/bluez/bluez/commit/d0869758cb3931477c7b3c8f5d739e7337393856
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add missing documentation

This adds missing documentation for -I/--iso and -N/--no-time options.


  Commit: 785daec07e083bad3194563bc9f8499d96db046e
      https://github.com/bluez/bluez/commit/785daec07e083bad3194563bc9f8499d96db046e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add dedicate sections for timestamp and frame number

This adds sections for how timestamp and frame numbers are generated
and explaim the difference between a frame number and a line number.


  Commit: 06897760d3dc3d8464feeffbfe031e22458f9a76
      https://github.com/bluez/bluez/commit/06897760d3dc3d8464feeffbfe031e22458f9a76
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add connection tracking section

This adds connection tracking section which explains how connections
and buffers are tracked.


  Commit: c415573717a93adebdf797a8008a114ae1ced77f
      https://github.com/bluez/bluez/commit/c415573717a93adebdf797a8008a114ae1ced77f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add a dedicated section for analyze mode

This adds a dedicated section for analyze mode.


  Commit: d2476b1b8a1f84b37bc687a321f6bfb0f5121b39
      https://github.com/bluez/bluez/commit/d2476b1b8a1f84b37bc687a321f6bfb0f5121b39
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-18 (Wed, 18 Feb 2026)

  Changed paths:
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Add a section for automated trace analysis

This adds a section dedicated for automated trace analysis which can be
used for analysing traces programmatically or with use of AI assistance.


Compare: https://github.com/bluez/bluez/compare/d0869758cb39%5E...d2476b1b8a1f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
