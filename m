Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B542F5305;
	Wed, 18 Jun 2025 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252010; cv=none; b=O+nxwyIjhIs0OkAyUDYSdyN+6zGKsnRhFeu+Kl454al+EJDMO874Gofaw00YNykJtbLSfhfGqT8tK6Gqg1GwNa5161f+VrkLCbnEzZcwa4ml6/XLKfBI5jquJUAU81mzLyS2434ss+oSJM3TrQZ91DXNinUdZvsmKWlhrufRNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252010; c=relaxed/simple;
	bh=tlMWEJilkt2cS5jO2hp7is3uP2AslL9bH22DIQ6vfqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTBsR8lghBP19hEqvFWzlKmaJWyLUfGx780bKOGpe08LsHVTJIKeyto/O1JZbt0t816PIIkXnbzHbxnb4l7Oenjb+6rqJFcTMYe0KDxo+LR8NkG5LcFEPaz9CK5QLuTa5dnCxWyMnM8kZ9oCb9BlAcx2F12bXVjzNcAmjgdQv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFEJtO4D; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFEJtO4D"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32ac52f78c1so69202421fa.3;
        Wed, 18 Jun 2025 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750252007; x=1750856807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IoaHM/RtVhw0m2bgiBxmx6AGN/3kU5yrYxZsQ8EOw0=;
        b=QFEJtO4D0vFYxhPlgc5M53igIYurq33XdjNskAp6y+Di0W22Llo+AMne3wDBTf/Y24
         ObEssi0JQPq2JHdAxZb/Mo7qH43aTmXZdNLFqKAS0OtvUlKWvGx8SjuCm3bnFcLwRqk/
         iba+PYeCAUEzPqubgXjfo7HWhKOYXgJmU20ClgXoVTiboXkXb8f+529p9ITFs7+tPvxq
         3PFnlNCRzMv5Yw2WH7ntdkQYdcVl2Wphqku94/jy/12oYrfUZtbA0VROTnMB4n5gS/lf
         0Fx/o/ILn1jC110XC6EJJktjH7lGbB2HcSwrrC+olJiBJ4hVD00FceI4uF52yxyxusHp
         jDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750252007; x=1750856807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IoaHM/RtVhw0m2bgiBxmx6AGN/3kU5yrYxZsQ8EOw0=;
        b=R3Uq2FXFhEPKWwjQdKSXdTrWQcX6yPlr1IOjqUqXzBrmwoAEWbiWH4J7Qiat9WZ1dJ
         EivgWhkj2sZhVIQYFddIsjFx5wTw+CiBoX41J9QhkXyKQJzxcUVxIo0vbWRS1RgfvY4R
         hhRUb4GtnWDZMRZg7y17TWYh9p0I2Jcg/QOsWbMClacjOUjcIrodP1vnIkzI0PYgXYLz
         Bq1pQ/uU9gr8L9EeM9fvNCmmC4Bv+xlmjxDVyrEsaOnuv9jg/7moFXVQmSPpR8nINkti
         IoEJU5zVbFHsgcXQHhw2GG9V7ph7zW3SfK4l9WmgJJkNM6UVLUFIeRTA0Nq6Hf9kLdql
         7ZIA==
X-Forwarded-Encrypted: i=1; AJvYcCUs0QD7tjx/gNbc/tLomI3+l5cGNhe82GFxokS8T9yVDWevPu+DRwB3NnFG7jSB2ribxZVWVkh0zQruUPjq@vger.kernel.org, AJvYcCWVsTz7KFd4MHyAybCHtIloLhem6j7ir0U/VkmiFJqpaJQQk81gNbLX97Bqg4UeAySHOo+O7J/BKNqC2skXsqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Ij1FJ5Zxh2AFr/H5th1nBv4RRjgzTtx8DrhdZNgzIxw7X/lr
	qx3dfy/yhXkCrxQleYACtKmPeXSa78ExC6Vc1Gr+8fi4/k8wG3OecKv9uuY0HTWKm+i2KVgF/Av
	a+nNUopih/0TLVTzatIy9fEHY8eiUYUc=
