Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC53DE43D
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166939; cv=none; b=qawV+4tCqVs+V+qYRObbTP7bO6pysszFetRU4Lgt6Nvm1C5TYtyOmDqzwwtyQUOWd1fFXJzokYTcdixOvCY4nwRU+gmcByZaE/7svw+e8QFwtGpn2W3NhDqogu9Pz0e5lmr0Z4pwbH/m3AzLelRVOGty7pDzX2XW9fXzwu3TpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166939; c=relaxed/simple;
	bh=51BRz7d7oWt0YS6n9ScZ4fmqIp2K7b7ZILvclFChVyE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ipdTC4YI7bdN86EJbWZMWZdaSqsihNxHPd7LVibZIaLlFsAZsi+g41OI34FEVMrM9BlWZ5N/7peKvxyiq9ty3mBtcJ8mqEz+dUsRRP+GRnYHgQ1SaeMNBqcyoj7vtzSVX+QiFcrkTOCDNDvf2m6VwdB2sZ1CuQodJflve1vGSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Nvhv+1lM; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Nvhv+1lM"
Received: from github.com (hubbernetes-node-2431ca3.ac4-iad.github.net [10.52.211.91])
	by smtp.github.com (Postfix) with ESMTPA id 85521400839
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 04:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776166937;
	bh=VnIK2vAPZvI/iBgyM+pYq7u2JrkAIPkgcVF6j5VxPI0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Nvhv+1lMrmdXQfjTXyh6Roett5fEtpm7IF/1QvEXwn7O4Tv2E/Fltkg0a/sr00iWV
	 KO8HYJXKeXqp2kS29efzqmRn7cq6eB03jxdDx2zWBazrbxobCinbusk/Zi1KW0RLgK
	 TAqR8oUmC5myv09l0Xyi39/XHhPhl7G3EQKXXpkk=
Date: Tue, 14 Apr 2026 04:42:17 -0700
From: apusaka <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081093/000000-1e4863@github.com>
Subject: [bluez/bluez] 5de8de: monitor: define manufacturer company IDs
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

  Branch: refs/heads/1081093
  Home:   https://github.com/bluez/bluez
  Commit: 5de8def71a42e3118d8f9b5e91a6765996975f88
      https://github.com/bluez/bluez/commit/5de8def71a42e3118d8f9b5e91a6765996975f88
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


  Commit: 1e4863460198fba5e75a8aec2232013dbe58ca77
      https://github.com/bluez/bluez/commit/1e4863460198fba5e75a8aec2232013dbe58ca77
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


Compare: https://github.com/bluez/bluez/compare/5de8def71a42%5E...1e4863460198

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
