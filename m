Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F122A4DA
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911787; cv=none; b=kk2pisSVaTcYy+WBHHk1YmjYs1ZmWPXKk9NCxKDV120mcSLkAkwiQ3vhlAcTC0yaYlSij7tnGgf9TVd5/z0jERP8Q8JnUH1dPH0dMimN5uRVrsy5rxqf+8Ip2CHTMV8+B118CzM+lMhOJLoU/IPadJ68GkIGkeKKxok+7eu8PPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911787; c=relaxed/simple;
	bh=cXUaXbzmL3MsfMla4tW0pjihaS+d4N/gAPkxL5H4aXs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KWj+6eq8+6S3kwZTUZ6qK9MuUQsQ0wQGxDOHsbHkX9ZmZ+tHEJHEhkr0HKDz0/EoVa03rnJLThFLDgDrt9BPfzOmTnssALf6Xa8yoaQq9GMdzz3wbHBkrzQU/WiCkAT5fWKaestb4LKv7tUg7epUlpjRFX+UzO+ZfzwmNY0ksIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fl9mCUyT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fl9mCUyT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFB6C4CEE3;
	Mon,  7 Jul 2025 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751911786;
	bh=cXUaXbzmL3MsfMla4tW0pjihaS+d4N/gAPkxL5H4aXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fl9mCUyTH32sAKwjF27EUjmt2gmvtmb90/To72neOf8jp9Wi/86JQj4HpgEfFkKLQ
	 WD5jB6AxSwZGuuMdWuyODpviuW15lriIVbaSTVLfMMIBR11JNjSal+7A2bQjdIf/kj
	 QXk9VRoLbgmS9GA4DpyIEW+MKblZMPDqhCdyMBMDIj29t0jjEg8ZZYDcaPCvSDM9Ml
	 e/OceOu4ZoAK8lP3BQeNj/XQbO6+edUs1UyIGhsigbbhwRcDXoNYeGMLIyYkevtxna
	 eK9zOhzOKTv0uVe8/MtFDgUJ/4UbGsgIiCY5QhddTbb+p9p0f07DuZyoc6ZAD3smnS
	 tLGPYSyT6MkLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D61383BA25;
	Mon,  7 Jul 2025 18:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 00/19] Fix typos
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175191180997.3378325.14050348753349283122.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 18:10:09 +0000
References: <20250703085630.935452-1-hadess@hadess.net>
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Jul 2025 10:53:08 +0200 you wrote:
> Used codespell to detect typos, and my head to remove the false
> positive.
> 
> Please review line-by-line before applying, it's long, but won't be as
> long as fixing those typos ;)
> 
> Bastien Nocera (19):
>   android: Fix typos
>   Fix typos in top-level project docs
>   attrib: Fix typos
>   doc: Fix typos
>   client: Fix typos
>   emulator: Fix typos
>   gobex: Fix typos
>   lib: Fix typos
>   mesh: Fix typos
>   monitor: Fix typos
>   obexd: Fix typos
>   peripheral: Fix typo
>   plugins: Fix typos
>   profiles: Fix typos
>   src: Fix typos
>   shared: Fix typos
>   test: Fix typos
>   unit: Fix typos
>   tools: Fix typos
> 
> [...]

Here is the summary with links:
  - [BlueZ,01/19] android: Fix typos
    (no matching commit)
  - [BlueZ,02/19] Fix typos in top-level project docs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d46ec5f46c36
  - [BlueZ,03/19] attrib: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87fb2b7b5a80
  - [BlueZ,04/19] doc: Fix typos
    (no matching commit)
  - [BlueZ,05/19] client: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9986633b3155
  - [BlueZ,06/19] emulator: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3b9fc5ac340
  - [BlueZ,07/19] gobex: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a1b1d08d430d
  - [BlueZ,08/19] lib: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9e9f27057784
  - [BlueZ,09/19] mesh: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ce78b15e67b0
  - [BlueZ,10/19] monitor: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=27b1e893cd99
  - [BlueZ,11/19] obexd: Fix typos
    (no matching commit)
  - [BlueZ,12/19] peripheral: Fix typo
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a1f82f1020f9
  - [BlueZ,13/19] plugins: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d68c6090471
  - [BlueZ,14/19] profiles: Fix typos
    (no matching commit)
  - [BlueZ,15/19] src: Fix typos
    (no matching commit)
  - [BlueZ,16/19] shared: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f019d0671875
  - [BlueZ,17/19] test: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=32e3d6351d3f
  - [BlueZ,18/19] unit: Fix typos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=de69e5a3ab7d
  - [BlueZ,19/19] tools: Fix typos
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


