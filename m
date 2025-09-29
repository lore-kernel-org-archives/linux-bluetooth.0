Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E646309EE8
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Sep 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162213; cv=none; b=Drlqw+04rnCxT4OVQ880/tBRW2HH4q7hgEaXWX3quDSbSmbeFThvDD639gzqyKuQ4JX0/tcPHf6mp8hQbUAhaLsht0v/JKMWCJpGTi4kpns8pxoyEjD7o+ok8Z6GdzlBwTr/Tj0grD5vjit4U9w3hoxvQTf0P4qj/vQktbPahyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162213; c=relaxed/simple;
	bh=fQ5oMdnOHIyeYEkejayuX51ckTPvK1o4NxB48g2uOBY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lmt5f/TZ43fWtwZA0UE1F4Ph9U0SkMd1QdfAk4/dMLT66jQ6rZ8ORpLVQnvgxHyGjcjowzty3neFqL4SgCwprr8q1e2RxhtO44SPb4PNb0MnNKqx5SBuiaEQ1PURy0+hRlxlzLMzyUB8Vl+vG32cbvuMeqNtlU4gCssaVLTkZyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TunjBCmE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TunjBCmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8523C4CEF4;
	Mon, 29 Sep 2025 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759162212;
	bh=fQ5oMdnOHIyeYEkejayuX51ckTPvK1o4NxB48g2uOBY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TunjBCmEKyE+xDIghXHso11yJuZu500FlgGK1N+MIzMPQsf41kvxVavGkaE9aV5f/
	 fExQk1mxB29yEfQ7PNNyltMjw+kojWp99yXSOMPyZ28vmCxU/uGJn3QA7psFVuo6vT
	 rNjxAU+FG7DPqGLPSliKeNPGPZAD6Vc2o7ycIXFVsjsbNzPhF97wRmXrI0DNuMix5n
	 7mun4WX7A20/Yw2X45Ote5Dq3tk5P7Pggpa+YRsLuiayB8EPOkWY7tilLhnPB/6BmP
	 dBTHy3xTkXyaghxFzfgVJ2KKpUTffk6WTDOK9N3Q6v+59/HrALjwkoIDMJbQUaX3UZ
	 Xgyqezj/oFDlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE01239D0C1A;
	Mon, 29 Sep 2025 16:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: ISO: Fix BIS connection dst_type handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175916220651.1630000.5610105462125801570.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 16:10:06 +0000
References: <20250926154850.714148-1-luiz.dentz@gmail.com>
In-Reply-To: <20250926154850.714148-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Sep 2025 11:48:50 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Socket dst_type cannot be directly assigned to hci_conn->type since
> there domain is different which may lead to the wrong address type being
> used.
> 
> Fixes: 6a5ad251b7cd ("Bluetooth: ISO: Fix possible circular locking dependency")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: ISO: Fix BIS connection dst_type handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/e325d4d4ace1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


