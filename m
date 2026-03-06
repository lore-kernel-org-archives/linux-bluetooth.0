Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33A3ECBE7
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 18:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772821207; cv=none; b=RbbgpRjr+xa40GWZFWaURbada5jj9QQCtmu1ahlD9rkr13OwqqANhQVs9hSL6s8j0ZALo/5VAbje/WFAA0R+ou5pgSg5teggzGQyIuTmWlRFFjdTyHLnT9LYuUFEXtHsy2JJY8IqMF06fL2OhJ014Wd+t/Brhd6PX9Z0cvla9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772821207; c=relaxed/simple;
	bh=0m4rMxCpq/mzIa3ZsKm4DNY87Ks+RHgPSBuCL+A2ljQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cEfvWURrTI+9er74MO2Iwzw2Ml3oXJqVPzJ1g6jrY8cs/ABX1UREg+mq5IFFDUAek1kaGWwYmGBqCjM28ndHz/+FuxWW4xSx79EzRIx3Q4Yyvda9jXx1wsBCR7MKU/rTaY9vJZVyYHMRaBn/uTMWkiAk1n1Clo+Hc7YgkwDDHcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUIdzDcs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUIdzDcs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C8CC4CEF7;
	Fri,  6 Mar 2026 18:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772821207;
	bh=0m4rMxCpq/mzIa3ZsKm4DNY87Ks+RHgPSBuCL+A2ljQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mUIdzDcspegehLSIUcn8aiKQ+8xSt/Pf8o/uZA5M+5Tlr9XvBDc4wwBq3eXmJzaId
	 6wMMHmtIPdRRrV4b4JVj4R/ep+/TbeqlPX32JH2cMA4QHGaZ55FZDpxeALTtvHejWn
	 ZKant+MZR6olay1MfgEWYvozdVtzJE+paCq58//pJ8xR+hOoQ+PMfi5KR5pUEh+aXF
	 KKRYM8q9Y5iMVqhTj5ECMnSMZan5an90sNfXXvZV3z2q7CMdJOSC3uKHRqROEhj7j0
	 ecWrFjm0NTWhI+IWWXa/3R2hMWFesH3/y/tqVyAB1pROT7/eQSpyto+9UYck4LxtGm
	 QTxKPk3BfLnYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE583808200;
	Fri,  6 Mar 2026 18:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/6] doc/qualification: follow up patches
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177282120629.1427.14094864527296244044.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 18:20:06 +0000
References: <20260306162058.15154-2-ceggers@arri.de>
In-Reply-To: <20260306162058.15154-2-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 6 Mar 2026 17:19:15 +0100 you wrote:
> Unfortunately, v1 of my patch series has been applied to master. This
> series updates all modfied patches to v2.

Here is the summary with links:
  - [BlueZ,1/6] doc/qualification: gap-pics: fu: add footnote for TSPC_GAP_21_9 feature
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dfc43ee483fc
  - [BlueZ,2/6] doc/qualification: gatt-pts: fu: add description for GATT/SR/GAW/BI-39-C
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a843a95b4cd1
  - [BlueZ,3/6] doc/qualification: gatt-pts: fu: add description for GATT/SR/GAN/BV-03-C
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0ca7685dd6b9
  - [BlueZ,4/6] doc/qualification: gatt-pts: fu: update descr. for GATT/SR/GAI/BV-01-C
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=47bf221d3183
  - [BlueZ,5/6] doc/qualification: gatt-pts: fu: add description for GATT/SR/GAI/BV-02-C
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ab15728068c
  - [BlueZ,6/6] doc/qualification: l2cap-pts: fu: add descriptions for LE CFC tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=33388cb1d6f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


