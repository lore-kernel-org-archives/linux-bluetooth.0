Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90435AC34
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973497; cv=pass; b=LmrLdwSlMU3snKbGuYtT/kUcgqMfke64TCWfXVX2qTKqgwWoBXd2+Fi7ySMlQhtNZhQdYe2HXK62VY4f8u9j73AJqp+PuDRpGtaYixYc3PHCoTDMgamAan7M0Y4/9UlRqPYnDfnihO8qen7Omz0i1T0ZQSjBfqIOuvXqejTv8Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973497; c=relaxed/simple;
	bh=tIRZ7AU7oQOSx8OjkIQs6nVoNmqWtQ9szYysH43FkFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HatKsSIxANRhZDlrfyjsVW60NuOEEOo1rRTqdKJp4ZSrDcdzwn/96Oe2r/0uNuLViVgfTwCevUJACCnJ0IMCZ8ArRmzJuZPEMQocRbHHe+wHi2PsmRZ9c663xtfZJuWE+62b6xSa0f9dKB2oS9q9zI3tijY68PLqQ25tG5XNoaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf6IAwqo; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf6IAwqo"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-667923d86a7so437735d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 13:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783973495; cv=none;
        d=google.com; s=arc-20260327;
        b=C6winAw/gcEc+Fxp3G/BLjHCeuNfFDREyxKjBo06Ue8fYmg3I2Mns5lpiy86gJ/HgH
         vi95DmLIeBKGjTt0F4bdhlzNQN+2sioTKhvzG7R9trn1fJ08sZmsgevv87fAXQHxnnjY
         ItGeJGnJGHA8v53sbKFZpWjbvJuUWQS2Uc9rMH7SDDAX8d0okjg3i4DVpViFObJessbT
         Q0KbKfG9ReFyCh+9kEhSCT0eFZQ1dokW1TUVXS1U3Eh5qDSMFLfjCQA8/zHQhHUHKyfC
         amP5KMAX19tFKdGgrru2uw5GezoolUG+Hh8GqhrRvSfIhxcKHZA/AanmXUJSmBh2y7gD
         +Ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DrD8LMuwT3TD2gURBip2mPkBkeyXPR4sMe+E/ge45Tc=;
        fh=SYf6xDH7haxyCC+6X6JG4c1ld3FntxfTlOfbvC2kVdk=;
        b=QnpHt+rdvwHL1hOtE5cO3A4KNtgnSK967ot12vpzYXIuGQFD3t69hTmYK+b6TC2tlN
         WyIDQIEnkFXWdAOW7WJK2bdbhnA+rDWPJ9oF0QwL4FnWFljvM4D/1OffCtVSSMQEocmY
         5N/Qyh1O+9p5cwlFvgLXE95xnISXXEqGTo/rpf/2Y7iZC3FuBJhsJ+B7lQIomR7DhNcs
         tVjvfq7bJybV/mN3VIQ0fEPlo/86svKKfboPL432eNPJbxflQF1jtehfmQ++3ygYLlno
         uLGoavFI23oUnJWBCwKK/WCDaIlJ50yWswIYr7fdAIn+3BphRUxFMFgYYosgNi3wQVyL
         VPWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783973495; x=1784578295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DrD8LMuwT3TD2gURBip2mPkBkeyXPR4sMe+E/ge45Tc=;
        b=Sf6IAwqojHMMNQq2qjqjMYkOgoV0Yh0Cagh+J8RQi78Fovonu7ELGY8nWlhW//JpID
         faFzHVqCzZM1BzjgsxLevB52VUSHBwNIG/eL0FXh4bObJxD1EWuZ/qB/qK4OhmxO2TL7
         OevHoKsCN8P2+vvl71hjSpgHf+bFZtDx35w80H1wVhsPJ3toBsVJRnsaFkkIj9oMVuiT
         iXcOeYYY+2e+ZPKcfiuS8+yPzU2qioSMD0tA22BJQWUBZNo+VYfxEYWMxZlgrLkszV/6
         rVKl8DUGSzReB0dBng3aQ7NC2R7uvCBHEw1wYM2wm2MEfUwaEnql8NlsmDmcN7c5fFU4
         CEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783973495; x=1784578295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DrD8LMuwT3TD2gURBip2mPkBkeyXPR4sMe+E/ge45Tc=;
        b=GIej/S/7eemgBOKzdncTyhXRm9y1603q0ZnryGm7rT37rNwZ+OL8y3nO5roUxGfSEb
         I0nVlhrCgDRary5KT95yIFqsWv0e2ibkoiizucKztxTQZUdPWNWd2kNey/3s2UKu4TLT
         8i4GfteX6uXAgebzuYphP5HjvfX0cGHYSTnC7YQUqNVC2Vb6TGmzyfpf4K/BsGsWdtgP
         IaRt0+Gb2ZcZ2+PQBqY7xZGWvnmB5WUUcQQpaCiI3fLaFfQLrNlHckjttNwJdXgEtRhk
         2JT5n8kktjRy9+x+wcjgCoj2jA0A33btn5kY1zp5f9jzp2pDieP/Ibmf1/nxOIKpBGQm
         p0lg==
