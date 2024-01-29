Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2F14AAA
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554827; cv=none; b=FuPh7kYhFTvwdDYKNP94uJ1YJeZOtgmDnRlJEvfNya1B7aThBl1iJUtLGRT2PMogxBaQjNiBOX11TcvbcW3bVX4jLiI3xdvSawIgP4TpxcEazSXYJNe+FhQ4TaPxTU4iTDBBWTjpAt2///pM07ntbzvI0lYIcHLCvF/e3HIk/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554827; c=relaxed/simple;
	bh=9l4xqgj62Honb/zhnpQ5LXG01/CkBIJW9sMYYdSYR4Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hD3i5MQVH3FnjJwhNx6pDnpKm2tCLizEWgvxR5751vNJt2ufhnDu71vcwtsDn4K59NvBHfKbF9SosjSw0Cng+czKce7iku/60wFpKznUudSHubyKqa8Kx8fLYzijvSpbjkEQ6++LLUUusPjVRFgu+NFAhUSmh2VMp+lHQ3Vz2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAdGT5zc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAdGT5zc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 556EDC43394;
	Mon, 29 Jan 2024 19:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706554826;
	bh=9l4xqgj62Honb/zhnpQ5LXG01/CkBIJW9sMYYdSYR4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dAdGT5zcr8fdlMAKO48jZ9XSZrm9lTfsXotjYNHa2OugED4IkaXdLdroux7pl5+0B
	 5j/EqAacCWr9kpDV+JPSEFoKeUvGiSmX8aDw/JGGeBkAotE4dhu68V4FKdNV0Tw4eC
	 RoCRdwStReWPmZSTT4oRNJUJp/lUua7tVoCypSCSzr6bvkArMjlc/xyFO+xOc8fWDS
	 yZmxy0j9KZ2X036WUq+gel6NzbYL9CCZlDfJq/JiHmtwQzGuDwTvSl8rB4ijUDF0oZ
	 Um+Cwly9EoVD1saIaqbu/iG2Q8AIJDVamORhaPM6iZV+4bFTTRnIHd49EVHnlnS9vV
	 kCCcR7ZSfQIxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CBE5C43153;
	Mon, 29 Jan 2024 19:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/8] Remove support for external plugins
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170655482624.4760.4346697423571608674.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 19:00:26 +0000
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
In-Reply-To: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
To: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, emil.velikov@collabora.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 Jan 2024 14:44:14 +0000 you wrote:
> Hello everyone,
> 
> With v4 we have moved from pre-processor to compilation checking for the
> external plugins support.
> 
> Namely, as we build without one the dead-code elimination will discard
> all the relevant code. Ultimately this means we compile check both paths
> in order to catch mistakes. Thanks to Luiz for the suggestion.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/8] configure, README: introduce --enable-external-plugins
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a5c9cf632e6
  - [BlueZ,v4,2/8] obexd: factor out external plugin support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=004b5b28a04c
  - [BlueZ,v4,3/8] bluetoothd: remove external-dummy plugin
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1db7a00e35c4
  - [BlueZ,v4,4/8] bluetoothd: convert external sixaxis plugin to builtin
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9f71892b63f6
  - [BlueZ,v4,5/8] bluetoothd: factor out external plugin support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=109cc8a0f6aa
  - [BlueZ,v4,6/8] bluetoothd: don't export internal API
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a1d3c7c4bc7
  - [BlueZ,v4,7/8] bluetoothd: change plugin loading alike obexd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f174724c76c6
  - [BlueZ,v4,8/8] android: export only (android) entrypoint from the modules
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f59f4902bc4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


