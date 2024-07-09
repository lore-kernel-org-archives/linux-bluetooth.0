Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E51DFCF
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720551782; cv=none; b=DrEuwaz1obs3lJNTsuM9SGbKSw2ugp1l8SyzXha62zXJB+UdcaXBhp6nfATntmfZxfugTxbr7/bKSabG+4zpiR9JHuF9ErMtPue/1DMFLmTyKvAWSfTK2I/bVjZ/sfEYeh0CJwvrzEPKcfXuC8W2qflgcZgPKJ6f2nEOAJgFiws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720551782; c=relaxed/simple;
	bh=i8AqnSkrm9riXFQla+1hFWg4F8gixk5UAWYK/d31cLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IbNYIuTnbeCDoyVYxLOHEDLhjn3uqo4h/ZS9n6BdIFeNveBtuk/jOp0n1posw7OVuqRT+V44HxrgdMKBycpbmQDRhYH/XxGFbiItjPtkJfF0lDPumocIF3Q5HoKGCGCXYK/x2/Xh5w4t2zni+snG5itng5tuShufSklT4FqFNUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlGREkD3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlGREkD3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2449EC32786;
	Tue,  9 Jul 2024 19:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720551782;
	bh=i8AqnSkrm9riXFQla+1hFWg4F8gixk5UAWYK/d31cLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rlGREkD3PYGUk2hJyvrNhnt32JeUWrzXCQoDUsWnuCDqstTpTCEmR0lXNOjYMq8p0
	 9laA1AYCeze9oJMr/uDqxkHOPDM4rH5h9aU2VyjmPJDja6MQSFv3KOXGHNXRO0qK9u
	 Flxn/OfwEml8xbd4udOiKGHGkpKhE6xuhTIl5EEa25DbRPNbzLqYohuthhs/Cdkwb2
	 YBp19u7tDUWzICcAqdxKv5KwLLrkWRbd/GmnZK76788UTNIv4xsWw8G9mIAPAOnC88
	 ULmmz1qTWFmNJEtMuzTgGLyFUq34yg8uqg3GaLncU48YcLY2jMF/IqJxUrnoIP5AG+
	 Oy2QpjQsMHCCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 116E9C4332C;
	Tue,  9 Jul 2024 19:03:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/4] fix errors found by SVACE static analyzer #3
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172055178206.32169.6195426319508636656.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 19:03:02 +0000
References: <20240709143503.12142-1-r.smirnov@omp.ru>
In-Reply-To: <20240709143503.12142-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 9 Jul 2024 17:34:59 +0300 you wrote:
> Several bug fixes.
> 
> Roman Smirnov (4):
>   health: mcap: add checks for NULL mcap_notify_error()
>   shared: prevent dereferencing of NULL pointers
>   settings: limit string size in load_service()
>   settings: limit string size in gatt_db_load()
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] health: mcap: add checks for NULL mcap_notify_error()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aa6063aa6695
  - [BlueZ,v2,2/4] shared: prevent dereferencing of NULL pointers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=11dcc9bf0dba
  - [BlueZ,v2,3/4] settings: limit string size in load_service()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=755091581336
  - [BlueZ,v2,4/4] settings: limit string size in gatt_db_load()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4ca662fcea16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


