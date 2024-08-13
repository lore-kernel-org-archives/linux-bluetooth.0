Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C749654
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564232; cv=none; b=T1DEiYUESuLqwv3RoY6CZEjrU3lDclI2enWQ5XMQlhOvERGen80G4jMZ32pHZYmQsWDYad8g3v6S4CwqOwlacExmr4fI4P6xZXeXsfRSwiRnqzLvLLko3NYwE/tznWSPdtaNR7aHXWj5nZrN1ffDSLmm+R0/ek4Sw1aK9Hp4eiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564232; c=relaxed/simple;
	bh=F5BjrfNHstV2tWA2WYzvHsc+hB8HSY8rzboa9uUyUJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HBI1d9ot5juYo+0dOrEiSwwa1bdn40xeQUmlRvoXcqvmxVv/fLJMy19hi43vbH+heTyskNr+8/uKmPq61uuQGUjpFMDxRyxpQ/b7afsNiRW8RsvheCgv2Mh+PShRSrBKkzlLFmHYJD+NtFn7SuGOHILf8li+VSibtL3DPt99msI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKJqnxpd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKJqnxpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64208C4AF0B;
	Tue, 13 Aug 2024 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723564231;
	bh=F5BjrfNHstV2tWA2WYzvHsc+hB8HSY8rzboa9uUyUJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKJqnxpdpJvg95gXBAG5YNV3J+LUC7Ebg8HJbXJ/pC9hFlLY/VA8R/3Brn2pWF2Om
	 J1oNFe7/KfKwwTPKJccklt3sY5Ka4MtCaSCoXkgrl6Qe5JUPc3XnKDs+YSmpFYQ++n
	 1KypVLF/sDmZfeqaZKMnaqm4uqGkHRi1GdUlo7WbMiTxSdyf1zdAyXbwXcYLpGYIvd
	 eIhOplENZ8yii4LDRcXogQqVoBMGStO44FIs+i51rFqkHPfLyiWP7Dsq2N3ARFkyih
	 sm9hxwGZIHSE390xzA23w8gWEx3+RzxvFPraAMiFxx9gEDcudAqbSrIzDC6FdJvNgU
	 DymvGeSbxeIlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1773823327;
	Tue, 13 Aug 2024 15:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] shared/uhid: Fix registering UHID_START multiple
 times
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172356423051.1679641.15765907778343921260.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 15:50:30 +0000
References: <20240813142935.504400-1-luiz.dentz@gmail.com>
In-Reply-To: <20240813142935.504400-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Aug 2024 10:29:34 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> UHID_START callback shall only be registered once otherwise there is a
> risk of processing input queue multiple times.
> ---
>  src/shared/uhid.c | 13 ++++++++++---
>  unit/test-uhid.c  |  4 +++-
>  2 files changed, 13 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/2] shared/uhid: Fix registering UHID_START multiple times
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ee39d01fb9ee
  - [BlueZ,v3,2/2] shared/uhid: Fix not cleanup input queue on destroy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a13638e6ae38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


