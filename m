Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3C73218B2
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415723; cv=none; b=F1mIqi/m94baWBPRa1MxUfW58FbGWJLKyIl6y2f7QEe8+CELQRyePM4UbasD/YtsS81StiC+iTFkOMBoImmhkm/ffDz0E2qUTG/ZkprQvxDHaK7+FejoMmc+l2i28wDx84O75lMU61LM8S+VPf7VeBq5Q/FlRPRSbcWnO/sdOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415723; c=relaxed/simple;
	bh=77quI2KiW2vlkmtOwWW5uOnRrN7yl8sXsq4vab0nP3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YHV0GROGUs01EQwcaP60aiqj1u0HpSoe4aIVDUkpcOyiVwRK0EIHpxozlPReM7FXY/XrQ8E3xdtpXTJbmSyqry+DFZoZo6EzKBfh/LFC+11RcgoF/sjPuTaseL/38jDiBdw9D8bn7LfvZ6wmTKB8Fk8QYn9vJYRyFhRg4tYanMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.216] (p5dc5575e.dip0.t-ipconnect.de [93.197.87.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E616061CC3FE4;
	Mon, 17 Nov 2025 22:41:54 +0100 (CET)
Message-ID: <02779265-0d40-436c-99fd-2e247a09aae1@molgen.mpg.de>
Date: Mon, 17 Nov 2025 22:41:52 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: SMP: Fix not generating mackey and ltk when
 repairing
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20251117190232.3918619-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251117190232.3918619-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 17.11.25 um 20:02 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The change eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
> introduced a goto that bypasses the creation of temporary mackey and ltk
> which are later used by the likes of DHKey Check step.
> 
> Later ffee202a78c2 ("Bluetooth: Always request for user confirmation for
> Just Works (LE SC)") which means confirm_hint is always set in case
> JUST_WORKS so the branch checking for an existing LTK becomes pointless
> as confirm_hint will always be set, so this just merge both cases of
> malicius or legimate devices to be confirmed before continuing with the

malicious
legitimate

> pairing procedure.
> 
> Link: github.com/bluez/bluez/issues/1622

Add https://

> Fixes: eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/smp.c | 30 ++++++++----------------------
>   1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 45512b2ba951..08461ca06cde 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2136,7 +2136,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
>   	struct smp_chan *smp = chan->data;
>   	struct hci_conn *hcon = conn->hcon;
>   	u8 *pkax, *pkbx, *na, *nb, confirm_hint;
> -	u32 passkey;
> +	u32 passkey = 0;
>   	int err;
>   
>   	bt_dev_dbg(hcon->hdev, "conn %p", conn);
> @@ -2188,24 +2188,6 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
>   		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
>   			     smp->prnd);
>   		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
> -
> -		/* Only Just-Works pairing requires extra checks */
> -		if (smp->method != JUST_WORKS)
> -			goto mackey_and_ltk;
> -
> -		/* If there already exists long term key in local host, leave
> -		 * the decision to user space since the remote device could
> -		 * be legitimate or malicious.
> -		 */
> -		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
> -				 hcon->role)) {
> -			/* Set passkey to 0. The value can be any number since
> -			 * it'll be ignored anyway.
> -			 */
> -			passkey = 0;
> -			confirm_hint = 1;
> -			goto confirm;
> -		}
>   	}
>   
>   mackey_and_ltk:
> @@ -2226,11 +2208,15 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
>   	if (err)
>   		return SMP_UNSPECIFIED;
>   
> -	confirm_hint = 0;
> -
> -confirm:
> +	/* Always require user confirmation for Just-Works pairing to prevent
> +	 * impersonation attacks, or in case of a legitimate device that is
> +	 * repairing use the confimation to as and indication to proceed with

confirmation

> +	 * the creation of new keys.
> +	 */
>   	if (smp->method == JUST_WORKS)
>   		confirm_hint = 1;
> +	else
> +		confirm_hint = 0;

Use ternary operator?

>   
>   	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
>   					hcon->dst_type, passkey, confirm_hint);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
