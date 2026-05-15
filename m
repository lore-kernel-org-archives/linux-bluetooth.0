Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9421A95D
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849848; cv=pass; b=EUB73KkdQUoq2cgt8j4o6aAieEY3caNnuGngLDlUfsK4qRLKkcuUPXum9GAfV4P+9OdsY84JYwKbOgabHwCTrfNTJqIcnxUNk+KBXRLS/RL8qnVlHYqzJmwT1yOmDdsl9gw1oCDjm7xMTJD3gN2ypkpJ7zJvUJwtQ2hVtV9nzuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849848; c=relaxed/simple;
	bh=HvePMbc+IKYuPFy3CxDPxP/OroNtmDTMgSK5OlMf19c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmcgUBXINVUBs4Ew6w+2XUK9fP8ASkbjANlByNL67mxdDZsVFw7wuH83HQj7+gOXvnjRdrZEC4zsSRGNHrXYLQYUCnSHhFLxo3rJeRsvBJMw4eom3GWRiMCGR4ZursAn9/+z81qkJSQbpVZTE8S0LgVJgBsqhJZhZStwGthv6hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0mSP91u; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0mSP91u"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-439cc157c21so1680735fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 05:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778849846; cv=none;
        d=google.com; s=arc-20240605;
        b=SdAcFRSmhY/taVACPSf6DYhASdcdOdnZkquXWhsg7gggQxqNalvcyovNHJTJ7h0dLt
         p78QnrXYJzFEaSWJYFrNE65/tytTW4Gm+Uf296CGc11xDgeh2isv/R1IyBzWUFQMctuq
         RXscAHblL0SGnuZuYBL6Qe5sjVBya4eQi1SF36Nn4PbESDH7cXxkqNhRSyv8bDy1shvZ
         K/avzlrYjPlDld1gZx4ieK/gY8B1f/1HUHbTyjoUnE4zAEMJrAUu8XVUSqvoIQndGuiQ
         ua0uJYlOFXMDEFRYIIrWxf0Ts8MBXhxIjg8/BVEyX+Dm519gS+ck4+hkrxEL2D2wdEm9
         AdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cQnMZZkAnyjkTee8chid/C0Y+Wq2fwLiHDMaNpGF+Dw=;
        fh=9QXzrW2NSwkEkdzJzYuHPbrEUUrjMKUbXO3nXLL+xXU=;
        b=R3+/u8FoksgD6Gakkj8WrXofFixl2nvMMYmUSwySSl3wgCZilTgvyaay36/avsfWfo
         i/W6Mw4qU+VhifM5UkCx01Qe/E1ZaRCSw6I3mU1eVutEk+T3rhqgRpGcN/8vxYpg1kTE
         LwuYf45n2ihvBsgDdvs8nciBdBbakU9um2mY8m1GhW5jUWuVRp8zmkC/bHf08+iksSMj
         VKqzIONWqKgLNvORbyZVM4Cp85hv/SqresRTliIDrWO6TQ/a07n1dbpUJNZf9jXyE9o3
         PPlFIME+IJ2xeQIRbkQsuyPO2YiYGd4UARmT3YEMnmXryJXrqrdSq9b7O4NUhOtJuNMU
         x21Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778849846; x=1779454646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQnMZZkAnyjkTee8chid/C0Y+Wq2fwLiHDMaNpGF+Dw=;
        b=X0mSP91ulr7aEIUfXs82/8InXPyrnotDX4XzFgqnLSC4+KlCjD949MtYBMCqiTGVvM
         tqLQti/Q15Yhg7Irs+lO2HK+yujyDkkF8+8X3ZWMCDSC2PyoBfEw73Cw8g1v3unodsra
         nDqBfPOjnWrfAYfk+JT4bAhEvMmHC9s9f3XLV63eI2S118yXSNIPqbInctYkmOtNkZBo
         VDmgr1pYlfhSe/brTBjc9FtxBnGmFx9js1eUYwsBngvLdpygll5nEVYgyYvi63hepOP6
         mKbNdONA4SO35ClHZAg3MO7NvmAud4+0F4odYYi6l3PSfUewPUMIXNP5GlhYdjpzHZh3
         //LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849846; x=1779454646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQnMZZkAnyjkTee8chid/C0Y+Wq2fwLiHDMaNpGF+Dw=;
        b=UZo3pvl+YeysQxCDx7cy5admkos3GjOeuUvJY6sGHffwEYsD2BaNBFjk57o1KJe1CY
         L953A1n+Kul7avZqjE7rG4K1ab1wFgXl2IMj9MXApLDXY1zKXviX7wzemuOWLzUBVxlb
         qRdtYPcsKcUvafO7zast4wFOf/9wz2XbrzkPQqnSJ2bXj+sRf6KkTQpUt62HC3ZRUnXh
         zIb4qVAa1ZkP8as+uR5FTUf9U3fmP2tyEyHUVCuaToEaUCTV9BhWXx9Il8F3V9UvnPMI
         GYhVDYCkh6p3FZz1J2EkqJ3k/lN+7WKXu+JzwYgoxC+hOQ+QZV9CKsqfisdjB7pfmuZs
         XKCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9h8r84QU91Kaeu60seOnfWs/qxLZbl1fFDJhfieyVN7QE1Ctim6SX7iRi0M1lkQg0c/Bgzu6JTLjIHJc2P38c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrN6mOq6usCX62RVHAeYqAEIZtQ/p1Ou8Pm5LsHjNdjm+8GWQr
	VNdrjp3DpGmmbcfSWXQ5dPhCECa7bxlxvM16NsIzLkZJsQWUfnb3Exsg6Zgd6Gd5isi9mtOZg2Y
	oUnU91tGcr1xS00kpFDQo4xyj3kICwb4=
