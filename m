Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DC4DEC0D
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617891; cv=none; b=DGkBpXu+yF63H7AZW7QMmV8qLs5He6acXhwx23Aj5ueTo5Geh69Tv39QbzDfSaem756qf4DHdRYX8AqzcMs2UdmaQG3oBOIiPrsOv39gjPzEgT9Qmc2EgpVPz8INDjPLmpq08gpdpKOFV7DgIZ86HtROQBU9XqhwbJJeMFv+lmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617891; c=relaxed/simple;
	bh=zqU0w+7kQ251J2y60kqlgUTRVTGLNYqchvdzUtNMUcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hARSkQ37OvPi9tbcK5/dC718llLedltHxZ0/lc7Y81UkWilC3JXlGsx306tkRA6OzUN8JwltSO07cxuyB1zMDIwz5rkwkh3zx+tnTFtm9pQvpPeoLdameSwgPse0N2T9V0uAWCrxDlDIcqu3a6ePQJlI8SIJYcJ5ytmp62X4PxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN3e7DRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN3e7DRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EED1F000FF;
	Mon, 28 Sep 2026 17:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790617889;
	bh=QxiB8r0NbnX7C8vkRRIBTh7SQNhwdtnAeR53BPKIgKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FN3e7DRAv7mViFE2cPJWB7bCEOBSRae5u4hy8Ef0t2bn6Q/0IG41lHnGW0LI4WfzN
	 j5zuf/iD1zokLlgfONwc8DtzOlm0/dlOs7pjtEHEQA22P6Z+BjNSzs+2YP/Xn0NedH
	 s7txrOlVvPg9ZJ9ROvzvOimCjkzjlW4MtvZQZO/XV37MNjgF6LhBRT8oqoBCMrEXjM
	 yp4pln9yp1OCyOINg1QJzg90W2qFaHB5heq0w3PY613h4Rocci3mnNg0K8tYvfY5X5
	 VPxfcBc5yCYCSyGX7sWIQ8Ce7qNxJ53LVrV5bwYjUagVPr6xFXe9tGqDDJUdIz/zrF
	 0ZWfq8J+f957g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A073924A77;
	Mon, 28 Sep 2026 17:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] doc/qualification: Add VCP PICS file
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179061781414.50268.15874789019874240348.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 17:50:14 +0000
References: <20260925124343.3344864-1-frederic.danis@collabora.com>
In-Reply-To: <20260925124343.3344864-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 25 Sep 2026 14:43:42 +0200 you wrote:
> ---
>  doc/qualification/vcp-pics.rst | 462 +++++++++++++++++++++++++++++++++
>  1 file changed, 462 insertions(+)
>  create mode 100644 doc/qualification/vcp-pics.rst

Here is the summary with links:
  - [BlueZ,1/2] doc/qualification: Add VCP PICS file
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f6e495f67bec
  - [BlueZ,2/2] doc/qualification: add VCP PTS tests documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb62c7d5e5f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


