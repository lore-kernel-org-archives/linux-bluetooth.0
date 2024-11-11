Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACECB4C66;
	Mon, 11 Nov 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341423; cv=none; b=Qk6LviyTedOwmeYPsgqKzBAPul7t8eGIJAnEkJGx54/WkAY2QB+YJGt10Ykl9stCAjdrKb4se4VR5vLpO4Ace3wdduyqJZcdpj5qj9OqvUdJWLlXEg7yZELhVuwuIW3rM403zDDzAzk/l65yMQbnD8tXizP+X+vZPvZOm+EXuPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341423; c=relaxed/simple;
	bh=JpuI1r9N1B3dnAU+PJXGfR0Xa/QKY9khHK0rcQpBmyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D8AU/FY+Z58NQ1v/F4JG7MHSaC9wurSinfc/9msIgNIu8ED4MQM387KwN8n3oATw2a0UYkazkaC14+L3aW11DhHgRij/tpN4J43FVNsJdcgHUvrVa6lCqdEjOVhA0h7mXU+3dyINpSzOg2ksLuX9PbwraU3CrKYPbH4sNVRyETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2lUpWJY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2lUpWJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F584C4CECF;
	Mon, 11 Nov 2024 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731341423;
	bh=JpuI1r9N1B3dnAU+PJXGfR0Xa/QKY9khHK0rcQpBmyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H2lUpWJYSV4o3G2Ewm5ojd4cqewLCv/o5VlKMDNChXdM3ZvAYgnUvbdUvA01pbSVF
	 bOCj1tF+BYE34YfuMaWXrJSL5S0PkE1WmE/+ENDHttQRiXMjikPMahQrPzLwUqhxD0
	 vOhNoOQqJVQkAZfAlV+Ze3Hz32oJnbPf8LL5WkmqdgNbRCC+qxqKTlo/UKzUhar4o5
	 JfuSmMGqYMf3mg191upegC+qMPLRCx4c6V8RhGpVySd8KzsnxlO0CNLfBNyH5xZlbR
	 IqCL6R5wsgq3ca9+xvNSOsAJit0vNmDib6tRucDtytNKnFSCKMKZKKf8l+edL5jLGE
	 gYvt3TNiEWXxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FC53809A80;
	Mon, 11 Nov 2024 16:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] Bluetooth: hci_bcm: Use the devm_clk_get_optional()
 helper
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173134143299.4081786.2121396156532887994.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 16:10:32 +0000
References: <20241108153349.1589499-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241108153349.1589499-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Nov 2024 17:33:49 +0200 you wrote:
> Use devm_clk_get_optional() instead of hand writing it.
> This saves some LoC and improves the semantic.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/bluetooth/hci_bcm.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [v1,1/1] Bluetooth: hci_bcm: Use the devm_clk_get_optional() helper
    https://git.kernel.org/bluetooth/bluetooth-next/c/42e8e5c1092b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


