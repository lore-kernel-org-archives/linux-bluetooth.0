Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A291D7992
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385820; cv=none; b=UXc/VOxjB1MLJ0y7mKoP5tahMkv+fZrJ9YF/GGhu+WQ914N4msipwmzeG++YFNvBuKPtkaxwVtLqypWrLo9FrqjWp4OQ0z9xfZZdsqMGzgpvvSujmwW6mSIlrl2+ZeISS2xPGgUl5VnX4+vFhcxhWLl38dU8jAttCOFspr8es3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385820; c=relaxed/simple;
	bh=EuKrEJFkOs+Vp9wppq3x5k55sDfyupB6W8aNuMI8/6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tGqb+RObEtv5CZMl6Wlzh4gDQ3fBX6U62XBh6YXavFmutQrQtlywUeOkDAEYCYZZp9P7PNp1XcoQWp+fwgs+Kpg8tmoPMKw2mL3n1wCenINwwqitdOiz5ig5c2eIYnfNhmhDW5vzb1Qt8V9YzSFo5nsqwmyP+cFjS5rKypimNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujZeutbU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujZeutbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D3DC4CED3;
	Mon, 16 Dec 2024 21:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734385820;
	bh=EuKrEJFkOs+Vp9wppq3x5k55sDfyupB6W8aNuMI8/6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ujZeutbU3OrPnu+7ZGQG/Ropz0HCVyl4vAIJJxi9B/T3D1sWRANfpwxVEk4LGYkmP
	 3Qg5ygXwYRJpyWQkoglHcZe6V/p3RcSPq9OsBoUECVFKp1rkRuyy6WplZHXbisbV5P
	 qNR/wT3cu8H+110rdNkh9fsHoDVCvXHL3db4LL375I0bIK/lXJTNUF9QBqexwiT3Z6
	 27121OKczBg1cPn0WsdvzWPmNDq0hV2/dvx9RqZw349VFw0EqwC7meozqYpHxkW9na
	 KZSJ5gvQxl1BQbj/nHgrHE/WTcrlMZANK54U+dCS3+pFcyJkLpe+0r+oiGRWl6n7aX
	 DCNp1/j8ieluA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB83806656;
	Mon, 16 Dec 2024 21:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] Add constant for 16 bits transparent voice
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173438583723.361160.15138474924465257449.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 21:50:37 +0000
References: <20241216184613.135538-1-frederic.danis@collabora.com>
In-Reply-To: <20241216184613.135538-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Dec 2024 19:46:11 +0100 you wrote:
> Add 16 bits, 2s complement, transparent air coding format for mSBC.
> Corresponding commit implements functionality on kernel side.
> 
> The voice setting is used by sco_connect() or sco_conn_defer_accept()
> after being set by sco_sock_setsockopt().
> 
> The PCM part of the voice setting is used for offload mode through PCM
> chipset port.
> This commits add support for mSBC 16 bits offloading, i.e. audio data
> not transported over HCI.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] lib: Add constant for 16 bits transparent voice setting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b631e09e943
  - [BlueZ,v2,2/2] sco-tester: Add test for BT_VOICE_TRANSPARENT_16BIT constant
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ff07f10ee4da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


