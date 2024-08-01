Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F47189539
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 09:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504039; cv=none; b=PxzCeCAAEesAUy7m01NvApKVVa6VtD6aQe9vvJEjMIOOXVxR7uMUswKlRiSJm30N/XwVON+HZJZ8qEjU0Pq+d0T3EfG4Z0E8KWFdThbAK5sFli+R0CVabd8QizRRHTeV78TzF8JIbEU7Vbz+sffSSNgDTWIiuKIfqi3potEBkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504039; c=relaxed/simple;
	bh=8GQGdicwvQpwEbG8iHaJDcppOisICEk3usagi7uaqes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BB6CbwFD2F2TEyFI51j0LSUbZrAUNPeBaq4rK4bBPLaMfO6JPdymbQMG9HaTC8PGnE7KlD1wdM5XN2jfgiQ9tjoyOs25dSDRr1KwElSp+gRzrzUWNtGI2n00E6+rSERBO7NVKuntQpFS8r8o9jrHF9uIdSamfKvIaS+959Ey5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9Yuk5R3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9Yuk5R3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C26DC32786;
	Thu,  1 Aug 2024 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504038;
	bh=8GQGdicwvQpwEbG8iHaJDcppOisICEk3usagi7uaqes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O9Yuk5R3vjHhxpxhFUFDbWgR17cfR43K086Jdht1GzO99A/bpinx09nj9AtMlwlo0
	 jTpNjM1nbrrA7xthXV/7j3ImHfNnCrjosdGRt/BCXjP//YKvsQnnIAHLd3fQLxyLa/
	 gm2fh3UwbC53k5EqwMNqmxv5FNfYqycqgLHq8C+Gw+45tgui9NXvpRnFI2qgDspcak
	 HgGmgOffCiIm5vn23R/UEimsTUqqt99JHqV18O8n37765G1LJJiPpbzGz81RYABMDj
	 WFQUPAWbxnuiE02FuqPF/eE3o51WIoYbpbjZpyIB4S/VwX6JtSK8UcnvCNUHfTQ59c
	 7sJ3ODc585J2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 840FAC43443;
	Thu,  1 Aug 2024 09:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] Add transport.select method
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172250403853.1152.12452114058022692430.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 09:20:38 +0000
References: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Jul 2024 11:13:35 +0300 you wrote:
> This series adds a new "select" method that can be called by
> the user on the broadcast sink side, to select the stream for
> which synchronization is desired. This is achieved by changing
> the states flow so that transport are not set to pending automatically
> anymore. Instead, the transport must first be selected by the user,
> which will update it's state from idle to pending. Any pending
> transport will be acquired by PipeWire.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] transport: Add "select" method
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=083d1a7b66b5
  - [BlueZ,2/3] client/player: Expose transport "select" method to the user
    (no matching commit)
  - [BlueZ,3/3] transport: Broadcast sink: wait for user to select transport
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


