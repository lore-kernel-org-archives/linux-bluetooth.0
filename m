Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCBE12BF08
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934228; cv=none; b=DGLeWw2cc8yLx3Iwx+O1jW9RLbjHGFP+/6pl4l7G/ucL55CBp9lZ7+MwCKw8ExnNy0qBFvzhKfihniOZtFmuo1CINfUrst1/mmUqU/D+AZS7qNASZMw3eMvSwRjrx2EdagMwJdiCREwzEN19n8nuTUDmrt0txA+zqG18tBtA/gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934228; c=relaxed/simple;
	bh=RUtVf9A0qDcfSY69HU3FU6KLv1Mu4kXLe+X/X4gWI+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dhZPHfWefkkjqPPS+ko/IURI8G9/ThZY6E790qAGF9x2HzmVGkCc1KnMrDtXosN1UHtH9Ww88Bl6aG6yT+x18kPuyXYp9lMqmGwD6TwlVD3njFM0frOK0zwPxv8skQpsnjBq8eLnxyP17BupHlVhDUPFhU23UNQxl1yU6jjeZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjBqrR19; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjBqrR19"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D95EC433C7;
	Wed, 14 Feb 2024 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707934228;
	bh=RUtVf9A0qDcfSY69HU3FU6KLv1Mu4kXLe+X/X4gWI+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LjBqrR19uEvqPliK4Kr9hZ73/mAy3qScBRupkU24HegParZyU5SonYM+nzTmf7Xrm
	 D87MOjQC/D41rPpMkbi4r+kIEpQm5xZ7PJZfI0xB7iaUO1XO24EMecoGpNaS6OLU2C
	 kkaRh/6L9L6zz5lpaeWiM2SQNhJdbuowfPXtVKzUNOKNXxrIh9bN6yBDDWXMFDwlXd
	 3BX5gmavLXYhGvOYOwL0V2SOpdZ4YX+HAqWpwwCHmg5bA9KNPltSt7L0AzwXhc8yVE
	 yLh9nnW926Dar2MM81UOcwFd7hQbr2DjkWm46PQY/ca/Sg5cH1AI45vA15JCSDdo6G
	 NgFkFfRjdtbsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CF52D8C96A;
	Wed, 14 Feb 2024 18:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] build: Fix typo in external-plugins configure option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170793422844.15256.18374433763905502719.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 18:10:28 +0000
References: <20240214153635.156548-1-szymon.janc@codecoup.pl>
In-Reply-To: <20240214153635.156548-1-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 14 Feb 2024 16:36:34 +0100 you wrote:
> This was causing build errors as macros were also generated with typo.
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [1/2] build: Fix typo in external-plugins configure option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=094f3fdcc0ac
  - [2/2] bootstrap-configure: Enable external plugins
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b55d98e5cc97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


