Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32261ACEDA
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246793; cv=none; b=Un6baHWZYsVW4ZmNXKEEKtbfDsNTDOmdyhwYtKhSwtiTecQcmkgxptMpSGgNbOuw/ETrzFH8IwuZSTrlL+sFAhvjaw5CcIcOBovaeoT+0aj8s7MPYYlJX/dB6emIRy8aVT0OuIX9eb5g+EI0/5/JqysFO9G+P7zKbk7dildL7RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246793; c=relaxed/simple;
	bh=1EUv3/ulUubrSlZliWhBsuXDn5F8UDRG/Em6EOe46Rk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KyXdkje/HfBJzGGEahWZZ1UCsUpJnaKc6E0tU4zqH2Ymin2y0JdSozEhyaWuFbNsKsMslJXhkD908rnFVYNEJg0/Mzm9oSs9S0Bm7W8JG1aafOdtOJ1axQLL1GojXd/tomVX6qpw2LtTb7RhzkMVcVm+a8/OrE0TF+SNvuvXndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwEbRri7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwEbRri7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF21C4CEE3;
	Wed, 14 May 2025 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747246793;
	bh=1EUv3/ulUubrSlZliWhBsuXDn5F8UDRG/Em6EOe46Rk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KwEbRri7oPvrO+2QY+5bMz2szzc1D8PWmnc7b5VYR1/JO1Z3BsPv0wIIprf3b48Vf
	 WnjdNTQ5pYyb3jgoAFR1hwrONBDEALQXE9RmGPg44Tk97zpEIWnfESY9voG1sJPHw7
	 vXSzZA67Zh6f9wkkR+rtzP9I5a/RkdRyqxVMhdg1x3w2h60VTQ3BZWzO37CcWzCMHo
	 pZMwCF1EKQyyeSTxZP9ua+WksMcHBHBkr0tGGbQPqvDLwWvxq30wdiqGyc/6yctwBm
	 RnXkmZqMDhMKATdCbBW5klyHs8H5OHaMPlV90zyCiQiEDXuyVi1n2DGvzXmjUbEobh
	 4oTLDyGfpqnpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AFBA2380AA66;
	Wed, 14 May 2025 18:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] monitor: Add definitions for FSU command and
 event
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174724683051.2463345.4791379271682448682.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 18:20:30 +0000
References: <20250513175600.1158690-1-luiz.dentz@gmail.com>
In-Reply-To: <20250513175600.1158690-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 May 2025 13:55:59 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds FSU command and event as defined in the Core 6.0
> specification.
> ---
>  monitor/bt.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/2] monitor: Add definitions for FSU command and event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f02ca9dc8d54
  - [BlueZ,v2,2/2] monitor: Add decoding for FSU command and event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=080174528484

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


