Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A04A92EB;
	Mon, 31 Aug 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196876; cv=none; b=BhxQmhRApYIihsZAXxMHcNN+m5FJa3JBATYf8wIO9DfjMQRPcydS+zLxkrZjMK5adPV1ZKmClSBkkiLvZ6xSL+MQZ6gov68bLnQPDgQn1BgYwHe2yp1vdIuRbodtPwRno433t3+6J7uapBEgjfw6cADuMj2PgmqnHEWmxLOhcqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196876; c=relaxed/simple;
	bh=o0AaucND5dKxKQues7jTePkCugVLQfcud3FjtWELaEA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bnGSJ6hOII6l5fTwXouSPeXU6k4lep33n69rzAo/QueN8KNhRxFMVJhS6IpQ+C0FvTSOL/cIZLvjf8KduAyXLExaySY2Cec4aPVhspjm/GiHgEHBa9lkPzWADd7aPcmnzvJMNTuE4ahMQCwSNjBAX2Q2N3hVc5HtzWAwAMolRwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnjPHfY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnjPHfY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110981F00A3E;
	Mon, 31 Aug 2026 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196875;
	bh=E67/Marflg89qdIQWFJ7mjFh7XGHMoAUaEe++PoDxyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BnjPHfY74W3aIT5qodKXsoSHns1s6+VdgsMF5a/pV+RGOcTqkVB2MHECMUbeAebdj
	 ZQ4iem3hICpwxPccMgG4XhBsXp5JJEraAtQEqrqHELQLZldC1lrQ40mhfQPjNY7nib
	 hy3/KtsCeZULgNPLuYbv/0aIFLGUCAAqj/++OqyebDi6csD6GWmzs3qiXq9480hyVn
	 gqETp9BDQ7zwg9aX2azRzUlPhoNrelBRYfVyn+/PDrgHVj5ii7he9hGDC7Lf3yMdmZ
	 rJ2F0tUd0iKQmv3Ery7JHqOJnGHyrBfLnJP75Fr78kIgqjDht0UWB9El9Mt25iE/gc
	 6rt/Ga+MdFxEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 64A423924458;
	Mon, 31 Aug 2026 17:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ +
 EXT_FLOWCTL
 pchan
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178819681823.671757.5365717532248944864.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 17:20:18 +0000
References: 
 <b30626af1ee0165d56dbfc15e5d16ae6efbd726b.1788109840.git.pav@iki.fi>
In-Reply-To: 
 <b30626af1ee0165d56dbfc15e5d16ae6efbd726b.1788109840.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 30 Aug 2026 20:11:36 +0300 you wrote:
> l2cap_new_connection() sets default value of channel mode to match the
> parent channel.  l2cap_le_connect_req() left this at the default, and
> created L2CAP_MODE_EXT_FLOWCTL channels if listening pchan has that
> mode.  This causes FLAG_DEFER_SETUP channels to reply to
> L2CAP_LE_CONN_REQ with L2CAP_ECRED_CONN_RSP, which is incorrect.
> 
> It can also result to stack OOB write (of l2cap_alloc_cid determined
> values) in l2cap_ecred_rsp_defer(), as l2cap_le_connect_req() does not
> limit maximum number of deferred channels or check for duplicate ident.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
    https://git.kernel.org/bluetooth/bluetooth-next/c/b1f1766ef769

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


