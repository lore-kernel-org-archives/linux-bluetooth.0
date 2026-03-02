Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2538D012
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441981; cv=pass; b=Ild8Mf8gbSheUbcJDxzvQ1+aedJHnaI60f2NcpGxUkYRsjwEv0CJmH+mS7ZMosEujwSuAkhc4wl6KBVKB4s/88nho++mzAqK54eu382CmFz0cdsXPiUrif1u1YI3OihDkIBPW4ieoNyfoieWS9wt/UWX8tOM1jzTi7hsOeARA7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441981; c=relaxed/simple;
	bh=No26Adbjtn/SWk/sC5v6/2geabx6VMZwkde3PaDyloo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PL7LJ9HoCeos/1a61PscZBcRCcGjBtgEAH1yRNW3eoj1Wqa0x1LjxdbJtBHsMDZHHpw6r1l+xvGwARRAYxHD4u7MLlidXBj4EVsQGk951L4PeieS1s3ReyN8IhdOuQ5XE9qumm6uy+FZgF2m2r7UhdmnkStCIDiBzG4vFkrWtxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=gTN0Wkbm; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="gTN0Wkbm"
ARC-Seal: i=1; a=rsa-sha256; t=1772441971; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DtyVsDfLXo80Dj10Da98fi5MwsUXaDPPIByAS8+yuXWypqgPQ+0SsXSu9IzhReyBZIefMgu5CJxobOpWALzM6geigfJkuiKWcjjpk/JcYBWUMYUj1OOEDITduBMPfF62xmeHELWQKc1yvFlxx+1X1tyzJTzIAsUHDUFn4JPybJA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772441971; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=o8o4VXqG7HY2xdh9sykgYKBuRXfJpWOpODKK2EUqQFI=; 
	b=EfzT6jggGWz4nB6SIJNfc7H3X2Rv5yYDaFH9ouSyoBzGY/9Ni0JTsJYQpCOz3cERvO2P/0phDjzVGz96zgpajGezPincq6o3iCn2oKVQr3C7cWSwjeTZQXWZ28975i/nv+74Fl94+OPVzKEiI01PrMlnFIsLt9bVbgugQhY/Lzc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772441971;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=o8o4VXqG7HY2xdh9sykgYKBuRXfJpWOpODKK2EUqQFI=;
	b=gTN0WkbmT1Y2UpKCJ7iNXg8qKpzdQFs1tBvq1HYgwy8OIPbLHWOTW0G45g+6HTn5
	hw2bfDxXV+WLNJqy5+8XUbVJKYmK9vb+OK/U89lTLw/4VeUpIF+Zgdec6aDI1jvMOoB
	dG8fLWRmugKcguuSLjMrYEnxxOr5H355WlBCvNxo=
Received: by mx.zohomail.com with SMTPS id 1772441969985718.5544663801703;
	Mon, 2 Mar 2026 00:59:29 -0800 (PST)
Message-ID: <a79cd039-2e82-472e-bfc5-cb987bf96f6a@collabora.com>
Date: Mon, 2 Mar 2026 09:59:28 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 13/15] doc/qualification: gatt-pts: add description
 for GATT/SR/GAI/BV-02-C
To: Christian Eggers <ceggers@arri.de>, linux-bluetooth@vger.kernel.org
References: <20260227160022.21462-1-ceggers@arri.de>
 <20260227160022.21462-14-ceggers@arri.de>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <20260227160022.21462-14-ceggers@arri.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Christian,

On 27/02/2026 16:53, Christian Eggers wrote:
> Same as for GATT/SR/GAI/BV-01-C
> ---
>   doc/qualification/gatt-pts.rst | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
> index 3959e70ab73d..760d78615970 100644
> --- a/doc/qualification/gatt-pts.rst
> +++ b/doc/qualification/gatt-pts.rst
> @@ -1172,6 +1172,22 @@ for which we know the test passed.
>   |                        |          |         |       |                                                                         |
>   |                        |          |         |       | - [bluetooth]# gatt.register-application                                |
>   +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
> +| GATT/SR/GAI/BV-02-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# advertise on                                             |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       |   - *yes* when asked if primary service                                 |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA read,write           |
> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       |   - enter '1' when prompted                                             |

Shouldn't this be part of a Pre-condition?

> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - Wait until PTS prompts for sending an indication                      |

Instead of "- Wait until PTS prompts for sending a notification" you may 
be use "On PTS request to send a notification:"

> +|                        |          |         |       |                                                                         |
> +|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
> ++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
>   | GATT/SR/GAS/BV-01-C    | PASS     |     6.1 | 5.69  | In a first terminal run 'bluetoothctl':                                 |
>   |                        |          |         |       |                                                                         |
>   |                        |          |         |       | - [bluetooth]# remove <pts_addr>                                        |

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


