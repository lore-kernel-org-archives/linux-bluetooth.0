Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A527212D7C
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161830; cv=none; b=jybs3lst0VpcWthBu7PG5dULBi24OumW8c7AbDqZugQF+YbY6YpE6iYI8lmuXtsjBsxv0oRF42a1S1QUGi4qGXtBWzVwZatBJKwb9U+JXP3ZcOJMaEGLD1ymmEMwcVIKxTz3o1drlRxjS2PXn1RYfyZgGYaUfVJCekznvC4tmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161830; c=relaxed/simple;
	bh=3rje9DnS8KN8t+I7PxpU66D89Ss9E55kcIYwJrGqnUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=VxLmM0GQo77LvA/79V7/qZcRW+ZJyc7kTYKUWLiRFu/SCv+p1LW0ZdawK/DNPAsa56bnrZwc49QX2YBexks2UgAeqwq+dD+35KCpmynEOkBRNtmHuDQ9LIRr9uKNRDbcEJSeMs4gw6vn3NPkoozT243SENB3IoVGiVY7GQMSO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyNoLmv4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyNoLmv4"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5957db5bdedso2244024e87.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 08:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766161825; x=1766766625; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv0TrkzmH86d4UpM6TrRkEQsEVKUbxajpiHyZvnVOnI=;
        b=MyNoLmv4LWt0CXzJdUm8oLrzLSd/Zpe49oGXc9qABOopzXNG3zR79w6lzpHdVgXuND
         QeNSQGxs8+8yeN1fpSxTgAzaIl2sw6ZYk6/UyYX1oHmFzQDxvIjOfNIrki5OAfgaUM77
         iJiPqjQ0yT49+2EnTvc5r98eDo8qGY/EFJeYdvP8m5jB6WvvWcWE4GYXX1WmzH9xIbkL
         FaebPuDtAT8iAkrU7OkqvydifKqTf4RYAtNtrb4iCNeKgpbPlgMFXJ953RpSngiHwLBj
         bssmdWl8XmF3/3VRtXf6nfbCJejuxUc7qxEub3eVVboK6lje+aq3NRUfqN54pAtn3GdR
         nNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766161825; x=1766766625;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bv0TrkzmH86d4UpM6TrRkEQsEVKUbxajpiHyZvnVOnI=;
        b=aXg6gn9+i6poPVpGWwth4I6XzC532N5THJRhBaDJpfdNxeQGu0Y2bwybZfKRgs43XG
         pTYhUjS9ygzENFVhg1TPgQeNcvW51LyYQRwiXHLOWmtqyitddt8D/Teii5PTN1+iqWAR
         1qftbMa3gKbAb9Bs5dQd5idD/MS8dxn37nJ5OFwAPqUhA0iECAlyohAgdWB6fQRjRD0L
         C3yexCIS2VPX5FyV8KJlxXo6aNZ40LZLBIdGaAIKTQ63F7CRUSIW4Aw72bU5sHE2Wv52
         /gyIsq+QbsyhZGCmFLEVvu2RiaVCZtqcxnps4Mcia4B1z7NBavlNn+dwSFC3FfPVuOyG
         8z5w==
X-Gm-Message-State: AOJu0Yyds1V7+OW34M+T6UDmi5ZJmPvQSmoMhtLBqorhRy2vT7icdIXV
	yYIlo4d4cm2Q5eqzHw+opLT0IsGZkVQxAcgR2e3OlwjqczBlEvYBrzzRdgOrTBh3JsBqo33Gu+m
	OX4GEWufLFX5euF7y36B7oPb66O30DtBpiMutp7z/Lw==
X-Gm-Gg: AY/fxX4Z63MRxN2AZxH4MhZBVvprXH/3LEImdvlW1+G0KTD7+TicwsDe/aoT5g9auPm
	KQYUSBUtoXRv1i/xDuDNyetyFuhTtHAFivocWTuC43d2/h9lJcOGKeaKsZtY/T+1AucXNk0ahDZ
	oN3LBn6kr0BOeXYN9jnwt+OdAxozU3AiiUWuGXFdL8rAhVgXjlP4IHY0VBzkTsIW2+Uf1qxSppL
	CDU9x6gXO6yLtb+R3D8DFnjjx09/1m8CK/sLMilU7ziumZLqVWPZPPxcw4EsnVwESbFIw==
