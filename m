Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077FA2356A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241292; cv=none; b=erputLOZwiEtHbSw4JNsdbanNfaI8Fi1NXCRl6khaSwt5fNEMF4H1XAreG5bjkmcxEz89YuiVci9UXmHIV0RkzMtJQNsdHQK5BFrunT/pV6M7NoFcupbUZqYNPJW1M8qWs0F+bMghGIttmp/S5bxQXdUFw3M9l74z6J5f2BfmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241292; c=relaxed/simple;
	bh=DmOCIBdGKaFbRQBq6bj+5euUWCrrpU6TAiUlXJHC83I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=raDmNJea+WoUK796sfgE0nszju3j0qp5KYXOyzZFG8snY30xI05f2d8HwkgULoMuTaMipF4nQcRYCygpvSYsjMavs7BU4HA5YjvEmXhE/1ruPs3yyhU0qdrEQx9u2a/238mZL9DadtaCu+8gLMi71EvoIdE1eRKAp4mgKNvYNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=C26JH19E; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="C26JH19E"
Received: from github.com (hubbernetes-node-f6cf74a.va3-iad.github.net [10.48.180.49])
	by smtp.github.com (Postfix) with ESMTPA id 202BF3C11BB
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764241290;
	bh=piZuYGMVugkCH04eIgOQyTjUQc4v0WZReTd8CPq2FTQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=C26JH19ENo1YmfOh7mnstGxlB1OhUhSQ2GePS8YdjFz7HHf7/CllGeGI0Xxsv7Xf4
	 PF9+CGz9NGFdxPYt7bIWgKWNoDY+QtIsjfxfGEr9PptJmgXLMo0IDhKA0sDB0sQxyb
	 MeSzWe0Bt9nAcnFrBToYFovBGzAa9UOGh8zdjD4U=
Date: Thu, 27 Nov 2025 03:01:30 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1027639/c63271-000000@github.com>
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

  Branch: refs/heads/1027639
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
