Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F0280C1C
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754731475; cv=none; b=qCD7FcZ0MxWGzEA2HBr2cAh+qprJgThq9jAGtqZ/IMkIRo4ZdiXGhRr7iZW+PhzKCWM9ArzMzcuqN1Kc06NXvEc8a4FY4Luwhp/pATtKzQFApglqqjyDWys5qPrLVIYKsimOPwWwnq0TTrkh25OgVX4vvLNdB5HvWxfmlboAQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754731475; c=relaxed/simple;
	bh=J+IPD8F7pLz54rxXf3CGORL5SiUBcKNoV1u1wr9WJWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=jltgf6xewBCDK2dwbmRMeQ0MsK80jtvef1vtlr3Lhu5Bl4lLjtEN32wqYOfuUA9lOQ8VT0g5vWoFYHZlFToK8FA3gMcKPzSrMEu9rum20LHL5Z4TLiroU/WHJ/WHjymdeIa7JwniKs60sF9x+X64dHZebg6PWWKOuUTsrqZba0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7a9.dynamic.kabel-deutschland.de [95.90.247.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3E65261E647B7;
	Sat, 09 Aug 2025 11:24:20 +0200 (CEST)
Message-ID: <f0ec9c48-39ae-4ab2-b62f-f688dd16f3bf@molgen.mpg.de>
Date: Sat, 9 Aug 2025 11:24:19 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_event: fix MTU for BN == 0 in CIS
 Established
To: Pauli Virtanen <pav@iki.fi>
References: <cc0cd5d3cd7ed9b081b60f34f97ed9c39a820935.1754728503.git.pav@iki.fi>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <cc0cd5d3cd7ed9b081b60f34f97ed9c39a820935.1754728503.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pauli,


Thank you for the patch.

Am 09.08.25 um 10:36 schrieb Pauli Virtanen:
> BN == 0x00 in CIS Established means no isochronous data for the
> corresponding direction (Core v6.1 pp. 2394). In this case SDU MTU
> should be 0.
> 
> However, the specification does not say the Max_PDU_C_To_P or P_To_C are
> then zero.  Intel AX210 in Framed CIS mode sets nonzero Max_PDU for
> direction with zero BN.  This causes failure later when we try to LE
> Setup ISO Data Path for disabled direction, which is disallowed (Core
> v6.1 pp. 2750).
> 
> Fix by setting SDU MTU to 0 if BN == 0.

Do you have command how to reproduce this on the device?

> Fixes: 2be22f1941d5f ("Bluetooth: hci_event: Fix parsing of CIS Established Event")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>   net/bluetooth/hci_event.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 4f0a6116291e..fe7cdd67ad2a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6745,8 +6745,8 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
>   		qos->ucast.out.latency =
>   			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
>   					  1000);
> -		qos->ucast.in.sdu = le16_to_cpu(ev->c_mtu);
> -		qos->ucast.out.sdu = le16_to_cpu(ev->p_mtu);
> +		qos->ucast.in.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
> +		qos->ucast.out.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
>   		qos->ucast.in.phy = ev->c_phy;
>   		qos->ucast.out.phy = ev->p_phy;
>   		break;
> @@ -6760,8 +6760,8 @@ static void hci_le_cis_established_evt(struct hci_dev *hdev, void *data,
>   		qos->ucast.in.latency =
>   			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
>   					  1000);
> -		qos->ucast.out.sdu = le16_to_cpu(ev->c_mtu);
> -		qos->ucast.in.sdu = le16_to_cpu(ev->p_mtu);
> +		qos->ucast.out.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
> +		qos->ucast.in.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
>   		qos->ucast.out.phy = ev->c_phy;
>   		qos->ucast.in.phy = ev->p_phy;
>   		break;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
