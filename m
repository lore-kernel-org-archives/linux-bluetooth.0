Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7184E222599
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416216; cv=none; b=RXkkaDNsF9A7UjFmmDRlNbKEfYk5mxC8sV9aOp7yJspOmlI0LaPwrO7uTgFr/tTJqT65RTecqcNxsyZl9mvG5viKl8clgZSHHNz7hs+GdbriCA7woRsH1GA9NSGsgpr00sDS91+adXJDS+8zGDSoH2vk9o4VLUpQQE8SMIMIp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416216; c=relaxed/simple;
	bh=cMRz8PVXzg64CC+CCRwUObypCmaje4mZaiUReMY3mm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ehVHq13Me7Q3r8qTw0eq3U7FkwSAI4OHXAiCShofIXP7kCULoptpDgMbvgqmPAvyNhPH0EF/HxhvvbRlmMaM5ZmHoDrc9CUcnN7zjpRDPVFEc9pLuV6VyjVan6s23LgB6Nkt3OnIKSwI+5AmxyCTWBQFehpKbJw0ujzbuyQZMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3wXVhU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3wXVhU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043D8C4CED1;
	Thu,  5 Dec 2024 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733416216;
	bh=cMRz8PVXzg64CC+CCRwUObypCmaje4mZaiUReMY3mm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E3wXVhU1uuCNDoqwjF67bmE2XSG8ZfH99JO5tm+ScxQNATk339n16hROI94rdMabn
	 BTu3tJAsnMSj6edORLK6ADI+EEBAYnNXDbOKNiHtvNjovp290SrgGxCTN9/jVIQ3M6
	 pYtMsJr8mY9dQMaUxXOzOtaPfV2/WC+rewqhxNjrPXPdYaViSm2Y0EPes4OL05x6PZ
	 QP8p+E8L9v34NZg1E0fEs2WMvCjqiXowC+eDoYadT6GkX0Sl0WyAsczE69eecfgJCE
	 l5QuZxaEGS7kYa1UI1yQRVSGjyehkb/1NoVsjXwVUTap1WZKFN0fgk7e197MAZaL34
	 bSKfoqDgHGEug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEDC380A951;
	Thu,  5 Dec 2024 16:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Bluetooth: iso: Fix warnings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173341623076.1977155.10984103049180271971.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 16:30:30 +0000
References: <20241204122849.9000-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241204122849.9000-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 Dec 2024 14:28:46 +0200 you wrote:
> This adds some fixes for locking related warnings in the ISO module.
> 
> Iulia Tanasescu (3):
>   Bluetooth: iso: Fix circular locking dependency warnings
>   Bluetooth: iso: Always release hdev at the end of iso_listen_bis
>   Bluetooth: iso: Fix recursive locking warning
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: iso: Fix circular locking dependency warnings
    (no matching commit)
  - [2/3] Bluetooth: iso: Always release hdev at the end of iso_listen_bis
    (no matching commit)
  - [3/3] Bluetooth: iso: Fix recursive locking warning
    https://git.kernel.org/bluetooth/bluetooth-next/c/269f7b219173

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


