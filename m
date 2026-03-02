Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2038CFE1
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441941; cv=pass; b=YcbieOgPrt9gpT3Xe12W74i1sMq2LA4u17UK6BPOSCLG3FWeLTpGOmmdn/BgTsx7l9M+b7Xvq7GbBb1sPcd/t843z9G2Eu0yucTDVIA+UY80DWx1WSoiws/UdJKZxwtW31bLpRhQA+oe/glwr0YKEMLcXgZmSj6iqu7HFWlMOB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441941; c=relaxed/simple;
	bh=TDPYbz/Gwrh/xFVXYLwJNhJ/VsSgqz+VqYWfnwEr0bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dImdSP4yhziWG03cARzM3Ur0TzmZB9WgLcIfz6dlCAXTQCdLuA6dAAkLciHDht4sWX3ijatjeInnbcLpTkRG53lvWhQY9Hcn9Iqy0apPgIIX4AQj3JeXK9tSaEWrWq6wvFqp6+BJ/o5rdoGCCUNkM02Qo8qd9RkTa+nvRNhpHiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=TFoVNsVI; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="TFoVNsVI"
ARC-Seal: i=1; a=rsa-sha256; t=1772441929; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mx2/oe1JpBSKAFPGOp72y87R3SmCsGwmeZySxIJRuFKBvfOytcL6ogwznpPwMBeyZ5G1z8NNk/dI/bof10a57bRqDR57CtwteCGUrP+VkqSnUhkR9QF2BMZaGLtBXmVuDbVgtVPNmP1o/1dnTd0NAvoRcTB2G1pNgGI60c2nb0I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772441929; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Of35+XTLPOzcNnStm6qeuqRMfY0wG1xzvDmezhD61BQ=; 
	b=aVMSQBxewaAU5hF6Om/UZ27CNa+JWjYYgxYqZB+/LGsf3vEFY6poBbiIFIm/E8t/hMj3n5cYsiBUAsZ9gMD5mdbypdneSUQbk0CW1DHoTCzEynTTD7UNx4uQMtlRF89PZY9Lztkdty4puI5OQMShH1b+XRWdhhuujPF5q4F8gPE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772441929;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Of35+XTLPOzcNnStm6qeuqRMfY0wG1xzvDmezhD61BQ=;
	b=TFoVNsVIS967czyGIsRqWLs5fZElGejbJfr0Y5JoysjY727SS2rbGp7RiopJ92fj
	Fc4PSCQL6F3dF1iiZ01Opu7A1My0CNylrUpIQSpNrifbX5ng7t9FJBXvOOQleNWSozR
	3h2OiO/22xmHWIpzywa6EYf5r/W1XFDd10V4cBm8=
Received: by mx.zohomail.com with SMTPS id 1772441927171468.50177784562015;
	Mon, 2 Mar 2026 00:58:47 -0800 (PST)
Message-ID: <e4b02d13-4992-4aaa-8631-856fa2b4812f@collabora.com>
Date: Mon, 2 Mar 2026 09:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 10/15] doc/qualification: gatt-pts: update
 description for GATT/SR/GAN/BV-01-C
To: Christian Eggers <ceggers@arri.de>, linux-bluetooth@vger.kernel.org
References: <20260227160022.21462-1-ceggers@arri.de>
 <20260227160022.21462-11-ceggers@arri.de>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <20260227160022.21462-11-ceggers@arri.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Christian,

On 27/02/2026 16:53, Christian Eggers wrote:
> 'btgatt-server' exits after PTS disconnects and is not available when
> PTS reconnects. Starting btgatt-server again would solve the problem,
> but we should prefer testing with the real GATT daemon instead of using
> debugging containers. Additionally, this solution also works for
> GATT/SR/GAN/BV-03-C (next commit).
> ---
>   doc/qualification/gatt-pts.rst | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
> index 239d7c154da7..7a2f28257338 100644
> --- a/doc/qualification/gatt-pts.rst
> +++ b/doc/qualification/gatt-pts.rst
> @@ -1116,9 +1116,25 @@ for which we know the test passed.
>   |                        |          |         |       |                                                                         |
>   |                        |          |         |       | Enter '2' when asked for handle size                                    |
>   +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
> -| GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
> +| GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
>   |                        |          |         |       |                                                                         |
> -|                        |          |         |       | Run 'btgatt-server -r'                                                  |
> +|                        |          |         |       | - [bluetooth]# advertise on                                             |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       |   - *yes* when asked if primary service                                 |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA write,notify         |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       |   - enter '1' when prompted                                             |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# gatt.select-attribute local 0xAAAA                       |

Shouldn't this be part of a Pre-condition?

> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - Wait until PTS prompts for sending a notification                     |

Instead of "- Wait until PTS prompts for sending a notification" you may 
be use "On PTS request to send a notification:"

> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
>   +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
>   | GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
>   |                        |          |         |       |                                                                         |

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


