Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE22C23E25B
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780732467; cv=none; b=lCNwBOU4SdZ1MXIFHnam2nPXp7KOQC+GUtbIYvIBDaZuVrcR209s2GhjsfHaTtYmTxKp74TnB0KjDSgqCOGpVtiPHd5lZBlJI+iS8WkJ541M6yi0xqOe2Bgn4vuywqk8lE19ZaAA8k2lPL/fqoQ2FJe4ZPNs+5VN8Y3vScKKKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780732467; c=relaxed/simple;
	bh=U8XtisAqu78+sxyjhdl6AjvnB+e6AIWa20JLMWhW90I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DgFmNPDgW/sxUiVEFtT4nYNYvVxjDqFZzOe3dDeYTahHaLgN6+1yVro42vMXD8S7z8MOfjQlU1nBcbS9AM264obdhrpqKm2yVy4uREgBCpJ6JrMXlL1qZ1njz6ydgxiCCZci/7oOjhCwJNJwIjAfzNGLbRmADch4yrTP/Yh+mBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V3825XtN; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V3825XtN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780732465;
	bh=xTsl6fEPNtdkV5b16257kXkwi0YBDQ7gcnN9flHCi/M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V3825XtN+sl5OUozb/5HORE2b0TT7lh7gldXGovKffoULNwz6bWuHKgl0d2uNbiJ/
	 2CZJWGOh0UOGVygSLW/P+UWYIkvBJOFrYaimzTnIsXWxTHKVBBq2gZwCorJhSyIm1M
	 Z3rcDSXqd77GTdGzYMGF6R6YaVgjxIBGtUktVLD0=
Received: from github.com (hubbernetes-node-1a48c1e.va3-iad.github.net [10.48.149.33])
	by smtp.github.com (Postfix) with ESMTPA id 053C6340616
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 00:54:25 -0700 (PDT)
Date: Sat, 06 Jun 2026 00:54:25 -0700
From: mdzik-sue <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1106927/000000-71d8d3@github.com>
Subject: [bluez/bluez] 1f6555: btio: handle error from broadcast ISO socket
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

  Branch: refs/heads/1106927
  Home:   https://github.com/bluez/bluez
  Commit: 1f6555cda23c7e438bb3374f6a3669c396497b0e
      https://github.com/bluez/bluez/commit/1f6555cda23c7e438bb3374f6a3669c396497b0e
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-06-06 (Sat, 06 Jun 2026)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: handle error from broadcast ISO socket

If not handled, server_cb() will be stuck in endless loop of calling
accept() on the socket.


  Commit: 71d8d36535836f3bfd01736f3fca81d0c703b26a
      https://github.com/bluez/bluez/commit/71d8d36535836f3bfd01736f3fca81d0c703b26a
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-06-06 (Sat, 06 Jun 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: log errors in BIG sync


Compare: https://github.com/bluez/bluez/compare/1f6555cda23c%5E...71d8d3653583

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
