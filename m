Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F101B87E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385818; cv=none; b=G114VXBVb15XIRdEFkPzUgfsCoxkyXzirQJ7pMk08MT2mIrjfhY/TAZlb3qUgArn3tjBFeBLfgjcgxt9+mgKQ5A7SYnSSml1UaF85QgRfdaTu9JhWOpbiobo6nrkZvfKeLX1sQB5ZOnYzROUvepot6MhGyxnz3H6vywwrnuDBVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385818; c=relaxed/simple;
	bh=KykcwYtryHHp+Vu8OzFNJs8ZQij8u5Pq+8aUW5rjOGc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c4OwjDBuaWKzAxBrnDCJq19srU914y/xfvQYPxFgMFgvfna8YbV42WsV7B0EmCVrVNjvdQvMQSW5tdscHn8w4R6Uap5zUaJyPCo5njF+a50FJDyRlu5dJLNZY4kh/4UIZWBg4L66Kk+hY9CDgcGUMY0T5Na/R93Mo0YA6kx38K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2N+Un8R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2N+Un8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAD6C4CED0;
	Mon, 16 Dec 2024 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734385817;
	bh=KykcwYtryHHp+Vu8OzFNJs8ZQij8u5Pq+8aUW5rjOGc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d2N+Un8R5HhHwqmVVVvj9/Bu4wvpqMwEf3DvJSBXUzP2xHvbGNeYs1NnKnnVUXT8g
	 9S99L3gSSESvap9zmFYgjzxV9NzK/nW8doJZqi+ccs7HgN6KiI1LydqnmimGtB1gdB
	 sMj4CPl//NoYlem7rcPEeUgYEVMKg98F/pCq2iYY/uoG/PFn9kc20quK6qkI8yl96V
	 fspuCB7ULqP0TubqkeAEZOP/VzuOaE4verGki5cC6m/xFhRFC8oqyi3JWOmkhQVanT
	 v/dMy9lVOrA+fsr0cC39BRBrwumw3LCWYCkd709UZxqYE0F14a2BvnwaiKMChE6Yfu
	 T7OWYuEnZpDjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 018863806656;
	Mon, 16 Dec 2024 21:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] obexctl: Enable Map folderlisting operation from obexctl
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173438583486.361160.18150307733869076812.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 21:50:34 +0000
References: <20241216152330.2579138-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241216152330.2579138-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Dec 2024 20:53:30 +0530 you wrote:
> This change is required for passing below PTS testcase -
> 
> 1) MAP/MCE/MMB/BV-01-C
> Verify that the MCE can retrieve a Folders Listing on the MSE.
> 
> As of now, user is able to initiate only map messagelisting
> operation with command 'ls <folder_name>' and there is no way to initiate
> folder listing with 'ls' command as second argument <options> is
> set as compulsary.
> In the obexctl code, map folderlisting gets triggered only when there is no
> arguments followed by 'ls' command.
> Therefore in 'ls' command, make the second argument as optional.
> 
> [...]

Here is the summary with links:
  - [v2] obexctl: Enable Map folderlisting operation from obexctl
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2caa26a4d62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


