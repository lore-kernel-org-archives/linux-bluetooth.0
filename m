Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFB3318B93
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767885657; cv=none; b=bKLE36FcLKosnFecU12rCBj1lg63AhzLNhl5yneSXMVbOFaLZVSa3Kea7jJg7H9dXCCUMkzMj0xQM7AD3iwMPbyvRyHfmR3kUfx+C+Hx1KLUWk2Yv1SxnZCI6prpnQsNTBen/kzdPxvczi0Hum2wXQcRH/svV95C3eEd+OhFKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767885657; c=relaxed/simple;
	bh=SYBzwgs0h4Jl1pedlxyjwcdnqy2E6FTJJDRAP32+oTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCUQvgG4akqy3IEMVQpRhSmyCEuazs0w/lrR528WDqZ/Dud9kvlG24+9Mj8peHT3jqjV8aaWcS/SjSK+tIZMcB71wqep0zfy0qXKedbpA9fus/rdp5KOW8dvE8d/5Qg1jBcmrC6+Y7LlWyfSG2gZh8VdiR90z/x6Uup6FDNk4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfNjy+pi; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfNjy+pi"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78fb5764382so36330787b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767885651; x=1768490451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/JIZCfAiC1QnwLzBVXe8TFLxLQbK/6zYtqQc68T5e4=;
        b=kfNjy+piNtXXPHE92zJviROGClWjRUftyahhnHFAsjg3l2GWFiD1rJOEv7xMubJZag
         +LiJCgKBbX8U6LwTHLpRz1sFtrZU+dDr7kZinxj87rpIPuNWlvaS16t7gk6mxjbQrGKO
         2iO4VRadL9aa3OvHiwrNGdEMzjksXm1kSGAr86APuxx84W5obT0/Zovesdsa4hLi0en4
         OjPvQSxAngx2+RyM2M1ytM2/iuhoAgCjzddT0R8UmvlcIt1X002nciJZf0F90btJ2xtk
         fitRXXnCOYbh8/9QAKx6MGGY4G9fAH/RzxRnYN4oRI7zRKv5Mh253NemlHYTBJlprHD/
         SjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767885651; x=1768490451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9/JIZCfAiC1QnwLzBVXe8TFLxLQbK/6zYtqQc68T5e4=;
        b=pg/jFC8pMTW/iPz39COCViA75thkvuliLjr6+RvrfIWPjm3pKFYGu/bcylBzaYrhEb
         QBbtW2YF6mxG9tg6C07h1WwsT8ObhEgDlkhOvd/lbTjhq/4WEaT5yKE7C+SKELn8U0WH
         dzXa8aRU9iXxFJDY0JUDH4zDLhbwrJ793mUtNUZmqPzYH+SGXWAiJo7MyshzZoetpuMy
         BR8qitsuH4dvFZ6q+e/DINSTgyuWvZAmuDtCdn2LP3nUPrCP+wFaGkCOFme6BIbEc/8Z
         axb2Mm7fnFRaXtJFg7i9P84l+af1/QcswSHm3oogzzyVLggDgedeDhQgAKOHxf41zbXe
         oVKA==
X-Forwarded-Encrypted: i=1; AJvYcCUhcyDRuslZGUnLeSxij7gNuQovGC2VLf8iGwTjXS1IFpRCj824xiYIxDPC0Fuf4GPA7H1ea8bxztYo2jNnze8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNJXT2DN3fGDHLDdUEms24wxh8rcuP6m63yFmMXeiS4TQVWeGl
	SUeArV/4SWh30X1jKJ1usQZQpB2gwTfaFvTAMrTw9KgK9v0c3FWWhOs17ujK5DdqSjN3xNCGnkB
	BbRWmFMRqtVo1TocOsoLp0AL1f8mmWKQ=
