Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EC1EB3D
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116022; cv=none; b=ZgJxBDfWaQb1Xr2LJqMPt6Je02fVAC7m4PshFHHFvs865oBIQ+YzPX0YJqP1VIVP4n67hGuRuAuz05LZ5+G9kqOcLI7K4dDPymRK64EbAyxuzqNgWahdJwbVMlWnAUPC9MrZ9Y5cKHgyuZ1Pt1eKvhedb3thaYEE3E0Zbb74xvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116022; c=relaxed/simple;
	bh=GPpasXgPBKpgPkrBGEe3DjgBJOla7nJVg2lP3iN70iE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gCVNAWM2O8AZViup6/J51DMyml646Et7nZPUWx6QOXZw3goPlOyY5ZNFCreWrBnG52/7QTlpmgbgl7U2yns4sCxdb/Mo8iRCQrMSwJyyfi+be7ZmFZiz+Nbc/6a/wkIr7dfsODR2vxpNoB+Qe+N/zwhvdbCSFd8j2DTAEULR4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXYfdA9z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXYfdA9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03692C4CECD;
	Wed, 20 Nov 2024 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732116022;
	bh=GPpasXgPBKpgPkrBGEe3DjgBJOla7nJVg2lP3iN70iE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OXYfdA9z9AnMrSwQwZSVIinChFKpaENGiDY0dlTgs0ajeITYjMiY2xbfvYV8BblEk
	 SxmcvkJMNGp/Fvl5PMZ24KFwGV6ZTw6lXTdc5b/+wg1r9IOUJNsYO88GzFj/wtQrGy
	 VRMNKmAwXuek9aQY9Vmx0yNzp5oISo45v1HMW39UkTQaHBB4Yin58FPTaZKqK/WBQv
	 4k9ZMQ5ZDbGUQHwTIIZzK4QoSCeK02EwWOlvS8QM03ZWO1AP3WY2ASYQcMz2ZF01cr
	 rQpf6yuKjKbaR4BpA1m6oJhuFCUsWZ87VvjZxp1forDmL8eIvYTTKNJcXZ3KqHYYW2
	 6p6uB3OSnDBbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB28D3809A80;
	Wed, 20 Nov 2024 15:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/7] bass: Rework Scan Delegator
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173211603375.1254308.5361878885594387352.git-patchwork-notify@kernel.org>
Date: Wed, 20 Nov 2024 15:20:33 +0000
References: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Nov 2024 12:25:54 +0200 you wrote:
> This patch reworks the Scan Delegator implementation in BASS, to
> manage BAP streams internally and leave BAP to just handle streams
> created by autonomous Broadcast Sink.
> 
> Thus, this also removes long-lived PA sync support from BAP and
> also the pa idle timer, since kernel support has been added to
> order PA/BIG sync requests.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/7] shared/bap: Add helper to parse BASE
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a0aee49df1d8
  - [BlueZ,v2,2/7] bap: Add helpers to convert iso_qos to/from bap_qos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8054693b0c5b
  - [BlueZ,v2,3/7] bap: Rework BASE parsing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=66a83fde5c49
  - [BlueZ,v2,4/7] bap: Make default PA sync QoS public
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3babeefa17b6
  - [BlueZ,v2,5/7] bass: Rework Scan Delegator to handle BAP streams
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ac56526b7e39
  - [BlueZ,v2,6/7] bap: Remove API to probe device from BASS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e618932b968f
  - [BlueZ,v2,7/7] bap: Remove PA idle timer logic
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e59a915db9d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


