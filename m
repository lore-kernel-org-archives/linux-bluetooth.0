Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6D419C553
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494835; cv=none; b=R+4HYu8ZPq2aiXz28NE+zM5qHqpWVJ+/5b3sVk70xMgc/fsBqQ+Mu5JR8DCiyWnzLHQApZD3jqhd/PL9E6IkxIex4sShELZckWaRI9jwbFBMLIB3IFYsj9k7JCthLOtEhUyq69bAQebo3b6/WPQ4XXe6mh7wf2a0afLA3a7+O+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494835; c=relaxed/simple;
	bh=He69cOSfoQMfZmYqBgslkLP0muvmgKwbXGVP2FLHm0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mw4oTy2mjOu0TWUe6DFDK0TfXt0FiyzGaDaCUrW0zHnDj+YTocy2OwctYvxfX/3Gz5674THtBUoxPawVXbHWJAhSqHgCXawuWBIdxuPZZlf7idiX8SmUJoUX/xzXAB1FP9+QuG6sAbCilRBgwKtcy2mXUzKkjcJixmd8hW71OTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwCnK3W/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwCnK3W/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C7AC4CEF7;
	Mon,  6 Apr 2026 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775494834;
	bh=He69cOSfoQMfZmYqBgslkLP0muvmgKwbXGVP2FLHm0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iwCnK3W/3G3zNv5zuvJtj1IO6AuPLZK1YBOuwoNsl30VIByrLYFVp3zjpl8JyYhxr
	 mOBiEIV9RtgKAZCbj2H0z3/nxp5EKNmjtbqlv3GnvqEK6bYh5o1RdGVjCcUNiPBuVI
	 pKhWSI5Aj4eI2FsUSNmq9GxVd+Txpvss/j4b8g1DgjnsCmJnAh+Wr9jJ05gq57v15+
	 gFXcWrmn8btZUxKqa8lUjipi/G8Q8FYPPp4yZl3GLyYrj7WneRkX3XojHxj08iq5K3
	 6Z7srJZTN8SIioB7UsE4o/x+bOv0wlQ5aBrSXA/z5ZOCdlJWsf8lBfie3k/dOOqwAe
	 t+tU3XVk4JeMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DFB3809A35;
	Mon,  6 Apr 2026 17:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/mcp: fix crash on destroy after ATT
 gone
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177549481353.3188653.15823430730825612852.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 17:00:13 +0000
References: 
 <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775481285.git.pav@iki.fi>
In-Reply-To: 
 <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775481285.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Apr 2026 16:15:19 +0300 you wrote:
> Tie lifetime of bt_mcs_session to that of ATT disconnect watch.  The
> disconnect handler is not necessarily called before ATT is freed, but
> destroy is.
> 
> Fixes UAF of session->att in bt_mcs_unregister() -> session_destroy() ->
> bt_att_unregister_disconnect() if ATT was freed first.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/mcp: fix crash on destroy after ATT gone
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=46b859d82909
  - [BlueZ,v2,2/2] shared/mcp: fix parsing of control point arguments
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=21db57fc0c2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


