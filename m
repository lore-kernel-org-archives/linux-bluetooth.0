Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1D130E3C
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221225; cv=none; b=dK/PMoEdK+eke1VMR1kucEW8ZvdFUV/tPy5ljgJ6EbiXgc/yGFUSLZKSlCr/9bYGxyvlDf90VApHpe9S3q7us0bTaURInsiOiJZEgK2LWl+IrEPNkPsjXKOw7WIEBoNa118+33W0AQTO+sE385hVWRas1Fau1is0eV6raKP8m/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221225; c=relaxed/simple;
	bh=ZxOlWqTz68VWqPX3cd00QnWQ2cXAi2dRMTkQHl/Xd/Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QxLJxoRIQcSIcdjJJN5edJzZ+OoTnapcUMPf1jCbt/VYOeMpcv7JJIvriE0xeY7nfevfo9aeBb2aIw+0tmXt7QNrrMQVeB4LRkH+5hbB4SiWt0kg3ej8XEe7ISUisL0oArK4+y7beMO+TFykg6ulf6N3hG4FzPb+jB2Y1FHABQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si5n2XLx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si5n2XLx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53D28C43390;
	Thu, 25 Jan 2024 22:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706221225;
	bh=ZxOlWqTz68VWqPX3cd00QnWQ2cXAi2dRMTkQHl/Xd/Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Si5n2XLxCzwjf6WXJP7mQUe8O4nOMPagA5DPJDz15FktMh5B7NyjhhMWOoBpwOUo2
	 wuzqcJYSSVT0GfvTWGpbqQo1OMwDOeZ/Er2iDaCIzTkbPuIiz7nlzAfwuKKhuDaZ3H
	 yyaa+TlUgZMO8tbnUOOeyBRVPyWA55zR1O7fW+9pMjZJWP6gpfrMzHJeb1Ed6FbNEd
	 Mc1Srre9ECqRCjkCOHYq06LvT5i/O4KlEqdrPzDytIOzDLBCKggQq+DEczWBiUwqMv
	 EJAGVjpA/Vt3JklQ1iluWBMHhq1IDsh/Y5wOQrXo4b90iXUc6FiMXCftxj0n2H7QPi
	 6aGcLrhtRpfDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D0F3DFF766;
	Thu, 25 Jan 2024 22:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/5] Enhance GATT to pass PTS tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170622122524.3098.8603359358102733822.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 22:20:25 +0000
References: <20240125190805.1244787-1-frederic.danis@collabora.com>
In-Reply-To: <20240125190805.1244787-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Jan 2024 20:08:00 +0100 you wrote:
> The two first patches  allow to prevent automatic security level change
> to allow to display the security error when running GATT/CL/GAR/BI-04-C
> using btgatt-client.
> 
> The other patches add commands to be able to call GATT discovery
> functions from btgatt-client and get their results.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/5] shared/gatt: Prevent security level change for PTS GATT tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6c15afefcd71
  - [BlueZ,v3,2/5] btgatt-client: Add command to prevent security level change
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f0cef854f963
  - [BlueZ,v3,3/5] btgatt-client: Add function to search service based on UUID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=68cd2ae6f513
  - [BlueZ,v3,4/5] btgatt-client: Add function to search characteristics
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=647adf9260ff
  - [BlueZ,v3,5/5] btgatt-client: Add function to search all primary services
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0de32f67f685

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


