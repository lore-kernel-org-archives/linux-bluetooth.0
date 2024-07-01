Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F316089A
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843632; cv=none; b=UTXke1uf4T/1cezZqi9AAkUnIH0KRH0VrAyyStxuCTuBcMZlWfNKAr3y6zu12qEtU+/iCj9QknkvlZmrSDCqeANzKjNcmvsy9Dzkzye6NeZu15q9IYOJYIjyI9pCXFZUNx5Y/UAG2+9PICuVHgfbUUNRfGw6Q6dSll+YCU8rg10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843632; c=relaxed/simple;
	bh=IRfuHrsHvXTBzf3702FL7PxOWmX/g1L8lvswRBE8JW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OLhOhR0vAzO3yajuNk/1vp2Hdsq5lfMDHZRJFPxJGwvHTckgZURcFjyt/SfYpUYQaQ9ZkWjiNpmsmxseLoT0T02RuJwEwOnyLb9SR6Db3P8dHavTsehNw9ucb1mUnkYUtUFL1NTNsAvLDjKttCywfRfGL5wXgS/PoDdgAviHubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsRZ6UA9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsRZ6UA9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9AC3C116B1;
	Mon,  1 Jul 2024 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719843631;
	bh=IRfuHrsHvXTBzf3702FL7PxOWmX/g1L8lvswRBE8JW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SsRZ6UA9ZtDmquR/c0fZHUjxuBmNKLM3JhVHEWCIngN6efJPkb1RMvtW5btDKF6b5
	 CahY1oJICcy3FzTwZTsXtgOYRfYi8ZxJjGyZ3SFkSTwjo7ATukkywfzUl5B6eYO06G
	 IuSfjLVnxDbEdh2QSdmR0JqK/g/bfzvPyuZIRmQi7CtFUbjv+2XzktYCUd4xdu4Aq5
	 pK/1YNyVAVIRBfB56Bv1UCvN7zuO4Cer50a1ksVNHLziWZgqkjuv/eoBRG2Og85sv+
	 Krpo2J2qp8DJWkHuCvVBFXBDlPvfi+Pxg6PRjNQhP9hh3wIpPNI1M1XaMqFLQIKULL
	 yKfy1fGBIdAiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97360C43339;
	Mon,  1 Jul 2024 14:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] avdtp: add NULL checks to avdtp_has_stream()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171984363161.28078.12097233491365199341.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 14:20:31 +0000
References: <20240629083619.11804-1-r.smirnov@omp.ru>
In-Reply-To: <20240629083619.11804-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 29 Jun 2024 11:36:18 +0300 you wrote:
> Make avdtp_has_stream() safe for passing NULL pointers.
> 
> Found with the SVACE static analysis tool.
> ---
>  V1 -> V2: added check for stream
> 
>  profiles/audio/avdtp.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v2] avdtp: add NULL checks to avdtp_has_stream()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be0b08770e92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


