Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A8F2E9EDA
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538615; cv=none; b=GEWyb9eGt87eZRsurkxKICdmELUPfH8L1YzJ5HrAJM5EOvIRvQNp1FYbZ5Ye2xLBJGgPmfvHQOPDyueHmHQC8YUAZnFdCRNQnVX9/lJuZojWazZIb+qfLGLcpaTkhaTowEUcuVb+rU+ja9UhBCrtDVzJP707Pmo01awmREgZWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538615; c=relaxed/simple;
	bh=NVnfe/H4jHJdduSpuL+TfiYkmNjRzBN0OqF2JahPg3E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C/W7MBUg7WTMAE9T8fMPYCgnFJQ0+I0o0zLsNGr4HR0HkOLuZUhmk/McfNIx+Oa3swr2suIzmMn6F+ICULhOGjTWj6BRSFVA4MDdwbespbTxUSgCyYjeAb/hGpGS+iRL0sCBjDv+VlAJpsp/ER/XIcILWjay0ornxEqZoarlJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oB3FE4mH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oB3FE4mH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1049C116C6;
	Tue, 27 Jan 2026 18:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769538614;
	bh=NVnfe/H4jHJdduSpuL+TfiYkmNjRzBN0OqF2JahPg3E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oB3FE4mHFwmvFCzzNkFszyPQ0JhDM2FERQW1yTNjJze/f0O79VZaqy8YhMwbshCYG
	 7m7gbAtpx6rznNV7qqp0Wg7CGWxwmMc6UsVzZKEomW4n+S3msK2F/mYWs3nalk25kn
	 izEEZt0sk/95LziXp263SjxDm40jPqV1/3QN1DbsxSdmujE3FoEi54V4XRVJqkZ5VO
	 Z31YNAGjz4xXxKmvs0rwCCplRJJ3xorN5ehieYkFlevM40A/l+8jvs/XhiHVcoFztJ
	 3PeypYIChrW6tywj4K3dwHqmDmUzIuf4D9Ids2pxd0X5RF6WwTUrmiNg4mI5UdmLnh
	 QtABhFOvDTWqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C6A380AA58;
	Tue, 27 Jan 2026 18:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/qualification: Add PICS and howto for the SDP
 qualification
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176953860861.1352702.5838161072961375584.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 18:30:08 +0000
References: <20260127171433.151442-1-frederic.danis@collabora.com>
In-Reply-To: <20260127171433.151442-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 27 Jan 2026 18:14:33 +0100 you wrote:
> ---
>  doc/qualification/sdp-pics.rst | 205 +++++++++++++++++++++++++++++++++
>  doc/qualification/sdp-pts.rst  |  63 ++++++++++
>  2 files changed, 268 insertions(+)
>  create mode 100644 doc/qualification/sdp-pics.rst
>  create mode 100644 doc/qualification/sdp-pts.rst

Here is the summary with links:
  - [BlueZ] doc/qualification: Add PICS and howto for the SDP qualification
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=516b7adfa7a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