X-Forwarded-Encrypted: i=1; AHgh+Ro2c0n0ufN5FJSG27k8y2KQ9OkgECO7mx7PjdrLwrz5OJt3zsD7k5hwk5pjildzf8kgbpEYkO3WxQ9K2Vz4sq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvt8byoL2iqUMr/KPm09IePPaaV39lMMsIKMHuyQiy08JOubhE
	JJVSesa83NHs3FKHI4g2B3P5Uw83BCAW/bMmGNa7MO4+lv+8fcG8w5xhS/tdPnr74Z6gwFYaH9u
	MLusDTmJ5R1dFJs5G0of8MXMnN6JQqQE=
X-Gm-Gg: AfdE7cmoQXAIhzPZUeOq+b8n5eEo760IwZp4WJGhKYFUku3ilLrrWFjRXW+ZbVFLVho
	N6qgwX6KQ5FrNbWtXyp1xZPSZKI5Kyy6mmTc6pfAx1kXOB17/MFe0SAnxBE8Vr+gpYgHz+/t2yv
	LS5w6dHzGGqUvZW20zkli9tazWs7g/PVaC/k9KyiigM/YsnDiMnU1xbDSbUZiRDsvpATRdQiTlx
	RV9jqI8vGm2960+xwnk0MmN13dxtCAK8vWr0NeGj10ClchY9h9qIMs6p+DQnd1RWaxrieNY9Sn3
	f8jpb2Imhs3M0WR2JKIkUb09JNoSzMp/S0eWXTD+bX/OVh+XctMVbL7Ar3Q=
X-Received: by 2002:a05:690e:4382:b0:666:5629:64ea with SMTP id
 956f58d0204a3-667d98f3f1amr4600390d50.28.1783973494706; Mon, 13 Jul 2026
 13:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_44ED865C14DA3D3823CA85AE1DF2CEBC1805@qq.com>
In-Reply-To: <tencent_44ED865C14DA3D3823CA85AE1DF2CEBC1805@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Jul 2026 17:11:22 -0300
X-Gm-Features: AVVi8CcGK5IqLTVyGneH30hKa2TEQXfBisCikorcSCdmRnRFKBvVSO8QmeI4igE
Message-ID: <CABBYNZJVZ3j3dPyBO_4A8oLv3rf293_p5j1r-7sWWxzZRG4STA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: Fix DMA memory leak on probe failure
To: Zhao Dongdong <winter91@foxmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhao Dongdong <zhaodongdong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhao,

On Mon, Jul 13, 2026 at 6:38=E2=80=AFAM Zhao Dongdong <winter91@foxmail.com=
> wrote:
>
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
>
> In btintel_pcie_probe(), when btintel_pcie_alloc() succeeds but a
> later step (btintel_pcie_enable_bt, btintel_pcie_start_rx, or
> btintel_pcie_setup_hdev) fails, the DMA buffers and descriptors
> allocated by btintel_pcie_alloc() are not freed. The exit_error
> path only resets the device and destroys workqueues, causing a
> DMA memory leak.
>
> Fix this by introducing an exit_error_free label that calls
> btintel_pcie_free(data) to release all DMA buffers and the DMA
> pool before proceeding to the common exit_error path. Error paths
> after successful allocation jump to exit_error_free, while the
> allocation failure itself (which is already cleaned up internally
> by btintel_pcie_alloc) jumps directly to exit_error.
>
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe trans=
port")
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
> ---
>  drivers/bluetooth/btintel_pcie.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 9e39327dc1fe..b672ce376e9d 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2896,7 +2896,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
>
>         err =3D btintel_pcie_enable_bt(data);
>         if (err)
> -               goto exit_error;
> +               goto exit_error_free;
>
>         /* CNV information (CNVi and CNVr) is in CSR */
>         data->cnvi =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_HW_RE=
V_REG);
> @@ -2905,16 +2905,20 @@ static int btintel_pcie_probe(struct pci_dev *pde=
v,
>
>         err =3D btintel_pcie_start_rx(data);
>         if (err)
> -               goto exit_error;
> +               goto exit_error_free;
>
>         err =3D btintel_pcie_setup_hdev(data);
>         if (err)
> -               goto exit_error;
> +               goto exit_error_free;
>
>         bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
>                    data->cnvr);
>         return 0;
>
> +exit_error_free:
> +       /* Free DMA buffers and descriptors allocated in btintel_pcie_all=
oc() */
> +       btintel_pcie_free(data);
> +
>  exit_error:
>         /* reset device before exit */
>         btintel_pcie_reset_bt(data);
> --
> 2.25.1

Sashiko seem to have found a problem with this change:

https://sashiko.dev/#/patchset/tencent_44ED865C14DA3D3823CA85AE1DF2CEBC1805=
%40qq.com

--=20
Luiz Augusto von Dentz
