Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B04A4826
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001079; cv=none; b=ZyzEI8465DyG+H4TKxYEc3ZMOExjDoS5WhXJ4HwsYNYICzkb9Z6VmWETaWGohJMZv+74RznmePsv+QqMYJHu3b1f6PfEn5sG+6wQy+iHQX4iugMT25VYpdllQ/N1QFHiOo0Q7oIoHHCuPmylSBAU5vkwOzvD6/mDgMNEXKnjqHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001079; c=relaxed/simple;
	bh=qeXBXT1wLkCOyLhz7B+Dt9WueDHUwTWYdR/TQa6uXdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WwFPTB7GVgqdnGWZjZRwQUjVX1G76j2GWcWoqN4wqjv8L37ERbLJJ+rToD8/MI1MghVYayHRKX5qi6cOqXdRTCCOlcL6sPKsOxcsF9JRKEG8gpbbLk9gsSZ/edl31Lr4t9aOR4UQL7GA9Ym4V+KWgaxhW+ZGOzqjF/E1BrfS50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jdi396Jr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jdi396Jr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6B71F00893;
	Mon, 21 Sep 2026 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001078;
	bh=3vkxKs18qVPeazB2shXQBt4RbKItRc/39z6YkPUMi8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Jdi396JrpXv/BQyGvTpNhfN+YvWU2+g6B8kJs6YAYAUzEyqLuE3TuZaoySf0/kl+u
	 yFTV9rsMc5u7iZviFDussGQ/vuKyhnhPnfv4HBbsBojUF+cq1EdLNcAkI5H0v80OLa
	 E8dqfZvUOjA6PAtWLN5uI9M63JWUt3+ves1gLPl3mgTEZZPNDQFL5W8RoRFYyQiKSp
	 9a4CZD1TvRiS++E+zkLXKaJMU0LV+G2QQCyZp9C3PyZbR+JkTZOfC2ypkLCiSFkQEA
	 /VFgnhRnc4DBxVYZ2MWDDcCcKUNf4mj8Kv1zfW/jL0Qy5NOl2ptU3sfiqaJTPmH+vo
	 hrbdXtN9VYUpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D098E392665C;
	Mon, 21 Sep 2026 14:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] adapter: remove the devices from the list before
 freeing them
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179000100938.3057876.5753948160387030061.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:30:09 +0000
References: <20260918215915.2572126-1-luiz.dentz@gmail.com>
In-Reply-To: <20260918215915.2572126-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 18 Sep 2026 17:59:15 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The devices of an adapter are freed one by one when it is removed, but
> the list keeps pointing at them until every one of them is gone, so it
> refers to freed devices while the remaining ones are being removed.
> 
> Freeing a device looks devices up though, e.g. cleaning up its GATT
> server reports the disconnection, which searches the list for the
> device it belongs to, and the search reads the devices already freed:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] adapter: remove the devices from the list before freeing them
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb82d81bf26b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