X-Google-Smtp-Source: AGHT+IG/0jXFmvX7U4tBppBLBVV7nnLYr6WTd663p7CUoNXjLj7xGeN/+yPfTsw/QRmKIcOYkJ1RwzoMms45cD9kuUA=
X-Received: by 2002:a2e:bcc2:0:b0:37b:a751:9cc0 with SMTP id
 38308e7fff4ca-381216a2184mr9757421fa.42.1766161824942; Fri, 19 Dec 2025
 08:30:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219162820.320823-1-luiz.dentz@gmail.com>
In-Reply-To: <20251219162820.320823-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 19 Dec 2025 11:30:11 -0500
X-Gm-Features: AQt7F2q3_sr3lagRQuZm3odYf8Z-4XzKWAKrvPeoGx6X1b9SvqN1IpISKcZZHuU
Message-ID: <CABBYNZLuSFMttw2XU+F8+-YGL=yfhoWE1=jj3b5Dq9QYG4rAZw@mail.gmail.com>
Subject: Re: [PATCH v1] fixup! Bluetooth: hci_sync: Add LE Channel Sounding
 HCI Command/event structures
To: linux-bluetooth@vger.kernel.org, 
	Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Naga,

On Fri, Dec 19, 2025 at 11:28=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  net/bluetooth/hci_sync.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 5de98be752bc..ab0b68faa61c 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4570,27 +4570,43 @@ static int hci_set_le_support_sync(struct hci_dev=
 *hdev)
>  }
>
>  /* LE Set Host Feature */
> -static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
> +static int hci_le_set_host_feature_sync(struct hci_dev *hdev, u8 bit, u8=
 value)
>  {
>         struct hci_cp_le_set_host_feature cp;
>
> -       if (!iso_capable(hdev))
> -               return 0;
> -
>         memset(&cp, 0, sizeof(cp));
>
>         /* Connected Isochronous Channels (Host Support) */
> -       cp.bit_number =3D 32;
> -       cp.bit_value =3D iso_enabled(hdev) ? 0x01 : 0x00;
> -
> -       /* Channel Sounding (Host Support) */
> -       cp.bit_number =3D 47;
> -       cp.bit_value =3D le_cs_capable(hdev) ? 0x01 : 0x00;
> +       cp.bit_number =3D bit;
> +       cp.bit_value =3D value;
>
>         return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_HOST_FEATURE,
>                                      sizeof(cp), &cp, HCI_CMD_TIMEOUT);
>  }
>
> +/* Set Host Features, each feature needs to be sent separately since
> + * HCI_OP_LE_SET_HOST_FEATURE doesn't support setting all of them at onc=
e.
> + */
> +static int hci_le_set_host_features_sync(struct hci_dev *hdev)
> +{
> +       int err;
> +
> +       if (iso_capable(hdev)) {
> +               /* Connected Isochronous Channels (Host Support) */
> +               err =3D hci_le_set_host_feature_sync(hdev, 32,
> +                                                  (iso_enabled(hdev) ? 0=
x01 :
> +                                                   0x00));
> +               if (err)
> +                       return err;
> +       }
> +
> +       if (le_cs_capable(hdev))
> +               /* Channel Sounding (Host Support) */
> +               err =3D hci_le_set_host_feature_sync(hdev, 47, 0x01);
> +
> +       return err;
> +}
> +
>  /* LE Controller init stage 3 command sequence */
>  static const struct hci_init_stage le_init3[] =3D {
>         /* HCI_OP_LE_SET_EVENT_MASK */
> @@ -4618,7 +4634,7 @@ static const struct hci_init_stage le_init3[] =3D {
>         /* HCI_OP_WRITE_LE_HOST_SUPPORTED */
>         HCI_INIT(hci_set_le_support_sync),
>         /* HCI_OP_LE_SET_HOST_FEATURE */
> -       HCI_INIT(hci_le_set_host_feature_sync),
> +       HCI_INIT(hci_le_set_host_features_sync),

Let me know if you have any comments regarding this change, I'm
planning to amend the original change since it hasn't been pushed to
next-next yet, this has been found by:

https://netdev-ai.bots.linux.dev/ai-review.html?id=3D999e331e-1161-4eec-ad2=
6-fafc3fea6cfd

>         {}
>  };
>
> --
> 2.52.0
>


--=20
Luiz Augusto von Dentz
