Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E6028DBD
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418229; cv=none; b=auggA66L8XRo2vX1CDH5xiSNdiAaaDmVgnv/AjYNAG0c+tyZnZJWpE7C4gKf+yzdW7P9baLDO4BiVLGgZTbXuLVnoaXMFccPI/D7g5ekyYdb+dI0tnp8zkewvmYgD0enZRetUgWfy0DWcXOPgxGxMIa9HNQt+Iqta4QnpJxlWD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418229; c=relaxed/simple;
	bh=r8DtaJyPhPFh76CaUpPpgKcj6aaM3r1Rrn5RXNxDz7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Na9m6RtawRCKXmCYyb85U4N8itGjbV4uGTdcSKMG++NBLNhztbZHnU84Wt14pSr6LpB8BkF7x+4Tz9uVBvPlPk3BU04z+ZjMYwD1mUBQbs5PfBLXqzG1NHufSNP7K5tkjs3X4m5ifH8kYMUlsOrDv/M3LWEz1kxVPK7+U9HGXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHbc4kG5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHbc4kG5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A02DC43394;
	Thu,  8 Feb 2024 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707418229;
	bh=r8DtaJyPhPFh76CaUpPpgKcj6aaM3r1Rrn5RXNxDz7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JHbc4kG5NyLLmg/vZ7QOBrXzcphKZzUPaLtYEACYEbHwB+gpVUajhP6UivRkeoTXA
	 e/9nz+98ydTLNr51TZJj/MBfgbsF0yX+1jBExzpaPI89nw3H1lTzhAMfV4D/QsQ+zW
	 blch08CLORyNv+HHVVbZLwL++ZH6/Hb+AEDMh9AuDGKIaSlCei4TVNcjooNuMDkcGm
	 DnrN3VOzIlKMYtQr4EBROS/wEdkOHUDgTitCXGlfebn8K70nR3SWpsxO7wmO/0Okdu
	 mm8rfdx73Y3sS0gTHM5NZYB+5pFEtW0C0gJw4s1VQRq+k6rYxbSWYUsSmRE2zyUCPr
	 ZR6XYyuK2Qtuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59E5FE2F311;
	Thu,  8 Feb 2024 18:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/3] shared/bap: Rework stream procedures
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170741822936.20497.15200084861913940209.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 18:50:29 +0000
References: <20240206223513.2783330-1-luiz.dentz@gmail.com>
In-Reply-To: <20240206223513.2783330-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Feb 2024 17:35:11 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This rework stream procedures to avoid having to check stream types
> everytime the procedure is invoked, instead this creates a operation
> abstraction which is assign at stream creation.
> ---
>  src/shared/bap.c | 1793 ++++++++++++++++++++++++++--------------------
>  1 file changed, 1014 insertions(+), 779 deletions(-)

Here is the summary with links:
  - [BlueZ,v3,1/3] shared/bap: Rework stream procedures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=74709286b6b4
  - [BlueZ,v3,2/3] shared/bap: Add .set_state to bt_bap_stream_ops
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e76c9140de1
  - [BlueZ,v3,3/3] shared/bap: Make bt_bap_ref_safe check if the instance is attached
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6dafe901a2ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


