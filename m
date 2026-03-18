Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0C184540
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 21:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870979; cv=pass; b=Iq5VWgZDrf6ZmPN9mT9bBS0BycPyoGOwIUq7quNt4CElvzlWEot13D1oZbgQyF25atp0PAdlbJIN+Yj8L0OHmp79/R/zfvpLgR3EwTXKGGgq4YyPa0WyWdq6XGP5ibm6tYgiMk5dzsv1f7IOe/QIlrv/pCoofO//DUdgeYm4rVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870979; c=relaxed/simple;
	bh=R2UrJw0RZ+c3RlCfg8obuufqYjsA00SyP55Jh4kXjGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oYx4gHZ3YUUl8UftvSc/AO+D0InIiAjxdBN/xaRUe6R7zZqslE4zDZh9X7R6yC6/CX1GSCoubhBGNxLreGmnnupRSRe2tnMjkKLaSa1FDq2EFl9U4azt4k7l0bKWu3NgbG3Aj7aVB1HFFRsu33i28QuqdGa8lkyXc8ZbhWIsZW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msbd+NiL; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msbd+NiL"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ca6595c8aso449979d50.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 14:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773870977; cv=none;
        d=google.com; s=arc-20240605;
        b=bKE5OU8kQOWQFbcV2/BElOa7JeonfASpDhQEKOEaR86sWILZLyDOPOXuaWa6+xjMUk
         8OUO7B2wAD/4L1IMtsedxP50qm6/fIVQT0s2wz4lBvwiVfjjy/SRvi61KHUMHWypVr/M
         x1m2vNWJ8+eduy2QCEMU1DXakdO2YXX/l82QkeN3uhQC4ERZeNi1Zom6R6ElrtE+6GHA
         wqNCXzu8Kp4487K60jL8Hs56HQRTJBfpXn843SsaOAu/gTtC4iUhAE18vpFsknGfjZmd
         eg1hFQ/7RUM6xGO1pEPU58+XYti8rGUkk3K5tWhvf7apqBRIuO3+04Q1MrArY9z3k3Go
         gzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2NBocKYwYMdkCxg0sDCYE+VGL7hfHbVS1QJdb3ts1cA=;
        fh=I08MVYRFsk3ianfGT74oyN+ut5eeUUw/nGErTUmy/QY=;
        b=HMtJQ5bDXF0r5LavC3jWnhFKymMV+KIXdPoQz25pemMtRnP5wokNM8jXRnkZD5Scxq
         58lFI3QzPTBG4x9l6tYYZaXX2K+glK28q0nZQrt2n5jf7R3fs7l66T8rNAf6E04fky5L
         GJGgU+jA4bhO+MredK8Q9v6Wm3OSmiiBAwu7xmIty8AEMjH8XeJKP1okRaTR3B28U0vZ
         DE0VM+0kbd9Gu77AzlRRg+FNNrOEdknBwokm+O/8mzOUUOM21a3mY5WGraSM4AQkeNqc
         GT5hsusWrvm0lPuisFr7GT01C4QvxqJn+ugQ25jHnVTlNYB1Jk0uASIR5OHApQ+VQaRw
         wPag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773870977; x=1774475777; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NBocKYwYMdkCxg0sDCYE+VGL7hfHbVS1QJdb3ts1cA=;
        b=msbd+NiLnsPKq1fQQDdg9ukukeuIbPEvRV06lMvcBxjoQQMiCP7kfTCUq9uzd3v2EG
         LIqlbBA48EgffcQVnxXc6pGyxDd1A6olGDocvmf5b/rBVEPNp83a+B21BkPnoJSU/SEf
         osdYapnEdnwYBgvEWQrApkcgs/yqelj/YcZo5aiFz3YIrYyu29qLGpchiR5M5nbuCy9E
         xvNG3gGujFscCvKxTG/hHxhAMcgNx2guOKJnljpVgIpYmSckmsua5cJf6wUvYBMQ0A1p
         i1/PydqFIbnUOQ2i38YeVxSdYoGtVKO2JPZ0gC1bd7GcOMDWZ8EOaS8yuLskn2eJ2Mju
         mlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773870977; x=1774475777;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NBocKYwYMdkCxg0sDCYE+VGL7hfHbVS1QJdb3ts1cA=;
        b=d/4uiBCZT48QYYTCG/4rIS1fd5eVepvQEB5uLu1bFakBp6U+po/xpXK1I9ZnBp3f4a
         s08MccOed6uhYNBt1FVGBODWh0ZrGmFCAeLImUbxJ7tP+dQRGhoR74+ezJX4HqUDwrgI
         5ojBnqVOse5AL/qbRPW90XehWO3iqZrmNEVesYdMc3VEYoXU5RU3rnIyQIaUrhydYX1X
         5//YTOL8Y10bTH92OJO7W8Z4kZSFRAowwoJhWLiMy2YbeOmD0V6I8Lb1gx75F7Sff+kv
         yMUjTwzFYmy9OMe/NWpK0IyDI3UlNSxc2ijdaAPTostlpB+IZnXbs5Y8cuIAeHFn4yrI
         ZjpA==
