Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497DC42B72F
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560052; cv=none; b=lVMgS/QVo0EiXBnkIFHFe5pCSETiAsbe0e1zaORA3iMQM2UH+RKec+i9jq7lQ81HVs3mtBK8kvqNmZh6r/pT1CcGoiy2scT+Wz6lxPavb4Z+CJyV2iYFsEImhXUlUTpJzGi0bB/LKbJ6cDw+sSwLkD+kBvM135eD89gCQpPXnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560052; c=relaxed/simple;
	bh=nUolHK13g1lFE2wET5U+1K8rBphplL1DuCGDL0zeMbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qyC6JPqk0A7EtCMvrr5Xz/6i9ixC6nSbRVXCjKUtFI7jXiXEhkvaM2fVFtY1mXHCMHa/0W+kcIWxVhl7dHnz5GI6dJFFifJEkXLj0JAA+hxFVR06A4+NSiSuOQ5oq0AIUYKS/3MdVfrcOPIn/5n/geu1oISX006FJd+p3q0ykeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2NRFD1b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2NRFD1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FB3C2BCB3;
	Thu, 30 Apr 2026 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560051;
	bh=nUolHK13g1lFE2wET5U+1K8rBphplL1DuCGDL0zeMbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P2NRFD1b4fQFvTYpLo0cIdwg7QlUlRKacwOsWE9ZmMq8pGBSuMChM4RvxfrYQkuIG
	 GjMhGiSzHKo1TsWexOGVSyJxieiL4PiLcoJfmyzCTyOQ7vW6TSyfKcgL6LvlUJwd+N
	 L8oaFEDZ61WGl9QRabu7XRMAts4j4CE9avHloEZyLQ8yrifCSAFijIH711kLWcz0wD
	 Zl/3X+GDi0rOZeJEyGDCXny0dJzY5BR+cDkfkbQy+wg7vxppATEvvocBA+BNBv4Mf6
	 FpdBxH5DCzJgssJwRjh6vaZhI532NqVVjzEUgFuNZxfIwqZr76IUzeT7SE8fNihJ2h
	 +RlJ9lm/3/MuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DD7380AA5D;
	Thu, 30 Apr 2026 14:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v7 0/3] Add RAS Packet format and Notification
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177756000630.3037252.7738479074577474130.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 14:40:06 +0000
References: <20260430074142.3599484-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260430074142.3599484-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Apr 2026 13:11:39 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Changes in v7:
> src/shared:
>  Replace pointer operations to util_iov operations
>  Club ranging counter and config id into one field
>  Add helper functions for ranging counter and config id
> 
> [...]

Here is the summary with links:
  - [BlueZ,v7,1/3] src/shared: Add RAS packet format and notification support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a9b39d71597d
  - [BlueZ,v7,3/3] profiles/ranging: Read cs_mode_one_data members
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d4792dc2a20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


