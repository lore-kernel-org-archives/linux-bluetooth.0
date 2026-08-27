Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC84968EF
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851265; cv=none; b=mkip1V/JfvPFrv+bXN32h5oo3WmdJHlik1ZlHtEfui4vxqQ0j0FJRYNWUILURHyvmidZkiXKIpK/8CwHxFwJ3FmuktTF+DzMUKlgMfLGvqFn1yGwK41yAc98lKwQATRWCdKG1IfJORn38lmUM+o6uDvEw1JHZE2z0nXukFgNBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851265; c=relaxed/simple;
	bh=cf2HPels8jvp1GakDEKVIjqv3P5+czSQs879zvBHFOI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OJv/mgJNSXuldRQoaeHB2ZnCPEP5crviCfEZ89VknLKHsD+FU8OlsH0fnL0ZFNIBSgCUPVd2An+OsAFR/YoZX4kp2gppLBHgdzw40ozX2x7dPV64j7cBaLb+TEtxdURMpY7PCAfcz+eMLVDd3fWDhu/Or5qY7sIZ3LJnGVI+2LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A37LOEpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A37LOEpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4751F000E9;
	Thu, 27 Aug 2026 17:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787851261;
	bh=w908Td4idgw/6os0lPNvuu9CZpAtz7zv2Mkeg6D5uWs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A37LOEpA1+1WcvValAEys8AZq7hmWvON7IpliPk4Lal0JyuZ3XMBr52O9iNsyTGWB
	 Vtn1UzcSvyGNJ0myEOOk1AClbdHzkM6z+Djx74HInlKnXmn+3MExIo2uZcprAH9qbz
	 DZ+XvbOivygseLpNHjOdabuZ5I5PbNeti7lsSnSENEeUutMALD1Cg95xYxearjNM9A
	 S+gdsKYNlRUCuDOS1MTHUdjtrMwQwInRTESeBEy9tuqP57SeafqZr775UG8qjUdrem
	 rMZ7QTtG13LVF4jTKUqezbYiyZvcUbREmcRwjB+mWyVzhyn6dGu45F/8UdJSOdIAqH
	 bBl40adfBwbKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09923809A89;
	Thu, 27 Aug 2026 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 0/2] ranging: mode validation and
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178785120639.1759916.8569344253023499673.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 17:20:06 +0000
References: <20260820174910.559116-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260820174910.559116-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Aug 2026 23:19:08 +0530 you wrote:
> This patch series introduces validation for Main Mode and Sub Mode
> combinations in Channel Sounding configuration and updates the
> MaxTxPower option documentation to reflect the supported value range.
> 
> Patch 1 adds validation to ensure that only specification compliant
> main_mode_type and sub_mode_type combinations are accepted. Invalid
> combinations are rejected, and the user is informed of the supported
> mode pairings.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] src: Modify MaxTxPower option documentation for ChannelSounding
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06b1ba3343c5
  - [BlueZ,v1,2/2] client: Enforce Valid Main Mode and Sub Mode Combinations
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=49592cbc1416

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


