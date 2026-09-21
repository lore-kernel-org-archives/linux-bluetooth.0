Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE043B2FDB
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001077; cv=none; b=EFr4vw643nax9se4cFboL/bh1H6XYMx3eDwWGE82XR8/Ogg4rqaDJLEhxxGmz129Vhs2F66Ca9EfFwHFDbi9M1s35T/r0ZZVV5wkQDXpMLssQiDDd3kOhz90ANx8IDhE3tRV8aYrwI+TWbL8Mv0Xmk3sHbiYzotKaTWbYrvlVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001077; c=relaxed/simple;
	bh=uO+LSNM3onsPZm6jrXqPd2OLdcyOhcaqOsxDQ0rw/mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mZrBmuIMtgrGJUoDnAfB+/pLT3/w8Q3GH5OYLo8nRm57M7w2lgWAP+KaGutNGWBDXwWXq4tkiBVi9jDvpkBsWuURrqFKuDCbSuEjj4SfyUDgRyKhxvDnsmP6uDJzM6mtLAPjavbCj09dGjzDHAWR3QrMH2cikLJdiYl7WCH+Tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNgWaJX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNgWaJX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7408B1F00898;
	Mon, 21 Sep 2026 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001076;
	bh=MgX3+QAvw0lnjY6mDI8zV3PKFv20kPVLZ4CzU6S9O/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UNgWaJX6ew5kClUx8W0Y6Nihr0FcyupVYMKgPU5+4Iqv/cYVXflwmp+E/A4NBLIP0
	 90DozWGlTFS2UBDL/wY7wvyBUFC0N9XM75U0xdvjtBGGixj+Nqa0UAKOafPrhzWiT+
	 TzULRm4MdlOhmRyrpuC2MZX+bkVT0toH+bVjAHj5lZeGobWXx8+PaoJW3V300NXKmP
	 Wxk3KJcbuBU2iRcpirehrn3sZCthNmjHsZNiGLFn8E5r5YHEaL4f+9G1sKJ85gTWF1
	 3juMS3YGpWwuOHzYry98baI8mdxMCG39pu3FHVlcOAMQbqTsdZRtAFGBDQ0ReQMNl9
	 zqO12m3awOvfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56940392665C;
	Mon, 21 Sep 2026 14:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/5] mgmt-tester: fix test failures + avoid hidden
 skipping
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179000100813.3057876.13874076253271965313.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:30:08 +0000
References: <cover.1789934710.git.pav@iki.fi>
In-Reply-To: <cover.1789934710.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 20 Sep 2026 23:35:08 +0300 you wrote:
> MGMT tests have one failure + 4 hidden failures:
> 
> Load Link Keys - Invalid Parameters 3                Not Run
> Load Long Term Keys - Invalid Parameters 2           Not Run
> Load Long Term Keys - Invalid Parameters 3           Not Run
> Pair Device - Power off 1                            Not Run
> Read Exp Feature - Success                           Failed
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] mgmt-tester: ignore Debug feature in Read Exp Feature tests
    (no matching commit)
  - [BlueZ,2/5] mgmt-tester: Fix expected status for invalid key entries
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=216f85e77b92
  - [BlueZ,3/5] mgmt-tester: mark Pair Device - Power off 1 as fail_tolerant
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3450e588533d
  - [BlueZ,4/5] mgmt-tester: Report unexpected status as test failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9015ae322846
  - [BlueZ,5/5] shared/tester: Count setup failures as test failures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=86dfa8e3b7b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


