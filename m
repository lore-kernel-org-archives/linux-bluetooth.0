Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550437D127
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770262; cv=pass; b=r9zD9k/HVgrLQx2mCe7P7VYzO7YEYVpAED+uOkOI2xHkPPcNYfZh7f5RfYSUeq8kPo+GCdXo4FUYbqfKaSoeR1FYJHKFaU8mlW30tCIbH1wbsh3ImCqGv4Y3Nr/2D+RqPXyozhOuqjCAb/a2Jcm9f8cMbqwdjYRSvq3nFRbjPGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770262; c=relaxed/simple;
	bh=ATiRPuDL6uGVu4q1OpUo2Qvf120HLJ8ba3ld/ecCS2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uP+Gq1t3bz/gz7cAeiebPvG6BsQ49QaPHVJHeAAOWmg/kXqufvDBUB+A+BrrWfyogDg5S7PASjdyjmcRot5+JEoR9Mg2kHvVQ4PoiLvqPr0P3S+Ws7hvCWumroSML8E77ivmnWO80DNkgjuVOkxbhyumFEhAvMggiLwnOttrZjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3v3p3n3; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3v3p3n3"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64c9a6d6b70so5119876d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 10:57:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773770258; cv=none;
        d=google.com; s=arc-20240605;
        b=U1T/01qQ94JV6P2yW4h6UKZhI/zo8oaP6kg0H6rAiOsGr86x9YXCENCEoudv04JeSq
         wGkUkfQhOw+C+ds+BGgQNcdzrE3uqHdeiBPZGL3jw+wbzjpRmfmVlto/pSk5fEvJkjqQ
         upOcIoY7l36ox7Ji315ftfdtIiEAyf+7FjJP8/ePWcbKMeDk8G72pPKYXYnvugq9vLTP
         yjrXupyfo6+/Mk+S0Zjm3lfV+M5ihegtJ8e+G54/XlRwOgax8PMDByn36HaLIeHERgsn
         eu4Yi0EdG8VkSE+2Uxxkwpsy09g8IpwUGirzTQYYOrclHqO+8c4HIKg2kRYtqr4HPrsS
         QowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6wmjG2g/fqd2q8sVRPcMgd8JiKHBdwb5kehO0TNLX/M=;
        fh=I08MVYRFsk3ianfGT74oyN+ut5eeUUw/nGErTUmy/QY=;
        b=TohXfjW/u0i9YDENjtdmrDi8cNpxT7OuZuLeq07ZIFcsnp9KOZLnD8OmL3dkle+Acr
         azgQ4UVQwSSXzkilQs4GdcFrNMwKynk0MyDa4cNtlt+cJ+T38ChVUssZIemE3co9/0TI
         jc68JQKb7tjuWe2KS46q5/yJ47UJH9MaKP//vIFW3yAg6sVO1YA9H8aly03UvQO4LYp5
         0SFGtiRPh8oM1psCw7S2fNOpKvsgLTZ0sIxESSoKPfDzTWM/Ma00Tn4R9gz+Ta+1POe/
         XolZzIOOaGM2B/DdstpSOJxqK16TfON/QCAL5roUD+UI0cKj5E0dqHKTHTjYhXCiqBiO
         yXGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773770258; x=1774375058; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wmjG2g/fqd2q8sVRPcMgd8JiKHBdwb5kehO0TNLX/M=;
        b=A3v3p3n3W62eShK8NqGFX1424/x1s76P5sZpUUvtEOL56mImLUmqCH5UhpwC55EeZm
         cbAPKuDrNeE3J4QPgGWLZhyVNcA5hhzYfIkBUttsDoaM48Jb7OT8qJSWS8c2SQE9mrZz
         +7Vi9BmfXmWwr/lP2GLeI008VnnnffmAcM1XQItqfnJpM2MmOuQaBBbjf18CbAHGqmmg
         c9qti+iL6a6FJGS4KhMT2YpZqiMccpdESQaZ3TTRBG/qnxGSj32n3hK8cdKlrFEU6IGP
         BMMziCPz51dVz5Q4eDcxmXPNjXNBMmqvGLQIphQNR4e/JykgrM7HTvGy6Rswl2cyoI/q
         hg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773770258; x=1774375058;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wmjG2g/fqd2q8sVRPcMgd8JiKHBdwb5kehO0TNLX/M=;
        b=BnKdeohuDDfud6MWPgugLgLPo261Lx6TPTxegzs/vlYadrheohUsnoTszGYaq6hw3c
         HHoUwIzSlFCiWNWR85kZy9w0xbsxH5vv3E9G2ejVL14HmUACa7b0SHofmWlpZ1Sq40nT
         iSx6hp5bwJW67XChLc5JJr+wwulsAWbgPWOiIGzumiaKYL7Df3kAaBW169TRej5p+j28
         zHeRFxI5ZeKQK/qp7VCwMFS6QpJXSTFAymUzdUNVRge45ZQCT+1pZ2EZAHb34zFS4kif
         MwC3vUYEMO8YTB/GL2CWg1mXf/ErCsUyB3JTghrFXm9HV0Yz/exNFTlk0HvpW4+8jSpP
         UAVw==
