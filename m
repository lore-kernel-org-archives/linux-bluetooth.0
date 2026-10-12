Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274142FCD8
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816023; cv=pass; b=RIW6OIF2OiG0RsAIwVE84JNDqf6e55gQgyUYyBVp9ZEXw23iXOwowdSeQAHSdAFMCxWxWwDkv1KxKnhOOf2QIVcxPuxgFxxRKbAnx/n836y68LsFqVoyMfdSkki1kFUYlCWPBOpsGFQj1rC9slKP79Jd06hudXDzCkJlzwKywHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816023; c=relaxed/simple;
	bh=vyjFk+OVzX73rkv+Vf4KwdMVbobAdz3wh39L0hTuAmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3fw8CEB8xhgHBkmu4SNgI4ZrXTh5atOgk20kKOWLlsUvKxioqsAuHS8114zod9OmrDl3SFSaNwMewmdNdEhuOZdSjJc/xKlI0WYA6oAYIvJRkEfHCoyJEZ0wSqgmg4dQbMkjBNkuuUBdxXmlQUPJjdio1fxZMxDd4qgWCp4EoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYWzYxqI; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYWzYxqI"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8acda240937so12973377b3.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 07:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816021; cv=none;
        d=google.com; s=arc-20260327;
        b=kRWF+bhQ8bEoBQejq+mRoDxRN6KrNDeUTziSgllf3ocB20o0VqJebm3ZzTx3KBMP1Z
         va37C48CaRZn+kQNghCylQopuyfF0Y9mawJ6yLe2qju9rdxfjpFiLENdCjQj2zNIsEnz
         01ONrzArh+KmoY5n68UiqWQlpT7r8gPu+VXthpSMka8Y5EEjdBJmZXcT1bSFxBXNgcux
         jU0gRE5XZECo+5+SuK+YRy4NTLQQu4VT1ufi9JUAmL5sPXRq4NCZs+83nBHc94WvIStm
         CYCZUPXydFwZm8KMNZsOyyCKBHUSvCE9tk5NtWWciPbDlHVrE/YfgkaqftZ3XJ/cnUVh
         88PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JCv8gBANZutmGTGlF/Uql5wg79snoB/nJkY2lKkKjE0=;
        fh=Z2zAN9xr5NDqfMpxnYv8IVTT6hA8iqz8XLtGvvSXg8E=;
        b=KEf6kh8LMfwgPZ/Rib34zbXNm7tLEsYEoYyekqg34/wL73GbF9BQqosdXmRACHEjAU
         xHinhKCiuzLP0JWpfOeflnZztsjod06b7pCwIuWyexzDYvlcsCBmEZNn1WcguDoic1AT
         /TFpmf9yONOplV28LvKxAyd/LMbDU9SvcK7EVOPK0ljvYNp/fDbXzANYOkeygQrpv0E3
         HaqXVN3JN+phQXwmEEhmtssV+eybXKLe3Wzao3UZiSCpWxagsDDRNAQg2CyOXiPECekY
         0PdY+hzK+QKuHe93/fplEUF+Vsy9Bq4QOq5mvsx92IdnYNyKLPtdKrF6kY843Zo4r1jB
         8MKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816021; x=1792420821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JCv8gBANZutmGTGlF/Uql5wg79snoB/nJkY2lKkKjE0=;
        b=qYWzYxqIFGs3ZcdrTMmsoWwJ7uja2OrKnsz9Hwne++42sA9Kkc3LTKJb26bHqSrzRf
         526eQ7aRiBtH0yqR8VoaaOsoVX602ReVnQVj15aOH7L7XzGo5Yu6Z8gclMxgn399S+0R
         vqJnKYI+L5S7ihpEDfDYum+ttp5dmKeGJLlabUjSnjI0AP1dLpNO3EbZ3NPXkwNLooSW
         yIzzPDbqDT9NCwww1bmsGLcoGXLMA91Bjk0AHkT7Wop7998l00FF/DYTjFROx1BYaKsy
         gYftlevQY36i54UMOZQhMyzTuSLgG6pyjQDrAst7L8IQK2H65u02XArTiig8DHZeb3pA
         AEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816021; x=1792420821;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JCv8gBANZutmGTGlF/Uql5wg79snoB/nJkY2lKkKjE0=;
        b=XB6bi/wKsGDjblReDjzHNylW6O8HPb4Fo7bzEb0NIeyj1540+RRu692CbVAzPdOElA
         C/Ct1FNRwSVDWzyLV8ypp+TmbE+FvPuz4yircLVWUzUU5LJQNRwz4lETF1UoT6u5X3/G
         QzZMyRaQjM6lABobaE7iaub6crBd/zLsVppG4f+DwP6d3HT4f6nfW8Kuz/tDhLcq7g39
         RhwIAy9gDSZ8Yim3nhtB+IK91Q1ZTQe1B0+bDg3ucrBZxoMpvEjfeNY9rkV8UQzZC0+p
         jkDs/7+55xaSvRBo9S5/8RZEglFi7/wQmZnwSsixx8YuLfQKEermqy6OQluxAg0x/xWK
         2PVQ==
X-Gm-Message-State: AFq9FYLtHIYTgj/ifTnFRouAJx6829X5kVPtIDq5xtI/ByFF0miLie04
	WJQ2qkRmKbBOj42uldo9oc6/LflRX4ILpqv7udPHDrWFOq0j7z2HTDS1sUNi8kc7tFJcz99IxeC
	naOhnv/9Z1nq1CpoZMaBTL6IHe62Krg8=
