Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DC117C233
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726582837; cv=none; b=tYM/FzcO+FyfrUW6z7SOKfpI8Jdptb84KIk+GFOcgisZPUofE1F00kcF6XZOcO6oCGJjIz95BolY762E0wPvaHHPHecS3lTofx9NyVqs9FLBLsXUy5kxaBa9JjZ4QzYMERUIDRwnYCu/fY2KhxIaq5ctMdpaQBjoeBAhSqLCq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726582837; c=relaxed/simple;
	bh=18Z4p+2KYZ21nV2UGTciplAkxiv2z4PI2Rc15VEKds4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d39CsLWuUKb2A+W/brkfliDZyITQYh/nzDz3w4xNNjJzsTvZqNoYpjkMQc+GmS4kyhmUGoeZpvYLpE/wsAhe+2eLL50rW+zus3WBUBZJ5HxhchHlC7i8ivoC+zSvUqFjdWJ0z8FqFw+xcuEgfKlMFzhvH4x/5RfU24ajeV7uZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWC/vqO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWC/vqO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19523C4CEC5;
	Tue, 17 Sep 2024 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726582837;
	bh=18Z4p+2KYZ21nV2UGTciplAkxiv2z4PI2Rc15VEKds4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FWC/vqO0N3+Vqtqxd8jskayQmXDysbAgvUn8K94js4EeuUzPZpcvm52R0F28lLiLL
	 JfJmFLTYsqM6gpIUQkEVYsFU+TRg4MH5uYKfuxy2OEtniB45GfhPdllyC4msVnV1r8
	 3FWnftOsmJmmwIcZMjKIQGqgEhwVVNYtwRzJHAVAEDnjw7z6h1ZO/Gq18Y5mIHdIdr
	 F6Mv1TN/TONgC/4jcjoVsIg1yfY7ORqiTQF2vgEYzf6oJXuxN9RZ+Y0hTrj3J166F5
	 fRl+f1rgnRS3XPRHX9UO1IXze1eYiWciaoymqqjoy94ZyvkJuHqimhSDdl0hhjTJqA
	 2Vp/v3rkkuhpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5E63809A80;
	Tue, 17 Sep 2024 14:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluez v3] monitor: fix buffer overflow when terminal width
 > 255
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172658283749.155805.6387894003374291123.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 14:20:37 +0000
References: <20240917-fix-log-buffer-overflow-v3-1-26fd441bb7df@gmail.com>
In-Reply-To: <20240917-fix-log-buffer-overflow-v3-1-26fd441bb7df@gmail.com>
To: Celeste Liu <coelacanthushex@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, CoelacanthusHex@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 17 Sep 2024 14:30:46 +0800 you wrote:
> In current code, we create line buffer with size 256, which can contains
> 255 ASCII characters. But in modern system, terminal can have larger
> width. It may cause buffer overflow in snprintf() text.
> 
> limits.h provides constant LINE_MAX.
> 
>     {LINE_MAX}
>         Unless otherwise noted, the maximum length, in bytes, of a
>         utility's input line (either standard input or another
>         file), when the utility is described as processing text
>         files. The length includes room for the trailing <newline>.
>         Minimum Acceptable Value: {_POSIX2_LINE_MAX}
> 
> [...]

Here is the summary with links:
  - [bluez,v3] monitor: fix buffer overflow when terminal width > 255
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2908491c7efe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


