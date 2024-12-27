Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E251E495;
	Fri, 27 Dec 2024 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735283110; cv=none; b=bsDCQlp8MSlXx3ppp9t1F3/eNRhBqVLgg/w4p6i58m1VZ/HXawoy4FKdLFRQEc1h0xNgeDmUEi05DaWlmeYK1HOA+rmzgvnvxb+hzOBgDvbz+8FzPehiqZ8eLC2jmBvYMUVB0xn5b5tZN+UNdz96KeaufDgAW6c5F3ZiYGj+8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735283110; c=relaxed/simple;
	bh=LqpB3Nrhp8OxuePd6i65Mh1x9lEO0tv5xigYprviJQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZGTFFUrbZ2SARxXzvIFihfzuBEbsT3v8EwdElM+U4v/O5XbYPD6rHVE52a+BfmDSgyqQJ4BCtMpwiici1Nl047k2q66/UEGs8oCzd+gLSy9t9M2j/0agQxrfbk22mSm5VbBHrzLmksVLcooN5j34OMFjW29nSmq0Q8Mq6F39Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT7H3Foy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT7H3Foy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A764C4CED0;
	Fri, 27 Dec 2024 07:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735283110;
	bh=LqpB3Nrhp8OxuePd6i65Mh1x9lEO0tv5xigYprviJQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nT7H3FoyDJjuK8WLoYtirqFCwBOce6JnrTepPXAmaquM2r5wIaMBezd9uwEYlRhJU
	 P4skkRdasBwDTsCocy3gBiofMjoONpFeWGFErJHrCHaPV5pPSSyt+eOl4fbFWnt9jv
	 3gzkigMoXJFk2TxDIWIx/YpiewzZ51C3La4GXaYPD/Wc3u1H2o0e91sx6uOHPAtsxi
	 74WunHKjXQp19pLfBhABNzbzX4D8621eFJv6o1N3Xp3rQIE0O0UNyDwHPMhTQwAA9Y
	 sIOVZF3rd++2DK2ejYoRhLmcIDZ1WPCTbgfdAyEVxJHfrDo71k+G5YBdxY07IQmaUD
	 C3cA5qxuQor/A==
Message-ID: <bfa6c330-6ba0-4361-aa6d-7ab7a61eb7f4@kernel.org>
Date: Fri, 27 Dec 2024 08:05:04 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] dt-bindings: bluetooth: update the wcn6750
 required properties
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com,
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241223135700.22660-1-quic_janathot@quicinc.com>
 <20241223135700.22660-2-quic_janathot@quicinc.com>
 <mzfad53v2paz7cawaepvaqeht2rr5spxyctqrlniiqgyfyyqlv@ixhxcksd3guz>
 <c87b12d2-06cd-4982-838d-ecaa97572369@quicinc.com>
 <31ddcb1f-4606-4c5b-893a-179718ed6339@kernel.org>
 <d7b75672-4885-491c-9797-906261979e15@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <d7b75672-4885-491c-9797-906261979e15@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/12/2024 07:11, Janaki Ramaiah Thota wrote:
> 
> 
> On 12/24/2024 6:57 PM, Krzysztof Kozlowski wrote:
>> On 24/12/2024 12:51, Janaki Ramaiah Thota wrote:
>>>
>>>
>>> On 12/24/2024 2:46 PM, Krzysztof Kozlowski wrote:
>>>> On Mon, Dec 23, 2024 at 07:27:00PM +0530, Janaki Ramaiah Thota wrote:
>>>>
>>>> Subject: everything is an update... say something useful, e.g. use PMU
>>>> abstraction for WCN6750
>>>>
>>>
>>> Sure will correct it in next patch.
>>>
>>>>> Drop the inputs from the host and instead expect the Bluetooth node to
>>>>> consume the outputs of the internal PMU.
>>>>
>>>> On which device?
>>>>
>>>
>>> It is for BT module wcn6750 attached on qcs6490-rb3gen2 board.
>>> will update same on next commit message.
>>>
>>>> But anyway I have doubts this is correct. enable GPIO is a pin going
>>>> from the host, not from PMU.
>>>>
>>>
>>> Yes you are correct, enable GPIO is out pin of host, but here updated
>>> the entries required for Bluetooth node from PMU, not from host to PMU.
>>
>> Hm? No, you removed for example enable-gpios, which is input from the
>> host. Sorry, I don't understand the reason behind this patch and commit
>> msg does not help me there.
>>
> 
> We are migrating to powerseq for the WCN6750. As per Dmitry’s 
> suggestion, we are now using the on-chip PMU, which necessitates the 
> removal of some entries that are not mandatory to avoid binding errors. 
> For example, the enable GPIO is now handled by the PMU with property 
> bt-enable-gpios, as shown in the patch linked below
> https://lore.kernel.org/linux-arm-msm/20241209103455.9675-3-quic_janathot@quicinc.com/
I don't understand why this patch is separate from the others. Entire
context is missing and nothing gets explained in commit msg.

Best regards,
Krzysztof
