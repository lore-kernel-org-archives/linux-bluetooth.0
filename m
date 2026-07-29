Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAF342C4F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343291; cv=none; b=eP4t3CDbanXt9mlv7kaanrFQwdfurqSEQJHU3UlWEoFkR5ga0xM1kdp/MFKpu9pmDi5S9xVpFTNtD26UVNssz0Jp7UCvNYoyZ64GBRDcM6rWaSxH56reiVGVST4Z5L6Py/5SESrys8NrDLDp58EjuCNKmEKo6aGjVZi4KX5Cs3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343291; c=relaxed/simple;
	bh=aYVxgn2jqw2yJNLFd5cugMpPVHKeYXBI1cnX0cjcQAY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TmBo9O66wwQnfjeEowmcHR+N1GQ26lxoJY9xOgUmokP+bFoMXxskJR2yuebk4YPkX4KAxzSObEQNifeg7jT4UPxsGiTrRihUs1SSOoeTt2SNDLIwu7Fz4DLfVuZjWbONLtduGDfQdeLM4QugEj8v4XI/6mP1JDh1VL1uGtyECbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bGVr5mqd; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bGVr5mqd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785343289;
	bh=D4wkTwWr01n0ZctJybs6QhyaZFxnYERY3jnj+0wyr6E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bGVr5mqdPa7CFdxLcxRU4bafLNzhY0mgE7o4QhhfLOy5d3V+AbD4COQHNwr6kPFtc
	 zHguK1vGLynp/pFjm/a+CWWp0oaqnqvjN+tt06By0YRJJ9DPDKqgDwKMYfpNkU5gHi
	 9FkB74201U+7iKuWM5yKlk7p9Z+f0gLjxSgtQICI=
Received: from github.com (hubbernetes-node-3ec50be.ash1-iad.github.net [10.56.189.42])
	by smtp.github.com (Postfix) with ESMTPA id ADF2C361179
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 09:41:29 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:41:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1134915/fc8f42-000000@github.com>
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

  Branch: refs/heads/1134915
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
