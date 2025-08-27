Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628DEEBB;
	Wed, 27 Aug 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756321802; cv=none; b=DwARoOUFkg1Q02qiYMbfPFfjACOhACVXWdUNaBmf2CUbQDK3Y8idXSNBl8Od9FAK8jB+9L2N6l+cj00PINER2/usmmKBsV10cvImJsA1ico22uFi9hGHTCw9zrTdxyIFHnDCrdnaSuV5d0ktm947CKfhVNE2Ul3R8sNjqWRfDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756321802; c=relaxed/simple;
	bh=OPGssxLS322JEgBEdgKku/FwgT3uLJG5E+t/y0whanI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JkYivjCAoBSX4hJl59oKLIaoc7Y0ysuIXXNepn4qNYd42eNlYt5nkYm8vSLyRnvosUQoChHE1O3VsbIMkzD/x/x7H+Wonmhz2umBUgPX2Kn9XB3/ZAL40Ifk0va0WaHlpkzjh7Ej6dQtZTErEVH3I6X6mYSkvjYUYW2FtAYkWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNDW0lwr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNDW0lwr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F188C4CEEB;
	Wed, 27 Aug 2025 19:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756321802;
	bh=OPGssxLS322JEgBEdgKku/FwgT3uLJG5E+t/y0whanI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HNDW0lwrwSMFk9hSJa5+Q5Np9TH5Tr4x6UTKUOlZmi/ihtjmVAlYzM+cpvfx/r6g9
	 ht9ckJbUdGlUu5XaBT+OW+HVYMGyTvgLWQH8YZMWoBcK7cfP8Nc8cZrRFG6KgQ1HDn
	 bJh8Uy+2YHNBtBl3+qSpzpbYiH/VAj75B3s6XCH/+MiihP7ixWe5zdqQ/mwCWWCgCO
	 acw7N65OPTqscI0MziBg9zpDW5aj47zxEhY5160VGnZAaDCvnS9Kn4uGrDxDMUkh6O
	 yCT7135oBuyG5R+1sQ2dc+EcBgzJFFhv99XYp0VVkcqjA58zxUnBxLlPo1IpJB5zd/
	 Miu4/FYMGv2MA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFA5A383BF76;
	Wed, 27 Aug 2025 19:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bluetooth-next] Bluetooth: vhci: Prevent use-after-free
 by
 removing debugfs files early
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175632180931.807633.7126813775951779992.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 19:10:09 +0000
References: <20250827145324.27180-2-ipravdin.official@gmail.com>
In-Reply-To: <20250827145324.27180-2-ipravdin.official@gmail.com>
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, mmandlik@google.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Aug 2025 10:53:25 -0400 you wrote:
> Move the creation of debugfs files into a dedicated function, and ensure
> they are explicitly removed during vhci_release(), before associated
> data structures are freed.
> 
> Previously, debugfs files such as "force_suspend", "force_wakeup", and
> others were created under hdev->debugfs but not removed in
> vhci_release(). Since vhci_release() frees the backing vhci_data
> structure, any access to these files after release would result in
> use-after-free errors.
> 
> [...]

Here is the summary with links:
  - [v2,bluetooth-next] Bluetooth: vhci: Prevent use-after-free by removing debugfs files early
    https://git.kernel.org/bluetooth/bluetooth-next/c/c27de1739b83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


