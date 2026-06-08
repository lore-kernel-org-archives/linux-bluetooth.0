Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755FE367298
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918192; cv=none; b=SOU8Fqo3Wr0IrHEfWinw0liUcFVIQ9uUoHdEYgKGGo6OwsgwweebGD+TmAovgnUgRJh6gEa1mBzma3szUVyKO0to37WetOp2psSsPp5epFgGLaSBVcj8dLfefdrXHGVxBRtvNd93ZlHQ4ZQ5JybKHkiovucQjYUaoKkpaEZdijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918192; c=relaxed/simple;
	bh=nv2qNe9YepXu+K3twUMVH10S3aWdBjuBGwwVONokYQM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RPbvHWz+ob5QDW4t+PBm03vDLLN4kkzF8EzWpVUqhcmfHwmBaqovQLyQO/Uf3RCvoWRhsO+/8hG0SREqZ4556orjKpsIZ24SPj/4nup24ySHUThjh0fbyCG+rnAQTtgv7rSKHVprnjWf/OF6xhs8SnR63cT9K7B8wF5OLaXDZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XA57q+fg; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XA57q+fg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780918184;
	bh=oclHxxUjSgrscyrYmUR0TEndQnsXhCspyoM0UQvxw2I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XA57q+fgMb07ix3zid8kag/yNAw4FJ/DZ/hq4p8w+Mb9QWuGXk3AQqokuwTdA+S7L
	 UmUE2h8U/TR5N+UBlSy5GAz4OrdlTgSPyoBNZFRHjbzuFmt6ilQk8CSPfg2NZIEDXT
	 TBC14SAYc50p3Ol6O8fwGzNA/oCZftUDPHiksqOo=
Received: from github.com (hubbernetes-node-dec98d2.ac4-iad.github.net [10.52.206.127])
	by smtp.github.com (Postfix) with ESMTPA id 70485741123
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 04:29:44 -0700 (PDT)
Date: Mon, 08 Jun 2026 04:29:44 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107787/000000-f254fc@github.com>
Subject: [bluez/bluez] f254fc: device: Fix auth_retry timeout not being
 removed o...
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

  Branch: refs/heads/1107787
  Home:   https://github.com/bluez/bluez
  Commit: f254fcf4fb7340e4a2d14d3ca63b918dd7868dfe
      https://github.com/bluez/bluez/commit/f254fcf4fb7340e4a2d14d3ca63b918dd7868dfe
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix auth_retry timeout not being removed on reconnect

timeout_remove() was called with 0 instead of the actual timer ID
because auth_retry_id was zeroed before the call.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
