Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B828727C;
	Fri,  1 Aug 2025 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063878; cv=none; b=n1RqGmPllPyrwoJV5Ph4rhWQdDtRS2AXVQvkUeirEgwRj640NYcCyzr7TRDp0VQBDBWLXqkk9DBcrOH5KCjrKN6INRW/u+XT2smkX441KCp9p8wIMuoMkPotqu0eMvEYu2ujxlBfeN9000SIVc2ULlMVeHREORTl8XaQ3l9lcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063878; c=relaxed/simple;
	bh=9hup+ts6H389VBPmzqObyPrifVRhy4TatN5AbeUY2iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBLl/SKRfZjAUEjw8fy8ktTKIhjwnEB+p+lyfgqJ5LeF1FOuvwPwu6fu5EGgdv/ZeJ+pxsJxn0d2xs4sTi3tW98h4cXGaLTVSQqF0IpiU3/q48w1I1jAmMOsgsaoCWF3KjNzlZoSBn/4bGnpfrqcTezaUxgLboACIv6vJbt5MG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuX8EzgW; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuX8EzgW"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55b79ea50f8so1878545e87.0;
        Fri, 01 Aug 2025 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754063875; x=1754668675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VvudzAIJzhH76ohIestnUnL2H/t2R/HphAlC3uM+pw=;
        b=SuX8EzgWXzyPUXMW5wECgns5tyvszDD8aklEGVrkEH62wy2FvpVZRygDI5EMGLljLa
         fe6r/elWHtFhch8UpqPHxE5KDHNg6d7ZifqCV4klGuxIMARHlgFxWO5YnkGuwBO7V2w4
         YUL/ieJSI0pEKV/ZlNihu2prkqjtl7oUn4MrBhySqvakO3ofVwrB3K4TC87cKub4RJjR
         Inha1wFVo+jFjWtlqSIkpWTLwxmJV3aDxyQhc1qbdy29/fNlSARHcSJ1ThWrFO/gFv1x
         S5bAEEpEKSSnN2pDlG4jaZssjmslPp9kYM+2HCIJrZjJ9Yl6ygEXVXd8jhpdM3Uao3QR
         lMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754063875; x=1754668675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VvudzAIJzhH76ohIestnUnL2H/t2R/HphAlC3uM+pw=;
        b=wBfVaOpFhY1I//TQ8k3D4TvmzBDK/rbmwCKoYyx/TeQp+p8B+QOlZRAFPNyOCvjaRX
         WX3B1i/yTeny5vLlmcNIhpid8w4IyBHVopHio6TY3ZPsWWuf/ZGrnPFOL5W8M7SikIQe
         f37neSIfk6IJi9eONC8acbKLy1NAWlRZHxGf9oMIMw4CKvT58dYvIolMxTsACGnHQLaX
         OQ6x/fqnSsaD/t6/ixXJFBIC0JSbGnmBRKIRtdRsYfIdP7T+t2LW9NfzhNA5wbMnaU4t
         bJkdko1V0nyAw9ql9sLP/uT/iJftqEvCe1wCjDt1WoF6pyqRnk0noxm25s7gXQfKjH8s
         qFUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHAjYEANkzdp7HgkrKdHIacUq2VyJpla1G1smj2gUV2+7HKjxUqcO9TpM2P42TXcumx8c8eyozSm5PIcqCHGc=@vger.kernel.org, AJvYcCVwnW7Uz7JEVUvyILOSJVNBwkm0mkpO8YfUU8O1KSUyuCli8m2x4tF8SG7RXWmFcJqDj6APIaU00al6uTzr@vger.kernel.org
X-Gm-Message-State: AOJu0YwDlUiAS80i10F1bybEaSgvpzqyYhw7tfMMOvarGWkZqTD1RKK0
	TTJlZKsNo9KVY8T0P5inUvPGdp4COf3jiB7mIJ+P7oFqi9RAoArj+g0KAD7GBdBbJZaBLH+oRpZ
	nYf33PDiQvG8Yv7ADJCTaLO/u/n6fhfQ=
