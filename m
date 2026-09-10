Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8515867E7
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065677; cv=none; b=OaVCz4e7/OZlmFOUb2U0paOUh2pH/ujgXcV5QzY/bXzATLMzD9aDs+rJoKsf4zz/qbeXLrgh+uT0ac3smeiNsJSdN2TxcMkcRL94l8HQsxXFroCrU3kqp+QFGLw6gzDn4xdaKPw/vdpbpIpEvQ4NUwLyjragqrVnHAwsjDcgxzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065677; c=relaxed/simple;
	bh=caHJ02DCNl3XGtEdD2d8/LB4TINzcUMw66qCCca1LGw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VNCG9iJowSA7a/uFmF3jaxsYUsTrS1B+FAZNuB5BE3EF3BOOSYQ1xI+Hyp97kiDFMm7bOW5E/xNiD9pXfbPseOoD+QADGhaAmSL/TucoOh2x8TiG2VVaKGidj14VzTbxltRMKUOh7qxDlhXZvVA4WooGEWh+ejRm3c72Yf1cxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzqLKgkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzqLKgkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B2A1F00898;
	Thu, 10 Sep 2026 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065672;
	bh=Jsj2vzVChgclFHaQK8yyYXKV/VJxsNi23MozbAZTUTg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BzqLKgkVYZIYjJuUoTq3fVHNvBC4stsA1ZAqUpg7CXHeoOSTxaA6no09ENjp1bYzT
	 yWRm46SAFcJhsBb51kyr7TS4OOdqpzdrGjUg8ed97qsDSnX9owYP+t1P5fqVF1YWmL
	 NJYyyCI2UJl0N+K44HNURmmQbr+p5nARHub7tkms6ZdpuJSJIzlvYcQNDOa5XoQCgA
	 2n+IE3Hqelk4ToZ+F5LlxiFOwbk5NrZfTDP6NrQx7b6umcQxYjOVia8HR6nIuDr8ZT
	 RNMvU+fzjATfsOtfrJW6eR4gZswHrgviWVd5zpwbfgeZKI2knF3LpdDKtKGgjRZt7q
	 kDUSlGAPAsPew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BDB380CEC6;
	Thu, 10 Sep 2026 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] obexd: Reference count the phonebook back-end setup
 and
 teardown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906560903.2027917.2521995556932726344.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 18:40:09 +0000
References: <20260817154810.92634-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20260817154810.92634-1-pmenzel@molgen.mpg.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 17 Aug 2026 17:48:10 +0200 you wrote:
> Stopping obexd on Debian sid/unstable with *bluez* 5.87-1 logs a GObject
> critical:
> 
>     obexd[10687]: Terminating
>     systemd[1804]: Stopping obex.service - Bluetooth OBEX service...
>     obexd[10687]: g_object_unref: assertion 'G_IS_OBJECT (object)' failed
>     systemd[1804]: Stopped obex.service - Bluetooth OBEX service.
> 
> [...]

Here is the summary with links:
  - [BlueZ] obexd: Reference count the phonebook back-end setup and teardown
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=74bc1ca27a7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


