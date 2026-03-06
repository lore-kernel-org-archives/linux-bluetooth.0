Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2F3AEF39
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809806; cv=none; b=Y6MtgKTtv+Z3Y90DNN4ylEPlHfS7GQRg/+4qrj5RIcU4uTFg9JEqwIZd05S3PxEFkiAG1tSBinsO2OkOWp5daJaDkOYcrQfWPByDjDuOW7N2TCYktACq7qJAg2sFP1glHw0IKQa8H+iO8zwjxRoHYc6F6TNKcQcqEaCfg3oe3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809806; c=relaxed/simple;
	bh=JHOk4iTITFu2v8pEQeqSz/MBbNmc9tOkCt0Rv4L7YzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K6UUMeCHuRK3Oae6IXZbx0Ljeq2/vuwd5oZSeC73Pz/F6u7D2cAgbfFAmeVhltFlOqnFp6aoaa8g3DD/mEaILMT2Pt69X3bUIJFfUe6nqHKoh4YsHueVLUj+hmz0s5n0G5GnJ8O2i/nVYBC3LAsNppTJ00iHIHc0z4at8RR7K9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ6N5QJO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ6N5QJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A64AC4CEF7;
	Fri,  6 Mar 2026 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772809806;
	bh=JHOk4iTITFu2v8pEQeqSz/MBbNmc9tOkCt0Rv4L7YzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nJ6N5QJOadh7Ivm60a7PNYKX2Lul7WgDu5ttoUpFm5cVEml1t5YrrLXkkaGCTK1NP
	 ZkRsL1AtlLnomFH1HE18siN0JEq/0dWWVIe2eVVb9eIpT7jK71tqXNJuzWb3maGzSh
	 N+FY8vP21YhxPUaWFm4fJr9ROC0nzaQnclBI+2o5lhCr6DpFsYXJ2o0pJwrc+/YJKV
	 IxOxAyb/gIQSPtg0wxdmIcnEHa44741U5E090EFCWwJKqGW9o/U0izF85GiBdHoos7
	 OzU3LljCyrjWgnfNo1HuH9iL+TsUU0wzVnv1+coOAkisZMs07ZSnEGKGDBWiH7QIBH
	 oDGPEUaHu1uAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E0A3808200;
	Fri,  6 Mar 2026 15:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor: Fix -a/--analyze printing wrong
 connection
 type
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177280980579.3708258.13564003945204298843.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 15:10:05 +0000
References: <20260304204649.309362-1-luiz.dentz@gmail.com>
In-Reply-To: <20260304204649.309362-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 Mar 2026 15:46:49 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  monitor/analyze.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] monitor: Fix -a/--analyze printing wrong connection type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f355617ee0e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


