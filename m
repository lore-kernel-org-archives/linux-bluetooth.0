Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2F78B51
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706640027; cv=none; b=bFRvl3wGXsTGREkXTLwrKOiqKdDd1zaG9c8hah52V7z0NkQ2xP36S+Y+xv7KBLt3W3ZbGQrZUgr0/fFbf2mVMUOxxClIWD5NSaP16T+gxiZNpufJ+TysQqEOT5M30A7+8eFHULvPfK8w2XjYBpjHCFxXbR1sP5gjym4WDHA+kGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706640027; c=relaxed/simple;
	bh=g2nEr6xBR/2zoWA4IvFSdNDshonImv8QvLboBiyAXRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Lcn/u6wJXgrnV+iRBFNW3g/U7PdSk75/kpySB5i8u++D7K7p3KNGEwxmE9DN/yThVu2BenOJM20lsbX0keNZVih8OMi0o1cWKyOruQoV6yy+SWucEUdrslFRnag+EGaeqSPgmy2dl99DvaAcyQj5uccLWQdzkJ9zZQjgKSCXUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Arik1OYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Arik1OYS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C354C43390;
	Tue, 30 Jan 2024 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706640026;
	bh=g2nEr6xBR/2zoWA4IvFSdNDshonImv8QvLboBiyAXRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Arik1OYSpnLULIt2uPREpz9bmmgozPyXFUFa9W7uN7e0jQ41PyLNAq9uDk7IniHVq
	 1O6Q4akA/67+hoSbLhxQr7OTk/AIgAJXtRhT4pDH1QioXo55o40OOdDGlNJKgIEZnK
	 C8k3WcK5xvdOxqUjcJzOKInudIBYSpsXKLvN1RuTm/u8G3FChznyHjqaBVST0va/D+
	 UWlwTh19MpgsJfPgkj/Ko6lEQQILZhblheBA8fp4xOrFG38rzt2m5L/p9y6Uz+xXIU
	 yWgCQyx48FCjrGMH3roX/zSNmV3N+vTZDRLknZboPBZgXGIB96oy7RNRQxU7QTmZy1
	 PQ9Dmchfq0sAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74A85E3237E;
	Tue, 30 Jan 2024 18:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/4] util: Add UTIL_IOV_INIT
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170664002647.26337.17110176556825062778.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 18:40:26 +0000
References: <20240129212036.163298-1-luiz.dentz@gmail.com>
In-Reply-To: <20240129212036.163298-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Jan 2024 16:20:33 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds UTIL_IOV_INIT macro which can be used to init elements of
> struct iovec with a byte array.
> ---
>  src/shared/lc3.h  | 24 ++++++++----------------
>  src/shared/util.h |  8 ++++++++
>  2 files changed, 16 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/4] util: Add UTIL_IOV_INIT
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e472230055d
  - [BlueZ,v1,2/4] client/player: Add metadata support to struct capabilities
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=423fcc4c4ce8
  - [BlueZ,v1,3/4] client/player: Use util_iov_dup/util_iov_free whenever possible
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2faff4cadfe3
  - [BlueZ,v1,4/4] client/player: Add .name field to struct capabilities
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=74e49f67e940

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


