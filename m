Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88041D12C
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452112; cv=none; b=unWje4FD0K5fQJ/iOWsAx2vEguiR3VXhuwJfubExHONC8TE2Rh00lr8LHap23/IlE/UJkUnpJrEv9yW0jA7soqsPKA1d5LZ7cKFPFoGQBiUQZnCiMbsSyVFeTlRqXWdkWcGOGjBqdkUev0raMIoYftcp9dNOFupVL4gaxzkHRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452112; c=relaxed/simple;
	bh=HqZ7G+JPRHcv9enLYdrXnBpZQUHqPiXtNoz8OSmk9cA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kd048hMhA1zhJgAZyG1VMgaVK5DWHe7ovMwFD4/ULSproVIrbZKQ+SK2hOO7GiA4Ibq0Qtefosk0Pb9lLiIG4siEypomPVwbHmJEABoFlxHLZAC2pGqQGAf81+RBdkvMWrkM9Whl7kt534RyylR/xGOcm0dc2LydDGxNNUYIrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=afjda4ue; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="afjda4ue"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791452109;
	bh=Z5LRQxVoZssEOTN63yBRKrNDSXOTJ7NhACnTSO6309A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=afjda4ue2zWPQB/AAq2tBLPTSYUOx4t5Rq7S9KoM4X4y40sb6khscIHF50JN9aoOP
	 cKzpJYvy58rEhgmkNegQEnZ3ja+JqG8zTkmwEqAOzmOtBwTv6XWqGOPgJ8hsHOHYEw
	 tV/U9qKvDBUr9uX3KjGFn4cbxD37bHnwp6pXlmbl3t8RfUsDrt0OTgi7vq66LQPNkq
	 EZrUCEnrN/cSFAL954regfl4leJq3A+U/x+Evqs6X8uhwJkv2uMn+ty4HXcrBnJ4SJ
	 jLPLs8bGoZmWBDQAgs2UJ7fes+3Ck4Xhn5Ctdf6HGchAwIlecjrrqpNyDTXoy2rZO/
	 X15AHb+qaiJrg==
Received: from github.com (hubbernetes-node-8800d98.ash1-iad.github.net [10.59.99.33])
	by smtp.github.com (Postfix) with ESMTPA id AC9B43612B9
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 02:35:09 -0700 (PDT)
Date: Thu, 08 Oct 2026 02:35:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181104/b904ef-000000@github.com>
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

  Branch: refs/heads/1181104
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
