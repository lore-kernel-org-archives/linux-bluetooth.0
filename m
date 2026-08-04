Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DF48D860
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864647; cv=none; b=hePbvSTi55nbhi85IKtTqDaSDl1mC2p46iewnbuV7f/hT+bWw97HTb2mW8h6duxY+sEULqOmX8IaIDAU2QU4gqe2yHVmnTrF0wYuj2KZP95YJRUAA1zAQWHf9neVNs5lNfNCRPjnbNZoVJS1kzT9ZhkOMk8v+WSvphswVWhxVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864647; c=relaxed/simple;
	bh=Y/5sxslCiXg+RSB6mWSpr+pk9N81ZoQu8OLucirvgJ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jz01UOjjf9PKSPXK2yXBvpXU4rR5oT1t1njMUErtZfA4W7qaoJn2s61p7NreTW8JN09ZhgnCPBaJpuEo0Ylbuo/fIB5vPQPGiJ4dwfbVQrd4lGlci9BlVxwS1+5kQO9HVmzdG9WpiW02Mlsp1wn5EGdrArXFu4lS6c/AHvom+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et1sSnxh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et1sSnxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8021F000E9;
	Tue,  4 Aug 2026 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785864646;
	bh=EGlH+ehjXZGnS/IOixHdsZxEw6TJI6uvnVH70t0GBds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Et1sSnxhrpfQbE80mzt9rcTqfOMheBxKd0uu5E8nCYJZebunDxgDpXcBfwm4rB8uy
	 4B0wSJLg3aonb2hQrDLetQMjqyExjq6oypMC/rnO+UgbdZDDo8Dr82QXw6nDr31y7V
	 lEQ6W6aBxBzbz1aCJBvD9o3mpvjO4IBZBTGrt59eHNGqr83io9vUANc7k6N+JpyUs/
	 dTRW1b/kF1faP93uE2b7cIYcu6uJSE/FetcPRQLKOoomjUtn34hyCMGEuODCaLm6u+
	 4DjZqHG+TcCJ+Q0pK+gxf0SRb0J14J7WiSo37zGMzT20izSoO6w1bb4p/6EUYwxo7O
	 whEre+wY41Z+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199DF392626C;
	Tue,  4 Aug 2026 17:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] unit/test-rap: Add PTS tests for CS
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178586460663.3699428.2074535802813189487.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 17:30:06 +0000
References: <20260731131352.3154342-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260731131352.3154342-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 31 Jul 2026 18:43:52 +0530 you wrote:
> RAS/SR/SGGIT/CHA/BV-05-C - Verifies the Ranging Data Ready characteristic
> exists in the GATT database with exactly the Indicate property
> RAS/SR/SGGIT/CHA/BV-06-C - Same characteristic-existence/property check,
> for an IUT configured to support both Indicate and Notify
> RAS/SR/SGGIT/CHA/BV-07-C - Same check, for an IUT supporting Indicate
> and Read on Ranging Data Ready
> RAS/SR/SGGIT/CHA/BV-08-C - Same check, for an IUT supporting all three
> Indicate, Notify, and Read
> RAS/SR/SGGIT/CHA/BV-09-C - Verifies the Ranging Data Overwritten char
> exists with exactly the Indicate
> RAS/SR/SGGIT/CHA/BV-10-C - Same check, for Indicate and Notify support
> RAS/SR/SGGIT/CHA/BV-11-C - Same check, for Indicate and Read support
> RAS/SR/SGGIT/CHA/BV-12-C - Same check, for Indicate, Notify and Read
> support
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] unit/test-rap: Add PTS tests for CS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=690c16df6067

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


