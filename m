Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610F17557E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604074; cv=pass; b=ARRPtVNE9pNt0LN2jsKBO1PUyOlaoY4FD22krWxJHMm8TAAbTqu7U5jszVAMiVZFqbg3jWfNPwutBHwY3oeUE7mCmeoG1AQrRgaEbyVjo1okB7vA3dT2tYlaIbjezTob3shX4B9xmw3xNQFj0VdmDIlyw+iKVf/YzKyu/mjLbJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604074; c=relaxed/simple;
	bh=uF8bdmm7zeL23ELFgnK6oCU1eV6C6W6l00KjSFVzcL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxpSPgqPybA2oN4I3ncjLUsw4+OH0K2XCjdezOdDxLS9ENmBgwGlS5Yc7jZQhDzLGkV0eU1p9U7PkA2Ehj7jga8dJhZxCi/T0grUQ8nWLejRm0XSHrm1cKSo+efUISUGtqQxfDZFj+AiBSKMnoezjdbCePl26uCTYXfzJqLQpy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJP3CvRy; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJP3CvRy"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651c366f7efso5895887d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 09:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778604072; cv=none;
        d=google.com; s=arc-20240605;
        b=kID3Wi6ZVS2Ql5bITkF6qc9/MYAYsPHq5v8VLFtsxMowXPf6jrTzjjCjWsbPwO9XTU
         n57jhjJxTTAZJrvi5tTstaCVK8erWTRie6PXXWzNIS0aZZTKl0jmxWlfQBW98KSxX7he
         9hLMXdSDRnWJqa9zKIbZYKaTZEK4FoAS6ANuW3NNEl01ZSbSSkFNituGDuXR2T6/2xXw
         z3L1scwVSS5r3LjEt89e4dRLxxRWoX/dwzfWOPQ1S3KL1L5P2Du5F+KFmtBMzkzg69nH
         RPyYmeRIu5bq7oiIy0p3ygdw0gkTR9Ly+cK6tcYOdGwMHsVo63l+yrL6DaqhViY4XVBT
         ZUkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zh/rkHRmtVNBN5GC04jzCaN1as+1DZO6fnrXsfl9s58=;
        fh=7CWVrfMfW/nw92lgfcg7amucbP9RQI5aDY3ftsZDe9g=;
        b=WSKl1mQ71UaV3kSoiaFbFkq/gKPgOKQZx7YKntbewU51OTfHW9SIJEfvcINEgK7O9g
         GEmgHLkn+QTFMgaYilVNbqTMdvYCrLJk8RYjmEdZyV3IABO10ELTVX6st3QT41TDj39G
         Lb5ZHlPoTU8jNgqUPwHJOJoznLY5pWyw//pxLnHtWijEzkbJlmkNa5uwKKnTHBKDjcvJ
         hZq5iv8u+iI5shK2v9122PGAX/SH/DedwfVCMNZuqoqxzSMdnnne9UtBkO6fkXiEX9KI
         64/xFOg7htlF+FNAp0lu5NzrwlSis9Y6zk1q9diObjLmDXMNFpeKzTomjeNWsf2GPNEN
         mD8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778604072; x=1779208872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh/rkHRmtVNBN5GC04jzCaN1as+1DZO6fnrXsfl9s58=;
        b=iJP3CvRy6nkHIQONqtpOkWniNtnrmv4LyvhQlpZ71OZm9UF5G5m1hB9Aq7MOU91f5M
         TDbzQsbbr9O4ZYJ3kB9tbJYOL4pPo/qA899LNIVlcsuRdzt7Yg43MsmwSMWQvpoYSMxa
         qwqA0DvbyfrCu8rLmWqrySRH4GkF3jPEkcybs6J3t32c+AVhiZXghXmijehVCqSdB1Lf
         jPIJYaycVFBEGW/i6Zd04n4719xP2FX69lFZWo6mZH6W0AGdHikq5DW2VQhpU8IiI6oE
         vha2WMlwRTZSWJmVdzr7pl86qYigsLXQb1nW/VhRJMKmHMcysd4tJD1kGACxRLKuwJb7
         4yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778604072; x=1779208872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zh/rkHRmtVNBN5GC04jzCaN1as+1DZO6fnrXsfl9s58=;
        b=hQgCJX/j7PmP2vXTPtHLHBEhdqJk/+NTE4Jy+j44LkgrEmiE6lRfnZY4HZqARbC/BU
         ZZVFDA11cD0Yjp24SxOOXQu8/OkeesNYexK8VRQYJP2t508CyrgnCUiJ//xMwvy/Lh+A
         PCnbi+7sW9KDBrJGOBXBPcPQaJaG1rFb3zqVtyKk+V2gfkQV0rRV7PwSP/701P3WNDa/
         pqhNN0/ILNLnj3zPJmZph4ZgYiOQb+UaukJqObTnRgxbIv9LIY8R+OsC28SkefqLz/n9
         a5Kg4LtjlX2DeGeGXB7+a6Im0txM7blZtuSvENXxyTWdIXDosKx56oyVrfTemaF91NPw
         WKnA==
