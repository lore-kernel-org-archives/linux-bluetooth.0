Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1BE81AB1
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636829; cv=none; b=d7rcGHy8OVjug1Z7MxoCr1YUNyGs0/aqhiy01cIWJ3y7PgBFyKuJOPc+fKOFakeFNWWPnRq/l6FsKDRfj8Lc25re/IgxOYAXdd0QjRkv7phtt38eOQlGMmpUdrxF2bZYWkYxxl32MR2dM9i0DEYouHSDHGI/YLUMktEDtPxzd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636829; c=relaxed/simple;
	bh=tAnG4VGamvL4JOji3Fefk4yRNtzVoBk5Z4P5ChgViJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MJuRZiNsXMLa1EfQ3Sq6CmwtnMAuOiLa5yj/WzDmsA8tLwMq3BJcFlUnYdHal0NcAtiL/OGyMdBSjFT6lgM+e9XpcqZxuGDDk9Fum4UB+rfFWxZJmUznDKNnUsxp8KSEzpqnfyR6urh1Ctz9flqDL4ut7Df0dy7ehpYC0IXhCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcaKlYpE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcaKlYpE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84BDEC433A6;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636829;
	bh=tAnG4VGamvL4JOji3Fefk4yRNtzVoBk5Z4P5ChgViJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JcaKlYpEXgjL4DWyiSJzyKkEUIhKspzH17hg/tqyx1jrUVJABKS4itHtpPuPTJry5
	 /R3OD+NbbX1h1RvPWez8/Fn9a7E1rJWm6EhR8QCcRHO9pT8UWSVXzmHM/NmD/wQiNd
	 NPIq88W5TEHW278mQuCSj0aEE7oaDrIVfwLiA90xmzKTupBARHgoMCMjs5vVkxN0yh
	 z9TsjdaZK1YhB69IdaKMV3gTQFMtiAqDEzPGim/dCjY3Am9/L+1Sc7CIVGQpZy+xD3
	 YpWjQe6ZepgeD0vglBg2aD4ryyRW5PgdJG8qmRRqaR8eUR1EeMiL+25WdacMfkv8Xl
	 QcfvZ8V+BBuig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B260C43168;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Fix MediaEndpoint prop codec for bcast src endpoint
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171163682950.3770.14333599076600005921.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 14:40:29 +0000
References: <20240327134947.40229-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240327134947.40229-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Mar 2024 15:49:46 +0200 you wrote:
> Fix MediaEndpoint prop codec returns 0 for bcast src endpoint
> 
> before:
> gdbus introspect --system --dest org.bluez --object-path
>  /org/bluez/hci0/pac_bcast0
> node /org/bluez/hci0/pac_bcast0 {
>   ......
>   interface org.bluez.MediaEndpoint1 {
>   ......
>     properties:
>       readonly s UUID = '00001851-0000-1000-8000-00805f9b34fb';
>       readonly y Codec = 0x00;
>   .......
>   };
>   .......
> };
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] bap: Fix MediaEndpoint prop codec for bcast src endpoint
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0ff7392af164

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


