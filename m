Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335421930A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922578; cv=none; b=Sic9t5sZkO9v6Q06aN9DOTpD5Y5WFBD5E8O0TIPp4Xui6M//wWRqOSCwyNLYPhxU2h8hxcHZIdZEYVlRC5brNZ0yFj3LHknbKD+i1EPJGSvicyw+a2zSqssCr+S1eEu5XZjwtpRwGQxzSevZKhB47A4scKTSCzlIAM6vjL3uh60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922578; c=relaxed/simple;
	bh=+LQDKGrq/l7U9bD2PIoDz2Nkon4gOweLIscyweAUnis=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YuHy3+RQwOWM4CUDJKAG0ovjuNi0jcqC+l/LOOzKoCDkkCi0dWfbkRjd29bOyO7efuhut6KqT5z34vuE9RfnoIB+duc7nSzEtn7/ouSy4NvWVsO3WBUnCg+1OW5vRbF6eCUhH6VGQwiQxtBaqmZdHRKsY0n9CTpd6HSjUjhil5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk1KmRzn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk1KmRzn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12611C4CEF4;
	Mon, 11 Aug 2025 14:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754922576;
	bh=+LQDKGrq/l7U9bD2PIoDz2Nkon4gOweLIscyweAUnis=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xk1KmRznDQMy5eUJ42p0WAYAYK5PcbuBMcp54SOwIkdb4E2zpVWHYPrVVMiZtyF8E
	 UvFLbkYGCX4OyRL79h+gbKa/qAjvvyMbKmhSyRDEM5EEN2W7My20tl3XqgHXu8RUI4
	 ffMpG30X6zh5/FJ2jcZNkisudjyDczPYpMDaCgyYoqSAshrKTajLzrV7bsNs2XchQ0
	 PyCOmiTW03DrRjIqA7+9MwYryaM8GpSF92bZ4rpf8v3m05PvUzE4LoVuW+Iy2xTc4r
	 9VjK/mR8OlDjbc/JG8TQEN8QnDqC4DJzCH4h5ZwNllpntD2n0CBmz1mTs/j+vOL5QD
	 LP/pvxYAjxiBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD02383BF51;
	Mon, 11 Aug 2025 14:29:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/7] Various BAP ucast server/client fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175492258823.1694545.11318279037423921016.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 14:29:48 +0000
References: <cover.1754678883.git.pav@iki.fi>
In-Reply-To: <cover.1754678883.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Aug 2025 21:50:32 +0300 you wrote:
> Fix bugs in BAP ucast server associated with stream reconfiguration etc.
> 
> Fix misc. bugs BAP ucast client.
> 
> Pauli Virtanen (7):
>   bap: fix multiple release of stream when closing setup
>   bap: send correct framing value to kernel
>   shared/bap: use correct parser for Config Codec message
>   media: fix pac_select(), pac_config() return values
>   media: clear transport if reconfiguring in pac_config()
>   bap: clear server streams when ucast disconnects
>   shared/bap: check ASE state in find_ep_ucast
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/7] bap: fix multiple release of stream when closing setup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ab82029d225
  - [BlueZ,2/7] bap: send correct framing value to kernel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a98314919a85
  - [BlueZ,3/7] shared/bap: use correct parser for Config Codec message
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bb0122151d2f
  - [BlueZ,4/7] media: fix pac_select(), pac_config() return values
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=caa495332e4b
  - [BlueZ,5/7] media: clear transport if reconfiguring in pac_config()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=84c336f2bd7a
  - [BlueZ,6/7] bap: clear server streams when ucast disconnects
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aba67693b934
  - [BlueZ,7/7] shared/bap: check ASE state in find_ep_ucast
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ccbff0898fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


