Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B1333D4F0
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674324; cv=pass; b=Q67FcLaLW27IqBvA3WqaUfTCbQa4Gj6+1RGRBt5PfvFoePWuh1IX0fvp7ytTdokxXV0rELvwe5/mD9tolEkKS0JNhu8rTFeihpz/WQUbEKYmgHiLY4FxOutiro589cKIPm+kWKiTolMSpU1VCEAswMrtRyp239X6mIsb33zbIhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674324; c=relaxed/simple;
	bh=npKn0E6KU+/u6EYCjOMis/OqRQVF4FuIYmEaF6r8g+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMT7uB4dFXCjGrZcyQbS+nuD4vqSQ7xBm46Vj8DGQpEgS6UBplV5llSb/tOX8tAQ8AfRFCdpzMKe8fq5BG/PkG8QGvLGNx/8qVKpq6JaWPuOFZwQrm7u2XOKWPy7nkw6DNUSuSMvFeg6UjAtu412sn7LPYNmdFfnXEhA6PIHddM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEiMlCNm; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEiMlCNm"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66d23c88af0so213255d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 09:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787674321; cv=none;
        d=google.com; s=arc-20260327;
        b=lA7AAFY/qcBAvYwADLZ2z6cHIATfOy37QTRxs4S3X+PFsheq8/7qEuwauk8e8QrPRv
         4LjcH8mjHi3NEE//NmZppcWqtFo1f1IJvt43VoLyzsVe9W99gevFOfTRaw4WQYAXTjZQ
         NiCCwZyPmcQPLgwHHwycgzVEZiGgkwmC5dLiKW/DIbuVidbLdIqkZFv6IoLx+Ep6vG/f
         6ew6VXkAIJIDzbNxNjhs1B7UiX6DXx3W70V0Vc/eKI41JxRKsL+rqX3mp7uCToMIoVyo
         zg7KvdCpiZwqDKhdieWhJrUKUhwbe8EnNj2RywH395jjySZHldmTtSGyhBx7MN43qB6I
         6lvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/H4vr4Fdngqgm9KJ2AB7IE67LLjchjxce8UfKvKYE80=;
        fh=OzGdaeiMjZgYAHajX7vnKwSpSiVzFDxYaf+uz7SF2AY=;
        b=Ar9iYcZaT/rabM77xM04lWfm7kmQMh+khjKvVTPWH5gd5nHd32+a/tOsW5JMzhDpoG
         qJzi6KU56gvoENAJ4oK942UD5GLIfLGr42rEt7S05GptMn5Myw6bkmZKm62keUHmcVEQ
         ZqM0Gst0n7ek7wN/58ba6iY4r0vIVgV5loYn4I7agBDP8Nje2wEZtTP0kV1ZyBs+3p53
         zBYSPBIouiPkWfDKHcpGJYkkxs7etnz/prIAzlWjT4aNt9E8N6uc0hv8vK2GU1F6Cg5W
         8bvvEw5apA5sQSDp1T/erQFxb2W4oxhmYea6JwsDnrNH1Us3txj6ng+L+Mji2yrAuykH
         tWfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787674321; x=1788279121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/H4vr4Fdngqgm9KJ2AB7IE67LLjchjxce8UfKvKYE80=;
        b=iEiMlCNmilUjG7bgBTxVtS9yY39TVZ1e1iW6AjAm6IT3Sxcsrom2WEBtS+/4BbQpn9
         AWSfA+brhHHZeJz5s+b5gupwJNlUrgmplKCC0naDElVRwPKzy5SGal+9Mu2Jw0EkCyJg
         tB86k4k/PKDffBeSEK22CaFOlUbrVZ3P7enl4dK/dJd89ur6UALpUShE9SHj4XWtHYFs
         uAldglRiEP2A89Lo2gzCJlon6AaGrv/5wq80N/r9CbOn7z+B7M07a8h/SBj5w1PF59w+
         8XAUvGrWKUPJ/dZEcQ89n5GIqKr+dk7dkKTUyrnu5Y3aEYXrOiVvH+iybPOycEzhjMdr
         +JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787674321; x=1788279121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/H4vr4Fdngqgm9KJ2AB7IE67LLjchjxce8UfKvKYE80=;
        b=IFeFbP/MJy52el3YmABM0I7HNeht3kuuj9EcBRIO4ebxu0xUvhK9c40m205CwdOqkN
         incJzH575YKeMeC83UthQ6DrC6sJwcWFNuk0EWcS4bip3PMCV+TA/DvolId11o9qn5uS
         SbdslZnAjwB6QgZ/rIQRu0SNstMb+6uyglc3o4tJ8mMO5rPCevOO0oLFpdPN2fRbmYrl
         ZSRq+SpTJx2UsMmk3twqcBVt8kXwzi27ilchWBreeqKg0XAYbZlxqZDsfMdf/L5L7tmX
         uMrQNd6SiQa3DC+9utJtNlw4v6pgr5hZg7q6viT0trqN/gdDAFdxvcibGKT060dYnDym
         nd8w==
