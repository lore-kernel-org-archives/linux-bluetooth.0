Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5B18E778
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Oct 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127028; cv=none; b=jryhF2y01OmUVhdzFKYSRFCIw8adB1P5w86v0XzjTsCG6FLo+Vi4jNSqzeGvi8ydF150ROWMWG5XNBD1D0eJ9Hs9/QTM0IJ6m7sTKbp1Ijl8R995DZE+6hWpqSKFsNgzh+oQ7259e8Cku7tu8lsWz0BDuBXRWgZcuvLQ1pvUals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127028; c=relaxed/simple;
	bh=AAw/O0LYAEiL8vzVaNNYqg5WEg07OdKbsiHdAPF+lRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tcx8gouul7Tnzz7ZqOhUgl/huqOJfdktIaO3EhFj3eWs2UQeDh1TgyHDcdrCK4nqTQ5VK3fs40cjUWHGvi4WfJpoGlqt34JDluCjJX3ePpmPwi9gxMQ0vaHrZvMfv5RMLxO9dP42QuyxXcEGyLyttwJdIgQmfihAcouyAcbU8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lquwm6Tg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lquwm6Tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186DBC4CEC3;
	Mon, 28 Oct 2024 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730127026;
	bh=AAw/O0LYAEiL8vzVaNNYqg5WEg07OdKbsiHdAPF+lRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lquwm6TggbTFNh+o093H0cSVavAu5JEScKPoML0IaWRmFNOOW1ePj6eU5u/4R8e4d
	 bt7ZM2Ivk509DvZRv/MtW4FZkiM2u9h6LSMncohEcieueRBx1pDQw1mj9XoX8TUp6A
	 HHSz02dtXcZ/tUVo8FAGqKDZGoGceVzM/K6Ik4Aqz+A2x5OzUmOcNkMbYSTTWdbe3c
	 q6bHA29llsUEHRJTAywjcKt7tsWdiWM/RhvLuMajPqD5ytSr2/i5MVrGjh5DSZr70b
	 YaPRCkFMnvr2w8bJkeujfpiV8aQbJt684cUjHbzfT35PDV1esFtR0nFp+uWMD2Lh+d
	 f6wzxZVl1TaeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE034380AC1C;
	Mon, 28 Oct 2024 14:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: ucast streams can only have one link
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173012703351.76507.3627813497106077886.git-patchwork-notify@kernel.org>
Date: Mon, 28 Oct 2024 14:50:33 +0000
References: <b0eeb28d794adca98f4a246cb368e68022e06e0e.1729937570.git.pav@iki.fi>
In-Reply-To: <b0eeb28d794adca98f4a246cb368e68022e06e0e.1729937570.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 26 Oct 2024 13:13:39 +0300 you wrote:
> In unicast, linked streams mean bidirectional CIS.  Ucast stream can
> have at most one linked stream.
> 
> Fix ucast streams to have only single link. This fixes eg. configuring
> for AC 11(i).
> ---
>  src/shared/bap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] shared/bap: ucast streams can only have one link
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c009be5c5973

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