X-Gm-Message-State: AOJu0YwKTa5uLEvhtZ8XXz2fWA7U1ecgQvAj+BBpAVkSmiyx/0M31zU6
	FkwOqkG/zJvBnGQO4qfqBC7IUBt4G+FVjm9KbBx5tmilE8YWU8F1AEuNS4hFM70+7MnE5/PT3ZU
	v4BWWDgQxMD6bM2W3l7m0vGJJB+Ame00KEhmR
X-Gm-Gg: ATEYQzyyBFyLK45QwtSv5R6zEfwgZ9F4Ec5Ejw9Mw+P03a7dktJ3vwm3GEVHk1B+I05
	xa/A2iBvISTPnUEgFtCY37fc9Iw21k5wxd6eGmeB1GVsHEEyy5pJJTAWPfm1z7N8npc/vm/FeJ7
	7+mgsY+Z6z76MGR1S4SMOvqe5prAAHaKyDSgP+TJ/gLx+/sITL0t8BSuscDdIUKWyZMgneg8y/Q
	+ikUE5bek3hk8lYFTcN7HXZ1OHr9Y/nqE1k17PHm8b/c/lBo2/AA82uMWlBTU+xkiXT4IoexSog
	zvUG+4Z2SIXOvn1vRSRhBW6pVuSUf5/ANshyBzjP0a9ESpef4mmhXUEkNoWJPUeP2E9kpg==
X-Received: by 2002:a05:690e:259c:b0:64d:626a:f4fd with SMTP id
 956f58d0204a3-64e915e1fafmr419879d50.71.1773770258204; Tue, 17 Mar 2026
 10:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317160258.194853-1-luiz.dentz@gmail.com>
In-Reply-To: <20260317160258.194853-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Mar 2026 13:57:27 -0400
X-Gm-Features: AaiRm510FdGFolY4OBF6RtEYcb2AthTMm6me7dhcapGOCIU6iy4Kc8UQhoOmlGs
Message-ID: <CABBYNZLJe1CkOntxtvRUviTZwo4=O_x3jn9EM_8AYBN9ojPBfA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix regressions caused by reusing ident
To: linux-bluetooth@vger.kernel.org, Christian Eggers <ceggers@arri.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Mar 17, 2026 at 12:03=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This attempt to fix regressions caused by reusing ident which apparently
> is not handled well on certain stacks causing the stack to not respond to
> requests, so instead of simple returning the first unallocated id this
> stores the last used tx_ident and then attempt to use the next until all
> available ids are exausted and then cycle starting over to 1.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221120
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221177
> Fixes: 6c3ea155e5ee ("Bluetooth: L2CAP: Fix not tracking outstanding TX i=
dent")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 39 +++++++++++++++++++++++++++--------
>  2 files changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 010f1a8fd15f..5172afee5494 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -658,6 +658,7 @@ struct l2cap_conn {
>         struct sk_buff          *rx_skb;
>         __u32                   rx_len;
>         struct ida              tx_ida;
> +       __u8                    tx_ident;
>
>         struct sk_buff_head     pending_rx;
>         struct work_struct      pending_rx_work;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ead51dc0f3f1..4dbd7b1bd72f 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -926,16 +926,37 @@ int l2cap_chan_check_security(struct l2cap_chan *ch=
an, bool initiator)
>
>  static int l2cap_get_ident(struct l2cap_conn *conn)
>  {
> -       /* LE link does not support tools like l2ping so use the full ran=
ge */
> -       if (conn->hcon->type =3D=3D LE_LINK)
> -               return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATOMIC)=
;
> +       int ident;
>
> -       /* Get next available identificator.
> -        *    1 - 128 are used by kernel.
> -        *  129 - 199 are reserved.
> -        *  200 - 254 are used by utilities like l2ping, etc.
> -        */
> -       return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
> +       /* LE link does not support tools like l2ping so use the full ran=
ge */
> +       if (conn->hcon->type =3D=3D LE_LINK) {
> +               /* Allocate ident using min as last used + 1 (cyclic) */
> +               ident =3D ida_alloc_range(&conn->tx_ida, ++conn->tx_ident=
,
> +                                       255, GFP_ATOMIC);
> +               /* Force min 1 to start over */
> +               if (ident < 0)
> +                       ident =3D ida_alloc_range(&conn->tx_ida, 1, 255,
> +                                               GFP_ATOMIC);
> +       } else {
> +               /* Get next available identificator.
> +                *    1 - 128 are used by kernel.
> +                *  129 - 199 are reserved.
> +                *  200 - 254 are used by utilities like l2ping, etc.
> +                */
> +
> +               /* Allocate ident using min as last used + 1 (cyclic) */
> +               ident =3D ida_alloc_range(&conn->tx_ida, ++conn->tx_ident=
,
> +                                       128, GFP_ATOMIC);
> +               /* Force min 1 to start over */
> +               if (ident < 0)
> +                       ident =3D ida_alloc_range(&conn->tx_ida, 1, 128,
> +                                               GFP_ATOMIC);
> +       }
> +
> +       if (ident > 0)
> +               conn->tx_ident =3D ident;
> +
> +       return ident;
>  }
>
>  static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
> --
> 2.53.0
>

Do you have any capacity to test the above with L2CAP/COS/CED/BI-29-C?


--=20
Luiz Augusto von Dentz
