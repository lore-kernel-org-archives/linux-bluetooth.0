Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6691D7992
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734385821; cv=none; b=LPE+eOtI1EOgiGjNgginQDVjjEFciN2zt8lgWhjrEGBDN/hZPYI/60wCJlZzza9zIhDHv12+R/XsHJGGsyNnEoKxlWL2sRp+ytKDiiJEtl7l/oHTORu52BQ+tiO06EHKZUCuF6KbQdYIZlR8fQr9ZxhyeMkMo+uypir5eYg/1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734385821; c=relaxed/simple;
	bh=ou35AYHsIapOm7xZUGm7UGfKuWezfPOVtxhnEZXZuyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dtu4QblR3PbxaKGbcCe0yrrqPzXweOb7YDpvKz4b2BcZrmViqV57rKNTJJbLl1YsRkxUKn7tBNAnre62bl7onIbJ4sGSH5UQ/z2oyRzTizErVARRkRteiLIUW3ESEmPUV9T0qiBQrdgY6rMtzVG161cbeyIIymVgkkYfePhCrF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9aUWyjG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9aUWyjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFAEC4CED0;
	Mon, 16 Dec 2024 21:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734385821;
	bh=ou35AYHsIapOm7xZUGm7UGfKuWezfPOVtxhnEZXZuyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O9aUWyjGjWhjHoowngXJFqI9Gdhq+s6WnqKwM+M3vTN4TaLJtKRKUDG2yz6NsIzHd
	 zQKPMQYjMuqKXY/+K6P5B5xKkrBdF1WWY6bn9V1BctBWAxt6qGB7oL0lkxaOK3NcOT
	 +ebE2lAVfVC0oq8JskCrlS6YLwpvLu9YiMUYIf/Y2xgXiEppyZ3e6N7aF5V4qt6xVr
	 /l3mHbd3gZwMN2LUKwcJDJOMwkTVEn5W0Hx/1RJA+xYDpb7cfBYSiv3epj/7EdMmGS
	 zan8dIp0apWNWICF1jyMiHBSSozZKbqDsGmStYRsr6FH/zSH7AQ4xggQ9Z+XqgWoO8
	 P/ImofOz027rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEA63806656;
	Mon, 16 Dec 2024 21:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] client/player: Make QoS sync_factor configurable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173438583848.361160.17002429269118008192.git-patchwork-notify@kernel.org>
Date: Mon, 16 Dec 2024 21:50:38 +0000
References: <20241213113113.64818-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241213113113.64818-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Dec 2024 13:31:10 +0200 you wrote:
> This adds a new user input prompt when configuring a Broadcast Source
> endpoint, to configure a QoS sync_factor value. This is useful for the
> user to adjust how frequent PA announcements should be sent by the
> Source, depending on scenario, instead of always using a hardcoded
> value.
> 
> Since all BISes in a BIG must be configured with the same QoS settings,
> a check is added in the BAP plugin, to ensure that the QoS matches for
> all streams. Otherwise, connecting multiple BIS sockets bound for the
> same BIG will fail.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] lib: Add BT_ISO_SYNC_FACTOR
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3db67f12c69e
  - [BlueZ,2/3] client/player: Make QoS sync_factor configurable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd2f851be865
  - [BlueZ,3/3] bap: Do not allow BIS QoS mismatch
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ead7f4028a10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


