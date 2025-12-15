Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBE341057
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765828046; cv=none; b=ps84u+yCwRXyby6pPYS95Hzlc/xKmBIuG5mmTMqClU9fhB/vdr+f0wHNkOBl1aHxQ/70Y6etcRAPIqQ66qHOH3XQs2z26Ncv2qroGxci941PsYaAjAsZV3D+orhBuV2tIdxQy/UoecGZnxnvlky+AJHXzBK4TIX9xmhfs9eWMM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765828046; c=relaxed/simple;
	bh=XdiAQ7FAU0ZAEPcMUOwGFxSqvX4UqOYFo1Aarg04OSM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QcEayFVjcDk6QOQV/HV/IOZ50dco9PlQp0jgK1uUm29Evl6H/aTH/ydjh4LxsNmM2tsO+ooZyYlbJrBHsiW4KKiyva+s3Zbm6KcrAioZs9gz0yHSs/P8HtcCjDbEE1VhjY7kkAwWLpAhqXr1YrCAN3XHlpiV8mPLgAYTBoIg0d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm2wDc63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm2wDc63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04092C4CEF5;
	Mon, 15 Dec 2025 19:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765828046;
	bh=XdiAQ7FAU0ZAEPcMUOwGFxSqvX4UqOYFo1Aarg04OSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cm2wDc63RDZ5n6OHd+Y1ELXfvpoioBhZ39X409LixlH/jyGz78AZmwhmcfnj0tLK6
	 CQHj+J6HPOWWskf+Owo3kcg6tegafuXMsyyXToPFjJ/rapfoDJE5nXhq2Kg/iMuyov
	 /TefZ9tLw+Ddd0Ua71R9HnRYsa5BxgJC0/ItgTSvq+8I9ZKGgTWYkAPhHNjJ55ioFf
	 bKtVwF6dfe9PlPrPmVozAE85CzwlXrelzjRaQ7sodaBO0THhmGZUzIHxSUR2sKwEXJ
	 r735XtukpvqY8RPJzWW7SSD1cMOVPxrwjuA4EEDDd7gyPiY9XPkXgwZDND4CiI1khk
	 H1ol29nJSqdyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789B4380AAE2;
	Mon, 15 Dec 2025 19:44:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] client/player: Refcount registered endpoints
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176582785702.183851.11478923750064431583.git-patchwork-notify@kernel.org>
Date: Mon, 15 Dec 2025 19:44:17 +0000
References: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com>
In-Reply-To: <20251215140203.638669-1-arkadiusz.bokowy@gmail.com>
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Dec 2025 15:02:03 +0100 you wrote:
> In case when more than one adapter is available on the host, the
> endpoint is registered on all of these adapters. When unregistering
> we need to keep track of registration count, otherwise we might free
> the endpoint structure prematurely (on the first unregister reply)
> which will cause SIGSEGV.
> ---
>  client/player.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Here is the summary with links:
  - client/player: Refcount registered endpoints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ba4978255c3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


