Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F22305976
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465990; cv=none; b=EFikyTtRhsVJCLXfkF24v3Pg1YG+GPBY7Lm9BkJZqAMYTEZl2hEYJVoEsjl1rXul5r6+90IS9fzoar6v7LcQrQ5PCtBZpiDU27Tbace7GmM1qZ8e211P8NXu4sARnKtkcad3OYtOM+FV0r8smIcqkQt/b4u6vsTsuhjl0xtdCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465990; c=relaxed/simple;
	bh=U51NIzkfPswByj0Q0CodDa6cxENsfQf8ZfuBKy/JtU4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=k+jIgaZYeUF4cplkR9THAb0WmDW2gWsSgdEUCeWHHZvRo9z12A5FbOKoCvyy95f4yUaMYcyL0VCLYNWHAt/IuzIdh7wMjmX4SRdOp7L6pt0FwTtwVXfi/qFPGcMfBOSn0AiC3JE/siybq/T1F9OIbPFg1h3ypcvUE4rBWPUijoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bId8+ERp; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bId8+ERp"
Received: from github.com (hubbernetes-node-5e24f68.va3-iad.github.net [10.48.209.64])
	by smtp.github.com (Postfix) with ESMTPA id 8F89D3C014C
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 14:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769465988;
	bh=/c8BbkvODtTZF8u8IIW9Uc8E3euSYLCWIgKpJ1mTdhM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bId8+ERpKubm6AtiLygrSTzAeG0KjEQfcgEkdVFCNFtim71RT7P9KwEM/a/L+o5rZ
	 Zbp6SoILnfN1AujyNrhZ//a7w/A1wxA9rwBqavAezMCHVSdbQiOk623s/JlrUT8Ezu
	 GtyyVJ/ztu6mBKNZOf4upM7dljwqClxLiSRPOM4I=
Date: Mon, 26 Jan 2026 14:19:48 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046202/ded731-000000@github.com>
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

  Branch: refs/heads/1046202
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
