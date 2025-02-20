Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96601F4626;
	Thu, 20 Feb 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053519; cv=none; b=ceYiEFxe9ZBAju0ci9xd7XzT2T7hA1RP3OSp2a2DUS1VpQ20nd+jt6p8OJYHwp+MyqjzFLLl5zO+2gHhedc8BFeWRyS0Gl3n8/AEYX7W15sL0ybOMEiPU4AS1IoHvCkNMdldy2FguRJZ5qeOs2ZTPM8rt6kFhF93h8vi3yJGOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053519; c=relaxed/simple;
	bh=H5E5SeieaLpNYPhpuYc6b4Ta1whQtBEq0NatzVE9X6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHswvRHOcTdYCRZrCn79GpQuYtCe5ASpgC3kMtzz5q71ow72O8+D9hgZNPvArq9WsKoPIGGkIK2DjRXdSQTIK8ZezxhEa+hpp8S9fX9QohN8LYcBQvH1rO7AmqOPCgGVCmeCAoFKTqTygFirGJjFb4zj3TpuUVwMPrgxgZVNDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4d1.dynamic.kabel-deutschland.de [95.90.244.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3FDE061E6478A;
	Thu, 20 Feb 2025 13:11:42 +0100 (CET)
Message-ID: <0e5f23a9-b1d7-4d8c-bb05-83f7a15a7285@molgen.mpg.de>
Date: Thu, 20 Feb 2025 13:11:41 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: net: bluetooth: nxp: Add support to
 set BD address
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, Conor Dooley <conor+dt@kernel.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
 Sherry Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>,
 johan.korsnes@remarkable.no, kristian.krohn@remarkable.no,
 Manjeet Gupta <manjeet.gupta@nxp.com>
References: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
 <184919f9-25bd-4f65-9ed9-dc452a6f4418@molgen.mpg.de>
 <AS4PR04MB96921164DAA8A63B2C0841AAE7C42@AS4PR04MB9692.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <AS4PR04MB96921164DAA8A63B2C0841AAE7C42@AS4PR04MB9692.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Neeraj,


Thank you for your prompt reply.

Am 20.02.25 um 12:59 schrieb Neeraj Sanjay Kale:

>> Am 20.02.25 um 12:41 schrieb Neeraj Sanjay Kale:
>>> Allow user to set custom BD address for NXP chipsets.
>>>
>>> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>> v2: Add allOf and unevaluatedProperties: false (Krzysztof)
>>> v3: Drop local-bd-address: true (Krzysztof)
>>> ---
>>>    .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
>> b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
>>> index 0a2d7baf5db3..a84c1c21b024 100644
>>> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
>>> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
>>> @@ -17,6 +17,9 @@ description:
>>>    maintainers:
>>>      - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
>>>
>>> +allOf:
>>> +  - $ref: bluetooth-controller.yaml#
>>> +
>>>    properties:
>>>      compatible:
>>>        enum:
>>> @@ -43,7 +46,7 @@ properties:
>>>    required:
>>>      - compatible
>>>
>>> -additionalProperties: false
>>> +unevaluatedProperties: false
>>
>> How is this diff related to the change mentioned in the commit message?
> 
> This is based on review comment from Krzysztof in V1 DT patch.
> allOf ref will import all properties defined in bluetooth-controller.yaml, including local-bd-address:
> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml#L18

Thank you. I’d include this in the commit message, but my comment was 
about the replacement of `additionalProperties` by `unevaluatedProperties`.

>>>
>>>    examples:
>>>      - |
>>> @@ -54,5 +57,6 @@ examples:
>>>                fw-init-baudrate = <3000000>;
>>>                firmware-name = "uartuart8987_bt_v0.bin";
>>>                device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
>>> +            local-bd-address = [66 55 44 33 22 11];
>>>            };
>>>        };

Kind regards,

Paul
