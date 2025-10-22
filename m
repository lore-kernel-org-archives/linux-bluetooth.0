Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED672FF678
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166312; cv=none; b=owTh27M9F5dgGcK+zM9TEzwANoArzmrjKVFzOkPO4kFA1DJ9z0TLb7qIG/5euXmi9Yo/bmAil1b8aKlnyLhUohC6AFxfqKmgFVC/q46z/d6DghHjBGwICooeHD0U331qwI5knGPCjfFavKxSio0xqQH1Xhc7YIhNMzNhIivHtF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166312; c=relaxed/simple;
	bh=dmy1Eil712HYq9Hv5n8oI105tK4TSEjVscITw7VUdIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OFw0aESHZAGiuTBcCZ1HRJHIurgNxHGmixIFaxjaVDHKXLntmOht+FkP25CXWnhsKALTfZCI63E3P5/Zatt2JSJKWfjta9x/QLXdh9DM6zW4m503ApFhUKWNgWkfmktjf6OhKek/wHHHH/Lr3daxjJ3y00mHyE7nF2jqHJn9FYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [134.104.50.123] (unknown [134.104.50.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E84246028F357;
	Wed, 22 Oct 2025 22:51:42 +0200 (CEST)
Message-ID: <345b9e2e-b47b-4d3b-8182-303dd3707c8a@molgen.mpg.de>
Date: Wed, 22 Oct 2025 22:50:56 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_conn: Fix connection cleanup with BIG
 with 2 or more BIS
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <20251022202941.1537413-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251022202941.1537413-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 22.10.25 um 22:29 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes bis_cleanup not considering connections in BT_OPEN state
> before attempting to remove the BIG causing the following error:
> 
> btproxy[20110]: < HCI Command: LE Terminate Broadcast Isochronous Group (0x08|0x006a) plen 2
>          BIG Handle: 0x01
>          Reason: Connection Terminated By Local Host (0x16)
>> HCI Event: Command Status (0x0f) plen 4
>        LE Terminate Broadcast Isochronous Group (0x08|0x006a) ncmd 1
>          Status: Unknown Advertising Identifier (0x42)
> 
> Fixes: fa224d0c094a ("Bluetooth: ISO: Reassociate a socket with an active BIS")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_conn.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d6162a95048e..0b86aaddfb02 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -843,6 +843,13 @@ static void bis_cleanup(struct hci_conn *conn)
>   		if (bis)
>   			return;
>   
> +		bis = hci_conn_hash_lookup_big_state(hdev,
> +						     conn->iso_qos.bcast.big,
> +						     BT_OPEN,
> +						     HCI_ROLE_MASTER);
> +		if (bis)
> +			return;
> +
>   		hci_le_terminate_big(hdev, conn);
>   	} else {
>   		hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
