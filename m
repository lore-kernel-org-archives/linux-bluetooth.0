Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3C3DD87C
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335520; cv=pass; b=sVB0XQPlVxDq4pb+TwMfr8Wdnv0ZyI9Z1yRC35TumHrrCFCqZWc1M2SWxqi/e7fxPcUMU/CYY11KdRuTDrtGzqKZBOBspv0Gc9Sv7ycyGnj+8vXsiFdSYcxzfMBh6YF86wE5WYweXk2oCUQvDsmQu/HFeBhKWGnaUV7qDZAkpro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335520; c=relaxed/simple;
	bh=KX0XQNGsZTluxtL+cZn6olzXsQ1zo7cmoLJGahr5L+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggyI3TZ5PAbrC0BsEQRDxVmChtPzUFZe60REQdq7w8IaT8h/T7ggCETQ40J9ql5/OKoXjNpiLJ9TCUP5xyBYN1jW+sUsCISEuHzwyOVrYPQiWj3YEr/oP4DF7F6V3uUg+bb1OZssB344m8DuVggoKZWy8x505Fn+ZEW9tLJ/cDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9blEU8z; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9blEU8z"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7de68222e96so27191407b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 10:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780335518; cv=none;
        d=google.com; s=arc-20240605;
        b=CLQUg6WM0eHC4FiBkruPzDS3ggiL8vz9b2rMjMPBpTrUAXzwKIX6meBi8owZR2EH06
         eMkEBAXlRedLMj9NNELoCIm67PA75VQPxjQWN9/P+kGFnsxSZ0W6h83Zdh/wymD1FmlM
         w1HEBk3kpyE+JT7sz1Uxl8sMfYSCeJGLxygP3Fn0ZwnzH+zlSb76kPnO9OaOtCxT2v5g
         m0DeG9O6rvnzhemKYo4WZ537T0RLDDhlJy/iW1OdM+pVAK3X+RadSHw39kNGQ0m+nYfu
         fhBZLWSuf+7oLPJjMAInRVX9q0nUPObJy4iF+hENUeB0ijQjh6R9iqbagqliadUPfJWH
         xZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kikUTBkBN+bs7+4BxhCLt47m/V/awmsQStRgzzJQu1c=;
        fh=1Qd8KxMnxWqGo9pbBQTcX0DzeaM7DBaxxJQTeSiJ1Gs=;
        b=MJZsaTwW0SUbEfVxXBGxckcN39CbWXcw62oyiGbmOxbkd9a2UhcQV5oUfdCQGjD5kK
         luV40zXMsIq1Nv1ZZSki/jPwJOYUI8/5pB4Yv9U1UCZLyy3G+W2ZaOyXveeTe4xtHWXU
         og0dVIaZrhepSDjhz6cktsZ3jskBVKc7LsSwsSn+UL3awe9LA7moLRe/I5X9qzjjrBd6
         YOLhdjxFx989CaHu+ke3ege5rSfqjEcMX3fz0PV4D0umcT5qZTcyRiHoa1g66sbTLrig
         KRDhRBysySvA6qITGGW6tRx+GbLxV+8L3VX2PW9tFQ4nGGqAfoNlhEUw6GMDIePbZkTS
         1M5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780335518; x=1780940318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kikUTBkBN+bs7+4BxhCLt47m/V/awmsQStRgzzJQu1c=;
        b=S9blEU8zvZgt/AYUJXbTOUYOV0914Xn4QWbdjSZUJAqe5SMeYrLiC09nGFAtfiTD74
         c/Aaaw23M8FpbCaIebGgsp8dcy7sM8Su4I7ud0yQYzyjMCDyRGbQ1XTn3VO7tgoBMdOS
         /K16Ra8RS/KZQjcWwRw7CtNTdDaQBXLcyloXL2yXxuIKdzbz7Av9y//o+ZW1JpGsqS9Q
         K5uSQJetRCnom+LHwvU0VqEAi+clhl1WlMm/FlLY8YSeYmZr85elS/VcBsSqg/63wxtk
         AV1OcTYB8zgrdbWuqBnkqCYNzsAuqSZa9G6YrCKb306P1emb3w5xEiHKyxn/NqvRD3XK
         Fgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780335518; x=1780940318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kikUTBkBN+bs7+4BxhCLt47m/V/awmsQStRgzzJQu1c=;
        b=Hos8gt/BNZQDpUBI0ReUXqzgtYBD0o5DlByVOI2QFKlCS0nvJmXWhfitydE+17RDFt
         dfBMGrbacH9CABBusARBgzCNpOh1GHrQ2/AkFg5zwXX3LLwuk5B2mpkCxLSwjHgUZu9c
         qXZ3xcAs716vBH/7mR7PNJQfbena6t74Fx3TsanwndaSOsIsIx5icH1FdiEGAH16tgvF
         6cu9NMi2RskGlbgigkQQA6/6+xJi3gPZDEbwzVCV8vZz9dD91PW8M3Z1ty0ABKM7sDUf
         HEypblT2zDyQSFVK3xUOJVnAxbuxd1021/4wJEHVbtFJP2aONcBg3XZB0ped0jy0upJp
         Bwbg==
X-Gm-Message-State: AOJu0Yxhc/fy8UhoPl+mEkLmiH7QmehxgV9hUBRxjuArphUs7CcTAUbg
	XhkBagwkSHVwtogWkp6TeMOqjgb6b7Gc78jEoLhJhuj3+Gf0LF1SdkzhtrcwrGvz4qXeEDc3sFH
	6WK5BflDnk3ijBI+tzZ1XrKOsG47wiJ/8NLFMya0=
