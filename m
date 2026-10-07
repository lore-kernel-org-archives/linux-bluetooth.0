Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F934C9E1C;
	Wed,  7 Oct 2026 17:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394219; cv=none; b=fQPXTHVwB+r8rVoD1XPwseoqTgZnghkimV48FbZGUN3lLeTcYVcuw2o5tbui8AUHLl+bcgYH1gwVCeNS5kwe8n/ehID9XZZTdZz0hZ4LFE4QxVdLV5l30RYDF9Naam2PwAc4EUvoXwI2Af1OVwfmUZO6LFxyjVBVaoyoFoiqbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394219; c=relaxed/simple;
	bh=No5cfcgLyYBofpzy/oHzyqtVZszywQZsgASlkT0Q4+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=snNmr+O6KWjrTeSV/cnzewvhpdOyhwy79LPP7G6PW2bwY2X831qfoH0Cmhv+M4sQC2e5iO6joEH+sOhG6aap/P2wEUWi5K9/D4BaA4I2Q/5Eu2eWkkRfoZYps8nA80eeqPd7tFSzw4htIoC9vnpi11uet1eZ+VCVruEpydIebqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5tDmUOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5tDmUOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468A41F00893;
	Wed,  7 Oct 2026 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791394212;
	bh=SPx2OVt2aOGNO67xzs2aKwRyIWC4ZNPmyoJ19nYGjGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d5tDmUOn+m9etnmA63AF9HWxvgAMJtFWxFCMX0fgAOYqZv4MOQqPOQS+NdayK53OD
	 iQ1b9XSZH/BSlyJDSUfB2KTmNik4wUVQrlELznX7N33BKNEvhx25bCXLFEp2LQ/+/g
	 +zItKlg0x/MRd0s7WcHd2G596fPuU1KsKGyXg5E7D/N6HrI7Ccy1DfX+0YEfaWKE8A
	 6KYKP5pDjkDJ9II3OtLAq5h8bzh8CIUdXyEXU+3bRZjHPWHDsYaoP91VJtFvO3Vgof
	 KFrHUXSylZPRTn4w6PJjpeXMLQd4JO+Qjbgf4aTtkhI0cV56PPUers24AJIrW0ergC
	 ptSlj2tPc1vGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A1603808209;
	Wed,  7 Oct 2026 17:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_core: Keep RCU protection through LTK
 filtering
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139421077.3628206.11889027224704009743.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 17:30:10 +0000
References: 
 <pm-bluetooth-objects-candidate-0123-v5-83023fa5b4741c350341@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0123-v5-83023fa5b4741c350341@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Oct 2026 15:38:38 +0800 you wrote:
> The LTK selected by hci_find_ltk() must remain allocated while its
> value is checked against the blocked-key list. The finder releases RCU
> before passing k->val to hci_is_blocked_key(). The helper's own RCU
> section protects the blocked-key list, but the selected LTK may already
> have been reclaimed before that section starts.
> 
> An LE ATT socket security request can reach smp_ltk_encrypt() without
> holding hdev->lock. With a matching stored LTK and an LTK-type
> blocked-key entry present, a concurrent MGMT_OP_LOAD_LONG_TERM_KEYS can
> remove the selected LTK in the following order:
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_core: Keep RCU protection through LTK filtering
    https://git.kernel.org/bluetooth/bluetooth-next/c/6a46ef87a65c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