X-Gm-Gg: AY/fxX7MqwikthJajxS/qLDwpfNyDGfP6PmaJtKydf+x4P7bGkaWpflghSRTOM+bqXE
	gLepY8NJYxf45LPmp186+lm5qcJJk7SrAa4TGv3y9B4DVdz/fvOcZJ3VyOqud3kFvR1binNy/Bs
	Q2nT4G/UiFsyfoyWPPUJu9LZbi48pzkByocv5dvfgEls5ezf0j2w8i+xxT4BwdT2bM5TtCWtGUQ
	5DNCFQ2IL665xbUEHW49m4Bil0gKoOM7N8MermFeMdv8OdoWYNgCQn3+9s7/EhS056tu0oFZpIg
	rU0C4pSS1Kh9IOpUCymSWmMnmbAAG3ED9QYOnUkaRRov9MBws97HKziI+g==
X-Google-Smtp-Source: AGHT+IHIaDNyPiYW4/gVDoMZ5/V5DhYMj9dxGBcwyXCiHPhPTkAvIVT33X3EtiNIOawdn7cj1YN98kyvjENH+LNavd4=
X-Received: by 2002:a05:690e:13cc:b0:645:51f9:b4c0 with SMTP id
 956f58d0204a3-64716c390b5mr5189064d50.55.1767885650936; Thu, 08 Jan 2026
 07:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-pa_sync_cmd_timeout-v1-1-cd35538a9e12@amlogic.com>
In-Reply-To: <20260108-pa_sync_cmd_timeout-v1-1-cd35538a9e12@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Jan 2026 10:20:39 -0500
X-Gm-Features: AQt7F2rJVRyull8q99SU7whxWVzYyGQUqMknP1Ek7gdAB7VEl5JQ6WGdA_Hu1X4
Message-ID: <CABBYNZKATWfF+5ekMGGQxkq0_gu8UkEJ5Me3-d1c66rxJROy5A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: use HCI_CMD_TIMEOUT for PA sync commands
To: yang.li@amlogic.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Thu, Jan 8, 2026 at 1:03=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> PA sync HCI commands incorrectly use conn->conn_timeout, which defaults
> to 20s and is too long. If the PA Sync Established event is not
> received, the command remains pending and causes userspace timeouts.

Im pretty sure this is impossible scenario with bluetooth-next, since
1. only one work can be running hci_le_pa_create_sync at time so
HCI_EV_LE_PA_SYNC_ESTABLISHED cannot be outstanding 2. The
conn->timeout shall be aligned with socket timeout so perhaps the
problem is userspace is not setting the socket timeout correctly or
something.

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  net/bluetooth/hci_sync.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index f04a90bce4a9..58292b01f062 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -7159,7 +7159,7 @@ static int hci_le_pa_create_sync(struct hci_dev *hd=
ev, void *data)
>         if (conn->sid =3D=3D HCI_SID_INVALID) {
>                 err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NUL=
L,
>                                                HCI_EV_LE_EXT_ADV_REPORT,
> -                                              conn->conn_timeout, NULL);
> +                                              HCI_CMD_TIMEOUT, NULL);
>                 if (err =3D=3D -ETIMEDOUT)
>                         goto done;
>         }
> @@ -7187,7 +7187,7 @@ static int hci_le_pa_create_sync(struct hci_dev *hd=
ev, void *data)
>         err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_PA_CREATE_SYNC,
>                                        sizeof(cp), &cp,
>                                        HCI_EV_LE_PA_SYNC_ESTABLISHED,
> -                                      conn->conn_timeout, NULL);
> +                                      HCI_CMD_TIMEOUT, NULL);
>         if (err =3D=3D -ETIMEDOUT)
>                 __hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC_CANC=
EL,
>                                       0, NULL, HCI_CMD_TIMEOUT);
>
> ---
> base-commit: bdb9aba465a85122bcba01a6154e237b9843e25b
> change-id: 20260108-pa_sync_cmd_timeout-ff46f67b5d2a
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>


--=20
Luiz Augusto von Dentz
