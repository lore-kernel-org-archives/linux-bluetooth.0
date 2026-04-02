Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5345E207DF7
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152222; cv=none; b=EnuEJNz/04Cu8zc2tS61DORvvsEtz0mXNoiUBXgXuKZfGeNPGFK5xf8Fsi5uIgitz1u6rU/oh7juJ1BT7KDDE7TYvTaw61l9N3lCKS64L3Nzl3v695GSzy3QHzZIhngMzEw7lAifBIIN6KblOn3t63LTaFmg892xKEim/6ZszCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152222; c=relaxed/simple;
	bh=/XKIrRz8W+U7j46JAQI8CCne7A30F5ptSpnRTMgfwy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jO54dXJ6qNBiI/0sdRZ9wJQb4hId1+nAfGLh7yin7Kv0TIU+MNgpi1DkhbgNFm8timilbcyvi9A/LbxXgNf8i4xP66Kz8PSQbMT+QZx9Dth+CMG5Ey5vNntWOGGWXR7PgTEgDC79pBvX3pN0Lh+c0GUTvY/66J9Hm/ufF/ysXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgdl4f5d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgdl4f5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3611DC116C6;
	Thu,  2 Apr 2026 17:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775152222;
	bh=/XKIrRz8W+U7j46JAQI8CCne7A30F5ptSpnRTMgfwy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sgdl4f5deO9LF5l1KfGpeAjLuIvHGwOMgUs6LJ1esk4ig7rpUd6y1AF4UdiZuHLL8
	 0mJVizcv5rt/0p8W2EVOLaWOsI7tnSla/41xuMNXOgScoAs/TyaiIsPOhSG6Q4DOwb
	 /evB0S0F0L4z3JdWxMJK4M4kmzfYUBo3F5AtHMi88TKb+gM1j40mgNRlmSyprX5jgD
	 rrIan00Qg+90WZ7UQcgtiPZ3aZGafiHDO/oWSzFVbO/FXJWGq/Ric/9oJ0zOFlYIDb
	 rZp9fZc7E/rS57tGHVX90nW7vL984War5NME0x3ZFmikearg9UdSGARYTUGGNXn72n
	 Xz3ai5w2PudPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F0A3809A09;
	Thu,  2 Apr 2026 17:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc: add btmon-mgmt.rst
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177515220454.553069.11150902360623340193.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 17:50:04 +0000
References: <20260401180746.2074659-1-luiz.dentz@gmail.com>
In-Reply-To: <20260401180746.2074659-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Apr 2026 14:07:46 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add a new btmon sub-document doc/btmon-mgmt.rst describing Management
> (MGMT) protocol flows as seen in btmon output; include it from
> doc/btmon.rst and list it in EXTRA_DIST in Makefile.am.
> ---
>  Makefile.am        |   2 +
>  doc/btmon-mgmt.rst | 526 +++++++++++++++++++++++++++++++++++++++++++++
>  doc/btmon.rst      |   2 +
>  3 files changed, 530 insertions(+)
>  create mode 100644 doc/btmon-mgmt.rst

Here is the summary with links:
  - [BlueZ,v1] doc: add btmon-mgmt.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1ce7cfcd0f6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


