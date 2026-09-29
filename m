Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD22353ED1E;
	Tue, 29 Sep 2026 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694636; cv=none; b=qtAjuYRI1JGWbXOH+HxDgEd+poNZyNWNdmTk8TtIB2D7i+WhVNF481hsUOYygyvTHoYCFX5vAfyFyIfqO/bOFYaotJx7ou9rZwSNbI3mInBluzT9/OYuXRXpJE3Qi3HfjDNEJhX3vz8jO72HebAmvBxwSY8PYWM7buTsidqagSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694636; c=relaxed/simple;
	bh=99zKdDC8rrrjvxVQnsMZqR/BRkDhrgmCeyOsNvGf1p4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EaPUtc7akW39YxMNRuIHgVsSZjTJswUhIfngkrhI1LhdHwaWtFeD7UueLVe6o7KOSxvHS2bRYX1jdvRXhGA7lwtIheT2cXNfod3xQ2rUwhc6V3xrhsIpubXIeAmGItZ9wSvv5sG4UX9qPADifdcGBBDWDuxwdMqhrDdnYvufA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN+Rp/tO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN+Rp/tO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071641F00893;
	Tue, 29 Sep 2026 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790694612;
	bh=tiukCrt2924ZzoATGIcEIqmAoeFgBWfDg4x+Ucf7wwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QN+Rp/tO6fDYD1n0z1f5D7E9aA5Qma+z2i1EYS2ptGhk6zwQaDtMeF6KvKQL+XFdT
	 s9dvwqfOWSBaLVN2KltVbXxoQaJBcy/OLbTio2Tlc/iEldyGHsOoz/Ctofxv2Chiiq
	 HjpJsGH2N+GL+VofrY6qDQ7IEpK1JwtR6ullI+uK6utTkmszgutqKEYRqOxrHd68jY
	 RqhgnsPSpkB4EkcRlbJimajQ9WXvnJODzY/1TrOqxJvQ/VIJi6F9ue8eNQ3/0Xdnn3
	 6yzqmbVm/TQytBVuurtqS7+i2Ptax8lrU6056/BT8LhPdZ7cSWS2o5vy9G51HIsiy9
	 wXKjRFVCvLYRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15793927049;
	Tue, 29 Sep 2026 15:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: RFCOMM: connect the session socket without
 rfcomm_mutex
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069461052.983246.10195137222615852144.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:10:10 +0000
References: <20260929122226.98970-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260929122226.98970-1-mikhail.v.gavrilov@gmail.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, nicoyip.dev@gmail.com,
 pav@iki.fi, r772577952@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Sep 2026 17:22:26 +0500 you wrote:
> An RFCOMM connect() issued while a BR/EDR link is being authenticated
> makes lockdep report a circular dependency, and the reported cycle is a
> real AB/BA between rfcomm_mutex and hdev->lock.
> 
> rfcomm_security_cfm() is called from the HCI event path, which already
> holds hdev->lock:
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
    https://git.kernel.org/bluetooth/bluetooth-next/c/ac022970e9fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


