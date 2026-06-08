Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46FA367B9C
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918178; cv=none; b=kbeL4cn0p9sFz15OdBJwOsgRnIy9rLJQNiS93tfDfetBOWMTenzF4ACOApJATlHRYkKEyUNOG2fvipPII5aFqVgIjVputcbhWnEl+059Vf8wUvyCELD8Xnt+5X619FQ9jq/zCr90Ep2BVth8IoeMi/fCvG/obvsBRDuH96HCzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918178; c=relaxed/simple;
	bh=t8xK0gpSeS+LOmSqFs9pqGZQdXYSlCDm77eIcfzLpws=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JZTBb+TI2D0FT9gDIAensJPGZKQJMiJKwxYH2V+HrKkl2zQ/siNRoLq1kacUPz4INQ/hoCBLPu5bBLKNQXm7FBqOQsPW7tMIiBzlpd6Q2SHVIMP1jvC34fqGRtMORQNfVyJC/s5k6+gYt7tVwYc1AVxA/pzZrtfDNfRIOX6EHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GJ0LUf7L; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GJ0LUf7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780918176;
	bh=F0fJOaIIvFN6SLQ4soCZHxeHGF5uAKGgOi99jNspikE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GJ0LUf7LmeODFlj16go6R/hINpgWiNSnGWFVcdKQqOzHljwOXMKAOgMH2CChSMsxW
	 GAtINiGqBLAz6YcE3nRZX4pSwWn7n89wXtO8qzt/MuG7ckmWfluPerX0NM1CuMcHHz
	 DEdOSpgHZjItTYiPR3NfRbZM+YFsktNhDZwgdF6s=
Received: from github.com (hubbernetes-node-facc7dd.va3-iad.github.net [10.51.95.24])
	by smtp.github.com (Postfix) with ESMTPA id 140BE341000
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 04:29:36 -0700 (PDT)
Date: Mon, 08 Jun 2026 04:29:36 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107775/000000-2a496e@github.com>
Subject: [bluez/bluez] 2a496e: adapter: Fix failed bonding attempt after LE
 link ...
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

  Branch: refs/heads/1107775
  Home:   https://github.com/bluez/bluez
  Commit: 2a496ed0fafa820b80e29d3747c22a241e6d5ade
      https://github.com/bluez/bluez/commit/2a496ed0fafa820b80e29d3747c22a241e6d5ade
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix failed bonding attempt after LE link disconnection

What happens when issue occurs:
- device is connected to both bearers BR/EDR and LE
- bonding is requested
- LE link disconnects
- pairing keys arrive

BlueZ would finish bonding request with error and mark device as
temporary. Then it would be disconnected+removed after default
temporary timeout (30 seconds).



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
