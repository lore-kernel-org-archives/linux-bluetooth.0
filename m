Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542ED32C30C;
	Fri, 29 Aug 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485601; cv=none; b=HJ+cT82S4gijMWHRJ1A1k1P07D6NbE49k7Gw/kq9SfzP9KXS3kkSLVL/NLBiSem8xMhI9hGucm30Hg5fc+3GDfLu5KehXAfzjmjZIZV1DICk4qiUi0XLD6CIvVyR9YgGKsldHxw8eIOGzmx3qtFJIDWYXFQ89A7TOXml75vftbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485601; c=relaxed/simple;
	bh=zvnB3Z6Dj3LY/2TUuCgT841hX93QqREtHKDShkn81yU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Npn+cL3Jj4ZIYYShcTqdcdsO3wGNGRdzCYhT+cK2oG7gHMJxGViDOO0Zv5uXUsvdLwbEa7k2wfaqOGQ982OAoojgQHzVO+sezT0THim8iQqSssXM3ob+Wy7drSy5hwVZESkVAwRuvL1+Exmj+70NRATIAyDkmGVpjmxyE+v/MR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKd3xnHK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKd3xnHK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F98C4CEF5;
	Fri, 29 Aug 2025 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485601;
	bh=zvnB3Z6Dj3LY/2TUuCgT841hX93QqREtHKDShkn81yU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MKd3xnHKYvT8XbW6rYUQMjx8oJzM4P758YuW8JhXCsvRvYj+6SaSsNlj0Sv/7rt+A
	 tAnTMRrdEET528XVEVmu3g5iOYF22g4M3gEQ8aGL3dqYausrzQwr5kas2sCVcSx+vl
	 6cW9bONA5lR/jwZf+UHfIqcnbpuhq1w+H+z2LR1FNz2vyaQg42KYONkrFsfI2KDXjT
	 4+oNe6EhZ9gVH+qJvsnTxepRi8DjyYGx3xHPaLLz1Z+8fr4I3nc0Qva7tflwTc+QgZ
	 Kyu+cxIMDaNrG/pQjo5gmVFeBvkgu24uC7xdtjxdORZlt+HY1D8CvYMAvWZlMjyX4u
	 SwXCHaR0f/xjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340E5383BF75;
	Fri, 29 Aug 2025 16:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: remove duplicate h4_recv_buf() in header
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175648560766.2276001.11700293691359487684.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 16:40:07 +0000
References: 
 <be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org>
In-Reply-To: 
 <be8edf7f8ba8dea6c61272b02fb20a4ac7e1c5a5.1756179634.git.calvin@wbinvd.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 sean.wang@mediatek.com, amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com,
 linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, johan.hedberg@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 25 Aug 2025 21:11:08 -0700 you wrote:
> The "h4_recv.h" header contains a duplicate h4_recv_buf() that is nearly
> but not quite identical to the h4_recv_buf() in hci_h4.c.
> 
> This duplicated header was added in commit 07eb96a5a7b0 ("Bluetooth:
> bpa10x: Use separate h4_recv_buf helper"). I wasn't able to find any
> explanation for duplicating the code in the discussion:
> 
> [...]

Here is the summary with links:
  - Bluetooth: remove duplicate h4_recv_buf() in header
    https://git.kernel.org/bluetooth/bluetooth-next/c/0e272fc7e17d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


