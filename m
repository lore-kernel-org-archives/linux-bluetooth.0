Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7437AA91
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479651; cv=none; b=lVG3b5mFKaeWOrTqJmjdzRodF0fwdBweH8r6dun2cfuEmMvDzEpwn+pUTnvGXFBEn9xdfz4xkY3A0Q1nCpR1EpqrTPWW1GKYjM3NFlRRp+QWXG7GITJmZi2EYK4UPlpmMsNHJlyusBL0s/ZjwY+CrG7B/M0HiytdcRmTgfRsZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479651; c=relaxed/simple;
	bh=JnsfNX+CH/WH0jREHPSMeSAHKYsugxAgJ9hgbh95khM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IaL8DBH3pITa/E+9tIaKt51WnzQKPYdscnb6OY7QyU5M/Ve0Wk67j8dxuVTpc4B7IDYZehBp5WH36TiF3XnsrbYw1CxSyHGl1WBDn+ZI4ZqOpd0MQbl3k5eUokQqPMyw3+Axk7MIxh30UsOxkkZGk8cVwBxIUJSjTuULQwEjXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0bg/1C8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0bg/1C8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F991F000E9;
	Tue, 11 Aug 2026 20:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479650;
	bh=ipgEKeRIc/QgsXRXGJLo1DU1QALC5OLC2TAi5dHaGfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c0bg/1C8gUCZr0kxh8BSWbQ4C31UJLBkotxziqyve9bNxwxhAWzkefu5QN56nEftz
	 h9UKgh0hMW41r5mDh3FsPc97gfG+Wks+WIdl5AZvXXJf0nwa3atXugOJfWaa50HEmB
	 ngl5pHYndjya4FuRBA6bckhu++DgPeVXOUtreuJp3K8xuhrap6+c8pTM/hsjZ3/w6s
	 pDBaWxpSpi9NS+xaCIcvIM6o4nCP2nDA686laR8sR/arLuFeYbzzUZcLabTAtlGJX5
	 v+8NOyIWhVBe0ytscDssQTNPAZC1bJI6pVkirjaFRu9PkC89t5m4kQhviRMYJYjHu5
	 Q5HPzgUYnPJfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A713809A0A;
	Tue, 11 Aug 2026 20:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] emulator: btvirt: support debug for -s socket
 server
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647960618.1138292.9372075870430178417.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:20:06 +0000
References: 
 <3a0785ebc5ceef448c52d25545b142659d25ce24.1786177678.git.pav@iki.fi>
In-Reply-To: 
 <3a0785ebc5ceef448c52d25545b142659d25ce24.1786177678.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  8 Aug 2026 11:30:33 +0300 you wrote:
> Support btdev debug -d when using socket server -s.
> 
> $ btvirt -d -s
> Bluetooth emulator ver 5.87
> Request for /tmp/bt-server-bredrle
> bredrle: host10: > 01 01 10 00                                      ....
> bredrle: host10: command 0x1001
> bredrle: host10: event 0x0e opcode 0x1001
> ...
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] emulator: btvirt: support debug for -s socket server
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=10df0bb74844

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


