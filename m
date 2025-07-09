Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD7220F33
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073784; cv=none; b=p5byO+rSsV1FHQdtLTixKs9t08nLxPW2Qa4+s/Fis1fuK/Y4AXZmLGY1kGlDNLluLkNLu9dp+kD6XNxPXA5LbKaAc1KvA4Qj2gowzwgaREXDTllqRM04ry8QjEwAUkEHzn5w4t6MWHmIAucJ0t5ZNibz4xW5Urs48r5iXO11zlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073784; c=relaxed/simple;
	bh=VC2APAKZQsWPaaI8VoE8eDDIaE1X/0otRG+jzx1BhwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bBmAeQga/kG58UUEtECzUUPX2v35lQgcUIrCPD9y+BuBLxNl0lpAUYbeGobbtORRnqNZpVfw1soyeC8890RZOkescdI9yoFte7q/faNWi/x3LiFP0dZ8aV7C7rlT+aL7c1UPZbSDzZol/Xob1UJa8zKV/NGaXf1dbVyNaDXvHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm2mUh9u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm2mUh9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C056C4CEF1;
	Wed,  9 Jul 2025 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752073783;
	bh=VC2APAKZQsWPaaI8VoE8eDDIaE1X/0otRG+jzx1BhwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fm2mUh9ugTvWneaT0K9OsiUs1qqjxxYAqLQ4B9wnzbnclz3Pfx4rfzq1xIr2nn9t4
	 Pt3NTOhzB0IGNqUTJVxA6Nn8oil6Y0jf6FQkyUhz0/gTJlnnJs4n3dPJ+iGwO0iUoE
	 yiTlkh3I9UcfYMYGypr7KcV+xu3Zs5jweMBLFlwbwfmJjQ5jtCq69gnr0AoRh7aAZv
	 p3LjTdhfDDblWpSb7Liplq5C7fXCRkUnXQhDuxVRVNyU5SfQmG5tSTopfu+3UmfmyV
	 4WSsrnzANIIKAuvzB9i7z6FUHgIIrhL8TMaFM9jq8tgYi56TFNQPDWE9e66calJQEO
	 q3btfAblkskaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB80A380DBEE;
	Wed,  9 Jul 2025 15:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/util: Introduce strnlenutf8
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175207380577.756353.6069570341903255220.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 15:10:05 +0000
References: <20250709131453.3203903-1-luiz.dentz@gmail.com>
In-Reply-To: <20250709131453.3203903-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Jul 2025 09:14:53 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces strnlenutf8 which works similarly to strnlen but return
> only the number of valid bytes of UTF-8 encoded string then replace the
> other copies of similar code.
> ---
>  src/shared/util.c | 82 +++++++++++++++++------------------------------
>  src/shared/util.h |  2 ++
>  2 files changed, 32 insertions(+), 52 deletions(-)

Here is the summary with links:
  - [BlueZ,v2] shared/util: Introduce strnlenutf8
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24a327427d7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


