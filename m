Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37BB37FF70
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068312; cv=pass; b=oRPsL5a9z/4lzAGPGQ4UjU2ecT1/wQVdREq2R0yuRVKmpfoZDqoQjE4XV3Ew3rg0tIGHsPqIuWDGWeycbeZgcBqbcZlxuxLSCDk6tua0M/tIW9uCX4bdJ/AH2Ic5FQ71Up3/LiLkwX0gy8UR956f1X8QgdOPsDbAF+oHI8WBP7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068312; c=relaxed/simple;
	bh=7jEQHBbqD6L4XJrfueM8ABY8MYe6xuz7TCyAOl7gle4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJ/RjuzQJI8OlRz1ZcAvU703hvRKtkVqWdrdjIaPSU6huROgnOUxIfwCNyy0vGfym/wYoS1UvKUz3fvbQdLl5qVRrsJLzuTBt9tbV9r+upNK8GuT+qrH7Ie3Q5FKMsxARfSm4ayyWWqftSUg1xEoPR3puWMMNRi2zVXxQF/APmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkfzpRoe; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkfzpRoe"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836c718715fso912477b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 08:51:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787068309; cv=none;
        d=google.com; s=arc-20260327;
        b=gnR7iXph72Q0CnBSgENLBpJyXXL1KG6KCkaKrVP+dOJoHd1HHqegj67OfixkL/zKE8
         rzX+7VYAvkZGfFx0tYsf6cNey/glYgNEW7XrYGAqTaFYR25nmFb8z6DpdQdy+2nogLjG
         3TmaEASu3QyNqHVoCDl9hFMkAuNmfhFM7//wWU2WBNTkF8KVNPtUbrCVGqPlZE3Uld/b
         XVY2lpDEdVoPSobNhgJkO0fZMFtZQr4sysEElJLCyLmUWZZ++Gg+48LEc2bVlliPf5/J
         XaCDyI+jfyRmsoSY4vDjHaCAGcaUR1daYSN9brVFRpdLimOtM7M0plIvrVBEzF+emA9I
         4NKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=thJPMSLubXeQ0qsOuIdmUsXg+LSr5BgvREX4gShPUbw=;
        fh=hEFDORQmSpP6WNXB0awanGSf9lL1STinaPtawBdkaDQ=;
        b=obI4xcGtiSsDV9J8ApwIov0yMf3uN0r9LslMqZfDcyhwTuLsKjrLR8MhtanvytuuqO
         N1B16tWbpJJF2+AUMkJe9uRQ1VHP8AMsVJG0BE/dE+lgawkUJsQsajVzaQU1/QZ9FX79
         kMePHX2vbHbXGSU81ZkxVD9H6Lp1xtu79rV1XDoeMwcDVbAknNSOOIZlLLVHhOC+HYVm
         QuhdYASrkumyBDVbkJp4d73R5iM7Y5bVWKIYwbETE+kuaAnFidhdk63oah5hamNXIbSc
         z0ocMunlXb/XWBp1O166GXFGvfuzM9rNgzHGLOYvhLO644pFy2Ar+JKuP4CcHfpGO626
         RV8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787068309; x=1787673109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=thJPMSLubXeQ0qsOuIdmUsXg+LSr5BgvREX4gShPUbw=;
        b=HkfzpRoeRfhF1U3zOU36WheRgdc9KR4K1XEJqHzJF34u4tPovYUx4S42xdUNo4OWG8
         v6lxjHJ1RF5QYbm1WTeT7yBKZ37sFDBbOd3Skw0ofd/HE6EPUol9Hk/FZZmwAE7jQIB+
         IDotGhT1sZb3q0QI/o4Wj7QEUdIG03562VrfXQW0hxzMzQ32Gq0+tH3us+9iMf+OybuX
         3OxjK+DNlUALN33LO71Up+fh7P+DFnY4Eia8GHK62KbEhhWsN/xbZYWdZvKH1CDJTdgL
         okBweZNIZJ+PFLoQH4GwmYzQ5X/nW/kd7A2JbRVlLoZOr1n0wXVKsWVo3UziinjmFvfd
         vjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068309; x=1787673109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thJPMSLubXeQ0qsOuIdmUsXg+LSr5BgvREX4gShPUbw=;
        b=B/Z6HstIuJ5If1LhP6Ppus1olkPfMsELt1lHfAXNS6NVmYmiyoBL7AumJ92LGNL312
         XPuxCatAzbVo1Es2X9liOPne7LXwEvZMaU7pDts7oDA+6VGgV75DGxOiTvi1qQ7EGeUY
         hLVe7U/HEbBO5WKe8Cfj97wCcGljbDUkm57SyAnuKi3swNAz7SAEBBE3opWHwU5xl1Vn
         Kgtcs6lBy9rKx/uZAqAB6sBN5rFP+B9U2tyJ++h/hVAqR46s9a86m3hsqAc6VcBhiWgH
         xniDFEx8gjo75oX5ZKWa4hS0037bTDb1GeBzMQOGLtFF4wE+Vjps4Yib03pmWSpZfxip
         Lz5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp5j0erhZGQlAyEYF1lkmZS5b7/J94KUcrU6voLz0QKruwfCfD0qnOXHl//Ljv0bB5lYskWFCdzH1rMVne127A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRs3a0EdXxaHC1PXsEGqufoGSeAlfSEDCu2AFmX+ifrgfQqPw
	uwn+h5gxGkQC5y5cw+p7AA/+4alYWaLYtNCHXFoi8TmxUtlwegzPWMKw0O0AFloypuhw2Uf6KtG
	2sNw9mMHCUZIOhD+jskmC1ypgbKJr3Ks=
