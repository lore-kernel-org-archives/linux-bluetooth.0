Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB93D5C0C
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604410; cv=pass; b=nMWhE9djOcearMFOXdcN/MqqM97maF5z8AI1kAudSeSM+98KjXG7JtTKJX7pejCkI++N0JC4sW2VZV/ODZqZWWF7zEeqjudG53NS05Y3ZmRe3rjsC0vk6hkjUO1IhJP+jCmc4EsK6Fd3XB92tx50TAqW8fUU3su7WHLGV5XhmBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604410; c=relaxed/simple;
	bh=lKKw5M+osTPdlvc4pVZZvV+7qvr1FDr8bXHMkQs1MMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPdCQ6nqg//lXRMRcJFPZMEfzoATswoNv/dULI0qI1uCy79IbbjW3o0Ws23Oh3ztOkvTi6BOYbFVCuRhtGL/DDt9uU+RlhLbSScOF2//bsrAdSblzTZymtYud+a0nRPHeHpcDiWGxI1sEvlNpA8REn35IjRxPYdjPVpqnYRNkaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN1MAz5d; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN1MAz5d"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65dbe04fc1bso2706292d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 09:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778604408; cv=none;
        d=google.com; s=arc-20240605;
        b=QF4OOPna2UoiGD6li6u08OjEgkb8TUJZkYAP/BYzNM082u6XJLOSDZSRG6/uIB6LEm
         9a6E/mDG6Khy8aR7G/EKTwuOvlkcMaUqLsJ72Cn6ktTh7WufI61cdKWgAOsK4knjlHQX
         fJMbHS+sI2pLq2nw0ZJm2LZp+V2+paYny7vMapdbzSB5j0QRQ/DVAVmPyNVxb2ZA5eLV
         3PkPQ21XM5EauXSsyA2boutalho46A9ExWNOn1PUJd2u04Jxp3qnePGbKD9E1CGVSyFJ
         5HIGM0WapgMacXZXnCsy1pfLBU7L5oypYCRHWuxSN9G5DSjeQFzSSgXgsHfaF9G3VWra
         +7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=19IbkDXVYRAN/s0vUZ9QuXlrDIrF1jI93IyUlb+Kmk4=;
        fh=OzGdaeiMjZgYAHajX7vnKwSpSiVzFDxYaf+uz7SF2AY=;
        b=bkb/FpXzVcu/6sqYC6sCLWcpNj4yyclszMVFG8+S+ymgHmDtj6AovUZ0pIC2r9iotV
         sMBh5AMsGx+HVdKOmNZIEoTcu/p2nmpxTeAV7DJkxA4Vusa8UJIqNEbXOaMxcKWPt5KQ
         mbq1oaBLOzajgy+NEpXEeVTwombPxhJM1d/Q672ZvplLGLeQUbGToTv3eXaCha64jAN+
         9yolBU4O1S/hA17zzUbjoobZAdBToDOIhFnFTGh9vV/RBCYHO7U9MbRpsHAVMiFwzhYe
         r6XzWuVbFgoROZcFI4l7rtDHqA8qxynNKkeWjrjIgCXnmYkftw1vZ8vR80WQNgXP3u/9
         u+TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778604408; x=1779209208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19IbkDXVYRAN/s0vUZ9QuXlrDIrF1jI93IyUlb+Kmk4=;
        b=PN1MAz5dz4tczmMF0pJ8A5pivSLcIK5zy0xTCmVgn9YrXxt4O0J2wICUaTrecQKIu3
         O+ahXP79KX6QIJLpecWkGnznjgfYLHBE+5KtwFinZNixTdQ5iButfLHfvAoMdb+1LBj5
         AH0f0T4/eI3WhtL4B0gCpR9f7wOtT4DYSE38Z+IykulXl0OEHa4/uEBGFxy6NaqTOAru
         UZhsBARtRs5+ZU7aqRUcB0vZdsjUHg6GdMAkBFWkqZY9ixBXC4RfimvzXgFZTQJp3LFM
         i2YEmV+tElmM6rcEfHxz+JcicCyLwB0e5CO2Kh7R2YXFtHXb1tWrmGaTfalcdqk1jC4g
         O3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778604408; x=1779209208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19IbkDXVYRAN/s0vUZ9QuXlrDIrF1jI93IyUlb+Kmk4=;
        b=tDiCEfj8oj3IY2vQ5+b4mdAQ6gg6d2MtdYzSA8F8YgIgIekuCypBMQcnmuvZiXkkzf
         gDgH+mvcbNdGhrMCl4M448bOFyB3WY6RAxaFDvZRrx58AYoLDOjcTe2HhJa/hRJCizuj
         t12M8BJN+T0OKMZh5lZd0o0WFqdIXDFuQVklj1rUkR14i43rr+sknUr/Y63+hByvaF6P
         W/r1lWM6iMTroPffM4qMxKMZbsyXlpu2/4OAvvWc+HNweb571ttqj2bjU1AIaxrfTerF
         Y5qE9HtGUMkfZ3BR/PkKaIvIS3E5D5Q/X+YMxj5hOXLo499Mof60UyFbRj/TPBiqbRHO
         o5Sg==
