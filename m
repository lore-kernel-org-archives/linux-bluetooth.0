Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE838F92F
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065853; cv=none; b=fTGQBQs8T9oNlcPLMLUhdh8JpJyg/R2MfW6Eze+SN7/wbPhhFRZUSekZF5++TlDsVytRWcfqLDpRl2cj+5WjmZfK65e+Gist2RSXqs0QVXAMe4H/gbNYvxzp9J0mHJaQZNK6GO2NT4jJGs14+3aTR4q/+aH1UTbRv9nELTmROqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065853; c=relaxed/simple;
	bh=P7hZph2QUmlRvjGa3/OeWYLnx8VIXy21h6mW52DiaLI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BBJ+bJqjtgM8FZfxsrz+4WDRUUh911LasQECEUHgWOPqlOc2WyjOgbY/R78kzHUbokZDdNMPpha+Y/qle1fKzfdsjrJTweV8jOpkMxG8rQ3Mu/JTSKlrGlr1h4+oVGdZrE43KppeRbmBQeV4ud5/ljlxewdRFrUuYa47N41IxM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Kb8iBE79; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Kb8iBE79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065850;
	bh=To5DTrAm5/Zfehkpr/Hn4Tu/HfOZKDfXq50bx4riJZE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Kb8iBE79TsSwY/H8NnJbu+X9dQAAiF96OdrXeo68lUMtx2hyUBRf0IbUdJ50v+pJj
	 Rb4FomlvrRuxs5zxLYozxyGCevO2J2Rr6jygVFWwQ7HtVvi/aW1U6KFnvfaSJhgZz/
	 LIhI7/ylbZ5gCDD0Uv4fCw2cRkwMT2J8a0MN++Jo=
Received: from github.com (hubbernetes-node-2c2be67.ash1-iad.github.net [10.56.145.39])
	by smtp.github.com (Postfix) with ESMTPA id C63195214B2
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:10 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148530/aa500e-000000@github.com>
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

  Branch: refs/heads/1148530
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
