Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D280BF0
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636829; cv=none; b=QrvvtlbJ/G1T3iNd94yB/2KmYy9bD0a5NBlLRdBZE46lAIGItPjtELHLbwXHQJR5TEsq001X8zs8S6hXU4wW29foSTEailNyNna7Sb5ts+Ww5swCuv8zIOEzVIMQXAOpmM/wD4T8gjsUsWPgZCxD3PI4a0v3/dsrFUIMNuXz2Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636829; c=relaxed/simple;
	bh=IHEORikiPwfd4lEQlu274IZpG1gFXwYxqSnU1ztyKDA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ngbwqDvrnUrnBsQxEx1V9xnzj5tu9491OwceWtqXRoq2iHXa/uZYkItciepMxQZ0Sio31gzPHg+piXfktmFz1/WZv1Kd1myeGJHx+4dB3MoWwiZbYupKspMj6Iwa3GRwAhIs7u0thnZfowRdp0YLjIXkWNwEozch1fec55b45wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igo81Cl2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igo81Cl2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6833EC43390;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636829;
	bh=IHEORikiPwfd4lEQlu274IZpG1gFXwYxqSnU1ztyKDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=igo81Cl2J+afelhy0cCswvAuAs2MHgsPEd6YozaS10CWFuHjQ9zsFSj3q3ZXsD/VR
	 qHLT+uftcP/BlIq1MAyxiIPc0vCtxAGCmTyg5ABaC+UgI8SfplBnzc6PeZ/XowIwqy
	 CQuSIQScMzDnU3nwv9oEJg0qvz7csPiBiNRBCayWjrzSV0AfqqNHVRikFg/X1wYMzt
	 Fr/brWhaw1i0vg0ODoLsw1NCR3EjOUjp3JceDnVYHVmtHw/gDGZa+SMEWHigJmWYLq
	 JNRetklEsjb+2RLwtHoWjbFMvFK9fTvctWarAK/edo0/dDvhhQJCRIVPcTykVMK9/h
	 sPbyUbJCjJTOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 564FDD8BCE9;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] shared/shell: Add script command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171163682934.3770.7011955627512589612.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 14:40:29 +0000
References: <20240326152012.1432957-1-luiz.dentz@gmail.com>
In-Reply-To: <20240326152012.1432957-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Mar 2024 11:20:11 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds script command to main menu which can be used to execute
> scripts at any point rather than just at the init.
> ---
>  src/shared/shell.c | 186 +++++++++++++++++++++++++++------------------
>  1 file changed, 110 insertions(+), 76 deletions(-)

Here is the summary with links:
  - [BlueZ,v1,1/2] shared/shell: Add script command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=868d8fc5dcf6
  - [BlueZ,v1,2/2] shared/shell: Add commands from scripts to history
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e6d849f38be3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


