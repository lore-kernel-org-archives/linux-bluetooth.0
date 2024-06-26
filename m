Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC3D191473;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432033; cv=none; b=ZusMzdgugzuMZ0CHUJKEWGkyRs16cbhDD+J3okHYfAeYx1jAU98Ep5UVBnIM1Vi4YH2oZabeFbkVhf8NLXTZqiP9T8MEmpRI6LzEPVEP68FTkSxd1ecz5cEQVg5SihAw9oFGc8fQl65w00aGismTwgX7BQBuqpdLURpSWzEN3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432033; c=relaxed/simple;
	bh=uhGQthDuXbKZos3gqEFmnB3YOE38LiquQGA/KO+E5D8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qABIdzGQwEfR8Vs6Sr8zFUZ/Ys4vpJmQXLgBVeY+t6UEnijVH1jgm1G67TbnWqMmaxoaZfTuL52509mCS337vSsvtaTlOXoMAAkCd7MdQAAAjX77XBQ4P0B/Rcj5B7VeT30ip/zhEXFc7IQ92HUdAjRjNZTeK/bSz70rBJjWCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVKbeT/a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVKbeT/a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3468C4AF09;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432032;
	bh=uhGQthDuXbKZos3gqEFmnB3YOE38LiquQGA/KO+E5D8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LVKbeT/aYJUXGZUaQU9GmUDMCi4ev2TUawytq7rYoEQH+xFQkg6aseI2Y5V0CVUYA
	 CvophdEEilxIuHS3LisXScVXZ3C7GYHZgSKS9TjmnlBuPN+sZBq/dYQtSOUQFc6p2N
	 yawbqbVoxnly8gkmFNHDCF7GTw4PkurUnIE32sSDgiQqSC9N24vlD6OUZchVQBVQtd
	 ARaJmp9m1LAPaM6MUFSc3lZejeAqwoK4tEccIB34pC0ePE7UzyFcD5GVPQ9VeAkBnU
	 lZSIyWai/eyP+BNZgGIDZv5z78tIXH17pKeFUkK6wa5PYFcu6Vv73C+Vexn4MAYmPt
	 uHoWYtbiVKCfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5F79C4333A;
	Wed, 26 Jun 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bluetooth/hci: disallow setting handle bigger than
 HCI_CONN_HANDLE_MAX
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171943203274.19782.12756236597529287956.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 20:00:32 +0000
References: <20240620192747.45267-1-paskripkin@gmail.com>
In-Reply-To: <20240620192747.45267-1-paskripkin@gmail.com>
To: Pavel Skripkin <paskripkin@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 william.xuanziyang@huawei.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Jun 2024 22:27:47 +0300 you wrote:
> Syzbot hit warning in hci_conn_del() caused by freeing handle that was
> not allocated using ida allocator.
> 
> This is caused by handle bigger than HCI_CONN_HANDLE_MAX passed by
> hci_le_big_sync_established_evt(), which makes code think it's unset
> connection.
> 
> [...]

Here is the summary with links:
  - bluetooth/hci: disallow setting handle bigger than HCI_CONN_HANDLE_MAX
    https://git.kernel.org/bluetooth/bluetooth-next/c/6115f1ecd308

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


