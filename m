Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD13C1D63
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340242; cv=none; b=XeVZXvAchE5FSRTJnnblVjlsOoubCF2DfuPypfuBI7BQ5Ci8UFmZuJyl7lHPWW+E8Kq5Vcj7s+OGZKSO3Weg2MtQWCqDdKsQNidTTbaIdOUbvFT81vfSxcSQ8JcdpvupFLKRndjDSpbw7n7qSS142s0adMtUvz7rQdo7C4Tf//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340242; c=relaxed/simple;
	bh=6jymljLLUV1LzPAzcqWg7gtPk9vVl2Xcdp9SoHakT9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CmLM203jMIqieJR1ihN1Bv3L8TGUo04BnZLW5UncJMYq1WmvAjKvct/hBh5UmzZqH2FeXzF+Hbn+pZ8jEjBRe7mXORoj/Jqkb1w8LSET6BiYnRdzb1yhnHT7sJ97vDjbvb4ttwuLX9ujSvz6XsbbBC7jaJvCLe23e6T+N+Dpp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn7SyaKO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn7SyaKO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA1F1F000E9;
	Wed, 29 Jul 2026 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785340240;
	bh=WvUczoy3xtiwDIdv/fa1jUKq5HCnHIlVIm3MCLf+ICg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mn7SyaKOE0g4AAKBOyGZzu5ZtukxesplnevuufO3lUNXUjkrBPMUlQK07y4+zMyUT
	 jhIZmGGRmNKjG+nItw/RDu0wYaurXhKkpmh49viLFc7cICFVk7S6tYJIwLxsm9G/8o
	 XzZnA34al7n6asaMRVn0mwOZqqeQPzJRfmx8Hjinq4QlbwvIaxCUjAFBNpIhx5TPKd
	 YB9RmwQipK4Xf+AcKisRq+JfkfCv/8jsYIEp2EB7RzXdY5Unzth6CFNxU+vSckjQ7H
	 jBS1P9j8AjYOawMrv65pOfCcadkLHxHW0l2nCc467Khvf73CjxJ4B20x9E+96mn3rk
	 WvmJ0+VPWzqLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 41BA239253CF;
	Wed, 29 Jul 2026 15:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v6 0/2] RAP: streamline session handling,
 reflector setup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178534020501.3138935.9208630328565039341.git-patchwork-notify@kernel.org>
Date: Wed, 29 Jul 2026 15:50:05 +0000
References: <20260727065954.1053484-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260727065954.1053484-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jul 2026 12:29:52 +0530 you wrote:
> This series adds RAP users to the direct session lookup functionality.
> 
> The first patch refactors the shared RAP layer by introducing explicit
> attachment/disconnection helpers, adding bt_rap_get_session(), and
> using session lookup directly from the RAS GATT server callbacks.
> 
> The second patch updates the ranging RAP profile accordingly.
> Reflector setup is consolidated into a dedicated helper, D-Bus registration
> state is tracked explicitly, cleanup is centralized in rap_data_free()
> 
> [...]

Here is the summary with links:
  - [BlueZ,v6,1/2] rap: use session lookup for RAS operations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fee4813d90af
  - [BlueZ,v6,2/2] profiles: centralize reflector setup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=98e5a74736e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


