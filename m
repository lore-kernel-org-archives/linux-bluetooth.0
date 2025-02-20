Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6301EFFA4;
	Thu, 20 Feb 2025 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051927; cv=none; b=kHTd9iNRCmV0TZ4XlmPvrAAFtN/sYl9uoZnOwHWY73kLsX6kaong46Mhedlj8kXzQFqKE3vNjfXo5mbs8bG+HikKWWI9tFDzBIyX037+sr3AFQFi+RrEc28eX/70tWTeljBIZrFhfoOK9dQ203UH5FWgt6qpJB/ZpexPc5R5xuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051927; c=relaxed/simple;
	bh=2EEW45Yj8xi2tZwxxOWNkFYSQ4lVAi8o8LQZMo4zddc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxUlMe8Ye5wAVtAGZHyIqSrr86S+YM761enrCokthufrS3aYQFdPGxX/hhcXLEvMJkNDQH4Dgz0lWyzkJgf6w0+7pxakiBYfPfNbbzVmQ7pw++ZYBdr4BHdlhxCb5AqvFnK12kYmgXoBHdQVcC8hvLjYU0EJU+56lbynfTB7gP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4d1.dynamic.kabel-deutschland.de [95.90.244.209])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 03CC261E6478A;
	Thu, 20 Feb 2025 12:45:04 +0100 (CET)
Message-ID: <184919f9-25bd-4f65-9ed9-dc452a6f4418@molgen.mpg.de>
Date: Thu, 20 Feb 2025 12:45:03 +0100
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
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com, ziniu.wang_1@nxp.com,
 johan.korsnes@remarkable.no, kristian.krohn@remarkable.no,
 manjeet.gupta@nxp.com
References: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Neeraj,


Thank you for your patch.


Am 20.02.25 um 12:41 schrieb Neeraj Sanjay Kale:
> Allow user to set custom BD address for NXP chipsets.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v2: Add allOf and unevaluatedProperties: false (Krzysztof)
> v3: Drop local-bd-address: true (Krzysztof)
> ---
>   .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index 0a2d7baf5db3..a84c1c21b024 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -17,6 +17,9 @@ description:
>   maintainers:
>     - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
>   
> +allOf:
> +  - $ref: bluetooth-controller.yaml#
> +
>   properties:
>     compatible:
>       enum:
> @@ -43,7 +46,7 @@ properties:
>   required:
>     - compatible
>   
> -additionalProperties: false
> +unevaluatedProperties: false

How is this diff related to the change mentioned in the commit message?

>   
>   examples:
>     - |
> @@ -54,5 +57,6 @@ examples:
>               fw-init-baudrate = <3000000>;
>               firmware-name = "uartuart8987_bt_v0.bin";
>               device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
> +            local-bd-address = [66 55 44 33 22 11];
>           };
>       };


Kind regards,

Paul
