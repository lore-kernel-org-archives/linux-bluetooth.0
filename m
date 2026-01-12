Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EC928690
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227924; cv=none; b=I+FOza2nbV+OVwjTzQoGSC7OhocIkrOqVpBXnn3is2fNhf0tafBsR9NiT1CmD+Fib/unLzWne9zvjNYX2gSmlNyVlyttWAZP6pQ1PPnMnGzjTVFaw/Jm/FM3m+pZ1zOz42pl+pK3F4vBDg8k28bXlUeXnsHz0L/MgdGp3gxnp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227924; c=relaxed/simple;
	bh=Rh8to1apCtCElzn+BT8OHw4BHSTHKVS5vRZF6y2V0GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgzVyRbN1sW/T609a0hYYxJHTE3OOtk0TOk+pQNDFMIk909hRzqBpFwg8kfJ10UOa0b9LevlTan9wNEzIDNdt1Kqba7gg2URiy3joXgAHy3xltIVWirhra8KqQFu2lBY2MfKZ4NqXU/OXFJN/ANCiyUcFPrS3diXew+ohf6L98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTe8n21j; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTe8n21j"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6467bed0d2fso6200721d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 06:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768227922; x=1768832722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL4TzgOyfcmh27MdquoSmz+Miu1KQMGgo4w1Cj/kmQc=;
        b=BTe8n21j8rLkmc5o/36SoHcRHHkC4ERqD71W4vNH+ZA4TwlD+30tqtRxYakmRYhO6i
         hChatqX6X1m8DmSWzBOUbemH1p9Z6ymUDXGU21pctgUs6VBJzBRjx1c5Ss5MCnYT/pMz
         YgJ8Gyew83e7MDK3p95EdBgyJ+0FrOwUyqFUk6j7zptJcJmo0At3w5rofJ6sMUIh0L7g
         mLKzrI6NGrhId6NI2vVAVF/wVDdp3vBy4R6k+d8BONAdBTPkLf2AzT99WATTth5GSAbo
         Ux68zW1HtOLKQFKHeo1cK8ahsr0Gr/FbeNEec2P9ZapxtloLqyfqSfBpsNcp5sBB16Px
         4b+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768227922; x=1768832722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sL4TzgOyfcmh27MdquoSmz+Miu1KQMGgo4w1Cj/kmQc=;
        b=sRpofY4uil2ZB8zoCj+0F0N/B+t0fcnY3nmkay8flCRtIcXbWR6zG8XUyj980rKuEj
         lsp3iLH+K+AOSzPk3avIc9UbUuRgOfRq8B73/Ac/NhH8l+Fi42AteUb7TVgjLbjTnC1V
         KHnnl5e4hWzonZLGxP59FdtCaZ91mNqKeInC/nCL5I+dh/gFxfI2E56wDrdKqgeL4zSn
         OCo/l3SNEL3Lu/5aEz4XI1GuCY0Vb3iYYiHJ9GSTmrP9b4yFi2lal5lPinJwg7kS3KNM
         aO8PjtUs1FYD02Ihqb1xzbgezpMOildjQrBnbmQIq22B6Y6qksIQIGmugSCNwgVNB1EZ
         0IwQ==
X-Gm-Message-State: AOJu0YzMOi9VRh2kPLlqSIV43x+H5bmHE+HCnWVpxBXiLCzXqeg2/IgJ
	FfjFxrE0nQZ2iqCsQM2tSk4V5jtRWFV8JmQ8/HFfV4cKJnX72ol40lUexnwsobCM3RRTnhR78jc
	i59AcCOdidBnldk2fLaNl+N0lQ4P7YxhMrnhh
X-Gm-Gg: AY/fxX4ke/bNbo9TFQEY8xN8iQLno99N1oo6B/lE+xhNBKlUW8b5plY0Wv9UMqSJL2G
	wnHijk9ZT/L3BKKxbp7rc7nfe8zUaz3oluwCLmBbXzy22PUw/A/1R4WkySobN8cZcyHKPjszjiK
	chK3yLP6GIbRuQgUQ7F9Dw4AzVwah7ed5rqs3Xklx1tX5ZiN/k9m1fxefMxGlwngOfAVVV7v+fA
	l33iNTaSlsPIrSmzceA/yI3zGEfBc/a4SEk+srZDTiDsAXG4BPueDXTvAxw97Y267HI63QzHgXd
	gWy51zuk+iKdB9hVrtR3kgy9j3cw+eya7PNUybEATG8nE55E0gcc2SY=
X-Google-Smtp-Source: AGHT+IHg0WvfqCzq0j/x6Lh2bHNz/K96ZvMwh7tASRYAaMBhPYEv7RHC/w3h+BEmK2ykOMFGocNee1cwuis5OY1Ak2A=
X-Received: by 2002:a05:690e:bcd:b0:646:518b:9fc9 with SMTP id
 956f58d0204a3-64716c54bc8mr15957354d50.78.1768227922179; Mon, 12 Jan 2026
 06:25:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
In-Reply-To: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Jan 2026 09:25:11 -0500
X-Gm-Features: AZwV_QjgjIAUoyOyd-ZKoFcGpo71fqtCyLncyMIBA_3ufJsz1iej-DoQjG0No7Y
Message-ID: <CABBYNZ+xrCofAHqVOs4SDn3avXQenNbv4L-sys6_2Lf9PAXFOg@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] bap: reduce ISO sync timeout to 2s
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Mon, Jan 12, 2026 at 1:42=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> The ISO sync timeout was previously set to 20 seconds,
> which is too long for PA sync. This could leave the userspace
> flow pending for an extended period of time.

I think we used 20 seconds based on the connection timeout, that said
I do wonder if 2 seconds is going to be enough given that the
advertisement window can be wider than that, specially when SID needs
to be resolved.

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  lib/bluetooth/bluetooth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
> index f9f22c3f7..572009e75 100644
> --- a/lib/bluetooth/bluetooth.h
> +++ b/lib/bluetooth/bluetooth.h
> @@ -152,7 +152,7 @@ struct bt_voice {
>  #define BT_ISO_QOS_BIG_UNSET   0xff
>  #define BT_ISO_QOS_BIS_UNSET   0xff
>
> -#define BT_ISO_SYNC_TIMEOUT    0x07d0 /* 20 secs */
> +#define BT_ISO_SYNC_TIMEOUT    0x00c8 /* 2 secs */
>
>  /* For an ISO Broadcaster, this value is used to compute
>   * the desired Periodic Advertising Interval as a function
>
> ---
> base-commit: a94f994201a69a36753abda65cc51937de9cd3e3
> change-id: 20260112-iso_sync_timeout-8e3ecf43d82e
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
