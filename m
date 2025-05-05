Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E32701C1
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477872; cv=none; b=juRN4XMaaIUy5ShJe4HizIDS5PJbIsX6SSY0/CxsZtvjKkooiOyL9iiYQG9qhmbFe032ob55VHjausc7/DrPQ1tCvdfLlB4WttXANcXS0rwXwmdw1kOtxQ5H3Q3KrQd3cGqfIOgcGodQ4V+/8DSYRGLXPx+kjp0wSdZxVRRE8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477872; c=relaxed/simple;
	bh=Vcfv2Vsey2kJgAohDU0kxyFu2w0kYBKQkf8VcT6y3eY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qKZfDSomv1ebxGjxhy5Zlc5do9KD+MVQackRVzTDpsaArt5DBdWZrslLu7SbGh7s0D3F+aNYI5H+J+fZ8k7NCfTCX5alZg+2kX5YTwm6kv4x5vKkvwfD3/FDtntlpfGL5XL0xoWzph5N/1PCBw0V/z+lnBGhWnU3tU0E9Anw188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Hl9MmLrg; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Hl9MmLrg"
Received: from github.com (hubbernetes-node-028f8bd.va3-iad.github.net [10.48.141.43])
	by smtp.github.com (Postfix) with ESMTPA id 3E2CF8C083A
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746477870;
	bh=TiZciZ2AZiLeOr/H6Q/O64gMzuS1jJ+Zs2J9bBmhtug=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Hl9MmLrg899sD7iAD47YmhqdR8vWQIYkUjZNrWQ1t54aUm0kfo1msCOsewz75DLRZ
	 JQLqDVk+UEv/cYHNDEEvvyhaWiRAZ43pX/nXzSUWCy0yNaPb9IeMODnp/TPa2r6Mi9
	 6nPz81GNKBI2zQAsDqXmDfzXyQXPfTyerqTuQQmg=
Date: Mon, 05 May 2025 13:44:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959619/bd6c47-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/959619
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
