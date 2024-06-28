Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF174077
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603629; cv=none; b=oMsT7WY4DSdfEPjVnr7LVAij6IiRPvwnM5Ve/XEkR0KOPqNFJ0S2YcTwVwGZh6+cSNyexsVXbF6QurDuX6aPDIhn2raK1vfwDRUEaeFaI6tx4Oky36rfYKf+QBBlByRLn0ka0YB3dv0b4BQeIK9yUrZxhqiiBNkQnug2LS357JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603629; c=relaxed/simple;
	bh=Blp120lvGVY4rVtvbtb1QTJQFlTqSHXAdcF4q5Ya5jU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rA+Gnn/ZkAhtnejPV6AP05Rp64dfJwoP+5GoJBANWli8Zh/Tcjqp0sO56kr0EvK5Mo/o51kNRlygk07w57IDFrhxk5J/hZ+E4MglEGN9rDpwV97ibQelOGg6A/dnGha8TnZJ3KKONQuOuszmI1Fi32M8nDhiH8ZpocctV+JvlhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMnsJapy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMnsJapy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22421C2BD10;
	Fri, 28 Jun 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719603629;
	bh=Blp120lvGVY4rVtvbtb1QTJQFlTqSHXAdcF4q5Ya5jU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pMnsJapylVBmmhTLP6cmGqdDbthnahwSqPeSQIaBrGPOA02zzEnMoYidkJ2Yvvh+M
	 +i3mWKILR7XOPjQSHIL9kFj93JBfCerWeDEKHEd7fBnuOXchei5TwDZhj6QbtZM57u
	 56Iri4wfoCUXUKlMYcIrCI6gGrA0UUYeZtms400KR/tavhV98X5Dpu7w/UjQ9olrhh
	 BXT71ROpZrP2pCfKQxuRuhabRAJLizFCHTOcTBUId2jwr9igTIrHhLrRsRwg+eJccs
	 SxIJhNktaYyYPMqkYO+ktmzTEodlCxN7c2lEYZFLr5MIZSdudktXMRYZPPgRXYQBhm
	 +Lj96F/S75wkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13046C43335;
	Fri, 28 Jun 2024 19:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] org.bluez.LEAdvertisement: Promote experimental
 properties to stable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171960362907.5711.10238816554127935779.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jun 2024 19:40:29 +0000
References: <20240628164701.626148-1-luiz.dentz@gmail.com>
In-Reply-To: <20240628164701.626148-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 28 Jun 2024 12:47:00 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This promotes experimental properties to stable since they have been in
> use for quite a while without any changes.
> ---
>  doc/org.bluez.LEAdvertisement.rst      | 28 +++++++++++++-------------
>  doc/org.bluez.LEAdvertisingManager.rst | 12 +++++------
>  2 files changed, 20 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] org.bluez.LEAdvertisement: Promote experimental properties to stable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1a51250a7ea5
  - [BlueZ,v2,2/2] advertising: Promote experimental properties to stable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7e028287ae1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


