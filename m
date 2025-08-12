Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482D32C85
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755012029; cv=none; b=Yje3RqezAUTd62P+i1n5PHhv4lAYKH17tVvykQrKzNDbrRR0DABVMk3N1Evh9w7Ky+4U7HRMD4guHNynkz7V2s6m3d3T0IhQ/mqU6THh8rzT0XK/6fV6Uo1OpSyuQD0BiPH8YeTm3eVA2R70wmStrXjraKlGb9BigBFLXKzhSdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755012029; c=relaxed/simple;
	bh=sZggN4p5QPph1Z1ABghkk+kpOyMkhoi447Ch67nrqiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hjVmCMqEVHa3Vwq+sUw4bV+jvoy+1hL0oZkoAr1CpHuKNsqwfsC2I1lOqAaovCoGJaMvVag0xeR+Qy0tmaY3MB24stSUAU9tkBJSUfi96eq7DALc5XcECF8GWO/2CSt+8iUvPf7aog0VFVuXhQ5T2T0pzbTNj+DyCzmjuvOKdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0823561E647BA;
	Tue, 12 Aug 2025 17:20:18 +0200 (CEST)
Message-ID: <13a10b21-63ae-4606-ad5d-e5d48870da22@molgen.mpg.de>
Date: Tue, 12 Aug 2025 17:20:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Bluetooth: hci_event: Treat UNKNOWN_CONN_ID on
 disconnect as success
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
References: <20250812141028.509783-1-ludovico.denittis@collabora.com>
 <20250812141028.509783-2-ludovico.denittis@collabora.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250812141028.509783-2-ludovico.denittis@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ludovico,


Thank you for your patch.

Am 12.08.25 um 16:10 schrieb Ludovico de Nittis:
> When the host sends an HCI_OP_DISCONNECT command, the controller may
> respond with the status HCI_ERROR_UNKNOWN_CONN_ID. E.g. this can happen
> on resume from suspend, if the link was terminated by the remote device
> before the event mask was correctly set.
> 
> Currently, the hci_cs_disconnect function treats any non-zero status
> as a command failure. This can be misleading because the connection is
> indeed being terminated and the controller is confirming that is has no
> knowledge of that connection handle. Meaning that the initial request of
> disconnecting a device should be treated as done.
> 
> With this change we allow the function to proceed, following the success
> path, which correctly calls `mgmt_device_disconnected` and ensures a
> consistent state.

Although part of your issue referenced below, I’d love to see the 
reproducer in the commit message, should you resend.

> Link: https://github.com/bluez/bluez/issues/1226
> Signed-off-by: Ludovico de Nittis <ludovico.denittis@collabora.com>
> ---
>   net/bluetooth/hci_event.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index fe7cdd67a..6c67dfa13 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2703,7 +2703,7 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
>   	if (!conn)
>   		goto unlock;
>   
> -	if (status) {
> +	if (status && status != HCI_ERROR_UNKNOWN_CONN_ID) {
>   		mgmt_disconnect_failed(hdev, &conn->dst, conn->type,
>   				       conn->dst_type, status);
>   

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