X-Gm-Gg: AR+sD12OTwoHxkt83XhUa6GfYLACPMeMLwtZz7kut3oUOEReN+iZVch4Qo2GzBhjPd/
	nu3SBELMyqIQ9otiiWzC1imQ68PosmjQNXlXCoYEfYpUNOIDw7/6qUmCr4mpFEku+Q3dLNQJZLM
	6/RVA9E3oCxQtGW1vVcyOu4gc3CXuaN5ko8gupbGHbl1LlY6yyf92tz29s8dV5s6/TwYBsW4snx
	/zCRr6AOyL1j30jOVkiWtQv2GVnyS/c2UwOOFoz1AGV4qRksbNr2CAdVDQUqc0HWZTL/8pYbHli
	QgVnSu5t1FLZtsEFgncH8DPYsbP5lKfp/Ac5SrYHuSALzXk5g9ZbfZaMva1KaaD4Ew10H6sn1Qa
	jOwgl42ndKd01eLwa4t0YDbNdopP5Fg==
X-Received: by 2002:a05:690c:e1d5:10b0:81e:6a10:f90f with SMTP id
 00721157ae682-8371125d508mr89980757b3.17.1787068308638; Tue, 18 Aug 2026
 08:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS4PR04MB969206113CDC2F5C66994E6EE7A62@AS4PR04MB9692.eurprd04.prod.outlook.com>
 <20260818080104.563675-1-ali@iusegentoo.com>
In-Reply-To: <20260818080104.563675-1-ali@iusegentoo.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Aug 2026 11:51:37 -0400
X-Gm-Features: AcwNN1WwINDWK3SuoXg5R3TNDfenBXhQgLHPoZtvf6Ep_Zmi4KB46MrMZykpyOA
Message-ID: <CABBYNZ+yDwFJ7YFB60-SG6Tr1R+6BeE1E=06d5+UEK_y4j7g+Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btnxpuart: Keep FW dump header in coredump chunks
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: neeraj.sanjaykale@nxp.com, amitkumar.karwar@nxp.com, marcel@holtmann.org, 
	alex.zhou@nxp.com, song.xue_1@nxp.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ali, Neeraj,

On Tue, Aug 18, 2026 at 4:01=E2=80=AFAM Ali Ahmet Memis <ali@iusegentoo.com=
> wrote:
>
> Commit 1fcf216462ec ("Bluetooth: btnxpuart: Validate the FW dump
> header length") changed nxp_process_fw_dump() to use skb_pull_data()
> when validating the FW dump header.
>
> This also removes the header from skb->data. Since the skb is cloned
> for hci_devcd_append() afterwards, the FW dump header is missing from
> the coredump chunk.
>
> The NXP FW dump analyzer expects nxp_fw_dump_hdr at the beginning of
> each chunk, so this results in invalid coredumps.
>
> Check the header length without pulling it from the skb instead. This
> keeps skb->data pointing to the FW dump header when the skb is cloned.

Ok, but if that is the case why are we parsing the headers in the
kernel? I thought the idea was that the kernel would assemble all the
segments and then push the dump as a whole. However, the above
suggests the NXP FW analyzer expects the headers. In that case I would
just have each segment reported on its own rather than appending it to
a separate skb including the headers.

> Fixes: 1fcf216462ec ("Bluetooth: btnxpuart: Validate the FW dump header l=
ength")
> Reported-by: Neeraj Kale <neeraj.sanjaykale@nxp.com>
> Link: https://lore.kernel.org/linux-bluetooth/AS4PR04MB9692EC13E3176B6D75=
25D097E7A72@AS4PR04MB9692.eurprd04.prod.outlook.com/
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
> Sorry for the late follow-up. I missed your reply on the v2 thread and
> only noticed it after the change had landed. This patch restores the
> approach from v2, as you suggested.
>
>  drivers/bluetooth/btnxpuart.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index f2bbe6e462aa..16d0f709d4b7 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1359,14 +1359,14 @@ static int nxp_process_fw_dump(struct hci_dev *hd=
ev, struct sk_buff *skb)
>  {
>         struct hci_acl_hdr *acl_hdr =3D (struct hci_acl_hdr *)skb_pull_da=
ta(skb,
>                                                                          =
 sizeof(*acl_hdr));
> -       struct nxp_fw_dump_hdr *fw_dump_hdr;
> +       struct nxp_fw_dump_hdr *fw_dump_hdr =3D (struct nxp_fw_dump_hdr *=
)skb->data;
>         struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
>         __u16 seq_num;
>         __u16 buf_len;
>         int err;
>
> -       fw_dump_hdr =3D skb_pull_data(skb, sizeof(*fw_dump_hdr));
> -       if (!fw_dump_hdr) {
> +       /* The ACL payload must be long enough to hold the FW dump header=
 */
> +       if (skb->len < sizeof(*fw_dump_hdr)) {
>                 bt_dev_warn(hdev, "FW dump: invalid or corrupt fw dump ch=
unk");

Id argue that this should be appended as is then, and the analyzer
should be the one checking it, _or_ it needs changing and then it only
process the dump _after_ reassemble.

>                 goto free_skb;
>         }
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
