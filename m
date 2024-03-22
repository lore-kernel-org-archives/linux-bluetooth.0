Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C02E648
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102232; cv=none; b=YJCLnZIMH64KvK1dedPw4X1yESp1NzoWReQAslffaznaNsdfMVwKEatsmeiZOuoTYoVBrPnRZb2kyuQWpIsvBEgX2Y2bsxT3vqSPCqWJMULz0YVd4fsuJKgEkS3u9TPokf7DFItxciAoptF9ZcgTKD17VtWtD76iop9XDdT/8PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102232; c=relaxed/simple;
	bh=dbTJKAJFaemHRCC4PE7gjJBQvMZN6VxQHleFmFwq/rw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WYWlrThjgtbdhIfojaKm+qJnrVKoMCHHGuA/cZ8ipauBEUeLJOFExopXme6HSucGaqQewuFyMc5/Jj0/kKe1pjGCTZogmmSiq7vyluK7JwbDlIApz45e3JvaA9PvGkmxN/+asbwZS6xx7Tq8MUaSGrXg5Hik3Nm2AfKohUdpybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZwKViON; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZwKViON"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BCE7C43394;
	Fri, 22 Mar 2024 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711102232;
	bh=dbTJKAJFaemHRCC4PE7gjJBQvMZN6VxQHleFmFwq/rw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nZwKViONWtb7scgGFwkvgNp2AK+GdpYZZeVkF/rvQcJU3BpVNQGTmA1GyPmTAhh+k
	 ZDSlGNTgi1OyDrctpyqTAKOfIUBuSiDn0+UcqcOqMogrL7OX5NdS2Fe1ODd1dTENmx
	 wXWcLgxkKM5fYxMpwRm8H9uiaZ4WAdE0xqrhzSqCKauPFhBLMCAyQ8c44FBl2Sfh03
	 77WojcqJImhc5i0orpCrcPKohUOFGoCrQn6svLn2wdH3GcfQXAjhD42zyIAlQ4Yv9o
	 5kvTFfyz2u+tCVCATWsTv8FIB6tSTvRSUw6lmuBqNS7dDVBExGvgJUbQeY7MjdxUel
	 7wM6mzqNCCEmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37C77D982E4;
	Fri, 22 Mar 2024 10:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/btsnoop: Add proper identifiers for ISO
 packets
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171110223222.5004.1004568958194778845.git-patchwork-notify@kernel.org>
Date: Fri, 22 Mar 2024 10:10:32 +0000
References: <20240320183038.411332-1-luiz.dentz@gmail.com>
In-Reply-To: <20240320183038.411332-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Mar 2024 18:30:37 +0000 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds ISO packets identifiers so they are properly stored on files.
> ---
>  src/shared/btsnoop.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] shared/btsnoop: Add proper identifiers for ISO packets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9250929edde3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


