Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC9612F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857429; cv=none; b=nn3Lb1gWWSsBpLDpBl86eBIM0qqGbLJeJZT3caAvjTIdTG/vDi5tTVQiPBwQOLyzgcFe/FH2doAzokZC6RvhGVaOpCGow/2vhk2WqdH1H8zHJApG+y/50z38kIOg5p2cxlh3raW+eqO6QxWTmdTbC1U9oa2bk6uuSF8Jz3kkuyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857429; c=relaxed/simple;
	bh=5mXDVWFko2eCvYXxUCkHBUf+M5Z4WvFcnr1M+uFO1as=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JwK/okYBRUsLVOWNmAzDgUqQbpt8F89nvV8Z6xsmLrGQeaqCJOrT2EoOGvHBJ7JKWPiKHvmme0k0ZYO0K1+/wl0JR/n+q+HHC04cKFEuc2Lj529IxDqXyyK1ywicN3sSX5GXyhKRJHjhWpsrnYZs2FqEXK+EcaXDNrarXnUSP8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnp/RC5Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnp/RC5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A0C3C433A6;
	Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707857429;
	bh=5mXDVWFko2eCvYXxUCkHBUf+M5Z4WvFcnr1M+uFO1as=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gnp/RC5YremXJpBtGO8EFg8pZIZ67zjXyyCaZ+hSV9OqkL/28JHpKA6krggM94nix
	 UM0j6c/vWHKge4r040hekulJzttec91lQgYCVkGBLMUOSOvNGZKyS/a1tVSzFAArbE
	 fYsAgRK2Ng/mzNbDU/ynxI9QNJptxLACNrJtjnJaEeYtxBw/s18zre4wB8Mgk1w25q
	 DUAO/2yjzgHAmPym2PK9cvtLgpcbAl4Trcnjw4crwcwAvPpJoK+oXlGiHhq2iRpXlN
	 upnYvfRuw94A363HnnCv6L3NvUu3XVBONRODWZBF+kRCPOYIitJeTRJJptJG0ihXhi
	 l2MSEfjjt/k3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1F20DC99FC;
	Tue, 13 Feb 2024 20:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] lib/uuid: Add support to compare 16bit uuids
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170785742897.22526.7013157781837651920.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 20:50:28 +0000
References: <20240213215703.21507-1-ajay.k.v@intel.com>
In-Reply-To: <20240213215703.21507-1-ajay.k.v@intel.com>
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Feb 2024 23:56:58 +0200 you wrote:
> ---
>  lib/uuid.c | 9 +++++++++
>  lib/uuid.h | 1 +
>  2 files changed, 10 insertions(+)

Here is the summary with links:
  - [BlueZ,1/3] lib/uuid: Add support to compare 16bit uuids
    (no matching commit)
  - [BlueZ,2/3] lib/uuid: Add GTBS UUIDS for Call Control Profile.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24d97e35fcde
  - [BlueZ,3/3] shared/ccp: Add initial code for Call Control Profile for Client Role.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


