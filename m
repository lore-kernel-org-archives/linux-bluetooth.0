Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD1749A;
	Sun,  6 Oct 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728214389; cv=none; b=BpU4BLjYFesQZb39agYM6TBxwpR4PIUXTtsvAe4QAu4EXiCS6OGm6SXwVDyVntjR2igbLBvRgfiyilg2jMzbYNxANSh5CzxL7ta7H8sasuqnfVE1rgNqqV07M6eGsiyqh9Jm5iEurB0qGpA4DsFKnrFlNuU55qjc+qyDnzu8HlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728214389; c=relaxed/simple;
	bh=ZICSkUBYeMZu29N/modjDAZ4GFu4V0bbMg9/g8AetzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lk8ZrXHT25wGKC0em66RoIJXe+Q0tHuy1u9uR2Av6cC6j6hbkQe/fntgJQKATGuP/9ndzfoUN3DrBLyYBQJfOnHeVJdCB26IXkWlPa7id70rV42/+nrOPHv8kjxPU0tunrD9B9qAkPWALawA/yTSoyY5DTWeE3vqf/CzlBeWHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1HDQKCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1HDQKCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DFDC4CEC5;
	Sun,  6 Oct 2024 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728214389;
	bh=ZICSkUBYeMZu29N/modjDAZ4GFu4V0bbMg9/g8AetzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B1HDQKCEYBdm1jb77/l6hRmJwxRrVwpL0njdi9h07MiW02Utrlqf0lwtBM4iEZ8cA
	 tikEeoE03+PUxo6l/QqNxLqhrvQelaPo9G2YqQSqwJCFjAQNDLus6RiGHdFUB3dByL
	 F+LOwKyidNxzAZjo8v3gmGRekYp9FSat7gK5zb0uLXgiEpwLYhvV+ozHg7CM6MoJOw
	 DL0Ib4GCSX1x+3mKHp/3pjra3s1zUdB0ziLUDSUu/UkTIbMPuZTE2LGGCwtHD5ELMW
	 3QLRvyVr9q5aoYLvG3HB+b8SAeeYYqYf/WLzy9hdA1eGiMnefeLWxHde//Ik81hWvo
	 IEZyNxYeNq9DA==
Message-ID: <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
Date: Sun, 6 Oct 2024 13:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
To: Sherry Sun <sherry.sun@nxp.com>,
 Catalin Popescu <catalin.popescu@leica-geosystems.com>,
 Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
 "bsp-development.geo@leica-geosystems.com"
 <bsp-development.geo@leica-geosystems.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/10/2024 10:49, Sherry Sun wrote:
> 
> 
>> -----Original Message-----
>> From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
>> Sent: Friday, October 4, 2024 7:36 PM
>> To: Amitkumar Karwar <amitkumar.karwar@nxp.com>; Neeraj Sanjay Kale
>> <neeraj.sanjaykale@nxp.com>; marcel@holtmann.org;
>> luiz.dentz@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
>> conor+dt@kernel.org; p.zabel@pengutronix.de
>> Cc: linux-bluetooth@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; m.felsch@pengutronix.de; bsp-
>> development.geo@leica-geosystems.com; Catalin Popescu
>> <catalin.popescu@leica-geosystems.com>
>> Subject: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for supply
>> and reset
>>
>> Add support for chip power supply and chip reset/powerdown.
>>
>> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
>> ---
>>  .../bindings/net/bluetooth/nxp,88w8987-bt.yaml        | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
>> bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
>> bt.yaml
>> index 37a65badb448..8520b3812bd2 100644
>> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
>> bt.yaml
>> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-
>> bt.yaml
>> @@ -34,6 +34,14 @@ properties:
>>    firmware-name:
>>      maxItems: 1
>>
>> +  vcc-supply:
>> +    description:
>> +      phandle of the regulator that provides the supply voltage.
>> +
>> +  reset-gpios:
>> +    description:
>> +      Chip powerdown/reset signal (PDn).
>> +
> 
> Hi Catalin,
> 
> For NXP WIFI/BT chip, WIFI and BT share the one PDn pin, which means that both wifi and BT controller will be powered on and off at the same time.
> Taking the M.2 NXP WIFI/BT module as an example, pin56(W_DISABLE1) is connected to the WIFI/BT chip PDn pin, we has already controlled this pin in the corresponding PCIe/SDIO controller dts nodes.
> It is not clear to me what exactly pins for vcc-supply and reset-gpios you describing here. Can you help understand the corresponding pins on M.2 interface as an example? Thanks.

Please wrap your replies.

It seems you need power sequencing just like Bartosz did for Qualcomm WCN.


Best regards,
Krzysztof

