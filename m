Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6F1F427C
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626304; cv=none; b=OweWo3mRLYm6h0C9T9VOK4zbxRpsvpg6rYL+NCy1KE3yRU9cJ7ofcWeTbGnjawXFwr9KH4NK4wNU2h5GYcGbHi0eLixs3GBzllvX9/3v/TdHctaGs124GX6Igne49Y4NrJjB4lGBRaEcRqA6lRwcJvVmeVKsK3exSFh1moaig/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626304; c=relaxed/simple;
	bh=IuznGt1KQlnMGdnk2IdyUnw4307DQJMwOI5qH9gDa4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XQI8BxWXZbb7e+hMlSdboHzmfj6gx89gTkGGVKTxNxQJR7ulv977h5JCGVb91BqeeMKoJ8NGClyUyjIpRtG/FsqzOl3dE01b6dmeS6jw0uJp2WyAebc2X1bh76Y2kbMp/JpopWcSOQcC0sO50BPorBEgUk1ufwJFbUBRaA1zwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN4O7At/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN4O7At/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F581F000FF;
	Mon, 28 Sep 2026 20:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790626281;
	bh=fIXY81T3wHYOEjF9SFuvuo4Z+w8/uhQbMu0bIODTNlI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gN4O7At/SWA/fyznuSSNF2cULtR20BN+sbVWLWFaQZ0RaDEbFRk2u8hQA+9f5ggbP
	 hT3wmCiRvShEl93/UMzWbo6sDRlWv0JjtVGu6AtaeJhiQzhCuLZdlyQsFlq5vde4XH
	 SBfrYsZJ8QFl+jJW2v3Ux8UegHilhEV2SS8zN1RB+e5qfKdS2mETa4M7Uhk8SPT1yn
	 OJAWpINqDcu/X3F3kXXda36Pd09Irkj/afQXnSuhMATNE2iv8A6+Gny2QC32M8rOTZ
	 3eQqQPYNLZVzofNkJiAt9ATMGOlFdWJzr1SDm9IMNdgDNYLpW7C0jLTScNxjfIaIlz
	 V8S7PPlY6n10A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1989F3924A7F;
	Mon, 28 Sep 2026 20:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] doc/qualification: Add PICS and howto for the
 BAP
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179062620591.111171.18113544518534541159.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 20:10:05 +0000
References: <20260903085716.741578-1-frederic.danis@collabora.com>
In-Reply-To: <20260903085716.741578-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 10:57:14 +0200 you wrote:
> ---
>  doc/qualification/bap-pics.rst | 3843 ++++++++++++++++++++++++++++++++
>  doc/qualification/bap-pts.rst  | 1012 +++++++++
>  2 files changed, 4855 insertions(+)
>  create mode 100644 doc/qualification/bap-pics.rst
>  create mode 100644 doc/qualification/bap-pts.rst

Here is the summary with links:
  - [BlueZ,1/3] doc/qualification: Add PICS and howto for the BAP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d09935d34414
  - [BlueZ,2/3] doc/qualification: Add BAP/UCL tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5b37dbfb3015
  - [BlueZ,3/3] doc/qualification: Add BAP/USR tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=73e934ba80b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


