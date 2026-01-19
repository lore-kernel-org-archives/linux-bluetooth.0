Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35929BDAA
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839009; cv=none; b=qTfrjO9ClZXJindJGveIiTixXKk7vy50d6aD0axkGN70IM6pCko4JwTgwiZgFSaMCHXZlvs1OJpYAhDIAD2mMB3PmqgGsXpajeYGG9PZ5DASBdbXF1ppapftZu7X8fHZD+rVA78oAR9LfSWleaT3t9OqW5p0qlIOOF7VgomFAuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839009; c=relaxed/simple;
	bh=dGl6lyfJ9XD0U6zFbiMX1K7PjlR4TLgaCRci+6Vbgnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hgW4MpRhyLjzFMYc1QJjBDzojRgPdvJGQnF+oD/JiaSTg+VDdACcu7NP6EqJ5pmGi9uLQO+CxbmpXs8zyFl0nuLCjr3lYjBOHfhx9bAs6mtQkJ6LN0DCFQsZXo7Ws0LrcHxEOUH5Ogo9Oa4AKlWuIn3Ugy2nTsr8OjXKh5gf7uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kE+kRI7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kE+kRI7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EC2C116C6;
	Mon, 19 Jan 2026 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768839009;
	bh=dGl6lyfJ9XD0U6zFbiMX1K7PjlR4TLgaCRci+6Vbgnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kE+kRI7m/mlVXIR4CDb/1fhX1DDH6bLSpf2S69bGmlW/CrqnQj+kDz6XI8H328ADa
	 ffebNxDnWrWtwLUprqR6wfe1KMQ10QlxvGnmbZ1hjM0hxT3cE6ZXMMFNlBgLf2Drgk
	 UlHcyanxPNyiJorSiURKNEweqhCfK0ThzLT6i2inYv2JMnoBUsoxF+ufEZcabGHWp9
	 Jk6x5tja1ce+eDTVmX2S+LsnqjRCUrJ99knnxGfYXOHA2657Oy5IOJQz6N0uk+R3TM
	 GPLwiGlFrq5eBN9YYX+mquwGLH/vsTE4yk3QDCIuoDnhtNMTw2KSAKlsYkID+0zjpO
	 +BFL8wbtIYXcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B8C503806904;
	Mon, 19 Jan 2026 16:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/util: Add missing entries to
 bt_appear_to_str
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176883900728.36627.14697292430552572923.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 16:10:07 +0000
References: <20260116191120.1768270-1-luiz.dentz@gmail.com>
In-Reply-To: <20260116191120.1768270-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Jan 2026 14:11:20 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the missing entries to appearance_table to it can properly
> decode appearance values as found in:
> 
> https://bitbucket.org/bluetooth-SIG/public/src/main/assigned_numbers/core/appearance_values.yaml
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/util: Add missing entries to bt_appear_to_str
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d6f86b07167b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


