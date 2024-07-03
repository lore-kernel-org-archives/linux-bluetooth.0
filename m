Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D201802CC
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019433; cv=none; b=VkjmBJRAWhSnPYvzN5HrNzT4/HgbBLIcaR13qfiNVzy8gvlphDLL3NtyNsrPYkd2tzfIojzEiq20YwRZOjVR0+QOWZcclzC7kMi7AFcNzHXyMzwgIwFdMc8ivScGBP/fCo7kIirUJV4thNuPjehoCviiTdGd6/f8bPME7TWgClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019433; c=relaxed/simple;
	bh=Sny3+dazXOQvttaIPHmU6BNav5vKo0/BRQ1KxDoppY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e+F+4JvhfD1q+/oTipQMlRupuQ4FZMzQj17FxwawjWG8s6RoToT2JXQzSFTyL4caxwqMwE2a2ZcsXLzZzPedgMI4HAm5uvozWUsW9a15MyT+OxuOkJI1A35SuXCp2Snnk2Q7iUi901gV7pagAFcXwInatfENawSBTPE371ffy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa02ic3p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa02ic3p"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 705E5C4AF11;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019433;
	bh=Sny3+dazXOQvttaIPHmU6BNav5vKo0/BRQ1KxDoppY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sa02ic3pooLYqfdiDlMaeTMoyZW5JVLS/exQdrPLO1B8eniI/0+x7ACPWXKMG6hNC
	 rx+NOZ0FOvh22oiJzjL0pvGQ2B9tOMQNQPEC0+5SVbX+yUIU+B4JSDrJ0hX3EkDifX
	 BDQ3CqS7w9YxgVIbVRxJvDVI2a1d7KtGHvR5yNIJFpyB9agEqcwdstgrMIxIBKqmGO
	 EZWLhgZWXsX3+psIb/LsT2dLUf03gMQFFA5UcrOhUSnzIbsZ+2udDKhJUaxxyFFcQQ
	 4DbWGwW0fQ6Dk9LgclOzEVfCeTUmEa+TcHbjDVDnHW2GsoxvwZz2sdj8FDPzEQf4o2
	 hBN2V3bBIfwFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64E03C433A2;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] client/player: add return value check of io_get_fd()
 to transport_timer_read()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001943340.18626.8769477963899790782.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:10:33 +0000
References: <20240702122717.77746-1-r.smirnov@omp.ru>
In-Reply-To: <20240702122717.77746-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 15:27:17 +0300 you wrote:
> It is necessary to add a return value check.
> 
> Found with the SVACE static analysis tool.
> ---
>  client/player.c | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] client/player: add return value check of io_get_fd() to transport_timer_read()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=537f96a28399

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


