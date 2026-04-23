Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC6C3195FB
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776963169; cv=none; b=s/phGZPwE640lJxrPZY0uZ0dxTIMfLiwgEruFQKL/fgFravbFCspw8NRCmM0gygUiIU1Ql2s3HaUhIXz+AHgVQDFvLLsRYHjegEil0qz3wyyFQr73qFVou6RyWyPcNJAuFRRR2PP/nMUM9sXzSdBc22qFHtq9+MfNQqCtDysihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776963169; c=relaxed/simple;
	bh=vE0Dcr9GamiG7f8tKZ9DobaakknFTc9Qfd1PE/8usCA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EoGtn1rGd0J4MtS9NHDwcmRLrUA/y0e4dKxUWVMOMLsWNIdyqeSFx+sM5RJFf0cKBbD7u5mrqq5YgZsN2ITZizV7uAs4JSY7V67P2k41D9KSeZcII9/oLk2ZfoPt/R8OGzeDIfNnbv0sjDnRcsLmD3OW/eZK8RURwyEyjTzF1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DH+fWVhH; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DH+fWVhH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776963167;
	bh=L3SZMO2hjT35FGeJ1bTHl1a3errk6J0Ml01KEL5eoQM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DH+fWVhHWU5p7myfck1Z8LtnzosIbiRbMuZfY3PQd78lAWZFjglwMJ0lb9rhzgOkb
	 NMEbnvKUZBbT9303lQSDOz3M5+N0Y41XixlTEfKwo8wAxRUYYOMjs2ut5mt4HntKIN
	 EebIWlo2jZgez/ij1uTelRs/fzXqh/Yc/xpYF+Wc=
Received: from github.com (hubbernetes-node-20636c1.ac4-iad.github.net [10.52.220.72])
	by smtp.github.com (Postfix) with ESMTPA id 19B83321131
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 09:52:47 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:52:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084336/e4a8b6-000000@github.com>
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

  Branch: refs/heads/1084336
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
