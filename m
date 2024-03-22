Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB62E62E
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122629; cv=none; b=KlnG09vZFcCki9dRTXtPxV+G31lhbpdz7rP4ue9J7Hl74rdnIiF3v0tc3mRlOoUIF3U096mJCLbU/lIHZvKXpp21gPMDegMEuFHGoL8zlZLOruqifYsCe82cNFf0loM1Y7QobV4fkcoLz0JC8vunGUI5ay4i24j8CnHgMyBBbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122629; c=relaxed/simple;
	bh=ZSJiwr1qvzz7XQ3QRGBQZyRTERsDLhvLEBD6YQBOHrg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X2+EZBLVmdBBvkP+3m2h3zZPfXan6y+Z+8rJAw/wjw7rKepmR+V1u5i/g0PqXGUKL7DvkGF2y1GDWJoT5/ROj5VNg6hqjHcNi72YgzagF48HXTkOTf5P31UJwuQ0Qt2kyZw46wjiw5uyoB+6A75VOXnx8Qcy9MkIe7GeoTYARcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOq8gqIB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOq8gqIB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07CC5C43390;
	Fri, 22 Mar 2024 15:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711122629;
	bh=ZSJiwr1qvzz7XQ3QRGBQZyRTERsDLhvLEBD6YQBOHrg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FOq8gqIBOvQDxI6l3houhzEFUGBNygcMyx9uPaKZGA1Ork/W4AMJNXInKtm7cpn26
	 n+vDbwFUdSngIgHA7auD7r5Cu3PRSugYs40H2ONO9dwQugScElIsyzi7X0RnQMRst7
	 FSivrDGz2Ip8FG/UGlYPEw0rn9rIkByD1G6JAcDOvZjgSXBhf2ZNpi65pk0/jmbNhs
	 YXOqCBgVLylTRAfSS5UYLGy1yampW5Q+aE34vIZRyOPoK1Pz5DLyKxvNVQzUa27HR8
	 3XYLfMU9hoVWXs4hT0KZ2ogWAUFC8G1661jDM8z3slkqoUckSF0ylAiL2k8uaefrpq
	 TRZ7KFklKefvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E52F4D9505B;
	Fri, 22 Mar 2024 15:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] bap: Fix not setting adapter address type
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171112262893.17124.6027957229910115815.git-patchwork-notify@kernel.org>
Date: Fri, 22 Mar 2024 15:50:28 +0000
References: <20240322143831.198777-1-luiz.dentz@gmail.com>
In-Reply-To: <20240322143831.198777-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 22 Mar 2024 14:38:31 +0000 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes not setting adapter address type when listening/connecting
> ISO sockets which prevents them working when adapter comes unconfigured
> which then gets assigned a random address.
> ---
>  profiles/audio/bap.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Here is the summary with links:
  - [BlueZ,v2] bap: Fix not setting adapter address type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87cabb267935

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


