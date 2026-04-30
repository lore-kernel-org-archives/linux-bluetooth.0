Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25542DFE8
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560057; cv=none; b=dWiZL+8FgfXEml0botImL8u6jLD4rJZrpzrovspjuqFtLNu4JCrhTbDSplEH5462rAPGGo+MO9DW+hhqkMKMi17OkTv3JrxA30UbYmjuw9X2yfgGFYDhxzfr3PyDINv2/QbgADOYHO22i4LAr+aiL6XZhbayy+iV3jx5llEkCh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560057; c=relaxed/simple;
	bh=gtJSh/2GKhD9Hv0frftcKHAbvaO7QBEQBBVXmoM8Jcc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NvUzjAH4OxIttpE/uRbxEHRp+QA1YJ25bJrLf0GVgBsRKB82dCxAwS6bdjS5B/fNj9USk5LhvWQWRir40xa2xu6PLiZ6zqwOgTapY9Th+W2h9h+kF7loYBsiEkfQ77DK6x2jz0kdvIWfDFnAkG65wYWCy+xTmvVxH5m+GwKH6dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SluS4cuq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SluS4cuq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAEEC2BCB3;
	Thu, 30 Apr 2026 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560057;
	bh=gtJSh/2GKhD9Hv0frftcKHAbvaO7QBEQBBVXmoM8Jcc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SluS4cuqw4BiYoPRA8wQMYKRWcVcX8rR3K6hUSenEhrZW54pviL2yEjo4H58GlwTi
	 Ae2cAyDO7okpVR5LY36SckvqdeUbG2K6jyPSLmPy3zIk3sDcxYIQqywGjk739JBGVl
	 tJTX2lK2o068b4OWP0jFHL4dDhyVRO+HRxTnugOmaE5Zy7MxDCwdb3Lf4rD88fLKoO
	 Z2BYZWbP+PSij9vAvJJqXDe8bRN7P8Y7y/olW8K+BZJdVjhUMi0vhM18OgtAKrQEkK
	 xKLiHuZ8J3+OHbLg3Y/q+k+p9nUgCEe/ScDCsUaWh+rHSuGWjPin/Zsu7sUcdhfYZV
	 h7L9F+gVi//SQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCE7380AA5D;
	Thu, 30 Apr 2026 14:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v6 0/3] Add RAS Packet format and Notification
 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177756001204.3037252.17112478516916808088.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 14:40:12 +0000
References: <20260429152942.2940978-1-prathm@qti.qualcomm.com>
In-Reply-To: <20260429152942.2940978-1-prathm@qti.qualcomm.com>
To: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Apr 2026 20:59:39 +0530 you wrote:
> From: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
> 
> Changes in v6:
> src/shared:
>  Removed 5 separate CCC write callbacks
>  Added unified ras_ranging_data_ccc_write_cb for Real-time and On-demand
>  Removed unused macros
>  refactored CS mode processing into separate functions
>  Improved iov_prepend_bytes - use realloc/memmove instead of malloc/memcpy
> unit/test-rap:
>  Added RAS/SR/SPE/BI-11-C test case for mutual exclusivity validation
> 
> [...]

Here is the summary with links:
  - [BlueZ,v6,1/3] src/shared: Add RAS packet format and notification support
    (no matching commit)
  - [BlueZ,v6,3/3] profiles/ranging: Read cs_mode_one_data members
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d4792dc2a20

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


