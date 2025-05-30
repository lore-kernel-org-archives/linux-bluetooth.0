Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBB1459F6
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 May 2025 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626215; cv=none; b=bVcra/3IStDatOY5hKmjFLC5lEzCeDXWDN/JMkk2bYn/Nqtc+nz0Od0Mzy7c4FmP+w34FOYNs+evudFieeWJUhs3Zk64O+nbU41+KCNvdzfQegdx16365Whpg22BP/uHb1LoBHIUSLFqWV2B4/fCqS4HJcFsjx4d7TV9InsomGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626215; c=relaxed/simple;
	bh=MYjkEZkVH2DqMUwNp9aJpxI8DKlhrqTxFhEDBFL3rr8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E09qkHZNV/3F6dxZXZziiY13V13CcgOs+Y2zOTsEjLdppx1Ep93cNBKNzZXxfZzHXob2fflD5ePov1b1jxlg8YYbD04V47ksfVcnjQ4lm3q/ug/44T3BKLpX8vO2pgQ/dtB5LJvBdC+4Q3t8+tm9dY12+uYbz7a/CigJhQgoc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKuAqHqr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKuAqHqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF616C4CEE9;
	Fri, 30 May 2025 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748626214;
	bh=MYjkEZkVH2DqMUwNp9aJpxI8DKlhrqTxFhEDBFL3rr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bKuAqHqrLHyqTUNxOcgTFB1M+llOUSQDzThfnGgd6RF1fw2JzLtb+MZdkwi/9wcp/
	 wOdsAZ5TPPp6iMdlTCBELYkrSwWEBjJZe/qWmjpqUclBbqXbA8b4Lx9kxpGHQD2ofm
	 9QUrZh1k9oTOnpj8OOS1zQlfDGyBvK8G4LddsnM5fdzi3CHp5410BAfwCt+3rLO2sC
	 Zqr3ZP+DWm0rSPOAcFO5TZIMLMvnCJaU+5INfVPpyx2FXLwdAzGRFIEOFWOhxUySwA
	 qIjnqfh4fy7jti7bm8+svsFmRibwe3DXNViBCoGsQYccSxqG+J7FvNxoWP42C8tlyw
	 0LDVJCB2IGH7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B4A39F1DF2;
	Fri, 30 May 2025 17:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix not responding with
 L2CAP_CR_LE_ENCRYPTION
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174862624799.4035476.277611158411805378.git-patchwork-notify@kernel.org>
Date: Fri, 30 May 2025 17:30:47 +0000
References: <20250528185311.540919-1-luiz.dentz@gmail.com>
In-Reply-To: <20250528185311.540919-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 May 2025 14:53:11 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Depending on the security set the response to L2CAP_LE_CONN_REQ shall be
> just L2CAP_CR_LE_ENCRYPTION if only encryption when BT_SECURITY_MEDIUM
> is selected since that means security mode 2 which doesn't require
> authentication which is something that is covered in the qualification
> test L2CAP/LE/CFC/BV-25-C.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: L2CAP: Fix not responding with L2CAP_CR_LE_ENCRYPTION
    https://git.kernel.org/bluetooth/bluetooth-next/c/a731614b3044

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