X-Gm-Gg: Acq92OEQwSBNvJOlLuuMGGRZfk6ZU3QFBAShcJBVs4MulS62ILyJdeLSIvrj+ynoD2N
	IlIxIsLuYxWOcxEli+GUqH6JGAWWavangfbu6aSCC4cPLNqlEFr5XOp7WoONOYI60fAC6SDJydE
	Jtly8KVW3l5Zy+jU9Ezx7nyADklErq6SOW+rD3k6tPfcjqyZ+E/c6ONQkKc3V6WUxOj+Aj3cyfG
	Q+jLkbbIMlygEv+Suqgf2LSVjhwuG8Wd4TSYLDpZdLbotrzVS8TrAU4Skg5NB2Xmn0j07G+ZYA7
	dcPYjAprB11l0PlJj85TjactS7CcF59iCu/eB8K8kBUdGnlSbwY4KDqtAhuVBPq08AhUIXmqCRN
	mPQ==
X-Received: by 2002:a05:690e:12ca:b0:65e:4b1d:c67d with SMTP id
 956f58d0204a3-6605fb3b60dmr10325461d50.53.1780335517834; Mon, 01 Jun 2026
 10:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601162203.1253918-2-xmei5@asu.edu>
In-Reply-To: <20260601162203.1253918-2-xmei5@asu.edu>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jun 2026 13:38:26 -0400
X-Gm-Features: AVHnY4K44j91gKtI0pECr6qb5GpFSzFmthrpwnZatseFc7W99MmTuQud3JjgzS8
Message-ID: <CABBYNZKmodLjPqOCtmY9R-4OccC2vBV=pDQfwY9vCFbwZo+LtQ@mail.gmail.com>
Subject: Re: [PATCH bluetooth] Bluetooth: eir: Fix stack OOB write in eir_create_adv_data()
To: Xiang Mei <bestswngs@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiang,

On Mon, Jun 1, 2026 at 12:22=E2=80=AFPM Xiang Mei <bestswngs@gmail.com> wro=
te:
>
> From: Weiming Shi <bestswngs@gmail.com>
>
> eir_create_adv_data() builds the advertising data into a fixed-size
> buffer of "size" bytes (31 for the legacy path in hci_set_adv_data_sync()=
).
> It may prepend a 3-byte "Flags" AD structure, but the per-instance
> advertising data is then copied without checking that it still fits:
>
> skip_flags:
>         if (adv) {
>                 memcpy(ptr, adv->adv_data, adv->adv_data_len);
>
> The "Flags" structure is added whenever BR/EDR is disabled
> (LE_AD_NO_BREDR), which is the normal state for an LE-only controller.
> However, the mgmt length validator tlv_data_max_len() only reserves
> those 3 bytes when the user-supplied adv_flags carries a managed-flags
> bit (DISCOV / LIMITED_DISCOV / MANAGED_FLAGS). Adding an instance with
> flags =3D=3D 0 reserves nothing, so adv_data_len is accepted up to the fu=
ll
> buffer size. At advertise time the 3 flag bytes are still prepended,
> and the subsequent memcpy() writes 3 + adv_data_len bytes into the
> size-byte buffer, overflowing it by the attacker-controlled tail of
> adv_data:
>
>   BUG: KASAN: stack-out-of-bounds in eir_create_adv_data (net/bluetooth/e=
ir.c:302)
>   Write of size 31 at addr ffff88800b7e7bac by task kworker/u9:0/51
>   Workqueue: hci0 hci_cmd_sync_work
>    __asan_memcpy (mm/kasan/shadow.c:106)
>    eir_create_adv_data (net/bluetooth/eir.c:302)
>    hci_update_adv_data_sync (net/bluetooth/hci_sync.c:1689)
>    hci_schedule_adv_instance_sync (net/bluetooth/hci_sync.c:2015)
>    hci_cmd_sync_work (net/bluetooth/hci_sync.c:332)
>   This frame has 1 object:
>    [32, 64) 'cp'

Add the btmon trace of the MGMT command when this is triggered, and
explaing how the advertisement was created, as with bluetoothd?

> The inconsistency dates back to when the managed "Flags" field was first
> added to the Add Advertising path: the prepended LE_AD_NO_BREDR flag does
> not depend on the user-supplied adv_flags, but tlv_data_is_valid() only
> reserved room when MGMT_ADV_FLAG_DISCOV was set. Commit 47c03902269a
> ("Bluetooth: eir: Fix possible crashes on eir_create_adv_data") later
> added the "size" argument and bounds-checked the "Flags" and "Tx Power"
> AD structures, but left this copy unguarded. Guard it the same way so
> the data is only copied when it fits.
>
> The bug is reachable by a local user with CAP_NET_ADMIN that owns an
> LE-only controller using the legacy advertising path.
>
> Fixes: b44133ff03be ("Bluetooth: Support the "discoverable" adv flag")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/bluetooth/eir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
> index 3f72111ba651..e574f8f61e16 100644
> --- a/net/bluetooth/eir.c
> +++ b/net/bluetooth/eir.c
> @@ -297,7 +297,7 @@ u8 eir_create_adv_data(struct hci_dev *hdev, u8 insta=
nce, u8 *ptr, u8 size)
>         }
>
>  skip_flags:
> -       if (adv) {
> +       if (adv && ad_len + adv->adv_data_len <=3D size) {

So we have 2 options: 1) Don't add flags if there is no space, or 2)
Don't add the user provided data. We should probably choose option 1,
not option 2 since option 2 probably means the advertisement is
useless.

>                 memcpy(ptr, adv->adv_data, adv->adv_data_len);
>                 ad_len +=3D adv->adv_data_len;
>                 ptr +=3D adv->adv_data_len;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
