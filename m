Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4373296BC8
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409980; cv=none; b=LZiGGU5yQFd81CoWiG23Pqeff6fuWLXeHmFClT1bDb6zP0zileIOL/VL56XDFL7/Zbnm9orRoR2jU2BEjnmSyvHWi+kLqpCucdUlFPIXNd1/aAh8c6oenJzLABcQHimrd7mei8nBF6wUP0yq15p34pzT/jz3QIkdcz9GOnrfNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409980; c=relaxed/simple;
	bh=/3kM6m2Mn+fii8IgaPfHDTq3zLdVH5BZ/maUDYv8W7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ax8xW0vhNbQtI0uKkAWlpFXdjAg+KRIX3tslZCOCUXxVqSGfS4b0egNQhxMBa/lfAb94RZdW3vXC6qJbrl/A3vPS7HUon/Xumy6mb2J18DoGqyYJeeSxewtQyE2OWpCyKAxVmDsMkkrqwy+w9teavknRKVXu6/a3lGgvr8hTJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.132.15] (dynamic-176-006-148-028.176.6.pool.telefonica.de [176.6.148.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7C0BB4C1A25A26;
	Fri, 06 Feb 2026 21:32:47 +0100 (CET)
Message-ID: <d7dff451-317d-4e31-9e77-a098390b3483@molgen.mpg.de>
Date: Fri, 6 Feb 2026 21:32:44 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix result of L2CAP_ECRED_CONN_RSP
 when MTU is too short
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20260206202106.337275-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260206202106.337275-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 06.02.26 um 21:21 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Test L2CAP/ECFC/BV-26-C expect the response to L2CAP_ECRED_CONN_REQ with
> and MTU value < L2CAP_ECRED_MIN_MTU (64) to be L2CAP_CR_LE_INVALID_PARAMS

s/and/an/

> rather than L2CAP_CR_LE_UNACCEPT_PARAMS.
> 
> Also fix not including the correct number of CIDs in the response since
> the spec requires all CIDs being rejected to be included in the
> response.

Could be a separate patch to make the commits smaller.

> Link: https://github.com/bluez/bluez/issues/1868
> Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   include/net/bluetooth/l2cap.h |  6 +++---
>   net/bluetooth/l2cap_core.c    | 11 +++++++----
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 6f9cf7a05986..010f1a8fd15f 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -284,9 +284,9 @@ struct l2cap_conn_rsp {
>   #define L2CAP_CR_LE_BAD_KEY_SIZE	0x0007
>   #define L2CAP_CR_LE_ENCRYPTION		0x0008
>   #define L2CAP_CR_LE_INVALID_SCID	0x0009
> -#define L2CAP_CR_LE_SCID_IN_USE		0X000A
> -#define L2CAP_CR_LE_UNACCEPT_PARAMS	0X000B
> -#define L2CAP_CR_LE_INVALID_PARAMS	0X000C
> +#define L2CAP_CR_LE_SCID_IN_USE		0x000A
> +#define L2CAP_CR_LE_UNACCEPT_PARAMS	0x000B
> +#define L2CAP_CR_LE_INVALID_PARAMS	0x000C

What changed here?

>   
>   /* connect/create channel status */
>   #define L2CAP_CS_NO_INFO	0x0000
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 81038458be0c..0b9753df802d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5051,13 +5051,15 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>   	struct l2cap_chan *chan, *pchan;
>   	u16 mtu, mps;
>   	__le16 psm;
> -	u8 result, len = 0;
> +	u8 result, rsp_len = 0;
>   	int i, num_scid;
>   	bool defer = false;
>   
>   	if (!enable_ecred)
>   		return -EINVAL;
>   
> +	memset(pdu, 0, sizeof(*pdu));
> +
>   	if (cmd_len < sizeof(*req) || (cmd_len - sizeof(*req)) % sizeof(u16)) {
>   		result = L2CAP_CR_LE_INVALID_PARAMS;
>   		goto response;
> @@ -5066,6 +5068,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>   	cmd_len -= sizeof(*req);
>   	num_scid = cmd_len / sizeof(u16);
>   
> +	/* Always respond with the same number of scids as in the request */
> +	rsp_len = cmd_len;
> +
>   	if (num_scid > L2CAP_ECRED_MAX_CID) {
>   		result = L2CAP_CR_LE_INVALID_PARAMS;
>   		goto response;
> @@ -5075,7 +5080,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>   	mps  = __le16_to_cpu(req->mps);
>   
>   	if (mtu < L2CAP_ECRED_MIN_MTU || mps < L2CAP_ECRED_MIN_MPS) {
> -		result = L2CAP_CR_LE_UNACCEPT_PARAMS;
> +		result = L2CAP_CR_LE_INVALID_PARAMS;
>   		goto response;
>   	}
>   
> @@ -5095,8 +5100,6 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
>   
>   	BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps);
>   
> -	memset(pdu, 0, sizeof(*pdu));
> -
>   	/* Check if we have socket listening on psm */
>   	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->src,
>   					 &conn->hcon->dst, LE_LINK);

Diff looks fine otherwise.


Kind regards,

Paul
