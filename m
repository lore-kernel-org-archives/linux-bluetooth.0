Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0411F0E29
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749236397; cv=none; b=Xf7+WHy3BUCKWzqU2MwcoyKu5ZVTfU0iFmO8+Xcw+q0KO9eLG6WTjfAjgXlio9VNynzZIe+c6X+hYd1SP05RE0FAYdGTcLZ3jYMPnGprATRQiFkB6rAmoGeQPdxvDRzne6cyRAOcimwxaRM+hQKKhrWPKMshWvflFVsbeXReMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749236397; c=relaxed/simple;
	bh=q0nvehAn6lNejMxmlFzu7TZUWmlRcigE8qH2Lm0PZsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KDmyvkUe1hfNXrRmsWt6jfZvTYTzHMakedzbyoZjodmBeoxotyTV2XZdnHUtqTt3UN63S6YJkPQers9BMqVn7eSBsRAv/5bg51YBeynO31pct21lCeEZV1zWY4EDSIEuAB+0GuNvPWALqdbNWaViEh/3Qx9WlXmNIvuqa1NC95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INR6IcVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INR6IcVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFB5C4CEEB;
	Fri,  6 Jun 2025 18:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749236397;
	bh=q0nvehAn6lNejMxmlFzu7TZUWmlRcigE8qH2Lm0PZsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=INR6IcVj7x3jz+lauQ50YsXMAcJVtFtruND0Tf8zOov03azJlAhRkb1irWFdlWLO2
	 uTN1gZzbU4W/h2ZPtTvXWuoimjHDQCuTj1Ks2YwhOm/1JiVrzXjnErNqTNz03KQYIF
	 JS/uU7TtX0SB/68wP9cXUSqTRrN3F29fWgFd1nyIMT/sMGyqi/VD1FLMKNI9Zp7NXi
	 AfB0uYiW1pwvfAHxowoWrHrAeZPCDaucBPRcEg8qYh2qKJDjoD0nrs2I7J9kEHU16d
	 MPDcOKXg3hJw6MTFJsF0j/EYNn9aZUMTWoWVl/OH1vhu74PY6tpKnw/WF4F9B1YGpZ
	 PdyAOca3QHcGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB08B3822E05;
	Fri,  6 Jun 2025 19:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] adapter: Fix exposing coordinate sets if LE
 Audio is disabled
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174923642875.3945689.16726314393463860699.git-patchwork-notify@kernel.org>
Date: Fri, 06 Jun 2025 19:00:28 +0000
References: <20250605181256.853484-1-luiz.dentz@gmail.com>
In-Reply-To: <20250605181256.853484-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Jun 2025 14:12:54 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes exposing non-discoverable coordinate set members if LE Audio
> is disabled since it may lead system device setting showing them to user
> that may attempt to pair them and end up not working.
> 
> Fixes: https://github.com/bluez/bluez/issues/523
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] adapter: Fix exposing coordinate sets if LE Audio is disabled
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4a7ee30978da
  - [BlueZ,v1,2/3] client: Add assistant.list
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=04c32f3d3129
  - [BlueZ,v1,3/3] client: Add assistant.show
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f09f33199858

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


