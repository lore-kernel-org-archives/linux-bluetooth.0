Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE511EF0A6
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258206; cv=none; b=qCcmJx4vCoYPv1JD8oZDA07D3tMsyMS9Xdco8FYF/Su1bPRj7lrqquRSmYtrFHG2Jyy5LFRnla5NKYxVQ9QTWzIxwF9zsURZ55cVnw3e8nYO63NDjDj/rlJNlSgrl2aHkIWLeIEykvsd+i8LkeFS49hjXmq4CNWCYhDd681MhbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258206; c=relaxed/simple;
	bh=i9ycEYTRuXjoKMi7CyGYfK2WpIMNUGfzayD+TvERQ8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N7oPnlgM5urfj0w3h2AZ9a9y5p9VYAjv1AN0yvWbIyzZqfK+U/MB5dr8XKLcPltzc2Isnjc81P0hkOsIgd7F2CeKUQeG2OquAcQwU5E1UTOJ37+v4hiZVXjv2/7hBWZFabrt2qfgm0OMTviWd1jFA6tIXWbNzsLNw6rQOnx/0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP6tICBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP6tICBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55EBC4CED2;
	Thu, 30 Jan 2025 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738258205;
	bh=i9ycEYTRuXjoKMi7CyGYfK2WpIMNUGfzayD+TvERQ8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jP6tICBvhoEBpV8VTvlC/I3d2OLG3Zq/Mc0zrw+gZLBofCsmEpUUg/hnSiRYCNnsJ
	 pm38Ya4iTobLJfu0oMUV6ggJ703lbvvANARLmVwgu1UnSFVMqMB8/iyN74GbCJolf5
	 J+UKbuaz54aJ0ncJLbWLXMV42YoHZNfhG+4MDfY2f+0CcsJh6ZdcDIo1+rQlmHpPJN
	 4llp0QE3UovO56ok/f6LhAAT+KYadHeGCe2+l8Us5wrM7FCT6D5loCqkwsVHChfTZH
	 cNwRKeJqr/NeMT23t8CPLVF/QS5Lk8eYJclLp1GTMRxYlg00r2URTKH8zZsA/zBFWI
	 +95R1zSG8Fxzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34AD2380AA66;
	Thu, 30 Jan 2025 17:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obex: Update the MAP Client version to 1.4 in SDP record
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173825823201.1027237.9880154585655209810.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 17:30:32 +0000
References: <20250128174130.1476094-1-quic_amisjain@quicinc.com>
In-Reply-To: <20250128174130.1476094-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Jan 2025 23:11:30 +0530 you wrote:
> This change is required in below PTS testcase:
> 1. MAP/MCE/SGSIT/ATTR/BV-10-C
> Attribute GSIT - Bluetooth Profile Descriptor List, MAP 1.4
> 
> Current MAP Client version 1.2 is being deprecated and withdrawn
> from BT Sig, so it is mandatory to update the version.
> 
> [...]

Here is the summary with links:
  - [v1] obex: Update the MAP Client version to 1.4 in SDP record
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1b37809b1df7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


