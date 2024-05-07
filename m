Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FED815EFAF
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092528; cv=none; b=pUhaX/fci7+BQehz7KY34CgkbxK4crp4Aa1xjAxUegRI/e/DtQDLEdgvIzy7sNPydgRcIj862ktLBgdru0XV8gG8b9XeSjWw6g+Vug+unT02fLzGfPEducnwZ4zC3osiDN0NXM3vOm2ZOKvt8ioiSweEUjvqwn3UsShlbHqYMmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092528; c=relaxed/simple;
	bh=erwOvewmY0SswCd0xpRkz2dmOGRizY2jrmSvG6P0KtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcSHCyFT+1Mbe2Kp81eBqrK31cOPpJwxvO4DKHzsV2gu4DNPnrOG4uSdrvbUJGw1o2MWV8qkhX30ZNtkDprRdx7FGNzwz+1a3HTsTlGWT7h6P9pSyPFOzhAHsvnhJ8DLcP7MmYnBCkyd4zQb2nZi76LwfiikDdBUipUSCacy9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OoNeDkgo; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OoNeDkgo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=slaEXbhoM4zWVa/rEBOex/cmRTR5H07TLWbT/yXTKqQ=;
	b=OoNeDkgonpDKsRARdaUblnVMbhAZ0exgP519ON9X9mXIhUEGFGriEikGLAlB/n
	Pcg46g8MVtKE2D+vSae3fz1hBuyqHLwfb/1ddH2KFtsr36U0Gv/sLvRq3hUBLiOT
	si9od2ymm6rUFRvuMSB60V52m5H+Y3o3PlBthTkIY3qr8=
Received: from [192.168.1.20] (unknown [183.195.4.43])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wD3H0zeOzpmIH90BQ--.57314S2;
	Tue, 07 May 2024 22:34:07 +0800 (CST)
Message-ID: <bdf55ed0-f9d9-4e84-90d8-6a788568a371@163.com>
Date: Tue, 7 May 2024 22:34:06 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Wren Turkal <wt@penguintechs.org>, linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
 <08241854-2837-4e8b-ba12-79bcbc970c1b@linaro.org>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <08241854-2837-4e8b-ba12-79bcbc970c1b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3H0zeOzpmIH90BQ--.57314S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF47ZryfWFW3CF4DCw4fGrg_yoW5CF4UpF
	WrCan0krsrXFyIyws2yw40vFWjyw45WFW5JFn8G3yrCr15XF1FqF4fKrW5uryUuwsa93W0
	yFWYqr93KFWvyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jhmi_UUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiyRnXNWV4JDQvGwACsJ

On 2024/5/7 14:27, Krzysztof Kozlowski wrote:
> On 06/05/2024 21:21, Wren Turkal wrote:
>> Krzysztof,
>>
>> I am reaching out to you as you had the most important objections to the 
>> change to fix qca6390 for the warm boot/module reload bug that I am 
>> experiencing.
>>
>> For context, the problem is that the hci_uart module will send specific 
>> vendor specfic commands during shutdown of the hardware under most 
>> situations. These VSCs put the bluetooth device into a non-working state 
>> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
>>
>> Zijun's proposed fix is to not send these commands when it's not 
>> appropriate for the hardware. The vendor commands should be avoided when 
>> the hardware does not have persistent configuration or when the device 
>> is in setup state (indicating that is has never been setup and should 
>> not be sent the VSCs on the shutdown path). This is what Zijun's patch 
>> implements.
>>
>> In addition, Zijun's change removes the influence of both
>> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts 
>> that those flags should not influence the sending of the VSCs in the 
>> shutdown path. If I understand KK's objections properly, this is where 
>> his objection is stemming from. KK, is this correct?
> 
> Yes, because this basically reverts my fix for shutdown path and
> re-opens the race condition.
> 
>>
>> Zijun's proposed fix can be seen here: 
>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
>>
>> I'm wondering if we can resolve this impasse by splitting the change 
>> into two changes, as follows:
>>
>> 1. Change that removes the influence of the QCA_BT_OFF and HCI_RUNNING 
>> flags in the shutdown path.
> 
> There was no explanation why this was removed, so it does not matter to
> me whether this should be separate path or not.
> 
> Zijun, even though I asked four times, did not provide information on
> which kernel this was prepared and tested, and on which hardware.
> 
> I assume Zijun did not understand original issue, thus assumes changing
> the code to HCI_SETUP fixes it.
> 
> 
>> 2. Add the quirk from Zijun's patch that fixes my hardward configuration.
>>
>> I'm hoping that better clearer descriptions for #1 can help get that 
>> landed since the logic current appears to be at odds with how the 
>> hardware works.
>>
>> Also, I am happy to split the patches into the two patches, or (maybe 
>> more ideally) just modify the commit message to better indicate the 
>> reason the change. I just need guidance from maintainers so that 
>> whatever work I do leads to something acceptable for y'all.
>>
>> So, please help me get this done. I am just a user with broken hardware 
>> and a fondness for Linux. I would love to help do what's needed to get 
>> this fix landed.
> 
it seems there are a new below discussion thread for the single patch
https://patchwork.kernel.org/project/bluetooth/patch/1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com/
you maybe go there to discuss.
thanks
> Best regards,
> Krzysztof
> 
> 
> 

