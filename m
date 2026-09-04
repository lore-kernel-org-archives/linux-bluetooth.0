Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D54FECE7
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553277; cv=none; b=ZYRVdJ9+cQIH7u4CkhirnIc1uRjDUbwh3HC57tIde/rBt13UDSxggmp/yKmSX/o5oTA8GuehGSOgv+Y+tHjHR+IGARa70711ewa01fsxOb0iZzMJ9OgAU5idkrvASuE/3pbUdTg1JheslL/rJYmPrAcCvMF61wOUjj9uXi4swU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553277; c=relaxed/simple;
	bh=3/w7hO3omLylw9HKDXN/EGrPSxwqDZvAwqA51dd2cus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O/2NUUf4ltvCuy6UMZleMnMV8rhBQs1dBb+GosssNgDNxPjQqNbVuXmYJsnjrr2qN8YxU6rE7jbp+j/5HQ/VkSys1Kpw08BZAXKeceaZ4gxyBRqSzKOwYN2g8pKL/tSQWnfjJ2YFYdTSv4qXKcxvjZUgnmdU87JquHKalR7pUqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvnnw6tL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvnnw6tL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4C81F00AC4;
	Fri,  4 Sep 2026 20:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553272;
	bh=714CCWXghbIhKhOXGqaWrQidrjPw//GGgLk6DGtFE+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Tvnnw6tLeRKZYGjYjSSHvt6jbeQ/9v2CBhWV7jMtG2YMz9NRKarupEO9l4CDkH694
	 9vxk+kJqEKlIp0kIfs0asO1EmVjAIW9aZb7Mf6pMUnkzdcbr0tUaft9E3gvzwuCRzW
	 Ck5gQtRQXTiG2V5TjV/3ef9XGa8iS2xNo1ONhUQsef7zq+k9dJB+GrvRRKUP4j4U2n
	 /qfaHcf+7I3N7FERATfLLLAanHXe5bnyyywvemde14Lwpdo6rMkDbVFA2Nn6cTKGYd
	 ZkXsiJwbc9W39PLzIZPcd4O6Thcrcttb1KRHV8NlFoaPb4eUv4ABW0vxc8+8kIsej9
	 AQ2v1n1Xbvaug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198103924A6E;
	Fri,  4 Sep 2026 20:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] btattach: Update for glibc 2.42 compatibility
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178855321263.954520.5061381540514705260.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 20:20:12 +0000
References: <20260903222005.482058-1-aaron@embeddedts.com>
In-Reply-To: <20260903222005.482058-1-aaron@embeddedts.com>
To: Aaron Brice <aaron@embeddedts.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 15:20:05 -0700 you wrote:
> btattach is not setting the baud rate correctly on systems with newer
> glibc such as Ubuntu 26.04. In glibc 2.42 the baud rate termios.h
> constants changed value, B115200 was 0x1002 which was the struct
> termios c_cflag enum bits, but in 2.42 they changed cfsetspeed() to
> accept arbitrary rates and not just the baud enum values, and B115200
> was changed to the value 115200. This means you can no longer set the
> speed with c_cflag |= B115200 and should use cfsetspeed() to be
> compatible with both versions.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] btattach: Update for glibc 2.42 compatibility
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12f5eb726c6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


