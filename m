Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472BF1E1DF2
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jul 2025 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752313327; cv=none; b=VbXtxWyHQPTD44nLuW6x/SnooNOyu1/cX5rikBZX9Qin22XfenAvJ2LSkxjP+UW4oBshEpZ2IjwqguaB5dBgnfuUAzY5fE8x+UkALuIGHg3W4L4o5+zx46YtD6I9ldRuoVqWUTIMORHWSYVGKj33p3veZsoU1mjH8wLCDWtlXBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752313327; c=relaxed/simple;
	bh=BPSK9a9cIC+XG8PeUxpa6gqkkqikg89Q3SjPa1y86bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Kn1/pF2Gl0ay2vpAwhkX2nzZdqXI0BdGmHGWM9cIzr6ea9oDr8/IjAYDkKQB517RstXKOQXBJmFx7qFv/Gux+nDKnbaT+8By5dK7j34dOqPj+m3P1VyC0cUHRn44pVlS1oXBwVFWTTo2IYQhK7LVB5C8I8M4Lqcnvqa/3uAJN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af136.dynamic.kabel-deutschland.de [95.90.241.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B1FFF61E647AC;
	Sat, 12 Jul 2025 11:41:48 +0200 (CEST)
Message-ID: <9c411a56-8012-454f-b7ab-3fd352e6d4d1@molgen.mpg.de>
Date: Sat, 12 Jul 2025 11:41:48 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez] src/adapter: Fix RemoveDevice timeout when device
 already disconnected
To: Ye He <ye.he@amlogic.com>
References: <20250712-adapter-rm-device-v1-1-808603331f92@amlogic.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250712-adapter-rm-device-v1-1-808603331f92@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ye,


Thank you for your patch. In the summary, you could remove `src/` from 
the prefix as it’s uncommon to add it there.


Am 12.07.25 um 11:23 schrieb Ye He via B4 Relay:
> From: Ye He <ye.he@amlogic.com>
> 
> When attempting to use RemoveDevice to delete a BIS source device that
> was synchronized by the BIS sink scan delegator, the kernel marks the
> device as disconnected due to PA sync termination. However, BlueZ is not

What is PA? PulseAudio?

> notified of this disconnection and still proceeds to send MGMT Disconnect
> command. The kernel responds with MGMT_STATUS_DISCONNECTED, which BlueZ
> does not currently handle as a successful case. As a result, the RemoveDevice
> call never completes and no D-Bus reply is returned.
> 
> Fixes: https://github.com/bluez/bluez/issues/1421
> 
> Signed-off-by: Ye He <ye.he@amlogic.com>
> ---
> This patch fix org.bluez.Adapter1.RemoveDevice method call timeout
> when device already disconnected.
> ---
>   src/adapter.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 79802300bedf4b25cb7c6bc3ea659c122a01efcb..5d68fa4c7dea251af4ff3b05a1ad66204c847c37 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8619,7 +8619,8 @@ static void disconnect_complete(uint8_t status, uint16_t length,
>   	const struct mgmt_rp_disconnect *rp = param;
>   	struct btd_adapter *adapter = user_data;
>   
> -	if (status == MGMT_STATUS_NOT_CONNECTED) {
> +	if (status == MGMT_STATUS_NOT_CONNECTED ||
> +		status == MGMT_STATUS_DISCONNECTED) {
>   		btd_warn(adapter->dev_id,
>   				"Disconnecting failed: already disconnected");
>   	} else if (status != MGMT_STATUS_SUCCESS) {

The diff looks good to me.


Kind regards,

Paul
