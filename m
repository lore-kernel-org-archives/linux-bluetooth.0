Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809809;
	b=z8m09UYMCD2bYhjzVDNlnlRxNsTvQQQfGwEuJZlX7RVsPV8d4dJSlkiQX+PV6Z+4pTjL
	 3sVB2ie2wu5ZaHANKQReK5Sj2/RUkakpOWF/1tY3FJM5Y2gfyxkwHemm/SbYisW3VRUWt
	 0lNuhLaCYDDOaTCBg6uRuCfZaoVP7vfVeinpSXL/Kt211NhXC+E4VZ/kQk/ePnr4h5RIn
	 bUbyMWZHQX69hOQNylqZWJyK7MW/GFwsHXCAWmTHG3ivSn6l7k/SJ8kO0C/SurM6QKtSe
	 mW+1BTuHCP6oHaiD/7iK2laMc2KTwMnj11974R8EmvsfHhTY4XCospVliCCeozlYapg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=tC2nKmg4osA7jKPMR3no7VRWSRDxT6i8+lKDD6EDMaE=;
	b=RSmKrs7B174mRsRyemGCC29J4CvWLnWv5oaYNACHf04h4lBAn7N1pjyhN4w9AbeWDblN
	 sHrul9wV4K/jt6xLX1+VAyXRJRJLjiP6jTntYqDNEg+T6C6SCduG+UXhr/UG5pXp8xkSe
	 YVC2TAhjPCUxsEEh4Mz7KBSBR1ACoKaMzIXBnwrlYsFPrrdu4s7u5fGzQDsh/WtXhjLI7
	 GvlRmhTSI/uvzLP1YDLzzKmZEj7QI6QxCZos5SZLdbVkOkA4rTTEJdKSMNoriL58tZw9f
	 g8lk5X6wg7PWFNA3TfFIFBxsOmbCJt/qI7JBQF2DH83Qr7uZuJLU5YBnQo+/v0mVXlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2BmLXmT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210D606A331
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2BmLXmT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868BE1F000C1;
	Wed,  4 Nov 2026 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809808;
	bh=tC2nKmg4osA7jKPMR3no7VRWSRDxT6i8+lKDD6EDMaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f2BmLXmTfpNuml25+z0WfV0LqLy66B2OeoVvnQtlGxunCmJMpvp0y9lYR6L9W9iuE
	 odir4bhP9SDajncYNX9hK0pKBVmgEdYRWYzMADRi3fqHYWKFoz5UYZv8Mtjez2N+af
	 g25ZunQXfz8ckJErwKYC0Mkab9nmj3FXBHSrNlJuGSgpaG5TbJSiYTwo1a2eYVoGqn
	 nKtr9AcF1zusTKsPwOWYBNkS5pCVXojCtum5wUNpoy1fKEuFgXwl8HtZPKStxzaJjJ
	 lAmMobpIbkxJtGsIfEtwrlZlopVCLL+g5FcY4SvFM5zZyCzoE0f7uAfS/pKnM/1uzF
	 xEwc+YuEtIeCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D27139E8A58;
	Wed,  4 Nov 2026 16:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] Bluetooth: btintel_pcie: debug INI rework and
 fatal
 error injection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179380980731.2929236.900247427168680792.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 16:30:07 +0000
References: <20261104122508.241477-1-aluvala.sai.teja@intel.com>
In-Reply-To: <20261104122508.241477-1-aluvala.sai.teja@intel.com>
To: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 Nov 2026 17:55:06 +0530 you wrote:
> This series moves the btintel_pcie debug INI parsing into the debug
> file and adds a test mode for injecting firmware exceptions.
> 
> Patch 1 moves the debug INI parser (DBG_PATH, ENABLE_INI, LOG_MASK)
> from btintel_pcie.c to btintel_pcie_debug.c, so that all debug INI
> handling lives in one file. The parsing behaviour is unchanged.
> 
> [...]

Here is the summary with links:
  - [v5,1/2] Bluetooth: btintel_pcie: Move debug INI parsing to debug file
    https://git.kernel.org/bluetooth/bluetooth-next/c/ac2656defdd7
  - [v5,2/2] Bluetooth: btintel_pcie: Add fatal error injection test mode
    https://git.kernel.org/bluetooth/bluetooth-next/c/d81a15edf4ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