X-Gm-Message-State: AOJu0YybMGvJrAUQInsy1rdJuOl0FWwrUTIh3Jtsa4MRqfciVYOkklot
	jvsuMbxE1DJDRTHWnsB/x1GWnVdVnWq3bmH61DRBOkErxv/32KAq5jjCdoXP+aIz1lH1ffvlypO
	A5ExQH+eyNEAlLhVMqDbTZUSMp5DeJHs=
X-Gm-Gg: Acq92OEDOSZKvVMvzKXItNRvsJQOdfoFPQGnbI1Enb7bEbLNL726dONtjIGvYta4E11
	+GOak1dEY/3A9/SxaqAkqAYqG5qRWqrGFKtyqaoWsFw8ZA4UJ1OFKWHYmlgsC/AvnqY6AxAfWUe
	ppsBVdWwfYKeFPxJ6o135fCZCdaogf3hh/2mE5dlzp25od+Lo9tnR8vncYlB1TMFXXabRgF5KP5
	uAJHRcvKRHj/itzp4tbIsnhB+QgCIjbwZKasTkMYgEV5W8bfxVsjZOiq7XvOuoiO90LBKj0G1Ym
	QvpAiti96zGAYLQ6OO7+hjAKpKmI0gsdQl15kkvdsWwDhpTExGgfzeatlp1oDE/wblnk/g==
X-Received: by 2002:a05:690e:13ce:b0:657:c3db:5ebb with SMTP id
 956f58d0204a3-65d94bab861mr19793868d50.28.1778604407824; Tue, 12 May 2026
 09:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511133932.1217624-1-kiran.k@intel.com>
In-Reply-To: <20260511133932.1217624-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 12 May 2026 12:46:36 -0400
X-Gm-Features: AVHnY4LwjAEYx_wUxr_mCXmMPjXDkmPTl9N05xVY19rgYlbQ_1Z9dYHmGMeKyv0
Message-ID: <CABBYNZ+QyfitMUEXFpdNPnwD4q-PSJ8+F+js1XR7_fhUf3Fk_g@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Simplify MAC access request/release
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Mon, May 11, 2026 at 9:26=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Drop the STOP_MAC_ACCESS_DIS and XTAL_CLK_REQ bit manipulations from
> btintel_pcie_get_mac_access() and btintel_pcie_release_mac_access().
> These bits are no longer required to be toggled by the host driver for
> MAC access on the supported parts; the controller manages them
> internally.
>
> Also fix the idempotency check in btintel_pcie_get_mac_access(): only
> assert MAC_ACCESS_REQ if it is not already set, instead of keying the
> read-modify-write off the MAC_ACCESS_STS bit (which reflects grant,
> not request, state).
>
> Remove the now-unused STOP_MAC_ACCESS_DIS and XTAL_CLK_REQ register
> defines from btintel_pcie.h.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 10 +---------
>  drivers/bluetooth/btintel_pcie.h |  3 ---
>  2 files changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index fda474406003..53a4ad80b871 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -594,9 +594,7 @@ static int btintel_pcie_get_mac_access(struct btintel=
_pcie_data *data)
>
>         reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_RE=
G);
>
> -       reg |=3D BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
> -       reg |=3D BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
> -       if ((reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS) =3D=3D 0)
> +       if (!(reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ))
>                 reg |=3D BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
>
>         btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
> @@ -622,12 +620,6 @@ static void btintel_pcie_release_mac_access(struct b=
tintel_pcie_data *data)
>         if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ)
>                 reg &=3D ~BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ;
>
> -       if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS)
> -               reg &=3D ~BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS;
> -
> -       if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ)
> -               reg &=3D ~BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ;
> -
>         btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);

Seem valid to me:

https://sashiko.dev/#/patchset/20260511133932.1217624-1-kiran.k%40intel.com

We could check; if no change is necessary, we can bail out early.

>  }
>
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel=
_pcie.h
> index 2db85f71b2f8..7fc8c46ed689 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -34,9 +34,6 @@
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_STS      (BIT(20))
>
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_ACCESS_REQ      (BIT(21))
> -/* Stop MAC Access disconnection request */
> -#define BTINTEL_PCIE_CSR_FUNC_CTRL_STOP_MAC_ACCESS_DIS (BIT(22))
> -#define BTINTEL_PCIE_CSR_FUNC_CTRL_XTAL_CLK_REQ                (BIT(23))
>
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_STS      (BIT(28))
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_DISCON   (BIT(29))
> --
> 2.53.0
>
>


--=20
Luiz Augusto von Dentz
