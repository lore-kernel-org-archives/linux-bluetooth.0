Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EAA28A2D5
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472009; cv=none; b=kL3Ut/27HrHkkLLyMNUv0NHjS46mEbUeoDr1m9PDIzZiGhbTiBik7XuaMY53Zui9pyudQ69hhmBwlSIjN5fZHtsXcINGzSiNyc0O9lE8xrpQMBlkh1TRspuRAg4Xr5TtuTgmNxllmueGNCBPq2HJgrIHg45Hq1R1HY6aYx16wDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472009; c=relaxed/simple;
	bh=P6nOFIK651dtinL10vXJZBKD+/qOIj9rRMa4gTHfIFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VWYnykrFW5AK32yLft2ChAU9HucWNthi72EDYnqT/c7v+z6fm8xV6IESBNkSIpprihU+U4CKeuAbX8AZqZc7Mw8My8DQ/JTv8VDXWL8oxKlPNGU2UNb6qvACiUFuOWDRQ4NVotmqq9JLNcMRCiPu/QMC4wV8SXCDpwF/ZVWhqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI/JNmZ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI/JNmZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B855AC4CED1;
	Thu, 13 Feb 2025 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739472008;
	bh=P6nOFIK651dtinL10vXJZBKD+/qOIj9rRMa4gTHfIFE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jI/JNmZ4lwoTLPhXrMRlXP5rL75z8r6qgo1noRY1BlVhsmisUQ5l1MGYLaHyyTmdX
	 DDyKglbQNy7oKYr4iaMXdurdB3h5RDc36WOXCDjOktK4yNi5wWNANilmWv6XuPTwaD
	 bu5XEfiR1/LGIfWS+dLqmb/jUmR02jo+LYwSYg31cJIaaKU2vNuc9w6JpYx2iHkvsu
	 apY7TPUr2DmLATm8d5+DQh2LNagVrIGMWbUZvSg/q0rNzSLJoDLNJNUupdLha/Sxmu
	 86WxYQdEIPXHIzWZrlj4dIqrUk5ZWileyXC1zhax9zVws7e/MZtB3DCfq1+P4atfCg
	 lmZAQdqn8BXvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34111380CEEF;
	Thu, 13 Feb 2025 18:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/1] adapter: Emit PropertiesChanged signal for
 Connectable as well
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173947203774.1333908.11305929458232662828.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 18:40:37 +0000
References: <20250212165820.179487-1-vibhavp@gmail.com>
In-Reply-To: <20250212165820.179487-1-vibhavp@gmail.com>
To: Vibhav Pant <vibhavp@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Feb 2025 22:28:20 +0530 you wrote:
> ---
>  src/adapter.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,1/1] adapter: Emit PropertiesChanged signal for Connectable as well
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f003b90d57b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


