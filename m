Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5DF153BD9
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551989; cv=none; b=s7s4s9VPF0I63UuroF5pyLvWeWbqJbSEba1kCTLG/i+AxibGzCGV1u/gSK32DKGaZlRwkoVsnJKYCL/kym+10wXdLmH0E+c2hW9mMhfaAdIsRbLhfOqPT9Le5tetlsohyft1mEBLnyUletFJiTJ8Siub31oCxy/w0LQdIfXlIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551989; c=relaxed/simple;
	bh=dl55DUbR5wdXMCxECyP+is/5x+3XiBAtIrYKIBDjUBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tkn9MTo7fuk85j9DP67LXjCDS9pOcdzFcw6yuslM6Om/qwgBE8DxkByl0oJ+ez2L/cVh6u2ntdUrgGrvCIKbjas/gsVRxCsII/kku/yXg/IMBW7mv6riGoSm4C22nqw95ekuAbvWkEOi+32GaqzO3useaQUnyleheQCYG94Z2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuVZgWZn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuVZgWZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5DBC4CEE4;
	Tue,  6 May 2025 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746551989;
	bh=dl55DUbR5wdXMCxECyP+is/5x+3XiBAtIrYKIBDjUBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NuVZgWZnRCtv2mdFFPplj+rUMHcnAkZIrTLbwDdPdRAa9NOQQkoXCfY6PebdbTE2J
	 57+8EaGW5OrcxrcsFw0VkDkt3P6FQWtAr86Xa0dCpqAPNZ6Qf+hRtRVobzryr7BfTZ
	 xgSR7Xd3TS/sjnpL9kBfQi5xs+8/6zfI7dlRC2BH1g2Yh3pI2PJfQKvfiP79jGvsvw
	 lmdL35rdyxUwF6sgrpdAcAc9Lb3nDLQchFmiELG3043F9avurt6iR3kgHJLiESQxqf
	 +GA5xIij4smbOe4hc6Wq9o7YfYdOe2R9qEWao4T2wStodBcjABhrUNN4ekwX9YFLYq
	 cJCrVheFgBc3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E06380CFD7;
	Tue,  6 May 2025 17:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH BlueZ v2 01/11] org.bluez.MediaEndpoint: removing BAP
 streams with ClearConfiguration
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174655202825.1596695.2381881115928395394.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 17:20:28 +0000
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  4 May 2025 19:01:53 +0300 you wrote:
> Allow user to remove specific streams by calling
> ClearConfiguration(transport_path) on the endpoint.  If the path is the
> endpoint path instead, clear all streams associated with the endpoint.
> ---
> 
> Notes:
>     Whole patch series:
> 
> [...]

Here is the summary with links:
  - [RFC,BlueZ,v2,01/11] org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=63b07d1cb639
  - [RFC,BlueZ,v2,02/11] org.bluez.MediaEndpoint: add client role Reconfigure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d0f178974f8
  - [RFC,BlueZ,v2,03/11] shared/bap: bap_abort_stream_req() should cancel also current req
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=62f0b9b539bc
  - [RFC,BlueZ,v2,04/11] shared/bap: fix ucast client ASE usage
    (no matching commit)
  - [RFC,BlueZ,v2,05/11] bap: discard stream when no longer in use
    (no matching commit)
  - [RFC,BlueZ,v2,06/11] bap: do not try QoS before links are updated & io created
    (no matching commit)
  - [RFC,BlueZ,v2,07/11] bap: add ready callback for setup configuration
    (no matching commit)
  - [RFC,BlueZ,v2,08/11] bap: support removing streams with ClearConfiguration()
    (no matching commit)
  - [RFC,BlueZ,v2,09/11] bap: add callback at the end of ucast client select/config
    (no matching commit)
  - [RFC,BlueZ,v2,10/11] bap: implement Reconfigure()
    (no matching commit)
  - [RFC,BlueZ,v2,11/11] bap: delay recreating IO after ongoing configuration
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


