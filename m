Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838F3845B1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202151; cv=none; b=Gm0GKHm4ULN3R8/0QDAZdld9jxy20eTHJ6vkhSRehYd1Q3Xd2lOYe8pAScGh5yspDVE9th36rsBDxxzYFvUanN1SchaQi0QmQywVol8A8ZK9gaZsv16HqlgJ5ifsWeTBSXYt9CVs5916KViL466h9zEgmmI9/w2ffrWmBqZ0Ngs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202151; c=relaxed/simple;
	bh=3G2bqG4qaQFpAA54pTNzkIsVshK/6r05ja1gSyVS3TY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Tb4GGyzF21Omy/4OzZ+Ek9qWoPvAGO2fSlBvRDHfY05wYZMs66GybFiaaqdwLwTsIcPGX5aVzaB9N8m9StKTl8w08zfhVXzxoSlHsHuk41kKa3ixeFMGHXD1Sjnq92y5Y5dfa403L3sfUUACCIlGYvuvN9nq1oeh3Mknp7MZepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=luhyyNVJ; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="luhyyNVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776202149;
	bh=w62VXYSc4VVF7JQOqIzJyE6N48YNi6FAdxhuUWpVRZo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=luhyyNVJxlE+ZxtjFZsDNl/xXufuVaNdL9mAnDy+nCcL/Q9Rg3mXx/QdsySAUzg0x
	 5FngtwSz7XkmcII5WON+Vtd65ch2BRBEZWrY3PVEZ348UB9Ph3RTqXjn93HhgnTO//
	 uK7wmsPSzWziW+SwUEwibIgEgqm213T6/90ZvAuo=
Received: from github.com (hubbernetes-node-3e494ce.ac4-iad.github.net [10.52.210.53])
	by smtp.github.com (Postfix) with ESMTPA id DFE62A10E1
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 14:29:09 -0700 (PDT)
Date: Tue, 14 Apr 2026 14:29:09 -0700
From: apusaka <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b3e1ac-510623@github.com>
Subject: [bluez/bluez] babc56: monitor: define manufacturer company IDs
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
  Commit: babc5699226b535b6f15549a6daaaf7fb45acdd1
      https://github.com/bluez/bluez/commit/babc5699226b535b6f15549a6daaaf7fb45acdd1
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: define manufacturer company IDs

Define company IDs to make it more readable.
Also remove an unnecessary if that could cause uninitialized variable
warning.


  Commit: 510623fb53b53dce5a297c4a7878cad7546c2e47
      https://github.com/bluez/bluez/commit/510623fb53b53dce5a297c4a7878cad7546c2e47
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2026-04-14 (Tue, 14 Apr 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Set msft_opcode on read_local_version_rsp

Aside from INDEX_INFO, we can also receive manufacturer company ID
when receiving read_local_version_rsp, so we should also try setting
the msft_opcode there.


Compare: https://github.com/bluez/bluez/compare/b3e1acdf9cd0...510623fb53b5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
