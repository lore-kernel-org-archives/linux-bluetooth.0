Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBB376497
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810000; cv=none; b=TzkD7QQZS3K4RSTwYuj6zlVJACU98uTGTlxXLEWOSxr6QYesI3c2X/Z0alcfEGC7rRgMpPZcIHVv35ZufKe0CfG0QinmfrMwzarI4Oxp7doEmks0c7XF7sr1+RfEPW1Y6ih3yFrtCI1yYPbMqc0Vaf+aa+ZSpOdN3G6sGguTGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810000; c=relaxed/simple;
	bh=AJ5duEGCeREopjhXZfklxzvLWdjo8upZbqlMTEGE5nA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DqwlnLIz70P/JbRyJM9tlmh2Xee6YTDpSJukZqQlqKZ9sujrRAoYwOSjVbzBS3x+gXu9WIluITahfC3wlbtuxzFY2v2HWybVL7mh+jyXnRxkRYQAlgAyqIx/DINEE3+ZWpWJLYSyXMvZcfq8WD5fWTpVZf/m2bbBnPi3tuUzFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeU+LKM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeU+LKM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50E61F000E9;
	Tue, 26 May 2026 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809998;
	bh=QkqFa5qRiosl+st0zXpsa4mL4yHFdxtbJlhF6qZGcyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TeU+LKM3fslre6VJ5PDCNgJlh0tNowHKWdGi8yJearfloNizh3DzeWlrMsKBWaLdY
	 Xe1l6BBnkgav2TGv9xyGqdEiT7SqKqpQBK2e2AwZjKfxkHlFsu2GGHEawFF0jOfuNU
	 WlKVbOxdIg3SgmlAXAFmfuVNWJH1ULcbE5oth3N4f+/CHs6Caxk8KtFDVnt0vTVkt/
	 3i9x0Xgm9dHRC9EoGSACP6QnnIS9NQxTcVLIheJEm9ZM1lrvo2lZkd+ayXvNjyfqYa
	 xboHfReO3T+xVTu44ZFVl44uaRM47n+2IBOf1R0mF9PESxaGuFKk7VZEpRTfgSp0Ws
	 8RwCOd9ByxtkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197FF380CEDF;
	Tue, 26 May 2026 15:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] test-mesh-crypto: Don't attempt to run test if
 AF_ALG is not available
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177981000464.3867281.7386793683102864787.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 15:40:04 +0000
References: <20260522164912.3253018-1-luiz.dentz@gmail.com>
In-Reply-To: <20260522164912.3253018-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 22 May 2026 12:49:12 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This make use of mesh_crypto_check_avail to check if AF_ALG is available
> and if not just bail out which is similar to how test-crypto handles
> when bt_crypto_new returns NULL.
> ---
>  unit/test-mesh-crypto.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] test-mesh-crypto: Don't attempt to run test if AF_ALG is not available
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b8d42b282b3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


