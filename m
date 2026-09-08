Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBDC48E0E6
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895283; cv=none; b=Bq09luCFx+CJ42tYSeBwbH5gJy/CCh7dsCjFIAQWYPP4X4gAAc92F7JCOIOEX5T5DuVJEBRjXSGuAkCLSh15NwFJZfnq+cI/sWTRB3piWnUg926/LAgIN2YoTp55c8pZOc+pTZb4V27dmIp6Sq7Pz3/xaCGVbyXOJnskzRhpR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895283; c=relaxed/simple;
	bh=kvwMWXqwRgWVZ6wnSeC1u4q0WN0mVVClcOHTGvxlPPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JQeD1vTF98N2+cf29IuOqa/AWvsG058/+Qfd/3bcVOExv9TSwLvlwawdiAC6WzbzP0CWP8+Hre7VjQT+4W9SWHzPicQJMs3D5fTCHGwA1CCnrXxCIVWwXf4N7I2DemSSGXZ3dLUOt6UVW3CTl6CTaM47QEDel+BO+6g+1Cj1iAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBdE/d5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBdE/d5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D046E1F00A3E;
	Tue,  8 Sep 2026 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895272;
	bh=ujtLQ9grdEI5gL/2SR08UIr+aLWCnUM6L4QG2OPpgUQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jBdE/d5bk61I5uDBSV7qEO860bXlrj0a3PiwGo9Sijk03M7PM4QC6WDJa7i5DCyeH
	 OrEFGeOFHFVOPMQt+97csglAL9pjoR8T6Iki93vBrwlMIMvwriTRNvxMZFhmb6MLUq
	 cAsEnwJ8zcGPYhExAb4sNu7Y4XssW5MuZW9QnA1tJnCHJaGb/2WK0bggdIkJNaF5tx
	 z2AM5Q3D3+IaczPJkyNmgrK7zDvd2xdm89qhL/41+iKrw6AL6sRlNqwl7BrV14fBEQ
	 kqZ4FNQioMEmDg4EOmBSTpE/y3TlpOEbt2W3ka1KqHMd2Hi61WAtRTV6lQ3eYK2W/i
	 yRbj+fIOjqFjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A09380820D;
	Tue,  8 Sep 2026 19:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/3] RAS: Add support for on-demand ranging data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178889521113.3704993.1182340712604469655.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 19:20:11 +0000
References: <20260908042727.1677501-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260908042727.1677501-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Sep 2026 09:57:24 +0530 you wrote:
> This series adds support for on-demand ranging data
> delivery in RAS through a new OndemandRanging configuration option.
> When enabled, the initiator uses the Get_Ranging_Data/
> ACK_Ranging_Data procedure instead of real-time ranging data notifications.
> 
> The series adds configuration parsing, enables on-demand data delivery
> in the reflector role, handles the associated notifications and
> control point procedures in the initiator role
> and ensures the initiator honors the configured setting during RAP setup.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] rap: Add OndemandRanging configuration option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0ffa6d24507d
  - [BlueZ,v1,2/3] shared: add support for on-demand notification handling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d19a3ac4a224
  - [BlueZ,v1,3/3] profiles: honor OndemandRanging config for RAS Initiator
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0418dd8e179e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


