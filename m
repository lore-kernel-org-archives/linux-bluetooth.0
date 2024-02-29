Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9013D31D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217029; cv=none; b=ELDXfjdky7AklMB11Wd5CxdpZVEVtkUI1NFAVyuvQV8cKX5WjfMq0o9AmtXM/d+Y+nAOQdGcRMXvJOWy+7cn2ej/F98zqUVNhdlmaKlVpV16dJ4hVr4ui8ckBqmcQLpKYr5X/YrNI9E7SMgJhJOJwIXvGHfyDGpdKLPbALcO7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217029; c=relaxed/simple;
	bh=sW9Ytr2L23oRXYFBMkKSaKz65Ov8nAoGPQU8rc2BKuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nTorlIAyN/wlg9BPnugWH5893tdV9KpTIXYX1VOV/rhSMHrUGgyjl7AIUm9Y2K1bqQezO1qnZ3cnggls5YlmNzc51dev1zMwPNld+pJt87GmHuy3vbs5rrC4eQQLF3sGw3Ur5N+BmkmRnjm5I/xh8Wr+xbrsxiPJDi+1cBDcgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ/swMSc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ/swMSc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDFEEC43390;
	Thu, 29 Feb 2024 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709217028;
	bh=sW9Ytr2L23oRXYFBMkKSaKz65Ov8nAoGPQU8rc2BKuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pJ/swMSc5jQg71ws0jDaVyFB5P677APGvDcXvtyYIWDooflK1x2i41IMXWdTfv+Zs
	 p8LDjMNEmZjqYHzTQys4BMj8CDlSe9j/ZBTkfv24cyQY4kwGwbXo1DRsqZaOtgZSJr
	 DL9JD6GUCu1AgMqPsLfy1w4hRv4HhLCGHsS9C4vNIwWhDE9UReBfdcOcMue8Ayrj8x
	 y0CdGUbkK8IH0Hx3n3KP6P6cvx01Wd7iYOSykuptCh2MFM2/R30QUDtSfqxbsxvYmP
	 rV0pKWIqYkg9ZaAcHZuYjWXyH0lcsG684N1yqsYmnmHrTdxXavCwdcjnScn5eP8WkN
	 iMXzZ/LIwIujw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C3BBBD84BBA;
	Thu, 29 Feb 2024 14:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] btdev: Fix not resetting big_handle on HCI_Reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170921702879.12513.14240011058449598683.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 14:30:28 +0000
References: <20240227164403.1904213-1-luiz.dentz@gmail.com>
In-Reply-To: <20240227164403.1904213-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Feb 2024 11:44:02 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> HCI_Reset shall cleanup BIG state including if the handle has been set.
> ---
>  emulator/btdev.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [BlueZ,v1,1/2] btdev: Fix not resetting big_handle on HCI_Reset
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ade2b97597e1
  - [BlueZ,v1,2/2] device: Consider service state on device_is_connected
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=44d3f67277f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


