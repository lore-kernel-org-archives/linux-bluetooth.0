Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD122068D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347437; cv=none; b=m+DE5aUt2s07aOSeyDcR+K6V2s+5WbxgaZ5Dnr5//psxagyY3icLmHhzyRZ0KXpw44xgZgo2clxpY+mP+/3ZfAW2n3DX5qErsyis7/5XYIawLOdnmO/MEEugPB0z/VUCWuGPXbABRGB3qgReqfR+BASYEni6lPrjU0E7x6puK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347437; c=relaxed/simple;
	bh=UpdOxINuEkwSuPfp6lT7WPCmloWPOg2r5BBZ9jPwurc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ayzNRGDgZy22JwACotG/9qs5yg5Iv7zA5G0YEjrdCtMhMzZQZ81qXWb7W3RfZsJcTEbQhmH46lR1GjkwKHsBLgRD/S1LOGUNgIL0pnBaOAorCzrHNRyQLGL6hGLct/+4rtq6V5p1Rab8jhqRZsh1v7hW6Y7REE72P61kQttcnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyQluhBL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyQluhBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D5EC2BCAF;
	Thu, 16 Apr 2026 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776347437;
	bh=UpdOxINuEkwSuPfp6lT7WPCmloWPOg2r5BBZ9jPwurc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iyQluhBLyWLqMxJQBeRvKfNnG5Q0c92yxDYlSkIqUFRvxPlozslFeOYUJysPWSq1G
	 YUEnWeuDQgaMQIv6XpICyUedFqmcuD/si3XRGRUK6U8VzaPJXA8j4zBtUVb3+d5i+C
	 6JqGSwdWj5TVeklGZ/ibi6y4uFPuXL8FpMYsTXkN+v89U8RZZ+XNTxVlyloGQCP6v1
	 R0ny46OX5CMPJD6jpQaYVMfox+HBXuSAPEoLJXOKP9xQaKX2FtfzmY3gUfBp1ifqEn
	 O/j9EfdydE6Q+CJsKBmCUKuMX63VmJ05ocox9TZLeHhklmpFRiXOUx6aqpC7/5Ksnp
	 OVvz09jGnMTUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE42380AA60;
	Thu, 16 Apr 2026 13:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] doc: Add missing btmon-cs doc to btmon.rst
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177634740604.2827737.7640411424955587978.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 13:50:06 +0000
References: <20260416100323.3848182-1-hadess@hadess.net>
In-Reply-To: <20260416100323.3848182-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Apr 2026 12:03:17 +0200 you wrote:
> ---
>  Makefile.am   | 2 ++
>  doc/btmon.rst | 2 ++
>  2 files changed, 4 insertions(+)

Here is the summary with links:
  - [BlueZ,v2] doc: Add missing btmon-cs doc to btmon.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=590bed15fbaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


