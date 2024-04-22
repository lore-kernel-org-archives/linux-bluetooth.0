Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5586D153514
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799829; cv=none; b=KzZ4x4JABtVI0mBWbE9wR3d3AZCJPkHfwXKu3fhERgZ+0VXOchkWxM4/m1tWZvqVACCLbhPjm7BBBoWOV1viF9gZIecz8+x3RtVheNyEgU9QDG1ctWaKfe556GUAj4qNlwvUCNvThxF+6tQsekRB0zwocEbfWSiQYU0vBoNqtb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799829; c=relaxed/simple;
	bh=UdlBIdpn1+IWKVJcMA6w4VmX5cDN11W7O4bRcTM8Dpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PJtJDHeAjQQyIOiZcVg5ZrYhcGEdqFOuiu7g8QJzV1uc1liRrc2MGfXwzTrlI1orArXoMcIaNvWc/o8h9I62bb2hTQZSxzFVD3ReuDf1pYjxNho3hoPinkxuh3Cj5Df4Gecok++zZf1xJh4b3shelBut/Ds+5XzeX4RvkfutoUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds7sZ26q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds7sZ26q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F206BC32781;
	Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799829;
	bh=UdlBIdpn1+IWKVJcMA6w4VmX5cDN11W7O4bRcTM8Dpo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ds7sZ26qDLnE++Ggrnqcln9viY0QKw4xmZMdxzRfXK2WnYsQgKMZbdxbMdlZ7EEWU
	 q023PSGo20yJA7kTsSZA7BDpVS2aSVNnNefnK3HibIT2V5mDk5elneSY9aJDkWayJY
	 pDSXIrmu3Ihp6xSyMgjobMLMGE4vLeX+JYydoCn8f7+H65Fwx8Vd79MKcsG3Rbop3v
	 rIOw6ZkhGyXDl1Ce4qgC36F6ceclWWUdjNgo/wuZVZwpOntLqIZH/ixuzB2A90HRqy
	 yDbJdDNMoe3soa/vqqFh3TmMiBb4oOCIbfBf7bqYVJ6xt7kEvYG5AqXB1/hTx4AvmU
	 i+uE18D1H8qcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E542CC43440;
	Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 RESEND] Bluetooth: hci_conn: Remove a redundant check for
 HFP offload
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171379982893.28518.13465274690527374187.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 15:30:28 +0000
References: <1713797194-22982-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1713797194-22982-1-git-send-email-quic_zijuhu@quicinc.com>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 22 Apr 2024 22:46:34 +0800 you wrote:
> Remove a redundant check !hdev->get_codec_config_data.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  net/bluetooth/hci_conn.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [v1,RESEND] Bluetooth: hci_conn: Remove a redundant check for HFP offload
    https://git.kernel.org/bluetooth/bluetooth-next/c/ebe00bbb01f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


