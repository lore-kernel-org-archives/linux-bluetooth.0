Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B16B43D51D
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705415; cv=none; b=Ry9LzaWkOsDhMTOAoLfc3f7XU0+JGje+IJTg6Qh0VvtU8uWEvmkrbYCNu7tb6XS4d4ZPxN2wd+atE0UZkGpm/TUbRljymyNbcHZzjtMZudr5TNmaE3gsK8o3hRN9guUxMzMd7onVt49wJgL5EaQ6kMU4kVQ0e/gsWKjKyqISMz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705415; c=relaxed/simple;
	bh=6OlNoFJ/zG7TbREBjgVW5k8mbkj1Mh2ED2L+Od8bTMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jsrbVviGXSnK8ymg0sE3kZUEi7mH9vJ43I/W64Ps9Lt0iVRMS+VBIeaX0X3xYy+hFhqEyrkfiVYHvJFsc5jUs5SAZwWV3rBCulGBoKr5vNVNhesALSXRu8C3of9XhLJCz2FR3uIkZoZA8+U094/KTVY6iHfpRg8bLhytoE8fTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uqm7dfuT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uqm7dfuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C150A1F00A3A;
	Wed, 17 Jun 2026 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781705410;
	bh=O+W+SyOgN+N5XqP3k4TSnRvbcy2nWbSV9ubcNXgHttg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Uqm7dfuT0vJmklyDiUZ+i66Ew5zDzEIRc1WVaO+Ld1plorvYs8JHsigL4GzuawYMN
	 R6uBIRdzvqoZYJXe7lZQmauno7Zigxlq2+YwwK43owkCsFyt3jPNqpCvtUeZHXpesE
	 TKMDxigyI27AXfYK1ubMfoe2JCGdK5sX0w8d5YiJeHGj0Py7cVcm+VTVYjpvoCdpWP
	 FQey8I/SBgaebze1d2WhSPzvSyORvOQMjbT/yihrnNkm+DsBjBUI4fnDsqMW0JCVCd
	 4qeVfWuqGtBRJUqKsfq2rUQKraoDWjfwzElAHm1uHPvah7lD0FFOKyaX8alsftEcVw
	 K3dEPl9vPcFQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197753930E39;
	Wed, 17 Jun 2026 14:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/3]  Initial Channel Sounding Support for
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178170540489.1639014.10013641284877443306.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jun 2026 14:10:04 +0000
References: <20260616072245.3700010-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260616072245.3700010-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Jun 2026 12:52:42 +0530 you wrote:
> This series adds initial LE Channel Sounding (CS) Initiator support by
> introducing the required HCI command flow and event handling for CS
> procedures.
> 
> The changes include
> 1. Adding an is_central parameter to validate that
> current local role is central before issuing
> HCI_LE_CS_Security_Enable command.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/3] shared: rap: Check role before sending CS Sec Enable cmd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=efa2a66a7964
  - [BlueZ,v4,2/3] profiles: ranging: Add CS Initiator cmd and evt handling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=20cc88874d57
  - [BlueZ,v4,3/3] shared: rap: remove the old wrapper API
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=629b788e11b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


