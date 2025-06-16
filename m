Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5F4A0C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111918; cv=none; b=Qf0QqXTQexEW01Tbl2nvPiEM2N5KOW4p9xist/DAOiz60orjqfrFXAQ8sHPh7Y7nLIadPV0TI5oXlIZzb3T5P906zJa4DPm9j5mTzis9sGQc4MHT3fOG7plK/IbAZ4LlFxuG0rDDHD2403M643iy2/Hgvpk9fcJjOdlOX7S5Y9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111918; c=relaxed/simple;
	bh=Cgz7taE3P6Y8mPz64CW9z4BWLVOjkDJwdt7SgFu9SBc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B+lj6CFryUej0cNLn+ZahDcmKxeHdnX9qpaCqr9El3i5SrdP7nvBq/bpECnD02VpAckQ/BDOfAT4UGheE9Bh2Bj5/zyhlL1s69K3hGvygkX9JkG8/4XETBSD6BlAjlF7tZb+tbzlvz7eI/y42hTz/ENkjpqmN2x12yRGJ2sqgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JelB0Uxh; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JelB0Uxh"
Received: from github.com (hubbernetes-node-18e9ebf.ac4-iad.github.net [10.52.14.65])
	by smtp.github.com (Postfix) with ESMTPA id D44B32002C
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750111915;
	bh=AmllI/uGzWe+EqP7X4/WKuDob9nWTtHvCCpKKom1n6o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JelB0UxhNpqYialaUMncrt1FJSb4tLDsYl6Uew1QMpwD3pRQbbTzr73B0LZkW61Nv
	 U8D2WBhcD9W4ByHP3lmeiGIO3c9hS+fIlh17WP8Q23dF7NJWOSR4P3c88J8k/BqnUN
	 uL3YoZZjwj3jOgJ4bTRkZB2ZvMc3DaVhW6PerHDA=
Date: Mon, 16 Jun 2025 15:11:55 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/971855/86eecb-000000@github.com>
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

  Branch: refs/heads/971855
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