X-Gm-Gg: AYBFou1xi5b8R1Z9QYqcBCOLPPINWcNrtiBvC5ycl30S5PPugUO3q3jnKAMponDnAL/
	0u0AVh2Bn8hQaaRmd5iknJ3O3+lCphJ9Ydb36Zw4pO04BImewQ0VHfVJmxdx9tsZnKmDSoC5HwE
	WcgAt04a3WMkoypHa0NGSFDmVo7Tv6Uf9X+PntuYqKH8cTgYBaMT43pCRkxxOLKsgoNeWoPbt6d
	6WurE3jh0HUV7puLjQXI0uCJVkP5Ya/jkxtzzhI5g59yQ8vUzCYS4V3NrDHgNU1YqgLhmKLaD8J
	blWGRyS1htVj9NzI9MK2a7jZEfUjrF+Qs+pIoKAIoiDITlXlmYH/r28x/k0yCcWfvu/QQ30eZ6q
	v7cL5UZq289dr1H4+2ZWnBziqKPV4oiLKXxcp4U25BA==
X-Received: by 2002:a05:690c:ec5:b0:8b0:a5d3:7198 with SMTP id
 00721157ae682-8b0a5d37935mr8627877b3.47.1791816020580; Mon, 12 Oct 2026
 07:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012092017.3275428-1-ravindra@intel.com>
In-Reply-To: <20261012092017.3275428-1-ravindra@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 12 Oct 2026 10:40:09 -0400
X-Gm-Features: AclHuK_W5r3-kSFq8ZOrp8v14qXeljv26kcEUvDpgPt4bofmiSEXo2HZBIzWGUA
Message-ID: <CABBYNZKHL4t+jfuLJ=6N4xge-XNYnqrsdJtjMRDo2fcubbuLJA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Retry FLR on device lock contention
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, stable@vger.kernel.org, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ravindra,

On Mon, Oct 12, 2026 at 5:17=E2=80=AFAM Ravindra <ravindra@intel.com> wrote=
:
>
> Several paths request an FLR asynchronously, including S3/S4 resume,
> resume recovery, HCI reset, and hardware-error recovery. When a request
> comes from a PM callback, reset work may run before the PM core releases
> the PCI device lock. pci_try_reset_function() then returns -EAGAIN
> without attempting the FLR. Other FLR requests can encounter the same
> error if another operation holds the device lock.
>
> Retry the FLR on -EAGAIN. If all attempts fail, clear the recovery
> in-progress flag so a later reset request can try again.
>
> Fixes: 9c36951474d8 ("Bluetooth: btintel_pcie: Refactor FLR to use device=
_reprobe()")
> Signed-off-by: Ravindra <ravindra@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 3a555aa50c87..251dd4e2ceb4 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -3743,7 +3743,7 @@ static void btintel_pcie_perform_pldr(struct btinte=
l_pcie_data *data)
>  static int btintel_pcie_perform_flr(struct btintel_pcie_data *data)
>  {
>         struct pci_dev *pdev =3D data->pdev;
> -       int err;
> +       int err, retry;
>
>         /* pci_try_reset_function() avoids the device_lock ABBA against
>          * btintel_pcie_remove(): .remove() runs with device_lock held an=
d
> @@ -3751,7 +3751,16 @@ static int btintel_pcie_perform_flr(struct btintel=
_pcie_data *data)
>          * pci_reset_function() would deadlock by trying to re-acquire
>          * device_lock here.
>          */
> -       err =3D pci_try_reset_function(pdev);
> +       /* PM callbacks hold the device lock, so the queued resume reset =
may
> +        * run before the callback releases it. Retry after that lock is =
dropped.
> +        */
> +       for (retry =3D 0; retry < 3; retry++) {
> +               err =3D pci_try_reset_function(pdev);
> +               if (err !=3D -EAGAIN)
> +                       break;
> +
> +               usleep_range(1000, 2000);
> +       }

We have to make our mind here, either we use pci_try_reset_function
and gracefully handle -EAGAIN, or we don't then we must use
pci_reset_function which awaits for the lock, retying a couple of
times with sleep won't solve for it for good since we don't know how
long it will take for pci_dev_trylock to be available.

>         if (err) {
>                 BT_ERR("Failed resetting the pcie device (%d)", err);
>                 return err;
> @@ -3817,6 +3826,7 @@ static void btintel_pcie_reset_work(struct work_str=
uct *wk)
>                 enable_work(&data->hwexp_work);
>                 enable_work(&data->fwtrigger_work);
>                 enable_work(&data->mbox_work);
> +               clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags=
);
>         }
>
>  out:
> @@ -3841,10 +3851,9 @@ static void btintel_pcie_reset_work(struct work_st=
ruct *wk)
>   *     in-flight one (whose recovery will reinitialize the device
>   *     regardless of the dropped trigger's variant).
>   *
> - * The bit is cleared only by .remove() / re-probe via fresh devm
> - * allocation, which is the intended one-shot semantics: a reset
> - * tears down and re-probes 'data', so there is no "in-flight"
> - * reset to follow up after device_reprobe() succeeds.
> + * A successful reset clears the bit through .remove() / re-probe via
> + * fresh devm allocation. A failed FLR clears it in reset_work so a
> + * later request can retry; there is no in-flight reset after failure.
>   */
>  static void btintel_pcie_request_reset(struct btintel_pcie_data *data,
>                                        enum btintel_pcie_reset_type type)
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
