Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF737CD4B
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387853; cv=none; b=s48i1jQ2GBA5NtldY83nXSnP2AKpg8hAvc8edLjI0Q5hHbnfZhbIIyS2cIsQH5jFrNfHcP7diF+y1bSCcTFFnmkKTANEXDy2r+pwR42nQhWnBGEahWcNLqx5CyNhgv2GIcZzdpVPKSl1d+0P6vXqbw32umwa22iFHjwlCjlZZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387853; c=relaxed/simple;
	bh=10xg56wWTOrzV/+GmEeyNmYSXR9G5SYavHBaMdhmdPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LEwYA6MFO/vZfOtgMF4CzuQVrWuB+JHXci7u97yCdA9hn+8pwckHxosyl6E+F1wxTso+o0PBXyFHrgdF7G0GidWNXZykZtMDnCZmzuHWJw61ALik9ujA1QqpZuIcGhA/3cFHo6TadWwzQaxL/Z082UEOWdtCVO8HIv++eIPjmeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGKfp430; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGKfp430"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F144C2BCAF;
	Tue, 28 Apr 2026 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777387852;
	bh=10xg56wWTOrzV/+GmEeyNmYSXR9G5SYavHBaMdhmdPg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QGKfp430YnAwHTH4ra0c9iP5LqKXsjpkVb7a6CKrlJdBTOcYqQJpp+YBwPr2ahIfV
	 Z5agOj0lYl/Twymo9KvEQbQSy/PkCcOl4MTqulNxCZPLVAgX+YjidUSQsAvIGNCDNF
	 6rH1hP2wc7aggB8+HLDgLoxfeOZvLsY70WLgQJf4apS3L0x3qYPQu3kzSVVjUmFoNc
	 UumqZT7Ep6ycQHfmyeFHwMUf9lNjiP1mU46bQPlX2VcbsT13HFuS+BePihNemumG7o
	 Kuj23QhgUdStNZb1y969TgmgNo+kEN54BpiN/ObQGOxaTat0lpV386jW4GGzPujsMv
	 gSGHaUQfL8n8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCD33930211;
	Tue, 28 Apr 2026 14:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] bass: Fix crashing on BT_BASS_MOD_SRC
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177738780904.948500.18411255452768170664.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 14:50:09 +0000
References: <20260414190459.161947-1-luiz.dentz@gmail.com>
In-Reply-To: <20260414190459.161947-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Apr 2026 15:04:59 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If assistant attempt o modify source the code would attempt to iterate
> over all valid range of BIS indexes which may lead to the following
> trace since the delegator maybe freed in the process:
> 
>  #0  queue_find (queue=<optimized out>, function=function@entry=0x58b8761109c0 <setup_match_bis>, match_data=match_data@entry=0x3) at src/shared/queue.c:230
>  #1  0x000058b8761127fb in bass_update_bis_sync (bcast_src=<optimized out>, dg=<optimized out>) at profiles/audio/bass.c:1824
>  #2  handle_mod_src_req (data=<optimized out>, params=<optimized out>, bcast_src=0x58b894661be0) at profiles/audio/bass.c:1862
>  #3  cp_handler (bcast_src=0x58b894661be0, op=<optimized out>, params=<optimized out>, user_data=<optimized out>) at profiles/audio/bass.c:1910
>  #4  0x000058b8761bc978 in bass_handle_mod_src_op (bass=<optimized out>, attrib=<optimized out>, opcode=<optimized out>, id=<optimized out>, iov=<optimized out>, att=<optimized out>)
>     at src/shared/bass.c:1069
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] bass: Fix crashing on BT_BASS_MOD_SRC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b3729e26cc42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


