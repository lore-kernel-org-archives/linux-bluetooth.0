Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B77EF18
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Apr 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402231; cv=none; b=ocTq7IMkdKrL2K5iNeYp7VAQlN9k5ybe0hw01sjIMVPeFA1SByByg9hFC/23+XcBvoNvY+0qrPWhSV5hPAVoWoIUhMONcNXaeNALTFyIQHGWc7wTkrBlJ9Y/02kYVieXTAn3QrtaOeCG5iz30P22XBTYvlLNz4YEGKi/8+MpuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402231; c=relaxed/simple;
	bh=DKU5w6T7jkZ5EPyu5nI1M+nVrlS9HqfoOVKJ5AVsGoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S3C1uBBy4kdTkpfg9P67SKUDCuGtNXjIWnni7+7F3vLi5zKHeXRecLVAr1A6+ifp1nrSroOrop7RoxvRLuVawUW439SoSJ5SK/wlSB2gpm5N1ZOxzcCrDZSLY/i81jJGdAz7oYLjapuu4wOPLbcGbPVja84kQbnnCQHvQvLffbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcjs+Ldm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcjs+Ldm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C57CC116B1;
	Mon, 29 Apr 2024 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714402230;
	bh=DKU5w6T7jkZ5EPyu5nI1M+nVrlS9HqfoOVKJ5AVsGoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kcjs+LdmMkuj3q2LwO0+f2ECC/uVh4FsubcAWRwKP6BxrxcSBSyPeohQ10WvtTYiH
	 JHFICeIyUcUEpi8jwH40rpDuLxU8GH39gEdKrUtOz9WU7HC06sOkWx3Qq0Le7FE/eU
	 9shIEiLXn0BobL3vmGsbxvLhCtjoD3zyavooJYdlzvzM+jVZAfb16ezGvun8o7e6Vy
	 s11ZmoyG5xv7futhh8DjgCeWBxdqjVuvXAnwEqdseIPQJemG0V5AnYarFZ1xoeotcF
	 3UMZj3bVCIt56AUzIWYzYglTTH9dfSKx1HbE7njHNCgtNXg9c3bgnGriZ86ZrFlAoP
	 wJpPCWr3aItlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 232AEC54BAA;
	Mon, 29 Apr 2024 14:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] org.bluez.Gatt: Add
 org.bluez.Error.ImproperlyConfigured error to WriteValue
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171440223013.10266.7151781521429895730.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 14:50:30 +0000
References: <20240426144826.2608852-1-luiz.dentz@gmail.com>
In-Reply-To: <20240426144826.2608852-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Apr 2024 10:48:25 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Some attributes may require to generate
> BT_ERROR_CCC_IMPROPERLY_CONFIGURED when its CCC is not properly
> configured so this adds the possibility to generate it by replying with
> org.bluez.Error.ImproperlyConfigured error to WriteValue.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] org.bluez.Gatt: Add org.bluez.Error.ImproperlyConfigured error to WriteValue
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=129b19166304
  - [BlueZ,v1,2/2] gatt-database: Implement support to org.bluez.Error.ImproperlyConfigured
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b29784717f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


