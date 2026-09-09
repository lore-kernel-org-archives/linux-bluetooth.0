Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44E376BE0;
	Wed,  9 Sep 2026 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982868; cv=none; b=SYwVfosFMboLDEPcgJoZONbXSIIeuuFm93zysftwCjJd23fQ1UoGU9rfafgc6FLeJqTalhBq25TjR0Molaj72lbXlRfE+E75nlS1Ob5HdZe6g1neYwZRsqKVhfGSZ+RX1FcKgdMMbXayKEiwhTG38+iswTWZChWwCTCZ6q1PY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982868; c=relaxed/simple;
	bh=41qWXe7OntFSSMRXSWY/ximuxNB48vNs2CoIqUTeLhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uj32MYiIhw/5ZkKulpIhTtdgli5AL4n0MJG1RPXVYzDg3K/U3brjW4NlQbF0r7DMHno0dblWqumZLEJcb7Tc2tfXUc8l8hVGm78Aj87c1k1ZMrvvhvyGZ/FGsZiutkQfRXvXkSk1ghYK/oHalh+KyJUrBAmkfTXNkbm/pHkfV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNc6/O1M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNc6/O1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF94D1F000FF;
	Wed,  9 Sep 2026 19:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788982866;
	bh=sPMVnhu1pOKjcFtFJeGNe9/kJc2pZQlRc/M3wYz4wNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DNc6/O1M88XyP4gYFMwLmBckuXjMwV6OBxjy2e6VGB0x0GnuDHT8UvCWXp6203uUi
	 3S98n02Arw/0G4f+d8tW10QhHwBvgNL/NgVzkEuizSbyVUwugsVPXv9nTGlwU9517O
	 9C2729tnneN3OqssvLKjAiYWX3FFKxF/bPiRDDj54j+EW9e1oWkNk66rWLD9Ja9jv5
	 VbAOBsJCeYJTPUUVmQrdNttdkePVkYDBhLWpC60ALOOxwqeVo2VfYADc+hLhZ+VrNU
	 B/4LSdFLRsWeFAe2E7njAi+sd0qxWDgBx2f9G/4i0OFwBjyApc0k0iwTvwglWEv+l9
	 j86NX0pECTi4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AAC380AA63;
	Wed,  9 Sep 2026 19:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: bnep: linearize skb before sending
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178898280461.1023805.10741395648052018810.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 19:40:04 +0000
References: <20260908165413.75026-1-adrianox@gmail.com>
In-Reply-To: <20260908165413.75026-1-adrianox@gmail.com>
To: =?utf-8?q?Adriano_C=C3=B3rdova_=3Cadrianox=40gmail=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Sep 2026 13:54:13 -0300 you wrote:
> kernel_sendmsg expects contiguous data. Linearize the skb in the
> bnep_session() loop, before bnep_tx_frame builds its kvec, so it
> is not split across non-linear pages. Drop the dead block and
> FIXME.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: bnep: linearize skb before sending
    https://git.kernel.org/bluetooth/bluetooth-next/c/c2daf81dc275

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