X-Gm-Message-State: AFuF++ndfoL4ofI1FWyLnXYi/enJHcOaZnKFT2EXq76x5n5vOmC/WO41
	LmsUg9MTNSH6pQNgQK8198KiW40USRU9Mpm7MeRgH+NXdmQf7blYyafvaUXsoPjQEroUymnB/Me
	bWBKCbzWXH0gMtPkBCsN7oti+RUvWKOw=
X-Gm-Gg: AR+sD12QeiUQAH/gyfY05l+j0C9eXMkNjtukShA9pi2tvMYEzvPKVj23AjpMeHVytpq
	hYe7zDwBzwl0Ek5EORmmJxAa2CHJVOkjNuFOhp9a4GrArFaBSLSBskbLRIP2kFMUSWSL/BaYOZU
	5w6rCkpNmlIG0jPHV7YKH9O9G7NsfrUNN1v1SinzcFOCmapN9ECnGQ8mdXjbLKPPWPDgh6Ejkkm
	CUibZqbOAL2UpjPBmEBpxjWsXwMXsztisPUrYHcxD3My4BYRr+nUYymOd+nKve9IL1nX/E+UuBF
	gdYr1OPjaP7XZMUDREa/d4UBQn3WqKFUvDrsyWycnD4V4ZDPpZHiR0qgFnABd8HgGU99YIQqAgJ
	D1VwU06iwP1dog46H9IdcHE3wlQVe
X-Received: by 2002:a53:cc8d:0:b0:667:a285:7624 with SMTP id
 956f58d0204a3-66ce4b02a7cmr9719452d50.35.1787674321528; Tue, 25 Aug 2026
 09:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825162512.143965-1-kiran.k@intel.com>
In-Reply-To: <20260825162512.143965-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 25 Aug 2026 12:11:48 -0400
X-Gm-Features: AcwNN1XrS1MrKJNGqtYO-cpO9Wy_4vsTbl3tARp_FFWX7UYwxCP9Q9GSF0xNsjA
Message-ID: <CABBYNZJSHpX_GD9gg8SP1BmDW8tWCXcW1aS5aCOXcEZp-0Kr1g@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Clear automask on spurious interrupts
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, Aug 25, 2026 at 12:06=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
>
> On spurious interrupt where the TX and RX causes are not set, driver was
> not clearing the auto mask which can block all the interrupts. Driver
> needs to clear the automask even if no causes are set.

Aren't we missing the fixes tag here? This looks like a candidate for
backport, right?

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index baa621b3fef9..30923eaabed7 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2051,6 +2051,9 @@ static irqreturn_t btintel_pcie_irq_msix_handler(in=
t irq, void *dev_id)
>
>         if (unlikely(!(intr_fh | intr_hw))) {
>                 /* Ignore interrupt, inta =3D=3D 0 */
> +               bt_warn_ratelimited("Bluetooth: btintel_pcie: Received sp=
urious interrupt\n");
> +               btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_AUTOMAS=
K_ST,
> +                                     BIT(entry->entry));
>                 return IRQ_NONE;
>         }
>
> --
> 2.54.0
>
>


--=20
Luiz Augusto von Dentz
