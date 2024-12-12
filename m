Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCB1B1D61
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037815; cv=none; b=iVmWDh4Ur9d/aJDD9VC+VQeqCWuj6eh9n5+kuhCz141PWwhQSXk0Arkv7skLVtHiDg9f3Zi318AVR4eKwSl3/Fp83kl3xFstrdqhot941HwtQ2OxSzz9evYSXg0jigQjj/52y0htReX3ysxvE6u/COI5HucOw25sf4fvZHbVICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037815; c=relaxed/simple;
	bh=1QeqjgFuaj9omXYoOyLvRu4RQludERvw22B0bRnFIi8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oDoDbCNr4tNrz/HCti8sODo68LNDBBYSaqDEsuYcuYi57TRAOGwytLOOH4tsZ+D5q9bLs3Lka3zNpCtIAtemzSF7Jj6pRFAASspUePL+/yHL3JKYjD+6L5aSz9eHlf9hVNfpeOXEjtc4EOzsDnJaSDiu7NFMeYdG5MGuN5N9DaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an7rrA4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an7rrA4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5978C4CECE;
	Thu, 12 Dec 2024 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734037814;
	bh=1QeqjgFuaj9omXYoOyLvRu4RQludERvw22B0bRnFIi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=an7rrA4rWdP3SxwKg5mOVfcKTm9pnStS1ucvefkPEWPW9k8gDU2A5SS6TpCG/bUQX
	 rJlyS+Pmxp7Hmss54QGTVxqYsDiLcNlxtnpqEuWaQ0T28RVBj05PCNTiCkwimYot7d
	 /LelqlooWO5rfjL03LpK/4LnhncdGMrHebHDW0Q5SdTufqKvd83w4EReuug8n8QUbW
	 9XU9CW+qQeCP1XrsBAkl8/Viqd2PKTBxuY30gejMCwSUg8sVNjleNnDr+0fG9sN0FL
	 mpDI2wxmxBMJIyeHCE9Mn0xcBsxMrVEedvZ4fcBYLTeek40Nc/yxB3UyZMUgleDMA/
	 w4+HgAo42eAKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34484380A959;
	Thu, 12 Dec 2024 21:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] main.conf: Add LE.CentralAddressResolution
 option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173403783101.2440486.2304036636574738171.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 21:10:31 +0000
References: <20241125204711.719853-1-luiz.dentz@gmail.com>
In-Reply-To: <20241125204711.719853-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 Nov 2024 15:47:08 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds CentralAddressResolution option to LE group which controls the
> GATT attribute of the same name using the new MGMT Device Flag with the
> fallback to LL Privacy experimental UUID.
> 
> Fixes: https://github.com/bluez/bluez/issues/1028
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] main.conf: Add LE.CentralAddressResolution option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c9d70ca65f9a
  - [BlueZ,v1,2/3] monitor: Add support for Address Resoluton flag
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7e0fe7d5c143
  - [BlueZ,v1,3/3] mgmt-tester: Fix LL Privacy tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92f3a3b108c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


