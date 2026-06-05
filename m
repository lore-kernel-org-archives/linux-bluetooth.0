Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED779CD
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677010; cv=none; b=MNwdcZ9qWu1CJX/Izh46wGQnXcgWd1Jp71sLRaU7xumEyfSHPIF2fDbtDZ5nUflC7Mhe4Y66W3C7lrjp7lGVWd0T5pDzqWhrOi1YOAo930Mw212Co2hBNvg+iJPl2gkZqHfzOWoKJ2GcaBya/nkv8OEEag4xwwHF06W24h2Yb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677010; c=relaxed/simple;
	bh=BQCZEnpULoxV60A814NBfOYdiv1n1o4w3iXsUfYRwKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=unQBWubTjKlOuJf0+8DF0zEkr8T8byfP6Ywh+tOROLg1fEDIfSOykMKhE+P7EU6HPuOfX5OZRFu37BqoWDU6jG72ZfOLPx/QYIX9bT3Xy6iICxVTOKeQ/G1DOUPPUU7u334f5y0Pk2uFkVoRSiwQnuG51mOEVQU8i7DcT+7SthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPBtatie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPBtatie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0753C1F00893;
	Fri,  5 Jun 2026 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780677005;
	bh=nqT3XlsjzHfAZAdH6RUzLWJ3lYRpV1DoqWTo/jF2aoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jPBtatierEblA+33O8VVDIj6vnQ9xIalmD/fpNuTOFXI2K/2qdIkrEKAAZ0AQ+Ug+
	 /folVjD3BY9lHOfVYV6CbdyUDbByggxrrG6waBxG29AK0sVYAZ8bT1aMQ0FphtYGVM
	 K18XWIr0EIE8KSQzu27rRnQH/v1/4EUCwQvjt8qmsu5whV4H05UQ1Rb1blk0ZYwKwU
	 hKV66vR4pLInD0U2bmWnK/BLiy5+3DZpfsDdxlUqlPFwhyMaaX4dNKm2paw/b2XsQC
	 8qC8Ng1Sj0R8Sog+dwGIy6UAG6ph2OQ5TeWf38Xr+bPibNhTxExZQew5haH3e9Bx5D
	 2FW7ndULQUrHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939FE3930BAC;
	Fri,  5 Jun 2026 16:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obexd: fix PBAP PullPhoneBook failure with ebook
 backend
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178067700540.3831182.14159878683070316070.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 16:30:05 +0000
References: <20260522060312.1503481-1-zhiyuan.sheng@oss.qualcomm.com>
In-Reply-To: <20260522060312.1503481-1-zhiyuan.sheng@oss.qualcomm.com>
To: Zhiyuan Sheng <zhiyuan.sheng@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 22 May 2026 14:03:12 +0800 you wrote:
> phonebook_pull() in phonebook-ebook.c does not set *err = 0 on the
> success path, unlike phonebook-tracker.c and phonebook-dummy.c. The
> caller vobject_pull_open() in pbap.c declares 'ret' without
> initialization and passes &ret to phonebook_pull(), so 'ret' retains
> an indeterminate stack value when the ebook backend is in use. The
> subsequent 'if (ret < 0)' check then incorrectly triggers and rejects
> the request with Internal Server Error.
> 
> [...]

Here is the summary with links:
  - [v1] obexd: fix PBAP PullPhoneBook failure with ebook backend
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a0c8ebf91e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


