Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B719DF73
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158232; cv=none; b=KLQW34TJXJ5XDVk1c613QdgIPAtaA+K1bQUjW+aXTFemdqA9rBhu1lSrmiFWisVlVk8hmRPUF0QkrgHx8XUqjweRHecBaxrEuptSa3SPpSxYjrhu9VXVINHbpYt+f3HyyXyIGMeQSxOWHyXGLeLzliTBfIEaIcjMSKJNKYPJV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158232; c=relaxed/simple;
	bh=0YHkhVbngkquqcWuJ4LCq/42M36LD26yVNKeFw5IbE0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S/54cbQ2rAG7EtujIwaKKidC/6nNmgdWDatzhU+ePbG9cQxiDjiCao6XPNw/+8rDqB7dYXQSkU+78siSqMHuBbCaFJYQMTYHnQ+tE5znthiahb1PKDaTJyoePxdm82v5z0764ca//qN64Q4XytEff4gw7/ovsYUCtRaQ8EEkVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc9QIfxk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc9QIfxk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ED31C4AF0B;
	Tue, 16 Jul 2024 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721158232;
	bh=0YHkhVbngkquqcWuJ4LCq/42M36LD26yVNKeFw5IbE0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lc9QIfxkxx4j2KpUJXTuRmIa9rAW2ZQ1pNgNoXWxfHWYyF4UHptj54rNXrDOObWP9
	 gqqWrPG/i2GqjnJ4lO3euM6BabvA/RzLAWG+Ba31BCjHQjc+PQwsHfSMpRc9GG/5mH
	 KGMqNuRBoWRCalO1HwZQ8PCpnp9Ja0ULX2PtAqHeshxrvHxYdZdbiwfEhlSrUn9+ch
	 4OYLm138WbzggcFqdb+wyMC5+Zqioxjn8v1lNuUFSwzowkD2zkgOiwqD3pY3Mg5DFg
	 u7FDgv/bOAibwT2SUifTnGlTjDJC4lDk1r21+j12cDRkXzVVP94f7L5ePnmAtyFg8Z
	 zlE2DtFVOCj1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4DFA4C43443;
	Tue, 16 Jul 2024 19:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Fail setup on error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172115823231.13786.13122226934806592735.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jul 2024 19:30:32 +0000
References: <20240703085242.3218277-1-kiran.k@intel.com>
In-Reply-To: <20240703085242.3218277-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Jul 2024 14:22:42 +0530 you wrote:
> Do not attempt to send any hci command to controller if *setup* function
> fails.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [v1] Bluetooth: btintel: Fail setup on error
    https://git.kernel.org/bluetooth/bluetooth-next/c/e0b0a863028e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


