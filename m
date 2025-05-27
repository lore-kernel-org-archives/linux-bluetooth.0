Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D029134CB
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354393; cv=none; b=bs14G0WZffYNsf8BUA+u8vRAJRxcwaQIyQWm2Y446zl73lQLtNgcWcPl3gKeco/s1UyVFhOdFf4Bv3dvcIKyyQh49Ko10Dqp23Xp7KlngU+zKu02ssPYiT0xwUvMSuMfH2pkskYK2/UtpGCu2dWBoUTWEctIpao+UPjaqhG0ivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354393; c=relaxed/simple;
	bh=WTZl7KtLCKitBDq4A4f2Y4hHY6p0QL8NOTJOgHIYaQw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ctwnDDZLDkvxLlE+hMKK+TtThjw/yvoEUzDn3Q3q1tIXXAnZuoNGPa39sSQvTsMyKobzBJxeigOM/Z4dtqA9dv75hac0BIADF2hXCJOmOr+vQkhaLZj3DXHPovW5uvKvBZicCEYTasMFeeV4A73JsxILN3fj4LtjSqfSPXJ9QuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEoauq53; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEoauq53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A32C4CEE9;
	Tue, 27 May 2025 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748354393;
	bh=WTZl7KtLCKitBDq4A4f2Y4hHY6p0QL8NOTJOgHIYaQw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sEoauq53plPz3c+C08420ftQde19eswO1wzNoyaO4XQ480nZe95PDF9iCUDxb3Ur1
	 U7YnNaUFeF6eZzYGNXOI60vQX5qoYzm8B7ZVbNjYJPTN1RX0aNexoklLhK84+xe2I6
	 d7qU7rZh1qO6jQA7bcWl+RbC4MfTzADoxj/X+/1k9wDvFhdkn7TTk4QYHZnqvgGW8Y
	 JiOYlT8eAEk1+Ky/vHtCNXtfL83bh6hGMZprG6sCutpFregkoI6J8n+Rjp8qy59gdS
	 CEwJI3Ddde/+R/C3Rwk2L2iDioHeGhB+tyYv1iORO+SrS9uPtJ2v3bPi21+UODesse
	 zv212mCpJvqIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE04E380AAE2;
	Tue, 27 May 2025 14:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] obexd/transfer: Send Transferred property on transfer
 completion
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174835442751.1648375.10879744216178916643.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 14:00:27 +0000
References: <20250527071759.130143-1-frederic.danis@collabora.com>
In-Reply-To: <20250527071759.130143-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 May 2025 09:17:59 +0200 you wrote:
> Currently the Transferred property is sent each second and not on
> transfer completion, this leads to get no transferred size info or
> without the last packet size(s).
> ---
>  obexd/client/transfer.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ] obexd/transfer: Send Transferred property on transfer completion
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f8c6693139de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


