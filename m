Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649219D08A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338429; cv=none; b=LBRWHiRISXdRQvXzD8/f+V72Yo8+U6lRd8l6OEiL8sZ2r3rBOEKGLRQbogIR/s5B5HzHLyuqO7GWg0+RHtfMGCCai2b12iQdEBo6uq7H9Ph1h5LszNtG9RiZMAMednTd6QmNye33pubUb3pJT77slEip64lOLGXbIrX0nyJl6mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338429; c=relaxed/simple;
	bh=j0ztFaHtiSVDhKuIFRy9h0yG8gD1k11aPzCan4hbWe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BUccoJOTyMndMX9H0ZzZeuz/qTYiyPQrsWxwIMEkj6bA/yyuuCxbmxA5aS3KWhbFElp7mbpWSas4bAfl3RzymLuU6uwXBo9jGvvchzX8WF0VFxCX1OamHFl8kZx8EulqfUHskIuchvjNeGEwea+YS9VOepQMJwOn2QlTBLqD0ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI7ZA5UR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI7ZA5UR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8E3C4CECF;
	Mon, 11 Nov 2024 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338429;
	bh=j0ztFaHtiSVDhKuIFRy9h0yG8gD1k11aPzCan4hbWe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DI7ZA5URVl+qYgkFPFr0bs7J4YrVSQ+kuU3x2wGY3oLXRpSlvKQUi5GZprp07dOcd
	 M2fmgLHlJo7hVvCtG4HBXf3n5KNmyVPD4CICawYPNsTRnnYn9f/XG0KuXvz8ZUPu9a
	 OMAMNUAQThlvmkFatG1xvalXRzQt3i0tTIm9KRH56LzNkMaaYM7n9GnZsfuYFZIRFX
	 jbXlV4VR9nYSimRTBwhj5BUNBJ7zU+Eyk8q8tZksLjkwpcYNFda81hO/eq+Rep+BC8
	 Q4YV8SnZXOMFP46ag8uE/h1ak9n4z8hGHsRRjN1kDNg09P+N60KH7kNJjSE4/u+Qko
	 ss03wbXRlOAAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34B3A3809A80;
	Mon, 11 Nov 2024 15:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] transport: fix AVRCP volume in reconfigured transports
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173133843873.4067431.4350236403687368628.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 15:20:38 +0000
References: <9dc80086204f29041b29570575df9112c6988955.1731177363.git.pav@iki.fi>
In-Reply-To: <9dc80086204f29041b29570575df9112c6988955.1731177363.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  9 Nov 2024 20:40:29 +0200 you wrote:
> We no longer reconnect AVRCP session on AVDTP transport reconfiguration.
> This breaks AVRCP volume after reconfiguration, since there's no volume
> update event incoming.
> 
> Fix by keeping track of the latest volume in btd_device volume.  It was
> introduced to track volume changes that arrive when there are no
> transports/players, but we should track all volume changes otherwise the
> value can be out of date when we want to use it.
> 
> [...]

Here is the summary with links:
  - [BlueZ] transport: fix AVRCP volume in reconfigured transports
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=774ad9fdd96a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


