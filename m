Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5D130AE7
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202633; cv=none; b=psEcvDwJ87cttQqyFO2sQXvSCzspb7HeyZjLY66mnw+1hp9B+BnZ+PIWc0oGOvsE97WkeFR3m2tMbSvEhG1Sa8vTryWMBkoO/bRQC2gdT4wragLZVdZW8Op5QUWg8nUxM/mjjPyL2XP60mxLVA9LNmgRbCfuWamKIvoxB+3beSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202633; c=relaxed/simple;
	bh=rVN+p4tODz6r8JK58yjrmWOKCAxbBXEkneWzwMAJCqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VRVsBWhIe4aIwAXg+hb11mSYxBRlEudpqMUj8IJLzlSme9uJnzQMkQbEduvD88IKdi9NL7c75c2LmlqAbbIccxdkcrb2jgpySfl+XmyncPZVIlZ4Usp+qi4tysBG+MAqtpnnJMKjBbWIGS3s3vZs4PaLTwxZbVFPF/i531dmoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRok75/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRok75/T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D40F0C2BD11;
	Wed,  8 May 2024 21:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715202632;
	bh=rVN+p4tODz6r8JK58yjrmWOKCAxbBXEkneWzwMAJCqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oRok75/TJxgVfRxAw7hRz2HjSlDqbtvBDNnGT+hLBBx1oHla3EUVYFmSIEaZ3JGIH
	 5wyEcfj12K3tUdn3vvpIfXpmStfjtl4lBZFKgizfZbTGNYByRqAaULnRX9/8uq+COt
	 HjHxVSnULa2+jc4fs5dKzhrq+gGP/1bmAa8BH/ofeHNlhpYOhcCLmBSQamFq17G5NJ
	 3jcTZ2SMtTd7iDov8fSnf3Vw4q3g/Dj6Na/jCiwi6++ZLxy/hEDJYaM+BXDpxUMjz5
	 dORU5c1YE5daQ+5pZwuw+Up/N5p2qourBDIo2SzRUqv5smFiqHD8Ck4kc72hJLFZ00
	 w0ncagTyRETqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2525C43332;
	Wed,  8 May 2024 21:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] configure.ac: fix sixaxis build without tools
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171520263279.5891.2878902218392411610.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 21:10:32 +0000
References: <20240508175416.635797-1-fontaine.fabrice@gmail.com>
In-Reply-To: <20240508175416.635797-1-fontaine.fabrice@gmail.com>
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 May 2024 19:54:16 +0200 you wrote:
> Fix the following build failure with --enable-sixaxis --enable-udev
> --disable-tools raised since version 5.73 and
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=9f71892b63f6b65dab874a633d88ae2dcad93a16:
> 
> /home/autobuild/autobuild/instance-2/output-1/host/lib/gcc/x86_64-buildroot-linux-musl/12.3.0/../../../../x86_64-buildroot-linux-musl/bin/ld: plugins/bluetoothd-sixaxis.o: in function `sixaxis_init':
> sixaxis.c:(.text.sixaxis_init+0x23): undefined reference to `udev_new'
> 
> [...]

Here is the summary with links:
  - configure.ac: fix sixaxis build without tools
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f4795bf64dbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


