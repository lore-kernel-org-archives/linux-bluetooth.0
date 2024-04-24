Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514C20DC4
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985830; cv=none; b=oTBHs8Dm7KgreTriMmAzUF1IaoupY3tRWPVYoENsIflLrN0AWAIHe13a1pqfSgGJa2sL9mmEISryYYM5rqsaLtxgQ+CBf2KLinQ2a68U/eRWrUrt669fRgNHTvD32gLIq3ZPYjvVE/kN0TQ9wN6JGev8BjV/4oYjkwTZWye4vz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985830; c=relaxed/simple;
	bh=7yApn7scpvqMZjVUqef4mf/JOvKbrZ2ZB73TNWyACU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a1n405AtjiITJwV14tW4D5jE4cfN37c37SHfmFgY6yslinNDHHDT0UeIOgrLzP6oJYr/bIyVpn/S195zt+2jXpmAozIWCtR673V/ZRJgXq3//gF6KLUvs4T1ZU423PewOhWgZDBCCmuWM1tupudx2KIF7ojgmVFojO8sDAaho+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpHP4E4c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpHP4E4c"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20B22C2BD10;
	Wed, 24 Apr 2024 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713985830;
	bh=7yApn7scpvqMZjVUqef4mf/JOvKbrZ2ZB73TNWyACU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SpHP4E4cUIgq83Pl9x8Oa1Fqx1AfruV1XUVSQPsuZvhzdrwiff+kVZsUp1uXmJw+p
	 3TwJmQX+vWX6ZNgfqt8CJrB9VQZaDL423IatuJFm7c7j8OZJVE/bQOGxt7rNm7koQ/
	 EBTsJ7RX0yUkEqVRZsNJlYRm7eMa2fqoVxIV5teKefaBAQ5f/rEnk4PvJpQ0pvHcgK
	 +G1+JmT0CnmJpsOFPZ8a1hTEotQjJBinVy4YvtIDwga9os9qkNBVIginummAVYLKS5
	 yPndJMYwcE4HJ9K/FYOaclUi6LR3Vtx5dJeOjnAqXE1xjm23JzkdHtbxJbiRgGw0/0
	 zWGPkq82kAnFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E531C43614;
	Wed, 24 Apr 2024 19:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] gdbus: Add testing flags
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171398583005.8080.17570797656586220655.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 19:10:30 +0000
References: <20240423224603.2124790-1-luiz.dentz@gmail.com>
In-Reply-To: <20240423224603.2124790-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 Apr 2024 18:46:01 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds testing flags which are similar to experimental but are only
> available for testing.
> ---
>  gdbus/gdbus.h  | 23 +++++++++++++++++++++++
>  gdbus/object.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/3] gdbus: Add testing flags
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d8f3a3fa497f
  - [BlueZ,v1,2/3] main.conf: Add support for testing interfaces
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e7578f9ddd07
  - [BlueZ,v1,3/3] ccp: Mark plugin for testing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=02ade13c439f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


