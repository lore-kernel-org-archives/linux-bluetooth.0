Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D001E411D
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Oct 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730295625; cv=none; b=esSf27y+3/wuXoOyD9iPLCuxXamFuCNILBfQciYjnQR8kdQRubmIKV9RA6A5nlfXZHqB8EiUlPy1h4sWSSDbtLiQd/UwLvWJzERQOhakawtM0e+HfI54dIAyWmzJh+O/Qq6xHI2AajMjy7Z2H9A4SAFwr8Fx6t1K2cHnkzEiU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730295625; c=relaxed/simple;
	bh=DKaIwRAnECxVzAAcoDnuYJTF/8/X5noriDrDP2QXP98=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rk2liUNKnp6yzMB3+b9zuKrzuMUkCKcgy2giX5Z8zFSTNH9Vr3yWl/E5ohIimLzpaQb9QjYFUgsyuQMrAWXt9trgUl0P1Djl6QZkhgRh10oZQ2SX2SY6faLkhdNrzGq33mQnYZQzxhv8vSFfgPirzgS5XGyvd/zxULDF2Km4h+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+PLeNA0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+PLeNA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8943DC4CEE3;
	Wed, 30 Oct 2024 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730295624;
	bh=DKaIwRAnECxVzAAcoDnuYJTF/8/X5noriDrDP2QXP98=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t+PLeNA0x/bk7BbyfEoljuek+FOulVyNosfy8779UOh4wyxIh+YkATpekl4givmiN
	 qSkbYYO6FxAqxUZzQzaMh+ax/idP9bOnDdXLfL1b+4OjWspVc0ijC3G1VBOcJvUERl
	 kRkLrQ2p1mHmB2ARn5+cHTNTlvqlByy5//nyu6wDoIfh8alcYFJe+FzbkH9XazWWLz
	 jHcnH0UMv2QW7VM2zoxJCKTrljUGH3R/9BMXoFWn0kh9/+vQUF0OXxTJhAlRsvgjGA
	 BDD2PdIBLX8QH+m3VJT6PxVAgoQHhwM7jg5Uba2kuNZeXh7gdCzHfBI5RS5TmbJxeC
	 RHemGPlWqFumQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71209380AC22;
	Wed, 30 Oct 2024 13:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] gdbus: Add g_dbus_set_debug
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173029563225.1342841.12278593654054576026.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 13:40:32 +0000
References: <20241029212949.3674826-1-luiz.dentz@gmail.com>
In-Reply-To: <20241029212949.3674826-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 29 Oct 2024 17:29:48 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds g_dbus_set_debug which can be used to set a debug function to
> be invoked on incoming/outgoing message.
> ---
>  gdbus/gdbus.h  |   6 +++
>  gdbus/object.c | 106 ++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 103 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] gdbus: Add g_dbus_set_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cbd68596121b
  - [BlueZ,v1,2/2] main: Add call to g_dbus_set_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e062a44edd9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