X-Gm-Message-State: AOJu0Yyh1CyDsoGk8ZYR/o5sAgpbKBamc5/Ha88il4CK4lWjRQB9B2Ee
	3S/xv1BsqNPBR2S9NJi73C525MKG0fqdIR1YgyCDIob3c2EGd7zgBvXKTHjJiNzeYJj5pctkWYQ
	ZWNdzEIAzeSaffpKvccFpdKGZ7Bpv9m+4FHG6
X-Gm-Gg: ATEYQzx8BhxcOig10ZscVl74kJaqaixmbmYu5fVoz3Cd2NF6Q1TYnr2o5FozRw6L5HA
	00aOzvkjSA5h7V+rcP7E60I9ETKO5hDxmo/3Ty+6dTUXvnOdZzH01e/OI3sIx3um4N2z65c1q1n
	1XlxJ/FSr/sYtpY+Up1TGfvsHUInxes+z9M1IZI77djxURYJ3HanJgSotsVhO7YufXwsyxvG6f8
	qNja65eakAjwMhQ3p6ao59yPX5kWl9eXSUMhQa+c4U+zDFl+ZIgTGvcbEZH1VSYCRJNVvFtJRuS
	4eLPLJjF7TX68bQnNDUG2yBzy9NHvH/4FqdRuq+Nd4cIIOAEwS8MCyspo8dy7s1CAic=
X-Received: by 2002:a53:a7cc:0:b0:64d:6813:6869 with SMTP id
 956f58d0204a3-64e9161093bmr3926615d50.73.1773870977251; Wed, 18 Mar 2026
 14:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318180922.307838-1-luiz.dentz@gmail.com>
In-Reply-To: <20260318180922.307838-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Mar 2026 17:56:05 -0400
X-Gm-Features: AaiRm52SlDEA1rxy1n4hcZlkDeozOxAxbDqQm2D8G6anEZt1n0E_I-LoqHbziOo
Message-ID: <CABBYNZKdB2i-zB4ZZmLda8ZShwi4P_RzjutzhDYMV6SGWtiKPg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix regressions caused by reusing ident
To: linux-bluetooth@vger.kernel.org, Christian Eggers <ceggers@arri.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Mar 18, 2026 at 2:09=E2=80=AFPM Luiz Augusto von Dentz
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
>  net/bluetooth/l2cap_core.c    | 23 ++++++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
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
> index ead51dc0f3f1..a818a58362d5 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -926,16 +926,33 @@ int l2cap_chan_check_security(struct l2cap_chan *ch=
an, bool initiator)
>
>  static int l2cap_get_ident(struct l2cap_conn *conn)
>  {
> +       u8 max;
> +       int ident;
> +
>         /* LE link does not support tools like l2ping so use the full ran=
ge */
>         if (conn->hcon->type =3D=3D LE_LINK)
> -               return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATOMIC)=
;
> -
> +               max =3D 255;
>         /* Get next available identificator.
>          *    1 - 128 are used by kernel.
>          *  129 - 199 are reserved.
>          *  200 - 254 are used by utilities like l2ping, etc.
>          */
> -       return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
> +       else
> +               max =3D 128;
> +
> +       /* Allocate ident using min as last used + 1 (cyclic) */
> +       ident =3D ida_alloc_range(&conn->tx_ida, conn->tx_ident + 1, max,
> +                               GFP_ATOMIC);
> +       /* Force min 1 to start over */
> +       if (ident <=3D 0)
> +               ident =3D ida_alloc_range(&conn->tx_ida, 1, max, GFP_ATOM=
IC);
> +
> +       if (ident > 0)
> +               conn->tx_ident =3D ident;
> +       else
> +               BT_ERR("Uanble to allocate ident: %d", ident);
> +
> +       return conn->tx_ident;
>  }
>
>  static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
> --
> 2.53.0

Give this a try.


--=20
Luiz Augusto von Dentz
