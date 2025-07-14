Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7623C4E9
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752527854; cv=none; b=RKX0X9U5bwOaNG/9B1WK/Diw+nF+cDOT1pS200mj6IelCd+MbmeJUewNSSl6xlqWS8gSvS3NBeWs3aA7GL1pYM04D838p8j3leoEF2aq1znTvXGCfnFyUYYjF9Q2KNbNpQHq9I75MJi6lkuqlYASAUQo/j7iX89PpHBNKxgGUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752527854; c=relaxed/simple;
	bh=L9mj9K54BVmc6OSQPVn0lX6+EfaJbpGp6uY7grkEbsw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ujYcedQY3yKb4eOCyW/sAgn0tRFOxJki1OEysLwoqp3DazBIg1qbIcw3oSOxzpKuOfswmRK5RyUtPGkMRCinAZuZs+KoJCQQFWfdhmv9Z27+B+YeP77FDtU8tDqDQZJnnBJyQJS8tGlYMy3urUCKSMkTI17peq0pYIRfE2ao+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FlL1aslI; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FlL1aslI"
Received: from github.com (hubbernetes-node-cc2b0fa.ac4-iad.github.net [10.52.166.13])
	by smtp.github.com (Postfix) with ESMTPA id D9041640B3B
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 14:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752527851;
	bh=WlUAQh3aZ9Kzn1fxFu+qqtkbE1oaMnxP6xsAKJWmWEU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FlL1aslI+gVKS8Iyc0nnryJedFRDRjUPgirmW/W2ICSSc3PdA4nHSMLxKLvfpUQtZ
	 DRN3moUJVUUqAD0M3a/nRfktMkw9RxjQsK6VQGO9txqr98TCJoDH9bfpwyO09JUAR/
	 /xIt5RoBKS5gia1cz9YlfopJzynJ6QBtt7dxm7Wc=
Date: Mon, 14 Jul 2025 14:17:31 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982133/2ef05e-000000@github.com>
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

  Branch: refs/heads/982133
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
