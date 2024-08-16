Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1D137923;
	Fri, 16 Aug 2024 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797173; cv=none; b=emAqhKxrndocqWHhG3Nuljgfhqyyig+jymW64uZunFEL4GtT0Qq/zWRnKA3Uo6E9uwGwxzQCaAsieixC3OHFGG/Nrnb8+e1soz+jP0PyBbDGz4hG07OZefXgZyDCQj7sGwTxHrcZT9DVRiUW1S3t3n6nBuop53XZZ1mlJKId9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797173; c=relaxed/simple;
	bh=zvoRoj67iI2jVCgaAAnl5Nf42IVbkNhBjs4gGc3zs7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AloJ7aGb+EUr1bl+eX21059Kk5C8AXjr0kBd7B/gcRTIkwewpymOOxjPSAXhLaotzhnvG0fvlx5GXdjAKUyA+4c4CSLFJBKsDxdVs0w7BEtv4XLEmKE5tViEXlegTV9uEA7yh+D93LjtTgK7YTT6gDwdynHXVkb7/tmuHGnnBeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af443.dynamic.kabel-deutschland.de [95.90.244.67])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8115E61E5FE05;
	Fri, 16 Aug 2024 10:32:30 +0200 (CEST)
Message-ID: <cd418c7c-20bd-4e6d-8e4c-4bbb1f49c8cb@molgen.mpg.de>
Date: Fri, 16 Aug 2024 10:32:29 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for ISO packets
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com
References: <20240816082524.286245-1-neeraj.sanjaykale@nxp.com>
 <20240816082524.286245-2-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240816082524.286245-2-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Neeraj,


Thank you for your patch.


Am 16.08.24 um 10:25 schrieb Neeraj Sanjay Kale:
> This enables btnxpuart driver to handle ISO packets.

Tested how?

> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>   drivers/bluetooth/btnxpuart.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index f75b24bd3045..0b52e5505687 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1396,6 +1396,7 @@ static const struct h4_recv_pkt nxp_recv_pkts[] = {
>   	{ H4_RECV_ACL,          .recv = hci_recv_frame },
>   	{ H4_RECV_SCO,          .recv = hci_recv_frame },
>   	{ H4_RECV_EVENT,        .recv = hci_recv_frame },
> +	{ H4_RECV_ISO,		.recv = hci_recv_frame },
>   	{ NXP_RECV_CHIP_VER_V1, .recv = nxp_recv_chip_ver_v1 },
>   	{ NXP_RECV_FW_REQ_V1,   .recv = nxp_recv_fw_req_v1 },
>   	{ NXP_RECV_CHIP_VER_V3, .recv = nxp_recv_chip_ver_v3 },


Kind regards,

Paul
