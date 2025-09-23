Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EB01F4165
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Sep 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635411; cv=none; b=MilBbXT+aDfQ7K182UJJFNNDbAdp3a15YJro9DCd2JOh5+bJVRiNStSTxNKreNsS6Kw+elUola9n2oyY3u1mDl+CUCHOcAKat169KFAj0UA+EpBiMe7JBIshJ6cPnXn3Py36ZdzcpPsPJk3QeKGnxHbFsKIfxWp5YolU6Sga8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635411; c=relaxed/simple;
	bh=wOjcPigF26WCAdR1jGfbl8cIzzdK0+wRe8TT7jYy3AY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B73Bgi2ruSKiMnaINdLFjUxLd1Wwmd9NIi9MVyOQTcyucNlE8c4WeZCi5i9q68Gwstya6vVoXwXkgro8ceicwIO6cnDEY4tuWkUq0HAMGTOinOahRpsr8KYas5MQoWF8SsQv456W5XnYnluIuB+FzmBL2MI+gNm6hhl2F+nrDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rko+6Z9u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rko+6Z9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13966C4CEF5;
	Tue, 23 Sep 2025 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758635411;
	bh=wOjcPigF26WCAdR1jGfbl8cIzzdK0+wRe8TT7jYy3AY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rko+6Z9u+hVX8sPrUM6GdXavh1bvyTQhy191l+sge1mWkwcSA1EJd1fbGSoAtHnyj
	 2iEDA2z6659Es5nLwcDTXvOQUyVoYSNic4XqKhbpjf75hwkcYQY6f+3YpH0x1QYemc
	 q4A6ZxCcWDOK2NlWZJzatoABaM/DH8cVBp4yQvCCwS6xd93/IeWcTx11m3M2wKXYvO
	 Jm+uImvpSa7w3jxVZkPbqlq5PM14OB6hoI1i2y1CNu9SJLwnZjGDrTj1iWWBbbOpyP
	 MRpSln6BHmWJUMX7KRyB5uONCpZ6X/HCuTkgKNwEEAsdKFAfQWTYb5wGH9PvNfMF//
	 hwwlaC0n6/BiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AB839D0C20;
	Tue, 23 Sep 2025 13:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] Bluetooth: ISO: free rx_skb if not consumed
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175863540823.1433266.5934662600295874428.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 13:50:08 +0000
References: 
 <0c01df0dbdda659b4b75e5422f6f54bb8cf7f169.1758564480.git.pav@iki.fi>
In-Reply-To: 
 <0c01df0dbdda659b4b75e5422f6f54bb8cf7f169.1758564480.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Sep 2025 21:11:21 +0300 you wrote:
> If iso_conn is freed when RX is incomplete, free any leftover skb piece.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  net/bluetooth/iso.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [1/2] Bluetooth: ISO: free rx_skb if not consumed
    https://git.kernel.org/bluetooth/bluetooth-next/c/b18365fe359a
  - [2/2] Bluetooth: ISO: don't leak skb in ISO_CONT RX
    https://git.kernel.org/bluetooth/bluetooth-next/c/f7db34762ae5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


