Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE924EF9A
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790400; cv=none; b=h5fiVYsMbtHQrFXgctUASnUCkZQzVSODRMDpvF52LiNGKEiNY8c7m27mria7qmqGGHKSDbICsQJ7dnSRXz5BJtXJ0OfE+ChGx0W19UAeZWz74nItcC3muqV78Xs3MfgQy1vCP6PeSfr48R5OLNuFIpwWmvAntRfKjeWUxzCFyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790400; c=relaxed/simple;
	bh=YmLktifSiTRI7Kfwa9kNyiuqT0ZQSA0CJn+WDppTEhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VjxoWi+hwzt6Gc/Jz3RtfzF74pj9wXdvstdSwcj3NAz+TFleqBDvZLHozfYKtH8yIcMbUXdtmhxrr8JBLtdEQMBuEf6bI3rpi83/AmkhlxRjcez0d0EGNYyftV7DFkcTZOWKBkvCrKhnnQZK6JTBEr15/ByqUgc99GrByT1WRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juif8jlZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juif8jlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93492C4CEDD;
	Wed, 12 Mar 2025 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741790399;
	bh=YmLktifSiTRI7Kfwa9kNyiuqT0ZQSA0CJn+WDppTEhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=juif8jlZh7F2YYBsEYWjJB/8TBaU9LEhUjjVtbzQcpIOcXZGPbQfB0mCzwlUvosyH
	 7wFlJ90J6jCZYHvJAMd3NV2Ry7DQeG75ibErte+YcwsL797iUTWgUuQEBnaK2JzDo6
	 O39P5G0yHbv96lw4mjfIQOXKh77FzLxo3w/qwzDA4982bdYLKPy+yU+M6ZD/sfdwFb
	 5kA9WM9Ee9WkrvYXcZTYcduybCEr+bThY0Evg92uR4+Zu924hA7qLDatxZut0VrGfp
	 kLV/2N2ijEhbo0nbGDIls+A+Hs0LztADcb9sus3YKazkjT9F8Pfyq4uHnjOvTUwo6T
	 ee00ZHPNIELvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345FD3806647;
	Wed, 12 Mar 2025 14:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] sco-tester: Fix closing the socket
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174179043401.818639.3782894640541829719.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 14:40:34 +0000
References: <20250311194226.15109-1-luiz.dentz@gmail.com>
In-Reply-To: <20250311194226.15109-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Mar 2025 15:42:25 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When writting data the socket shall not be closed until all the data
> could be transmitted or the test times out.
> ---
>  tools/sco-tester.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/2] sco-tester: Fix closing the socket
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=df891f0ff44e
  - [BlueZ,v1,2/2] btdev: Fix double lookup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=adcd73901831

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


