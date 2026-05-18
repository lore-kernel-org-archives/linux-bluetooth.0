Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F93ACF11
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143396; cv=none; b=uPWP9eiGjrgXKp2LTHgVzrykiuCDWuvKdsiIhhpRRIId70LpvLiGNxkQEXdUmhckY8RQYbYAKSe8ij9A5T/ZevZWkYmfelHqavN1V/9yhJOXTbSdm8/HzoQxLNADIcFsjdRMZQNFkspx8sY7VM44t1QwcGZJiU71QQdzjXShaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143396; c=relaxed/simple;
	bh=fpI2MJqe9zMtKYo8QMrjMnvKYBMcTYoe/f7JJgwR/6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YPZPaXOC+eJAr5cfHSXG/V4S4zvzXc20fpjdWjyjTGTW1GbcehZDvFqO/txCfR7G4n/uNmK9TW+u05medi93lNgCCPn5W53rFsUZ7/G15QDWzzcI4Jcpyp+aDjsxJVcsgifERrQ8FuMDGolUTq7ify3gk3zQuFo7kNU5DHktny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym7KMrI8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym7KMrI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87E5C2BCB7;
	Mon, 18 May 2026 22:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779143395;
	bh=fpI2MJqe9zMtKYo8QMrjMnvKYBMcTYoe/f7JJgwR/6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ym7KMrI8S5d0jp2uG5hk6WOvs1/CaQo7AVR8iLmZwubtWD99CYHGbMbq98ZiDOk8i
	 xRjRl5KI5mdhb5tq02FGbrDHBUjPl2T4tyul2+LyjAZuplwze8MPfNVau1KglRdA4q
	 E6+aE8Fj9bluZ6KHs+uJbmOMNEpyOf8AdKaKE3pRl4NVBdbcDePi5r3zDa324N9B3M
	 0MS7HRKyoMPF6R0BKm2zEdRpuv0VVcPAv0CKLrTqAmFwqN5Nquy/E1apBDg6G+FzcR
	 BQWJSHnd2zASHRhznPWgsnaI6WG/UvqzM6I4FpGfBlQdylEkq8AkEE7YXPMZ2DOXhU
	 I3t7GI64bK+bQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A583930CBC;
	Mon, 18 May 2026 22:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] shared/rap: fix use of uninitialized value
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177914340713.1994926.13382920627560378159.git-patchwork-notify@kernel.org>
Date: Mon, 18 May 2026 22:30:07 +0000
References: 
 <e7e72c0208f579fd6bb63b76f9d2a1ea3cabd2fc.1779013529.git.pav@iki.fi>
In-Reply-To: 
 <e7e72c0208f579fd6bb63b76f9d2a1ea3cabd2fc.1779013529.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 17 May 2026 13:30:08 +0300 you wrote:
> Fix error handling in send_ras_segment_data
> ---
>  src/shared/rap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,1/3] shared/rap: fix use of uninitialized value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e0f608c05f9a
  - [BlueZ,2/3] sdp: Fix integer overflow in sdp_extract_seqtype
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dc07b3d54b80
  - [BlueZ,3/3] main.conf: fix unintentionally set value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1e0688e8bfda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