X-Gm-Message-State: AOJu0YzRP+yjHwbXao0WWwpcc0K5mFQXwPVVKPtXUyVSZ4GdrIGEutlF
	tTF8ZYM+P6rphgytNskZMuqooWALcuAp22gLf3owdWXx9tkuh5//gRyD3U60+CZ3+Qx9X1W61PS
	6U37pTCS+F9UaOVfnyo0yG4aNvVW1PmSsJL7lOUg9pA==
X-Gm-Gg: Acq92OHf8cDY2dghcXNvCMwYI4VW9YTOo2LHjYPvQLIsxA023foU6sE9NTRM73AWIr7
	2sG0helAMDB/AvVldPRRAE+oEWNaDnIVSDDQfX+EPIGxu4tcVGZbrw86rzJKwX+XAiu9czXLwoz
	tHCHjr9/qO9SXmLaLwk1OS2cGcE+O6+kmXGLCccf/a3nwfjUv5xPzp7xTxkIE1v86ycv+mBdWFM
	/2ZkTL9TDsmnu5ayfL6QFgC/U7ckcnisSxa9LqaChYDtYKUugDNCqeX8rEufTAfgf8Z2H/VS6S8
	4Uj+L2lk1DvOgA4cvHKLEbRdi+2j8hWxKBafHDpD3U2q3Fe7IpFMwaw70XUDwap6oMFJDA==
X-Received: by 2002:a05:690e:1206:b0:65c:77c1:6609 with SMTP id
 956f58d0204a3-65da8601aa3mr13534410d50.60.1778604072061; Tue, 12 May 2026
 09:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511132711.1216139-1-kiran.k@intel.com>
In-Reply-To: <20260511132711.1216139-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 May 2026 12:41:00 -0400
X-Gm-Features: AVHnY4IjbgTNHAKkxdGB7d3Wk-xu7AqaDwVou7GpkbbEohDzp2K1jnB4gAFNAVw
Message-ID: <CABBYNZL70z8BNp2kZ9xQAkX5VB6wdVUozBa-XWY=JkXTTcu_UQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Reset controller before
 configuring MSI-X
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, aluvala.sai.teja@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Mon, May 11, 2026 at 9:11=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
>
> Perform the shared hardware reset in btintel_pcie_probe() before
> configuring MSI-X so the controller starts from a known clean state.
>
> While here, move btintel_pcie_config_msix() out of
> btintel_pcie_config_pcie() and into the probe sequence, and propagate
> errors from btintel_pcie_reset_bt() so probe fails cleanly if the
> shared HW reset does not complete.
>
> Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index fda474406003..6ff08de9ec78 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1646,9 +1646,6 @@ static int btintel_pcie_config_pcie(struct pci_dev =
*pdev,
>         if (err)
>                 return err;
>
> -       /* Configure MSI-X with causes list */
> -       btintel_pcie_config_msix(data);
> -
>         return 0;
>  }
>
> @@ -2659,6 +2656,14 @@ static int btintel_pcie_probe(struct pci_dev *pdev=
,
>         if (err)
>                 goto exit_error;
>
> +       err =3D btintel_pcie_reset_bt(data);
> +       if (err) {
> +               dev_err(&pdev->dev, "Bluetooth shared HW reset failed (%d=
)\n", err);
> +               goto exit_error;
> +       }
> +
> +       /* Configure MSI-X with causes list */
> +       btintel_pcie_config_msix(data);

Sashiko raised several comments on this:

https://sashiko.dev/#/patchset/20260511132711.1216139-1-kiran.k%40intel.com

>         pci_set_drvdata(pdev, data);
>
>         err =3D btintel_pcie_alloc(data);
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