X-Gm-Gg: Acq92OFiY2vWar8KMftRX7o8mZGsv/wczztqzj3C2QN6Vfr/V+r/CuxRY4kiFZPAB1t
	RYtCH+hYEYHs8/TYgBE5wuCQ6z5lvt0gNmA6TLFPlO7FDcnK8ORTXQot+nabgiavx3gDrQ+V5RK
	iJB1KGDSwVNeKiZB35P+OyMy3HBs4w414fi3UiCfjphvfACLYNLrGNV0NIdv1btxXGUHIEcycZm
	qcS78aEsz0asPRtKTIVn8wVUk2Y2Q5LKpYkOxNFAY5wnibX+ECWGxq62LhiIVM2W8iSZntqA9xw
	nLPMILyg9YIGN+gg/OcQ9Vt8lqGrpdHzYJHh+EOCy1PK7JDipgfdln+3tJjpjp9oagGM6+p8n04
	HCO1VYEHIHGHB
X-Received: by 2002:a05:6820:8184:b0:696:15ed:69fa with SMTP id
 006d021491bc7-69c94588db6mr2303802eaf.48.1778849845816; Fri, 15 May 2026
 05:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com>
In-Reply-To: <tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 May 2026 08:57:13 -0400
X-Gm-Features: AVHnY4Iibw8AgHblBwkV_mZr4d7mkojs4xZXQFk7Tletu0db9fhNJk28lLhoQ1E
Message-ID: <CABBYNZLQU_dqZkUP_EUcT5bYGif=dqC-sYEM+yV9Y=TrWwNWMg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btnxpuart: Fix use-after-free in probe
 error path
To: Zhao Dongdong <winter91@foxmail.com>
Cc: amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, Zhao Dongdong <zhaodongdong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2026 at 8:54=E2=80=AFPM Zhao Dongdong <winter91@foxmail.com=
> wrote:
>
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
>
> In nxp_serdev_probe(), if hci_register_dev() succeeds but ps_setup()
> fails, the error path jumps to 'probe_fail' which only calls
> hci_free_dev() and asserts the reset GPIO, but does NOT call
> hci_unregister_dev() first.
>
> This leaves the HCI device registered in the system with its backing
> memory freed, leading to a use-after-free when userspace subsequently
> accesses the device (e.g. via hciconfig or bluetoothd).
>
> Fix by adding a 'probe_fail_unregister' label that calls
> hci_unregister_dev() before falling through to the existing
> 'probe_fail' label. The original 'probe_fail' label is preserved
> for the case where hci_register_dev() itself fails (device was
> never registered, so no unregister is needed).
>
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
> ---
> v3: fix gitlint WARNING
> v2: fix SubjectPrefix
> ---
>  drivers/bluetooth/btnxpuart.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index e7036a48ce48..a4d7747e5be0 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1907,13 +1907,15 @@ static int nxp_serdev_probe(struct serdev_device =
*serdev)
>         }
>
>         if (ps_setup(hdev))
> -               goto probe_fail;
> +               goto probe_fail_unregister;
>
>         hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
>                            nxp_coredump_notify);
>
>         return 0;
>
> +probe_fail_unregister:
> +       hci_unregister_dev(hdev);
>  probe_fail:
>         reset_control_assert(nxpdev->pdn);
>         hci_free_dev(hdev);
> --
> 2.25.1

https://sashiko.dev/#/patchset/tencent_4A1D33225C74DB33EFAE8A0B6E884567DD09=
%40qq.com

Not sure if it is valid, but it probably worth checking since we can
perhaps simplify the error path.


--=20
Luiz Augusto von Dentz
