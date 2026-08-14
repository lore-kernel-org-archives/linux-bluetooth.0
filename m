Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D659363C64
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716508; cv=pass; b=rMFEYDfqLS8xDkf67Q2Gb+dissm0ga07ZYMk/OMEbYqTDEB68B8aFx92Vu2HLiHBQebwUiY+Qp5/1CeMBprzVi84e45rakq0qIIQrH5CLxJCKiSLy9whY/V0+QWUoadZw6ZSIjgvdFKt0hMtbxkV+2f4aOvGOg/QhGI/SpaTOmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716508; c=relaxed/simple;
	bh=U+wXWEVBDwFO92Nm2eev/Cn8S8T1hTf04b8yNwOgkAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoD7p9e1Ye7gShx0WTRF65v325SsvdkJISgVQSJ1PO/xkMc8O5Y7DkS3IBbQtRh+ReuTmZNn1Ddh32U8k4Rhfg4+UnKKDO+WYvZB0GThjKMpKHLBwuDY5RV94ZVYmE5QsaNDp19MJcoCU0jeyVnN0ZY1sjFp3nriwupgfIYwFxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zuv/GJhg; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zuv/GJhg"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80bb41f7f3cso9409307b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 07:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786716502; cv=none;
        d=google.com; s=arc-20260327;
        b=UsENbbm7mHO0nGEuJNa5evy8Xl5KgPeEpXUM+FsI4AXdUYH6Z0Zh1YS7M5jMTnFEf6
         BV4WchoOrfedhkszD1FSnNQOXcgA9iyk6nLYTydjHDQ6XnPTzUPruP5aB5GPFmYqVWrm
         L23gBqF3tVeHJSfutoIFnfA2qQVRVcd81zQQuDo+43/JoMlpVkedPvGhFREt0hpLUDOd
         zQtAcwrejPfubabuzibKSi3wA/X1vorF9kE3k0vYidtFB2u4W6LIZ9N4Wlm0KB4wfzX5
         5OAxjzYXqizn6xpE0i/Vc2xNTvK945L3b6q6g837pQwB0oAE2cXTR11kL2DTUa8SgyHE
         GQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xBB4FXa/tUL1fekuXxonhIMIsjZqy69lPsymPJTPQhw=;
        fh=SafjKfZ8fM6P0dawqFRvMQrN/HsLB6xkhZg5/yagbFs=;
        b=WH9JRX75eK1LuFSqYFYOqf1EUJHj9abaIAxkIb3khVej2V1fLtkDv7VHpZyw6rvw+j
         DQQ8HoyISnzo71JoX9kuxna/oi8EQBBKxhFvH0cxWGMTYRkyRhF5RfW9xUU9FRQZ1K0F
         7ZF6euVSX45V8TxUxU/1e2YP590PlJJ3ogac61lPxswkmrxlOvIRv+Z31ni6nRkiiYAP
         2jcODS9zhSIZix2FsQNxP2Oe8kuN6D7QgbcPeVvDjngU32QLlIZqoGnCbtKWeC4jsuEA
         TEqedwJCUnAAZUjSYXqBmzXtgjUsfZ1UpV5acCENEopv5NafqMYRNgqVpTey3mmOuufN
         L0Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786716502; x=1787321302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xBB4FXa/tUL1fekuXxonhIMIsjZqy69lPsymPJTPQhw=;
        b=Zuv/GJhg1/9yWn67J5jzQOe8y1jr1NsNE47FtmeBIpJiskY+uVR7Cw3FPkzvVdZcQS
         gHbeqTq/Exw14WH4OVyApb/OLfdi77S49Vr9t4mFr9C61QBDT4Ma+5qS3UQSa1xUkFs4
         t+KheGoP7oATGRsvQ3VG7FDFzO59ZTlkv8dX5ykxCQE+BgQ4F9bXVTD7aGTbToWV7r91
         LLOMlGJtOtzgQmxCJZ2zdDSZPquI86lZN8bjwqspyFUJde+NBItb0Q4ONCVrFm3tXevu
         3QhsCdDkSH+6nzgjmv1uEODehJpQNRWpnTBBOXN5A2BXSJ03KJl5uxy+vLxYZMbbmuZt
         ZWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786716502; x=1787321302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xBB4FXa/tUL1fekuXxonhIMIsjZqy69lPsymPJTPQhw=;
        b=ofyecwXd07ean6ixXjVe8YZRUoyuguYo0nbguTN8vMBHK0hSQ/hK4p8Q9MGZTh1/R6
         PNSGyXlCgRgSKqn7h/BzTYO9l5tl5rYx/Nt2T355GxqgBNH6ZhC2Ra65x+82ca2kpPTn
         tGsRZfLGTz1zoZxdFImC9AI7PfPlv2gQ5ysJDlMB++NHBTNPEvoLERlubUtWVXAYUEls
         6urkzjdeVbIlLsi/Vl2tTM9fKUC9JTmKxWtMGbfilCtoV4zBIY6EdgajELEOqxXsGkn3
         yLv9s8rgNC21nwOggPiPstXQoTztPvwTFiIM5XZ0GogRveU43M1r2TF/V5YSxKrbymKH
         MCJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJlBjkxqG3Flo8ayHnrPoShoUT6PTyXKgY1uA3Ue7velzqSCFaff1tLmVG4l0d1dQI5BWFYf07khpOUun4ESY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLnm8o9ZrBHITqdHrshUfjzefPleS1tGMZTcm7k1qE68yrJ9N
	T5oH/D65W6x3FFwl7IPR6F41Rd15i/KBzFY+CrsG17LQi4RO6Lr8KGC2bdF8Rbt1pgyY9ZZWk9m
	h1cmP4cp8SlFIRyIYLEXKcBAiposVxSM=
