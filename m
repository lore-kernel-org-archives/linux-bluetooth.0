Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159E28D82A
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914864; cv=none; b=BNlZt/uImmcA/AL8E0H2weTJuNmnQ+ZpdYkT4gRYSHUt6JBeB2G/61zgkwZwe/wWt5Raz1ia7yinqtNIESvmWd4wysJGRfWeMIUgcxsYfmQgMfJsc7kpo224pfk2vZOK663XLLcPMx0Ly9a7e7gJCS1hom5J4+c2Ed8HBm1jCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914864; c=relaxed/simple;
	bh=a5LvL9UiRiKrJ4aM5Xx0M8PZIJ+JUOFK95wr1KpST8U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nBtbcQ/fQfWGYnfhyvbWPio4FS+TO7JksJAJCgZ0q5WG0g0oGRL2CLtlaiGQdAeODnboCjmZdCaMdvkrlJ8Ygx3BwadOVVmRFx2TIhtsJDgCjLEuzVnl/5QgUVd/TYkWXY87U1MQZHtMdC9ObFfU5rcNMwOprHs4N6Cd9DQjNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DAfg1wEe; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DAfg1wEe"
Received: from github.com (hubbernetes-node-e651425.ac4-iad.github.net [10.52.221.67])
	by smtp.github.com (Postfix) with ESMTPA id 94D3E20A87
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 11:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765914862;
	bh=xYiFA8n7k3TXDLc0UMJvHpUDILiMo1I02kOY/Qq8ZAM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DAfg1wEek+jFoPXUCGVfiPdZz6LkPE6tAPylvqZsBg9gw03vz4uOzUncVo59IvIUS
	 4Gnl9fJRTUPxNOw2wc8hU3CJhSsxN8wixJoFwVkrZYstbvF9+qW+NIJRA9rfMRb01/
	 w5ScZSbu15uXIPow+p3X/WBKGjRm5E1yV5niUeJs=
Date: Tue, 16 Dec 2025 11:54:22 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1033906/000000-f555ae@github.com>
Subject: [bluez/bluez] ddf5de: shared/mcp: emit MCS error if value changes
 during...
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

  Branch: refs/heads/1033906
  Home:   https://github.com/bluez/bluez
  Commit: ddf5deaa2c7f74b3b0c57df11ddbbc2cf074dc40
      https://github.com/bluez/bluez/commit/ddf5deaa2c7f74b3b0c57df11ddbbc2cf074dc40
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-16 (Tue, 16 Dec 2025)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: emit MCS error if value changes during long read

MCS spec requires emitting Value Changed During Read Long if value
changes between remote reading with zero offset and nonzero offset.

This is session-specific state, so add support for that.

As server, track value changes and emit that error properly.

As client, we don't need to reread if this error occurs, as there should
be a notification or track changed that queues a new read.


  Commit: f555ae9e4ecbd559620a48906be2d627681652b0
      https://github.com/bluez/bluez/commit/f555ae9e4ecbd559620a48906be2d627681652b0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-12-16 (Tue, 16 Dec 2025)

  Changed paths:
    M src/shared/mcp.c
    M src/shared/mcp.h
    M unit/test-mcp.c

  Log Message:
  -----------
  test-mcp: add tests for long value reading

Add server tests for handling the Value Changed During Read Long error.

Add similar client tests.


Compare: https://github.com/bluez/bluez/compare/ddf5deaa2c7f%5E...f555ae9e4ecb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