X-Gm-Gg: ASbGnctqYfXT3mTfweRqBdtRCofWw+VBa2hRBCI/fpooSp9Ty6IX383Dd7sYvoGyTzw
	iHT8qtmiWSFFLT7lrv5jqK7bBJ5ZvRtqod95hGdF+7bWtn6odw6grGi4/s0ymbg9rPC3li+6oPW
	wi9AtwcWMJQZLRG5McZ4P+jXPIBU90e6yC0tDX36vh/Q==
X-Google-Smtp-Source: AGHT+IFW5eg4nDCvWVC3JaKdWEEDmDOfiZXHEF/NsB44p9dKG3WhCdZHPJSSi8VPpN/yO04GE11Mq6EPx0yaVh6w6/c=
X-Received: by 2002:a2e:b893:0:b0:32a:83b5:34ba with SMTP id
 38308e7fff4ca-32b4a4a996bmr51046381fa.20.1750252006463; Wed, 18 Jun 2025
 06:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-bluetooth_adv-v1-1-6876bf4e85b4@amlogic.com>
In-Reply-To: <20250616-bluetooth_adv-v1-1-6876bf4e85b4@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Jun 2025 09:06:34 -0400
X-Gm-Features: AX0GCFtcrAqEx8zuj1i_twEve05S-BIMcFl7MlWPA_YLxLwUWdzwUitbSQwORvQ
Message-ID: <CABBYNZJnakr4Yt8GUVurYkG0G3GJS9-zvZe2CO0LaxS3QZJBVQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Prevent unintended pause by checking if
 advertising is active
To: yang.li@amlogic.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Mon, Jun 16, 2025 at 7:05=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> When PA Create Sync is enabled, advertising resumes unexpectedly.
> Therefore, it's necessary to check whether advertising is currently
> active before attempting to pause it.
>
>   < HCI Command: LE Add Device To... (0x08|0x0011) plen 7  #1345 [hci0] 4=
8.306205
>                 Address type: Random (0x01)
>                 Address: 4F:84:84:5F:88:17 (Resolvable)
>                 Identity type: Random (0x01)
>                 Identity: FC:5B:8C:F7:5D:FB (Static)
>   < HCI Command: LE Set Address Re.. (0x08|0x002d) plen 1  #1347 [hci0] 4=
8.308023
>                 Address resolution: Enabled (0x01)
>   ...
>   < HCI Command: LE Set Extended A.. (0x08|0x0039) plen 6  #1349 [hci0] 4=
8.309650
>                 Extended advertising: Enabled (0x01)
>                 Number of sets: 1 (0x01)
>                 Entry 0
>                 Handle: 0x01
>                 Duration: 0 ms (0x00)
>                 Max ext adv events: 0
>   ...
>   < HCI Command: LE Periodic Adve.. (0x08|0x0044) plen 14  #1355 [hci0] 4=
8.314575
>                 Options: 0x0000
>                 Use advertising SID, Advertiser Address Type and address
>                 Reporting initially enabled
>                 SID: 0x02
>                 Adv address type: Random (0x01)
>                 Adv address: 4F:84:84:5F:88:17 (Resolvable)
>                 Identity type: Random (0x01)
>                 Identity: FC:5B:8C:F7:5D:FB (Static)
>                 Skip: 0x0000
>                 Sync timeout: 20000 msec (0x07d0)
>                 Sync CTE type: 0x0000
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  net/bluetooth/hci_sync.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 6687f2a4d1eb..4ea5a87f017d 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2481,6 +2481,10 @@ static int hci_pause_advertising_sync(struct hci_d=
ev *hdev)
>         int err;
>         int old_state;
>
> +       /* If controller is not advertising we are done. */
> +       if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +               return 0;

HCI_ADVERTISING is for directed advertising, it shall probably be
changed to HCI_LE_ADV like in hci_disable_advertising_sync.

>         /* If already been paused there is nothing to do. */
>         if (hdev->advertising_paused)
>                 return 0;
>
> ---
> base-commit: 6c31dab4ff1e1f4e0f3412efb1cfc88033358d1f
> change-id: 20250616-bluetooth_adv-6496e1ca6165
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>


--=20
Luiz Augusto von Dentz
