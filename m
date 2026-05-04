Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6202D8DDF;
	Mon,  4 May 2026 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914658; cv=none; b=sq12qZOAeBhjfUTu77btNBhLrxZfKvRM81k+gVsmLh7JKBW3mH2Y/tiBw1qgMthAR93ZqYBQC5vKIhRgJc7CvyIXJbQYRdSg8H4nN5DMbZAhfpj3C/jhONU2rcRNUOEVagkFbQ4I4M9bgEeOZmN7qyUrFiijVrUl8x86lEf0Gs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914658; c=relaxed/simple;
	bh=yrZr2zuNo/D5hbS3mxzbUhmCDsCYDSZo5dlY5YXfMig=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q7F5C2Y5sM3L076HMH6whzz+X1TyRNo8cPOeQqegH3JoCvtblnQVrevJpwkuOp3QbSXZmFFOhHGwqdo8AkJ8dUcCyusxKAVY5xoBQ+ff1aCG/BPnSvIetMGmCEhcC7FYZoy+7QlJS3mT3v5sYRMNKOiZONeoQPXnjsax6MOQ6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKPERfxp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKPERfxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39396C2BCB8;
	Mon,  4 May 2026 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777914658;
	bh=yrZr2zuNo/D5hbS3mxzbUhmCDsCYDSZo5dlY5YXfMig=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mKPERfxpvMZNqipMmeyhqbg+eTKDF6vK6HKI2yXDqnwpsUQRR99TNshKVEclFrlNy
	 oP/t5xmWjRRqxJbPf3OXCQX0Bg66LKsT8u4Mg4EfGzThFlVgdg+NtZAhP1MxSeo13+
	 kQAG5k04uZuMaUog7ynQ3wHP7Mp4iGmyPM6kMzRQQhyQmHb4WIpV6dEm5mqpXLJppf
	 SxsF2IczEY6D0QClOhxnqO+sCezjJ3wxLr2yzuq9DkOWVzBKyzq/ncMs14XXMxKzUB
	 1nXoY6jyvy1cdaGbzT1hmBKWJPpCZChtYE4+euHM7WUa4ww1KPK0aq2RvE/MJl/biq
	 WijiQgwJTuP7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0FF3930032;
	Mon,  4 May 2026 17:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: HIDP: serialise l2cap_unregister_user via
 hidp_session_sem
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177791460929.801187.17207788998768867034.git-patchwork-notify@kernel.org>
Date: Mon, 04 May 2026 17:10:09 +0000
References: <20260502164303.2299816-1-michael.bommarito@gmail.com>
In-Reply-To: <20260502164303.2299816-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pav@iki.fi,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  2 May 2026 12:43:03 -0400 you wrote:
> Commit dbf666e4fc9b ("Bluetooth: HIDP: Fix possible UAF") made
> hidp_session_remove() drop the L2CAP reference and set
> session->conn = NULL once the session is considered removed, and
> added a bare if (session->conn) guard around the kthread-exit
> l2cap_unregister_user() call in hidp_session_thread().  The sibling
> ioctl site in hidp_connection_del() still reads session->conn
> unlocked and unguarded, and the kthread-exit guard itself is a
> lockless double-read.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd572908d364

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


