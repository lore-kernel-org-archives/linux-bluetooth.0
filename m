Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5C40759D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364761; cv=pass; b=VJrf5sJ++6iDnwUMlZzrQlpS6dbAAiMuIt0r6iAsAKcjHc3wiVgITF8jWBTSSAnJjXStzRrbIKYS+1meW+m2wW56o8Q8DXQnQ56D1oVBtV6fRv1A4T9M0XtpqTg6srhRna9SFcyNCmPjHD4OO+V4rSD9g+QSfUoQuPG0YsCio74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364761; c=relaxed/simple;
	bh=Syw9Zv8m9OOhhF/YlGTbUW2wyqQKhTbzhF1EefGCxw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B1iqTSFRQsFgUl/Aob6B4CE3KKvzPlfzBrt11I555QgjkYCFL2Hnp0YE9/4jV57LgqWywPQ7tkC/kSJCjGgOT4iVd7U+ADyYz9kt1ScerL5aGj5LLhWDLLmzGx7D2myFH2D9bZYdHVirN14TDLjYY9Xs3bKQ9SzeiCJ78Gwe0PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ia+EgxQc; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia+EgxQc"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-46726528f1cso3720187b6e.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 08:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364759; cv=none;
        d=google.com; s=arc-20240605;
        b=CqU+u7xTarO3muBeSp2qMLY4xkojlKUvJCAYk5uHfnfriYqU99gFZCC0tp/z7w1AN0
         w7CuUs+cbjXTd+Ue7touTkBFbH081H6tNdSSHarN6FHLOIG8r5e2C6tm3QyRF/8Lb6V5
         SoynZnWyM9m2MjwfZZWouPpidAk3Dov0sykx8LmGNuIX778bD56o5Ar0W5kakMSjXrvP
         CQuEuevDQ4y1wemc6Omi17dXPbxRKoDcAUe5HN5y1kzeBSmsOyOn1h71OO+4gTmCM8dR
         GxosY9biFoA5pYna3pNlzc6oUQKeUe0GzCxEF//z1yZTCoWnrR3cTtKlqhl/vBmqSNku
         WwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DzUn14JGyajcFwHW9EydOwqTS4MCvGkmTg9vuna5ptQ=;
        fh=T6tKiZ8VXaP8odXOehZ1gyE2G54zUxsbUFp1khOEz70=;
        b=hKPUMW8Iyx+qO/ktOTztbjCDsnJQXQ2js5Y2YW/XzM5ugiTSyUIJOKieo6TltY4HpW
         T7R5NoOaV3VKgZ9ljdf6DU5PqWI3nnD7MX/5qs28Y60klyxnu3LXgeVNR5WLg3tGs5fK
         KFjAWslQDNhqxg5s/AOhUFsZye8Gi+UXtD9vokzaJKXy61g9qsNdWc14UePEEuH2hPp2
         vntgJqzOH92VzbenKStIdQLyVXr7eHiZ7mlDOUucDazz9NX6X2YhEuN+9zR1cqN4u3MV
         GnYIHwTlzp+VPzKURnAVqwmDmm0lGN9oJAGCDzvqAI8DSuQ5qFk/mj9ktYilz2dMx3qr
         ikDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364759; x=1774969559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzUn14JGyajcFwHW9EydOwqTS4MCvGkmTg9vuna5ptQ=;
        b=Ia+EgxQcZ73EJbE81XHHah3lF0/sl6LkKwnd6BljxwON7ra4QAD3U+D92cp+UsU463
         IYzUzbiX4KNryUdLhyAlgZ9shU44z4qjwD4NvM7yC+HzOtDSkRHPn8AKnsB4GyZNc1/O
         fwUqxiSyjFc4dLEk9vCvc1TrbeanLRgHl83t0eSqDdbPraFqp0Qqxnc4uHRWACa3mSh2
         NjDnKGoKj9MbgFHzSJ8a6XvK8VRswLepSAAXO+AlWGLhZtyPRp41cDnTET4GrffH/SYG
         thT6tAl5ykDjtlCWjentxeJCjFnDIvBM/zTKAhlyga1ioXVWsJo22SmuBFoMJZHm7Qd0
         kZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364759; x=1774969559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzUn14JGyajcFwHW9EydOwqTS4MCvGkmTg9vuna5ptQ=;
        b=ZrBh3G9f8cfneFFbwOD6VZLClm4jCrsebotGon73aS/zIG9K1FXhPYUBDtRbtLXDit
         rugUkr3QXaiCYiwsjJYt/IUxxQ4HdUwnySfUhU6BPzc9kDyFJ5lX6YaQKx/ZcOy0auO3
         949CyxFgoFhZ10yk6nalgFUYnLqR0K6/ISakpsetRdSDjQNhDQwSd/YbwOwV9imxvNPK
         jAUNpLxDy6iFgwOkBNYQjtqx5hha3OViMGMuiHjeXwQuDyYC4HGj7G4DP8Au1IJkJj0r
         G5fOYx78QaMpwSiOTcgKosIVMvURgmJo3XthKQGPviy1Y5uh+xYvUOocAeQ9WMtNlzQa
         CkPA==
