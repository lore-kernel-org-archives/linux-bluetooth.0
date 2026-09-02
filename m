Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE653644A3
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369066; cv=none; b=owy84SoeSAzbYZq/ixyYC3rUDnPhGBa5DdvB4MUV72yIZVrV4u7gzSfVVOEILMH4XJ0a/ZyZwq8P/tkRUx7iZFV2b4tK2KF5MJ7HBpRhx59KQPvs7LuawZswgnooNt7V9VUMgGqsNDPhYLzGqzdJislKUh+ldxKWfxajMIsrFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369066; c=relaxed/simple;
	bh=6Hoe/eEOHPwQo7u7LY3eX+vcDVXVfaDchE+kpqTssBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oooNEVvYFSUIotBZCaWuxvjO2kxrMcpu0clfxySxoZ9o8lFVjvSHQGaFO2yPEDNrxfqy06igkmdAIxuMuamrKTIbD04SkaCbPQfpEC6XNCo8xhhNpegEDgyiSS8TWD9do994Q987AerJjpjEPux3LWzJplo8u2GWcFeecSTqOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL0wvzsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL0wvzsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F22F1F00A3A;
	Wed,  2 Sep 2026 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788369064;
	bh=rq5llXvDqc/43WQjClPsI4+NiIUexL8Ri6L3/oGLk9U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eL0wvzsWI7InPS/iiVhllKN+7meIk5ULa4jBmz/alKhIQwd9FD2Rc/HtSl4HPzU03
	 jsv/2J2TmIyvNtH5/WpAsN3/JJTrGmFlNbuA1tfdWAd4SNuLW5QBIpe30JCSBVFJlk
	 4WBJI8S+b1rZphtgBySgLGXFNMk3X+VNn3OMpKO70UyckJev4nUBiRnDt/uzdMTcvQ
	 2LOZL2trTEwA6VyUqitzBxum93YvujrKyOTHp40GfQ4SZCGt3czy1S/IUGbz9eFnVY
	 I5yftRmS1lQxwZsKbuEdnQzJdZAKmQL4tzMJhVmwKz+Dez9coBIYWOKmvwIp1yywFb
	 aWtEG2/YzVCBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9389F3926655;
	Wed,  2 Sep 2026 17:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/7]  Add ranging provider implementation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178836900639.2851456.8688573882939387333.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 17:10:06 +0000
References: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
In-Reply-To: <20260827052034.1374180-1-naga.akella@oss.qualcomm.com>
To: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com,
 quic_anubhavg@quicinc.com, nakella@qti.qualcomm.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Aug 2026 10:50:27 +0530 you wrote:
> From: Naga Bhavani Akella <nakella@qti.qualcomm.com>
> 
> This series documents and implements the D-Bus API that lets an
> external ranging daemon compute Channel Sounding distance estimates
> from the raw procedure data BlueZ reports, and feed them back for
> reflection on the device's Channel Sounding interface
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/7] doc: Add org.bluez.Ranging1 documentation
    (no matching commit)
  - [BlueZ,v3,2/7] doc: Add org.bluez.RangingProvider1 documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0654aa95ce08
  - [BlueZ,v3,3/7] doc: Add org.bluez.RangingProviderManager1 documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da77259717e4
  - [BlueZ,v3,4/7] doc: Modify bluetoothctl-cs documentation
    (no matching commit)
  - [BlueZ,v3,5/7] src: Add Ranging provider D-Bus API
    (no matching commit)
  - [BlueZ,v3,6/7] client: Add ranging distance display support to bluetoothctl
    (no matching commit)
  - [BlueZ,v3,7/7] test: Add Python Ranging Provider example
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


