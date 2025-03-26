Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254F1F3D56
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001797; cv=none; b=JLsi+7J1MiIQp8NOosCeVJwaboyPz+3aG1llV9kCkPaAcFYkz0pJn6InM0C7P2jG1YQ1zm75wdLEjbi/e5gu+JwFIv/nFKhzPCuFxpdZXbdbk8K3acAAeBp1Ojhl7yMRkeXPGihjrhK4WpX+BMne5arn+8EgbBcZv8LSf/V7c2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001797; c=relaxed/simple;
	bh=XMsOAE6spX7k2h40iXSCcbDa9sJNmEK/Clg0q50v7BU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pMoB4LjGA07WFJqU/zKRHhYLSClQlEEBR7AL875xHHL8mufkELsGCCGlLGEbsIougbaKXYf84Rgh/Ym0mm25nSgEjKGSU3XOoRTgRxMMxOjjfuDsB2ewUOsBIiw/b2zJszWS0EZA/NACVTgLy7zW7s8dm7GPrSPGzIx8iQQsPUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2BkzMqa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2BkzMqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E66C4AF09;
	Wed, 26 Mar 2025 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001797;
	bh=XMsOAE6spX7k2h40iXSCcbDa9sJNmEK/Clg0q50v7BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P2BkzMqaMXxHJSkSG2pcickjKWb/uIWFFzy3wtCu6Uhqh+6rb8rdfKpBQLT8F4n6Z
	 45l0WZBWcgq7pr/TKT6I/5k259oswGCXB5LwQ/vy7j9cLFsvsp03Y0aFlbNLPlKbp6
	 TDZkwxHe8rTHYqkD5PnCkQcbFIDVkbH6FAF+OQoUEVi/QQti+qw7iMmehGR8DJDMkb
	 OQUUfg5Hp7AFYtfVxVu6OM6TqRWLINWzcwiSEQPks0R0R6jtB+grLb6gX0WnkEB+lf
	 ZUe8qAloyLQSnHDKZTtuvc5qhmf9xXU6uJVRCUvsJewDcFGJgqkIc2y7ofEKARu1ry
	 KF89nUwU0fm+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0AA3810901;
	Wed, 26 Mar 2025 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obex: Add supported-features tag in MAP Client Connect
 Request
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174300183377.1347744.4130588837493988066.git-patchwork-notify@kernel.org>
Date: Wed, 26 Mar 2025 15:10:33 +0000
References: <20250320123126.216903-1-quic_amisjain@quicinc.com>
In-Reply-To: <20250320123126.216903-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Mar 2025 18:01:26 +0530 you wrote:
> This change is required for below PTS testcase -
> 
> 1. MAP/MCE/MFB/BV-06-C
> Verify that the MCE sends its MapSupportedFeatures in the OBEX Connect
> request if the MSE declares support for the feature MapSupportedFeatures
> in Connect Request in its SDP record.
> 
> [...]

Here is the summary with links:
  - [v1] obex: Add supported-features tag in MAP Client Connect Request
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f8219bccb485

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


