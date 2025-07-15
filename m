Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B161922C0
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590518; cv=none; b=bG3fbO+AHBhLLIqBw4tTt3oQyJDhSHYLT0xEa0JOO2PiiPq9XOkFuOid9Z1LI8gORUjEkPgNTPQIateh6jJU8CzXMk4OKo7p/ZHpwcu6L8a/jFlJNpTLWXkR0EZb6AlnwQ+C2LhtgjB2AHyt3lUtmBR5WBwDgLcQoj7IaJ5Slzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590518; c=relaxed/simple;
	bh=TyMBzt37JKdGSIqsvsPEQJdyYQlapWfdB3IKfFn29vs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pgLVQclVIZeJmOKKe5zKWg819VjSc0abAX2PxLaP6pXjq0MlxrK1ABmjT3DX8AMJ9/DDD0vEDythrgm95hNB5w6XrApF7HtjbXH2PGChOVi7dHcZ3DCrzlnrtkjo/ivUezXmZV/ooJ+tPpgwqnjtJiEqJG+zHU19MlLvaMi2KEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TgMZVhbF; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TgMZVhbF"
Received: from github.com (hubbernetes-node-73a420c.ac4-iad.github.net [10.52.184.49])
	by smtp.github.com (Postfix) with ESMTPA id EDA53211BA
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752590516;
	bh=3bQ0Q8rkOcDyZZLMV24HybfDgaZfgbefymA23l1gbzQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TgMZVhbFtvQiuXLJpyJP/7gYIs/eNZdaRanr2tIex7CC7TJBVhXeu7DVeIPTiZh4/
	 4ngX/a8SRhFnadZ7/JoFInuPheXVAvLAoOdxpOfrsFTuM7e6Gh8Gk/d5KMJp9zoONH
	 kT7Qxd2i+vynQJPuYGJLEzi+pKRa500JoIrYaYIg=
Date: Tue, 15 Jul 2025 07:41:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982542/35838b-000000@github.com>
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

  Branch: refs/heads/982542
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
