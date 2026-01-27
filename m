Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3D192B75
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538621; cv=none; b=g8Md+jV6Kk4t5yB3JgYolDlWPeRP9It9RfiAabph1r1pYR7zM5AQkJ2ofp8pH6p+d9ctxGAAjeZV+f7Zhuiph88S4F4fM2QrrHgaCRLH9DnIYx3EhXvgrxg99uX8bWt+AXgGfoea6NmVRMv8NX9TPKkpkGbYf/pmQWXQefAwIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538621; c=relaxed/simple;
	bh=3l0aODXpjEMFR9YTipUgyTwI6MMfMopGJPlv8LAkD7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h6e7gEL2IoHnkTHc9UU8ohu+RsI9M6azfeXylVYyRTIb/MXCJKIuI9ni0i3pH/XgQ11dWbgpKj5HchFEOSGZm1X0GrIEZVyZsy5OSU7U6jj7RLVP3BBlTsG46EW/YO28KzV5ORq34QLak7Qd7VulcNngbnqnm63Snpp/txEkXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9MKSD5m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9MKSD5m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685AEC16AAE;
	Tue, 27 Jan 2026 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769538621;
	bh=3l0aODXpjEMFR9YTipUgyTwI6MMfMopGJPlv8LAkD7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E9MKSD5mHQwM8wLZKMLMkuQbj8YjciGPBF5uWuuSraWUUH2kia1j0BkSM8x2grgg2
	 yIkzsTqA07L9/TAW9NLvsFaPMBx5xpXpc9CdSI7MO+3/mvtS2MtTHC6CkuknJQydFi
	 Oj3Pk8xAoO2ZYzaulGUyk8eTxY69dBpi6qV+r3oI52d4xjR+38sy70Qd6xciettYid
	 j6tOzewVa11G/eqy7dPpEhlVSSFxOm25VY/dba+mL/XfjCbNs2ywsbjHWHiqlp7SS0
	 m9BGXC0hzaytULjH5pWgtclSW9fbbmEm99a+PlIh2JwV8FgLtpIjCDUKMBVrQfyqyO
	 sVq8t36pJD+1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BACF380AA58;
	Tue, 27 Jan 2026 18:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/qualification: Add PICS and howto for the AVCTP
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953861534.1352702.11792908613826653070.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:30:15 +0000
References: <20260127170527.150218-1-frederic.danis@collabora.com>
In-Reply-To: <20260127170527.150218-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jan 2026 18:05:27 +0100 you wrote:
> ---
>  doc/qualification/avctp-pics.rst | 116 +++++++++++++++++++++++++++++++
>  doc/qualification/avctp-pts.rst  |  49 +++++++++++++
>  2 files changed, 165 insertions(+)
>  create mode 100644 doc/qualification/avctp-pics.rst
>  create mode 100644 doc/qualification/avctp-pts.rst

Here is the summary with links:
  - [BlueZ] doc/qualification: Add PICS and howto for the AVCTP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae788af205ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


