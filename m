Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67F651B4
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535725; cv=none; b=u2J9vJDIGsdN/kCptNTfiBP/B5w+/VExH7Nur4UfT1bAbujMUby+lZ/int6DwfGqemDkk/U8t7+eOTsi3LO6LOG2tWuKQcug8QG9vz4iHWoF+jyB6MhzVT4meIju4wy1X4vKC3lNIDr7rNyUb5UWV9suoFRVADT6OXsa4b3yRmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535725; c=relaxed/simple;
	bh=U6ybcjPZfJWAVm+9+XFP+575jlZjGQaSD2A9UyRVsdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ48lCXCDx7+urWSl8dlk6DNjfRp0zi+50uiugSA7mSWPapQMoSOxnou6eT82W4KEVoz4apUog5FLRfaT+vTapWqtq8gJOs8Env2Uoen5/yeTUu38xoIQXCgJg4DAYHQZNMdr+OmA+idssXmxJH2xAmwzhiCySQ9fKqeyicsOLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2lzeOoe; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2lzeOoe"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d043160cd1so13871091fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 05:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706535721; x=1707140521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02XMQJsRMCiLGswiopR62LDY/up2qe+YKdcqWZOCcSc=;
        b=G2lzeOoeitQH/bqBxWb9tj3t7yN9K4YSZgyxvY+e32rSpqGzY3v7DC+IYxBxe6Fo2u
         C+iW6mCfHcMGdzKkpvgIANRqdFuxwdHMnVLoV3VFpG96811sgHMGj5snQRIbIFeOPxR6
         HKnsiyNsgZGXJYRKmZk7Im5uqBh/RXtVC61dyjUEkDZab2wl3fXiE2qdmfL8Z2vylaXc
         +CZXO6iheMBfcANu1hafXoA+SzzhB51yMUVXybkc7VEZEtomtFz+1NDCRrWi223RIAXO
         mMOyv4Vf5dC8HU2c7KkuTNT/kFqEzAKKWEA+C7cx2NZ1iWnh5d9jUYPq8rzCwdflUKCG
         hkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706535721; x=1707140521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02XMQJsRMCiLGswiopR62LDY/up2qe+YKdcqWZOCcSc=;
        b=qnT3aQVfHORjJmt5KD+s2PVHy2Cv2/IRAbWKtKmeLbFGTg/ko4JM3kg8E/ROlsMRQI
         d5yy3HdFzMOcZRDvdzy3bQER8GCObqSZLJl/5kagMN3BrmZ+gNsuPw9KaK/aCTAkxwi+
         FwWl2qhpbWLrOXshmcUhlKPly0lxek0tcmKH5hcpz3rDwdp8qI+pfFGkKzbwnLvvrzCZ
         uVEf3zAGxLSw3XyBGGIgPVDEUmZ81Ip8D0jlNSwSdWl1i9FwYWbhxU2TscEvNobHlEeJ
         EJEHCokbOdCwAapV9LnyL9l/Nok0LD7k5mGOahkhscHVEXcLWbqM357XcxoyCkkBLRcT
         5kQg==
X-Gm-Message-State: AOJu0YzV7wkNxTkHzYX9KW9qGi4xfELl0+Y8WMsg6IsVQ2GbvmQ1NbsG
	e351Zu9rNwNPyJ+eQWu43LQnhkkN8Gk+LqmPMSiGfaQlI1Z5Nx8rtKKFphI84tRgI6qwT26hg+g
	GEsJMHiIW9yek39Exs3D1vO0oBevKZJPA
X-Google-Smtp-Source: AGHT+IHxJfH6ekCIoLPO4CqLf411qAg8in+atqtj1esNbyGcGhq4NAed4S/ATwIjm+sQDnDE8EysGtplquTc5PaiWVg=
X-Received: by 2002:a2e:8395:0:b0:2cd:ec28:ccc5 with SMTP id
 x21-20020a2e8395000000b002cdec28ccc5mr3622501ljg.14.1706535721171; Mon, 29
 Jan 2024 05:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129114900.92919-1-verdre@v0yd.nl> <20240129114900.92919-3-verdre@v0yd.nl>
In-Reply-To: <20240129114900.92919-3-verdre@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Jan 2024 08:41:48 -0500
Message-ID: <CABBYNZKEYUgf0kvsKVMnQio6-eVm3ziCFmPYTGMrzew9qxjiGA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/4] mgmt-tester: Adjust a test for recent kernel changes
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Mon, Jan 29, 2024 at 6:49=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd.nl>=
 wrote:
>
> With the changes in the kernel to move to hci_sync for connecting ACL
> devices (see kernel commit "Bluetooth: hci_conn: Only do ACL connections
> sequentially", https://lore.kernel.org/linux-bluetooth/20240108224614.569=
00-1-verdre@v0yd.nl/),
> the "ETIMEDOUT" error path for the "HCI Create Connection" command was
> changed, sending a "HCI Create Connection Cancel" after the timeout.
>
> This leads to the returned error in the "Pair Device - Power off 1"
> test to change from NOT_POWERED to DISCONNECTED, so adjust for that.
> ---
>  tools/mgmt-tester.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index ee12ed7d5..7c9e63cbb 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -3216,7 +3216,7 @@ static const struct generic_data pair_device_power_=
off_test_1 =3D {
>         .send_opcode =3D MGMT_OP_PAIR_DEVICE,
>         .send_func =3D pair_device_send_param_func,
>         .force_power_off =3D true,
> -       .expect_status =3D MGMT_STATUS_NOT_POWERED,
> +       .expect_status =3D MGMT_STATUS_DISCONNECTED,
>         .expect_func =3D pair_device_expect_param_func,
>  };
>
> --
> 2.43.0

We haven't applied all the changes from that set though, are you
planning to resend them?

--=20
Luiz Augusto von Dentz
