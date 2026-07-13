Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB34935A952
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973437; cv=none; b=NpmSV5zZCt8jtFVM0WfZ4sT8338+Lc8WJ4RpvIweJUT2IbeZ1UISHpUqJIZWK/CTSpeTUUQOiEwG+a2IMExCe5eTI4pwK3VXJW4Y7i50kX2ohMktk3f+sx49uo6jcx4minYHlLKNlXEk/Yd6x+iaSmYbqQD+EMyQ42zuBR94z2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973437; c=relaxed/simple;
	bh=Y6tdJRt+I7JZSmhOXzZWdMNp3UPt3LlQ6jdWWU6TG18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a5OuaS6sfKtOcmfhWEMxBYbp3NPjlpCEZ92rH7sCnGjRNX1DMaMJrytwp/yJqL8ql4N77m1SOfQDC11pUn5Abhj6wuAWQ3W+ci7jfcIvAY6YDIeBo9wNIAFuLu1zJIj+x3eidIE5nTwQFUtPe65EVKc+SbBxoYQ71oennBhnggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdGoqkRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdGoqkRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618F41F000E9;
	Mon, 13 Jul 2026 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783973436;
	bh=I+1K+RjxMvpuauTQhm6nXOIFRCn1AR+V5pECpkS4CaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JdGoqkRuqUNQrwegKiY+YdyzQBxhzHV1D8wnrO3BQa6vlvpEO8P2SLUcXYKyVvlIG
	 j709Rf0T1XZOI+VvVhAIbZ5+/isEBVFqOKH/t3jFW2szIUtxB3r5gpS1ZY7ffaNU5n
	 +9yMufBWXl3FDt1r1TYHLJqIws7PuqwpwebUNJzHFsU1oVO/tBvcrMiUcteOZoWqaQ
	 fYfmSo1H22NfK0uXOPBBc3e3gWOWBEiyMTWiyujrPdlihZh/RbrRyU1+X5qVyoj7bg
	 F7MtmBVgmbyIsSZK7YW2FqCDY4YUmHzye1qfbsgsg7FwGh5KnCLhd6OsaoZAzDETqI
	 EU1UMRmN5Pq4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A3B3924F90;
	Mon, 13 Jul 2026 20:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/2] lib: add iso_data_* macros to hci.h
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178397341139.2830302.15779811095462508470.git-patchwork-notify@kernel.org>
Date: Mon, 13 Jul 2026 20:10:11 +0000
References: 
 <e2b3c5425a653eb198700cb28c453607e2d82840.1783761325.git.pav@iki.fi>
In-Reply-To: 
 <e2b3c5425a653eb198700cb28c453607e2d82840.1783761325.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 Jul 2026 12:15:25 +0300 you wrote:
> Add macros for parsing ISO Data Packet header items.
> ---
> 
> Notes:
>     v3:
>     - no change
>     v2:
>     - no change
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/2] lib: add iso_data_* macros to hci.h
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bc49d63210f2
  - [BlueZ,v3,2/2] monitor: fix parsing of ISO packet data header and slen check
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1309d5f9305d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


