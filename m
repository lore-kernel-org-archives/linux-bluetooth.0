Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BC4582D5;
	Mon, 17 Aug 2026 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996012; cv=none; b=J3TwZhv1j7AazXDdCx8SnewAX6FNAmQlsjAj5RmPt/xj52tTGXKUXJXc8WI2Foa3us157WKrLYFHg+W+uybqvbEjmAMmB0ywFWf+TP+Bbl0HaBz7mZxCLyuClbREO5RWyvBa/IGktuvebswR2sxsqXcnnX92XD1kLGWdoKLnWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996012; c=relaxed/simple;
	bh=H9cxcLBnXpKTlARPXIFO+MeRlw2UMPvREsOmG3FsKdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DA/kO6AtHIWfjQQ1gTeH18jEh5zVy/gn8VjhBmt8v1AMIlfyA94mwIlprh++nQCkAkJDZocaLb/SBVUf+jGz8yYbMRfIMw7NMew06cpq6ZKETTKlHsfuEHb8yfhuzWKaWYWPWeaXf4pQyZwXrDuRO/9/DKQUx2T/cGRyf+yt40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i55afvds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i55afvds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AD51F000E9;
	Mon, 17 Aug 2026 19:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996009;
	bh=VFMEIlvYA1Frfzxp3Zos3SRntiQrR0PS+7tfmdd0bjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i55afvds4PeduDl62G1L3tQMIQOcisJjDYOFuOlEQ5UbVitmydANu94/ZaDJ+iMIW
	 CHOWNnGj6hP282srm7zBjXzXzsJHilv5Zr/+nEKZq63g7j9KlrHNLW3FRIqg6MUoBe
	 squ2KGMvkWIQtK8DSAm2l++fqgQd5jKoV/8Nbh1L/sraX4fwBjek2DePs0IdvVukJC
	 yxcQPTJ1ocjxsMUL3cEd1iVCw66lJ6paixq1+t8F9IsAJc3L1VBGIfgD5BMpAyYHdY
	 lvgoKropKzVB8KwkLreTQ/sOrd7iCjLXVJFT0qTLndRvVmuYTERCcwnuMMptEvqpPm
	 yWs1Xcz/M78Ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568823926262;
	Mon, 17 Aug 2026 19:46:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] Bluetooth: hci_core: add lockdep check to hci_conn
 lookups
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178699596188.1691257.3368890907172827506.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:46:01 +0000
References: 
 <2be38d111362590f45776a0bc114f7890906ead9.1786875148.git.pav@iki.fi>
In-Reply-To: 
 <2be38d111362590f45776a0bc114f7890906ead9.1786875148.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 16 Aug 2026 13:26:21 +0300 you wrote:
> Add lockdep check for RCU || hdev->lock in hci_conn_hash lookups that
> return hci_conn pointer, as dereferencing that without locks can be
> TOCTOU issue. It used to be several callsites did not hold appropriate
> locks.
> 
> The check is equivalent to removing rcu_read_lock() and doing instead
> list_for_each_entry_rcu(c, &h->list, list, lockdep_is_held(&hdev->lock))
> Although there should not be any remaining callsites without locks,
> don't remove the rcu_read_lock() for now, and just add the warning here.
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: hci_core: add lockdep check to hci_conn lookups
    https://git.kernel.org/bluetooth/bluetooth-next/c/f4fe51177b82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


