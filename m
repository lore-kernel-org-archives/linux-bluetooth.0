Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74B8C1F;
	Wed,  8 May 2024 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157247; cv=none; b=uXq7/u/PKYxmsrE6dqZfEobT/W1y4Q/ppIlmrreEr+HYYVMi7HnyJLp/Fa3aSJDO4b00u1ojOVAwr4LoXmSg0AFDDdrXP7FQy4/oQZdrxxwl+z61qokSqzJoy3wgWOGr1mGpKZY4AmlZqteMQb/yNQuaVMaXWhJRmHPvBfLf218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157247; c=relaxed/simple;
	bh=eZo0SbgVlDwK+HUbWvKnFU4s6LwJQVx0tiQVgOF+HlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1ZSbDeSABFTcJrFBsDQiuliEQi3C62NY9Crdb8b6i0XfbQ3UctDfDo+/rNo94ErRLazjHwMzwUxZH6nfpr837N2Oi+VQiSlHi/4xUoRmXa18SCxJb+49+5vBhVGo3sIjod11Eb/l9Tf/k1GMO20cP2FuSY9573ipL0kwCmFqUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=fDO6RXd9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="fDO6RXd9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=VYf2x8KePoKCnsFPyEO9iLMDoM/FQ8kORSg9BUE2DME=;
	t=1715157245; x=1715589245; b=fDO6RXd9Bl1JRryVHuQUyunuXDtieEPoINtNl85v07NTRB5
	JHZ7DDU2bP8fy0mdh6B9+WlzTSScxFtuCLfuc93qkreQDLbB79LfhYdkdhgPe8d455Cjl9vfIqHbO
	Ws+NHqyLj/Qde74V4J0KpE8viC8kloEOlZXHDHQjb/p7esysLJ4HyrnDqWZgMxDzXGKbuXudsFIHL
	qyaSmqytYcZMUIdAlvHtWbvmKaBVR2ENxkhmlJPXj5C4B6vtf9t2lFSTe2Lc6f1OZ7L2A512ip42a
	IpipJvwxXK7HFUsIAXoRSlJojU2jpDgkoFXQe8SLBPCw68gl6fuEN9+D6iV1HilQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s4ckO-0007C1-9k; Wed, 08 May 2024 10:33:56 +0200
Message-ID: <0d59ae68-7552-454a-8d01-72c359496901@leemhuis.info>
Date: Wed, 8 May 2024 10:33:55 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] Bluetooth: btusb: Fix the patch for MT7920 the affected
 to MT7921
To: luiz.dentz@gmail.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, sean.wang@mediatek.com,
 deren.Wu@mediatek.com, chris.lu@mediatek.com, aaron.hou@mediatek.com,
 steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 patchwork-bot+bluetooth@kernel.org, Peter Tsao <peter.tsao@mediatek.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240415141922.25055-1-peter.tsao@mediatek.com>
 <171328023414.16225.12939333659144302573.git-patchwork-notify@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <171328023414.16225.12939333659144302573.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715157245;99242499;
X-HE-SMSGID: 1s4ckO-0007C1-9k

On 16.04.24 17:10, patchwork-bot+bluetooth@kernel.org wrote:
> 
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> 
> On Mon, 15 Apr 2024 22:19:22 +0800 you wrote:
>> Because both MT7920 and MT7921 use the same chip ID.
>> We use the 8th bit of fw_flavor to distingush MT7920.
>> The original patch made a mistake to check whole fw_flavor,
>> that makes the condition both true (dev_id == 0x7961 && fw_flavor),
>> and makes MT7921 flow wrong.
>>
>> In this patch, we correct the flow to get the 8th bit value for MT7920.
>> And the patch is verified pass with both MT7920 and MT7921.
>>
>> [...]
> 
> Here is the summary with links:
>   - Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921
>     https://git.kernel.org/bluetooth/bluetooth-next/c/263296438807

Hi! 6.9 is only days close and this is fixing a 6.9 regression, so allow
me to quickly ask: do you still plan to submit this for mainline merge
soon? Or did you already and I just missed it? Ciao, Thorsten
