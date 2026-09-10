Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A123507B
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054117; cv=none; b=pnqd8emw4zK46L+/V5QnUOVacOAhKH40gUazqxs7p5nZNd4uVw6Zs+9NGij9Ljkg+dhXNNTWleawsQ+nyKY7sEMM12haG05ldTGCFFRwJBmSwpcKcYrz06/mT4L/5+8KXgI4ScXEga1KonWhDIMR9EfAoioj1gaorT+LGzvpt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054117; c=relaxed/simple;
	bh=ZtmTKCL+d1SE69/9ymH+F2OxYBMh1OwBIvzBphcPXPA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CFBHYFymKrAf8NfNyTVEpTdybSq5U8gUFT1CUoJ2p2uocw69tjn37qrv/j+eE3UXRTsXp7P1zu16j1BrpDhBokHV0w/DjrfitpJr3vlQ/DNoKiG//heeAiH2xMa0vyLIpJwcqJLdCa7S7pdU5LZSF6xFP3yCK001VjTp5N4hBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WiylmJb3; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WiylmJb3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789054114;
	bh=MWpHtJ1y5dvN8+L3xGwUOmNhoh5Nwl00MuEzgeuspxk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WiylmJb35NKgPPiLipB0QHGTkv25XrhLcOPw8fj4XoIuirqEkzur8Fw8W6UghrT5n
	 rOmlmgwn4TIKxPZdiko4loHxGk7zkK/buRLuCZDUJCDcV3PMKidicyik00/aP+kCBI
	 EvOzhTV3rnDdeiEp2mLX9VMviIxIocCcP7kp2hX4=
Received: from github.com (hubbernetes-node-891584c.ac4-iad.github.net [10.52.80.32])
	by smtp.github.com (Postfix) with ESMTPA id A0FFA9413AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 08:28:34 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:28:34 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/9693b1-db1a03@github.com>
Subject: [bluez/action-ci] db1a03: cleanup_pr: fix TypeError comparing naive
 and awar...
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: db1a034cad6b02bf0883cad7bc783fc2d4d7e012
      https://github.com/bluez/action-ci/commit/db1a034cad6b02bf0883cad7bc783fc2d4d7e012
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M cleanup_pr.py

  Log Message:
  -----------
  cleanup_pr: fix TypeError comparing naive and aware datetimes

PyGithub returns timezone-aware (UTC) datetimes for pr.created_at, which
cannot be subtracted from the naive datetime.now(), causing:

  TypeError: can't subtract offset-naive and offset-aware datetimes

Use datetime.now(timezone.utc) and normalize pr.created_at in case an
older PyGithub returns a naive datetime.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