X-Gm-Gg: ASbGncvTmLbCiCJSUT4wOmD+jMGyYEmmlyqZ8Pr5dYh2dpKrbap97v1HM50CmRmC3rb
	0OeUw4v9Ss+IdTJgiQNLNjBGO3/+RGVyMhxWDW9X2JyAsZL55kpRTr9sl6k3rAtauxIhKPSqtSO
	x1Izo2boSD/zojXXVMBmRK/nX6sIZOVF+8yVPLlsQSlXh0Ml3bpnL8iz4TPghvch+0ieExXTYGq
	49AWg==
X-Google-Smtp-Source: AGHT+IE6Yt6iDgb+tRl+UfS4re9d01zMUis3JNGKoNWNHgJ48wF55I3TK9egBf1KUWQxvH8FLZaX3zJj97wX6V7FQxA=
X-Received: by 2002:a2e:a884:0:b0:32b:b0f8:fe75 with SMTP id
 38308e7fff4ca-33224bd6915mr41280771fa.29.1754063874417; Fri, 01 Aug 2025
 08:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
In-Reply-To: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 1 Aug 2025 11:57:41 -0400
X-Gm-Features: Ac12FXwRReFV8vyfVeX0pajTzXu9yIhVrZ-Mx5kkUr_Y5BachubzJ6BgD5OB7rs
Message-ID: <CABBYNZJu3izq6ZhNRKjMz-mW1CcP2VAE7Xs5oq=NupnVD7aayg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
To: yang.li@amlogic.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Thu, Jul 31, 2025 at 4:00=E2=80=AFAM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> When both BIS and CIS links exist, their sockets are in
> the BT_LISTEN state.

We probably need to introduce tests to iso-test that setup both then
to avoid reintroducing the problem.

> dump sock:
>   sk 000000001977ef51 state 6
>   src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>   sk 0000000031d28700 state 7
>   src 10:a5:62:31:05:cf dst00:00:00:00:00:00
>   sk 00000000613af00e state 4   # listen sock of bis
>   src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>   sk 000000001710468c state 9
>   src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>   sk 000000005d97dfde state 4   #listen sock of cis
>   src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>
> To locate the CIS socket correctly, check both the BT_LISTEN
> state and whether dst addr is BDADDR_ANY.
>
> Link: https://github.com/bluez/bluez/issues/1224
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  net/bluetooth/iso.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index eaffd25570e3..9a4dea03af8c 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1919,6 +1919,11 @@ static bool iso_match_pa_sync_flag(struct sock *sk=
, void *data)
>         return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
>  }
>
> +static bool iso_match_dst(struct sock *sk, void *data)
> +{
> +       return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
> +}
> +
>  static void iso_conn_ready(struct iso_conn *conn)
>  {
>         struct sock *parent =3D NULL;
> @@ -1981,7 +1986,7 @@ static void iso_conn_ready(struct iso_conn *conn)
>
>                 if (!parent)
>                         parent =3D iso_get_sock(&hcon->src, BDADDR_ANY,
> -                                             BT_LISTEN, NULL, NULL);
> +                                             BT_LISTEN, iso_match_dst, B=
DADDR_ANY);
>
>                 if (!parent)
>                         return;
> @@ -2220,7 +2225,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t =
*bdaddr, __u8 *flags)
>                 }
>         } else {
>                 sk =3D iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
> -                                 BT_LISTEN, NULL, NULL);
> +                                 BT_LISTEN, iso_match_dst, BDADDR_ANY);

Perhaps we should add helper function that wrap the iso_get_sock (e.g.
iso_get_sock_cis and iso_get_sock_bis) to make it clearer what is the
expected socket type, also if the hcon has been set perhaps that
should be matched as well with CIS_LINK/BIS_LINK, or perhaps we
introduce a socket type to differentiate since the use of the address
can make the logic a little confusing when the socket types are mixed
together.

Now looking at the source code perhaps we can have a separate list for
cis and bis sockets instead of global iso_sk_list (e.g. cis_sk_list
and bis_sk_list), that way we don't need a type and there is no risk
of confusing the sockets since they would never be in the same list.

>         }
>
>  done:
>
> ---
> base-commit: 9c533991fe15be60ad9f9a7629c25dbc5b09788d
> change-id: 20250731-bis_cis_coexist-717a442d5c42
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>


--=20
Luiz Augusto von Dentz