X-Gm-Gg: AR+sD11/bs1rB/JbQY5ux5V6aLiHiRLjkjJlLcLUHdInZHagCF4i62N0xghHbl3db7c
	+sOtReJuaTanpybkivVWdGpBdz339z+bVrq5vChXIsNMF5aolyTNObFxCsjko1LgvhBERn2mHxG
	IM9jlDD/DwM9T0b1ZMQhqCNkhojC1QhvUEOsBMe2BJUJYLZaMg0vtWx8yK/IQ9jN/VIfr+hgzDh
	ENpb2VHtvb0nQQTZsCdIb+ljKx3POZwxzPNBxJzBdGDTAy4xmrxkrQZ5JaSOrBKvp1c9znAvDDp
	fuELn51zZlumNpVO7dkh89tVPyeK0s3OHTvkCu7z0swSI+nDEYTSa7jUNjVY5G/YSCEqxxWO4Xa
	fLxYBInX0wNMPORh3/3DOnQJ2kzfR/G4=
X-Received: by 2002:a05:690c:7013:b0:830:598e:a356 with SMTP id
 00721157ae682-8371125d10dmr25080437b3.20.1786716502100; Fri, 14 Aug 2026
 07:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814081221.913676-1-ali@iusegentoo.com> <20260814084110.920879-1-ali@iusegentoo.com>
In-Reply-To: <20260814084110.920879-1-ali@iusegentoo.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 14 Aug 2026 10:08:10 -0400
X-Gm-Features: AUfX_mxTC1u_AU3sgc-tDR6k7fZWe5woef17-g3qQdEE0qRHOPEqYdwDIcIMqbo
Message-ID: <CABBYNZKVQ0CxsviF92iP1Hj2rBiH_hmmEHirp8D=b-DvuaTNeA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Validate the FW dump header length
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: neeraj.sanjaykale@nxp.com, amitkumar.karwar@nxp.com, marcel@holtmann.org, 
	alex.zhou@nxp.com, song.xue_1@nxp.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ali,

On Fri, Aug 14, 2026 at 4:41=E2=80=AFAM Ali Ahmet Memis <ali@iusegentoo.com=
> wrote:
>
> nxp_process_fw_dump() pulls the ACL header off the frame and then reads
> seq_num and buf_len from a struct nxp_fw_dump_hdr placed at skb->data,
> without checking that the ACL payload is long enough to contain it.
>
> h4_recv_buf() collects HCI_ACL_HDR_SIZE bytes of header followed by the
> number of payload bytes named in that header, so skb->len is 4 + dlen
> with dlen supplied by the controller and possibly smaller than the 8
> byte dump header, or zero. A short frame with connection handle 0xfff
> therefore reads both fields from beyond the received data.
>
> Beyond the read itself, buf_len is what terminates a dump: a value of
> zero makes the driver call hci_devcd_complete() and reset the
> controller, so a truncated frame can end a dump early.
>
> Reject frames whose payload is shorter than the dump header.
>
> Fixes: 998e447f443f ("Bluetooth: btnxpuart: Add support for HCI coredump =
feature")
> Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
> ---
> v2: Warn on the early exit path instead of dropping the frame silently,
>     as suggested by Neeraj. Dropped the trailing newline from the
>     suggested message, since bt_dev_warn() already appends one.
>
> v1: https://lore.kernel.org/all/20260814081221.913676-1-ali@iusegentoo.co=
m/
>
>  drivers/bluetooth/btnxpuart.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index 6a1cffe08d5f..f439d287146e 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1370,10 +1370,19 @@ static int nxp_process_fw_dump(struct hci_dev *hd=
ev, struct sk_buff *skb)
>                                                                          =
 sizeof(*acl_hdr));
>         struct nxp_fw_dump_hdr *fw_dump_hdr =3D (struct nxp_fw_dump_hdr *=
)skb->data;
>         struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
> -       __u16 seq_num =3D __le16_to_cpu(fw_dump_hdr->seq_num);
> -       __u16 buf_len =3D __le16_to_cpu(fw_dump_hdr->buf_len);
> +       __u16 seq_num;
> +       __u16 buf_len;
>         int err;
>
> +       /* The ACL payload must be long enough to hold the FW dump header=
 */

The following can probably be replaced with skb_pull_data e.g:

fw_dump_hdr =3D skb_pull_data(skb, sizeof(*fw_dump_hdr));
if (!fw_dump_hdr)
...

> +       if (skb->len < sizeof(*fw_dump_hdr)) {
> +               bt_dev_warn(hdev, "FW dump: invalid or corrupt fw dump ch=
unk");
> +               goto free_skb;
> +       }
> +
> +       seq_num =3D __le16_to_cpu(fw_dump_hdr->seq_num);
> +       buf_len =3D __le16_to_cpu(fw_dump_hdr->buf_len);
> +
>         if (seq_num =3D=3D 0x0001) {
>                 if (test_and_set_bit(BTNXPUART_FW_DUMP_IN_PROGRESS, &nxpd=
ev->tx_state)) {
>                         bt_dev_err(hdev, "FW dump already in progress");
> --
> 2.55.0
>


--=20
Luiz Augusto von Dentz
