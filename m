Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B4547046
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617885; cv=none; b=nQ9SDBkXNpR59A3s36mP0vhKybkNdOk6Cz4jnYb5dzub9KmStp4iN9kzJEQMyMYPd54qyv7S6M2Q93aREknxLmA7463CFJVxsA0aP3szPiFobBvg6+cCYQj07XdrTA5RcigVTqZ99FnuXob1xqU+hBbewRYu6kbXcjGwqk5agnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617885; c=relaxed/simple;
	bh=mMqQ9wr1LaI1oXU7bEQz2OzSSwSWxk92oTvR9z6paM8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hAgo/shC7wpeNEh2/27W5herjNd3joi3tRENCIV6zoSG1Adt6jyAreKWDr5Ow4HGAzs2jrc+183pgGPDZFRHmP6iXDbR5pWLS619Ar9ol96qx0+1hEPoeqDWQjkaweVie5DJ5bhIAoHpFJIm0MaBIq/8SLRkGg4KUJh21CAspvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E94BVWra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E94BVWra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F541F000FF;
	Mon, 28 Sep 2026 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617883;
	bh=mjtyWrn0NBv4U5xmQ+slaPFzJgHGgxCydosLWp/zy0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E94BVWra5Lu9mQ73FBprfr3RF2zcC5BF2u+PjPN2BzJz0gaO2xhRA51bDgnYmZWUs
	 LJdTR+ltNgSvE7n0puJCeYP1oxER2/zdu6nWdHD8Y3jtkrzp/MD6hwSL2XSJGjmlxt
	 ZMxTYT2ruDQIDqFMSntOkX963HMLp1ahMY9leGvszHVhFwsj8ZGoPggb4BpMuLbCCJ
	 o9dX4n8LHS1ti1zF9a64GpHGhOICO+5Qo9g0LbRV3Z4QDcclbOhezRbRPHF2RX4jcB
	 UX2P0AvSJ9tePWhq1XP/PhB+JaRRJ5TzqTAZk+l/LklDCvsFukxZZ2U1Qpnji/OMfm
	 NVn9IivwL2nxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A1D3924A77;
	Mon, 28 Sep 2026 17:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] doc/qualification: Add MICP PICS file
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061780840.50268.3037893366478728337.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 17:50:08 +0000
References: <20260925124838.3346980-1-frederic.danis@collabora.com>
In-Reply-To: <20260925124838.3346980-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Sep 2026 14:48:37 +0200 you wrote:
> ---
>  doc/qualification/micp-pics.rst | 370 ++++++++++++++++++++++++++++++++
>  1 file changed, 370 insertions(+)
>  create mode 100644 doc/qualification/micp-pics.rst

Here is the summary with links:
  - [BlueZ,1/2] doc/qualification: Add MICP PICS file
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07acc6ee5758
  - [BlueZ,2/2] doc/qualification: add MICP tests documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0c19f5a09b90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


