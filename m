Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD91DDA30
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730816423; cv=none; b=Joo7UMIx7zRVyepS9Y5dSy77cxbm3nsL8h5CiYm5Ny4wLxIFm4b8z17mvE7OyOvW2x/1uw8oRZZ8pjhYAhUw4pvVX3LIlhQPoYyjLzHIym0hxXBhKJIOLJnirwCmOq99TwABpCPfwM99n3sA600WkpRCXZQ8c2kXFJSnemhU6+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730816423; c=relaxed/simple;
	bh=VOj0KErR/OKax/1V1CtuzYy3baofqvn1pCEqmXM9G1g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qYN7ogndtKL2DEPlAGMwm5e6RRv9qlDR4UEluYVgV9KdTacGdJXsXIXkaFX7VQ9eBNfIm9EVX9Q1YzoRSPiKXbaGjC4FZb/vCxKIl3YZNFVHJ8qTE0Mkh1DfPX0QKs6Pw4Xhf/Z1RIN5TXqSNG3ZYevzvbfrx8VFk/J9IkgV0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc9GlySc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc9GlySc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D534C4CECF;
	Tue,  5 Nov 2024 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730816422;
	bh=VOj0KErR/OKax/1V1CtuzYy3baofqvn1pCEqmXM9G1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wc9GlyScPfsC62kRtoJ6Of0FOcQGo1JO65j9o9JmnTa0QUaqhcNXwReVNJYpu4B6x
	 htaCyLcLgnOvKkq52SEmMpC54jGPrIDk3JPIe2Ee+ktp+BIpQShDQmGr8hEYHcg1U7
	 qsmyKV7FvhPQen99Fhymg/RvOUd0jmk3nJPWHn/ZFNDddNZKEh76eFKz5Ld1hHERm+
	 OOnRUvTAEyM2XURB6/RpjwTQno92IJcWrE5Xp2iwtD32Acm4RWZOPl7yQ/kxAPVLkd
	 94NqZ7tD8ymDEi9KD4RRK6sgNUH5MkmYj9slv0QUvQv0hCtQk+Db7LjN1COuOP3euN
	 4U+jhQFNS8a/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 737763809A80;
	Tue,  5 Nov 2024 14:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/5] iso-tester: Add tests for Broadcast Receiver
 sync to 2 BIGs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173081643125.572563.2794731489024503294.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 14:20:31 +0000
References: <20241101115118.43891-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241101115118.43891-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  1 Nov 2024 13:51:13 +0200 you wrote:
> This adds new Broadcast Receiver tests, for a Broadcast Sink
> synchronizing to 2 Broadcasters, with and without defer setup.
> 
> ISO Broadcaster Receiver2 - Success
> ISO Broadcaster Receiver2 Defer - Success
> 
> This also adds emulator support for creating PA sync with
> multiple trains and for sync with multiple BIGs.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/5] btdev: Add support for syncing to multiple PA trains
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=30951c983ddc
  - [BlueZ,v2,2/5] btdev: Add support for syncing to multiple BIGs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fb09ce5cfda1
  - [BlueZ,v2,3/5] iso-tester: Fix memory leaks in iso_accept_cb
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1a55bac5595c
  - [BlueZ,v2,4/5] iso-tester: Add test for Broadcast Receiver sync to 2 BIGs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b87c3767f5e0
  - [BlueZ,v2,5/5] iso-tester: Add test for Broadcast Receiver Defer sync to 2 BIGs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bae6c32940d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


