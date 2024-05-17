Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4728F1
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957433; cv=none; b=ViMFSZBQZjQCwDv4KUXZ0VLzqhqfClYS0x5rh7DtzqrxMcUTyYtI2reXzZTdh66pxdUsBF+aYab7gKPtpVOiVLF/rty1fIn7fwPXjj5c4cvptxG103iXtAfdZZHohbyeidLiG3oy41utUVMilFPGYP7afHLQCtkMpJWxvqZc+kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957433; c=relaxed/simple;
	bh=fQubphhMdqhEOLi47iVXXjpTvLLyOpf5LVnIP+jUoN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PeLKEW7I9SfhEKHcA0XcLowx+OMrf4KLo8gbXorp5NpTtkFJyo0e3m/NSlVyhRN2dapIjIkJPv/BslQeiPyschU1SzPk4uaYVotVa7heTJJr48tk2gb+idyAAPDDCh/z5uKNhEdJNBTJtedSdwHFg8PoSyWEAhjgj7GcE8ncwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQeAJYWc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQeAJYWc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7A6FC32781;
	Fri, 17 May 2024 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715957432;
	bh=fQubphhMdqhEOLi47iVXXjpTvLLyOpf5LVnIP+jUoN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MQeAJYWcL1iTPmctXSw8tvHadXb4YjPLVS2eEPvUqOfDZxUtL8TZNT+cM07Z7QHGL
	 Bnd8HOg9i9AEVzszxhYTyVGKTWyt++Erq33+vu7VXdUBMTf4c5F0uk2xj4SliPlm2E
	 a4ZrcXQwuyf7nzVuOIPsV+ImLAZ3aV6ywl8MN42pGqE7v5Mm9KgZ+RwNj2ADUK1Uzc
	 WnLUbg4bCR8kGmNft5mxbjupNXYFlxYJ5sCOIQsBTEn7iUIFGTk26FDlrVCIWc7MYZ
	 F5JKsCh/fvm4grCIQmcmpUktXUSCCdRyK1ssffejsRZdJNgRCoAxQnJm2YkxwFwyrK
	 fbQgOFv+eb2Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6490C1614E;
	Fri, 17 May 2024 14:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] obexd: Fix memory leak
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171595743287.5154.9091403956918765881.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 14:50:32 +0000
References: <20240516134053.102475-1-hadess@hadess.net>
In-Reply-To: <20240516134053.102475-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 May 2024 15:40:48 +0200 you wrote:
> To not leak "buf", we need object->buffer to take ownership of it using
> g_string_new_take() (but it's only available in 2.78 and newer), or we
> need to actually free "buf".
> 
> Error: RESOURCE_LEAK (CWE-772): [#def66] [important]
> bluez-5.75/obexd/plugins/filesystem.c:411:3: alloc_arg: "g_file_get_contents" allocates memory that is stored into "buf".
> bluez-5.75/obexd/plugins/filesystem.c:418:3: noescape: Resource "buf" is not freed or pointed-to in "g_string_new".
> bluez-5.75/obexd/plugins/filesystem.c:440:2: leaked_storage: Variable "buf" going out of scope leaks the storage it points to.
> 438|			*err = 0;
> 439|
> 440|->	return object;
> 441|
> 442|   fail:
> 
> [...]

Here is the summary with links:
  - [BlueZ] obexd: Fix memory leak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=46c0e376fe13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