X-Forwarded-Encrypted: i=1; AJvYcCWr7VNgoyWHA9Tv558/12dZYWLPLLqUagxanFx2WANx94ZYBogpiwuJLMy2ZgwyNmuqdOJSKszRh3am1si384w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwglYtzTgAhYAMe2Zo4KLVCgCRxjr8rFdi+NwQZGvqEMgM2JDnN
	CP79Wm7vLfQy70sS7hypeJRDY9xxaoPsS9JREISc4CemOYMV8xO8LdXaK3VV3glFRLuEFV7UxBv
	nA3YwnQMi9klj+X5UeH1gw5XcTxMpfc7txg==
X-Gm-Gg: ATEYQzxMlwuRZJxKHi0cMA7OKfQmDYHl4SoaxXsOvp3XkO4md781T08vNKndy38XhB0
	q6qaX9L4nMOgIkRJyb6vXVa/6r32DYIr0c1p350umWaluZRnOyFyBp9RrERMKW5ECq+gNJcyttq
	z0lkK292rjztuYX1DQ5H/plM0a9yE6nkYwEbihtdeaRBcSpYmDhTGlZEE7Dyf8dpsdnWpoLN6ZL
	UpN+9k0YQyHnHWFoHRYhzlDDQiLyjgNv6kR3RtHogDZ9G7DvQBumIzcGxOGKF/ioM1kssOj/zaE
	G8aD39ovONgW8cvs22XRwiDVMc3VHVFulUxHRpGOLv4SCaxojtLffIjec/344lbF2ho=
X-Received: by 2002:a05:6808:c40b:b0:467:fab6:c7ee with SMTP id
 5614622812f47-467fab6fbc0mr7490451b6e.38.1774364758525; Tue, 24 Mar 2026
 08:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324085152.74986-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260324085152.74986-1-pengpeng@iscas.ac.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Mar 2026 11:05:46 -0400
X-Gm-Features: AQROBzBEIrUHiIJbjYy1dg0TjVmTIuFHx1nDimXEi1st0bWk-S4BTYakgzhDgvY
Message-ID: <CABBYNZKGPBFOc5EwM=2wC3rjL6zZUXG0UdAdvq2zhu963LSw1Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix TX queue off-by-one
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi @Kiran K

On Tue, Mar 24, 2026 at 4:51=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> btintel_pcie_send_sync() reads the next transmit slot from
> data->ia.tr_hia[] and uses it as an index into the fixed txq descriptor
> arrays. The current guard only rejects values strictly greater than
> txq->count, so an index equal to the queue depth still falls through and
> is used as the next transmit slot one element past the end.
>
> Reject indices at or above the queue depth before preparing the TX
> descriptor.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/bluetooth/btintel_pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 37b744e35bc4..760cb3d1aa18 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -359,7 +359,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie=
_data *data,
>
>         tfd_index =3D data->ia.tr_hia[BTINTEL_PCIE_TXQ_NUM];
>
> -       if (tfd_index > txq->count)
> +       if (tfd_index >=3D txq->count)
>                 return -ERANGE;
>
>         /* Firmware raises alive interrupt on HCI_OP_RESET or
> --
> 2.50.1 (Apple Git-155)

Looks valid to me, index starts from 0 while count start from 1, so
index =3D=3D count would probably overflow as well.

--=20
Luiz Augusto von Dentz
