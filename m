Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDF03E2762
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846658; cv=pass; b=oz4l9z2CrbLbca4phyAMe90JRuUK1wuk+kYSaNJHFFHkkacZ1pbTU+h5Hig25e3pVsf6Y0LlirutNb7FLt6myt+WRlJiSnL+dselKyf1NQBGjhXgsjd5IEIP5Jmig3Jk5ASDxc+u50Fe8VhLqZ15G5EMlaltY7uJG9KPDruOQQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846658; c=relaxed/simple;
	bh=rsfkC2YcIsGPu8uCjSeQAL+u8mT5NcDG0WvoIxyZJI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNs77V+VvMA/GVLQS1fKiB9kMNe2WyyP6LvBoEezMlCLI+nlfRBOHGdF5swYsLS46AY8Rl2scthC+RvorrRFTmqC6xgUzdnXyqXVIe1MapUACC4+GI4jKh48Fw4gAOqn1sbtBF4bif5L76Pghudsyag55iooxv781dmCgmT30es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXEiWAJs; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXEiWAJs"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ca2b32f46so20328d50.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 08:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773846653; cv=none;
        d=google.com; s=arc-20240605;
        b=kGdTssw4LRwLELzoNXW4OQ0yFG3uT1xQKThjd+KNi12aIu+PeejlUjdHV3swFrGWbo
         49FrK9lUBSwvI2psE5g/Swdw0RryQB/Gob7Ha9hCIOG/0QcYClyPYDhDDTh845YW80gI
         fHqKfQ/+kSwbcBlSz+e/dDEzwtBeZnzDQ1C1aYd4E9DbYb/3UGRknoE9RQzt+2MVzBym
         viPh2b5LISv/pGA7sZNg2t2e1576lQCn2KTqRyNp9GNX4fE4kmY3NLyj0xtkVi1b7mvn
         52Nl91f4KgDDpSKNa3Ae4p8cxfE0BMl1dNcaYCZiOR75vVLAVY+2Z23aYHphsULxOmiE
         nW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wPREAHv5y9Mor44ygJ4J4/W5N3VaLesbU2I4BqeC4GA=;
        fh=kQa6Wv+jZCCo0Dk13pUerCaj03ZHdzDdDvtl5YYmgPQ=;
        b=EGLJ+fUqSFSSYtHxQKhR3VfQxLX5XTFsv5OY4WPEKuBgCcQUV6k0LlUDA3Mpd/NqiV
         2kv9Ngxk1k37alSsLFw598HtZKQO33jgO5gqDeunlGFXnUUT1vCYduP8jSEq1o9N92s+
         yBreaN3g2u4lbH6m3SFNnFdCHw+61XXU0XPlqqeWnuXJDe3ZPrFQAn/vB6YQbJqtvgZr
         tR4g9jssF88rFqOfMq+MmNeiC/H2mAYzdARS0eKpvBHvpkdovMkCTArtA/5z0m0wl4Gi
         eXBWzZ6lz4MjEkt/w6GgONK+d3kxmYwV7tcaa8bm6xRhhqHumE9Th/9ppMw82RNKCFuE
         OCdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773846653; x=1774451453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPREAHv5y9Mor44ygJ4J4/W5N3VaLesbU2I4BqeC4GA=;
        b=fXEiWAJsBcSBAnDuAz2v+zSda/JIU9Su/kJz990ml4vMlh/kE7p3bvQC5ugORXzLm8
         xkjVdrA7DbGmSsgaQDNAmUJ9PXM3ARPuE35po1/QzSAYmdqCDWY87K4h/kHOYdcu9sDZ
         Epq23GeSh56QUF3pFRhwjX2XnDvFFV3vxM1/Ac9s8jYvmgOr37WUdCmfAYwHIVdzAeAx
         75fZwq859RBTw5kA4TXDIU/cO70rRiNBy7OlVtEGT09w60Vnb1PtLfM+i8QZJZP78f6A
         naD5ZWaaeh3XhV9dNGkI0fXZ4OBnUddnkrTJ4fb9+t6YPvzfxeLTQfK59tPgVy+oQNne
         w2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846653; x=1774451453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPREAHv5y9Mor44ygJ4J4/W5N3VaLesbU2I4BqeC4GA=;
        b=rcishdJf+0GEYM5SoN9biPiGFpvpuiHK3yuZXrNwfK+npqjw7hq5QwMJN5TAP8GQLE
         utjau18973F/iBC/HzvRVsg7FucCtTKWbbygxDZGsJkY3Kj+oAc7MQtdqJwuQ/fgzrA1
         eLbN5zHgWIvYKarc7/Nb5ha8VlmXtKuha3fcnI4FkTvBBPRSYvHvkYxvE7f29+7DLe6P
         Fy+O3ZFsviN5kyPO8z3oNsTqfSIeD8cOasaQhhrUtNdZO0AvDaxDT1cJXz2wL3FxU1xE
         A81RX0SJGU/MEWi68bqUAS+yzdtCVBU35CCAa6LVlNIqXOY5JgkuATQIxTxAv1UTDY1n
         x/Pw==
X-Gm-Message-State: AOJu0YzZgdiPlIVEGpGUiivGRKhuniNFogcxgPtLmqZ1X6XgCrdpyLSK
	1nPemn8rD12fuMGGFA+aAO8MYQcKYFoaovwFUS7Xr7dS4FoLRSivmvAuKt1jz0zd2AJfaB6GxXf
	fOqKgKfEfmne1vMDm1sFoJtZPyeytQCM=
X-Gm-Gg: ATEYQzyyskhMoV8lmq/LTZUcaEhUiTlEWDIbpCtIZBvY99MgtcjBv2iuCK9ZyFDBBzQ
	P4Qqb6bl5CwwewNGXouHrAnTeXVbJz0emJAG5qliNnxhXG/UEgNGm56VgH5tLCbnBGgOMV954za
	T43QcahyqTSENu+7zngWbQQ+NMEZBs0TewpF3XYahNb9WpsptgrPBBVxSjVDtW5l3wbMnbeqcD0
	OAJ7hzTJEM1JcXLFbVBRmzM0O52zkUylm0f7EPRgz3aRW5eY8QSsG3c1YyaSBcGZSzALh2DL35o
	xd5jOk8+Nnvf5h4MLRBdYhmmHvhMpHusenHjN6xviJBVUkcDZNNZ36Ppb/dJ+w05rRA=
X-Received: by 2002:a53:ece4:0:b0:64c:b242:497e with SMTP id
 956f58d0204a3-64e912e8a07mr2997010d50.1.1773846653146; Wed, 18 Mar 2026
 08:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317160258.194853-1-luiz.dentz@gmail.com> <CABBYNZLJe1CkOntxtvRUviTZwo4=O_x3jn9EM_8AYBN9ojPBfA@mail.gmail.com>
 <2351187.vFx2qVVIhK@n9w6sw14>
In-Reply-To: <2351187.vFx2qVVIhK@n9w6sw14>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 18 Mar 2026 11:10:41 -0400
X-Gm-Features: AaiRm53q7pk7TpIsNq4wbX2DSd9vjggt0q69a1onlAjeftISj6boFhHfjnE1XT0
Message-ID: <CABBYNZL4sksat4WC81dsFbpgdTxGALi6Lbj58xSRfyegwVNAAg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix regressions caused by reusing ident
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Mar 18, 2026 at 9:33=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> Hi Luiz,
>
> On Tuesday, 17 March 2026, 18:57:27 CET, Luiz Augusto von Dentz wrote:
> > Hi Christian,
> >
> > On Tue, Mar 17, 2026 at 12:03=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This attempt to fix regressions caused by reusing ident which apparen=
tly
> > > is not handled well on certain stacks causing the stack to not respon=
d to
> > > requests, so instead of simple returning the first unallocated id thi=
s
> > > stores the last used tx_ident and then attempt to use the next until =
all
> > > available ids are exausted and then cycle starting over to 1.
> > >
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221120
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221177
> > > Fixes: 6c3ea155e5ee ("Bluetooth: L2CAP: Fix not tracking outstanding =
TX ident")
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  include/net/bluetooth/l2cap.h |  1 +
> > >  net/bluetooth/l2cap_core.c    | 39 +++++++++++++++++++++++++++------=
--
> > >  2 files changed, 31 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2=
cap.h
> > > index 010f1a8fd15f..5172afee5494 100644
> > > --- a/include/net/bluetooth/l2cap.h
> > > +++ b/include/net/bluetooth/l2cap.h
> > > @@ -658,6 +658,7 @@ struct l2cap_conn {
> > >         struct sk_buff          *rx_skb;
> > >         __u32                   rx_len;
> > >         struct ida              tx_ida;
> > > +       __u8                    tx_ident;
> > >
> > >         struct sk_buff_head     pending_rx;
> > >         struct work_struct      pending_rx_work;
> > > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > > index ead51dc0f3f1..4dbd7b1bd72f 100644
> > > --- a/net/bluetooth/l2cap_core.c
> > > +++ b/net/bluetooth/l2cap_core.c
> > > @@ -926,16 +926,37 @@ int l2cap_chan_check_security(struct l2cap_chan=
 *chan, bool initiator)
> > >
> > >  static int l2cap_get_ident(struct l2cap_conn *conn)
> > >  {
> > > -       /* LE link does not support tools like l2ping so use the full=
 range */
> > > -       if (conn->hcon->type =3D=3D LE_LINK)
> > > -               return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATO=
MIC);
> > > +       int ident;
> > >
> > > -       /* Get next available identificator.
> > > -        *    1 - 128 are used by kernel.
> > > -        *  129 - 199 are reserved.
> > > -        *  200 - 254 are used by utilities like l2ping, etc.
> > > -        */
> > > -       return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
> > > +       /* LE link does not support tools like l2ping so use the full=
 range */
> > > +       if (conn->hcon->type =3D=3D LE_LINK) {
> > > +               /* Allocate ident using min as last used + 1 (cyclic)=
 */
> > > +               ident =3D ida_alloc_range(&conn->tx_ida, ++conn->tx_i=
dent,
> > > +                                       255, GFP_ATOMIC);
> > > +               /* Force min 1 to start over */
> > > +               if (ident < 0)
> > > +                       ident =3D ida_alloc_range(&conn->tx_ida, 1, 2=
55,
> > > +                                               GFP_ATOMIC);
> > > +       } else {
> > > +               /* Get next available identificator.
> > > +                *    1 - 128 are used by kernel.
> > > +                *  129 - 199 are reserved.
> > > +                *  200 - 254 are used by utilities like l2ping, etc.
> > > +                */
> > > +
> > > +               /* Allocate ident using min as last used + 1 (cyclic)=
 */
> > > +               ident =3D ida_alloc_range(&conn->tx_ida, ++conn->tx_i=
dent,
> > > +                                       128, GFP_ATOMIC);
> > > +               /* Force min 1 to start over */
> > > +               if (ident < 0)
> > > +                       ident =3D ida_alloc_range(&conn->tx_ida, 1, 1=
28,
> > > +                                               GFP_ATOMIC);
> > > +       }
> > > +
> > > +       if (ident > 0)
> > > +               conn->tx_ident =3D ident;
> > > +
> > > +       return ident;
> > >  }
> > >
> > >  static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *=
skb,
> > > --
> > > 2.53.0
> > >
> >
> > Do you have any capacity to test the above with L2CAP/COS/CED/BI-29-C?
>
> Today my test system seems a little bit bitchy, so L2CAP/COS/CED/BI-29-C =
even
> doesn't complete with my latest working version...
>
> After applying this patch on top of my latest version (6.19.9 +
> the BT patches I already submitted), I see a new error (log is below).
> At 40344 ms, the connection request sent by the IUT has an identifier val=
ue of
> '0' (just after wrapping around) which is not a valid identifier as of
> Core Vol 3, part A, chapter 4 (page 1122):
>
> "Signaling identifier 0x00 is an invalid identifier and shall never be us=
ed in any
> command."
>
> Any idea why the identifier used by the IUT wraps around from 255 to 0
> instead of 1?

Yeah, that seem to be a bug in the new version, let me check how to fix it.

> regards,
> Christian
>
>
>
> +40078 ms
> Verdict Description:     Received CMD:LE Credit Based Connection REQ:
>     Code: [20 (0x14)] Code
>     Identifier: [254 (0xFE)]
>     Length: [10 (0x000A)]
>     SPSM: [128 (0x0080)]
>     Source CID: [64 (0x0040)]
>     MTU: [672 (0x02A0)]
>     MPS: [23 (0x0017)]
>     Initial Credits: [30 (0x001E)]
>
>
>
> +40078 ms
> Verdict Description:     Sent=3DLE Credit Based Connection RSP:
>     Code: [21 (0x15)] Code
>     Identifier: [0 (0x00)]
>     Length: [10 (0x000A)]
>     Destination CID: [79 (0x004F)]
>     MTU: [64 (0x0040)]
>     MPS: [64 (0x0040)]
>     Initial Credits: [2 (0x0002)]
>     Result: [0 (0x0000)] Connection Successful
>
>
>
> +40078 ms
> Send Event               HCI!ACL_DATA_REQ{
>                            connectionHandle=3D0x0010,
>                            boundary=3D0x00,
>                            broadcasting=3D0x00,
>                            length=3D0x0012,
>                            p_data[0]=3D0x0E
>                          }
>
>
> +40250 ms
> Receive Event            HCI?ACL_DATA{
>                            connHandle=3D0x0010,
>                            length=3D18,
>                            boundaryFlag=3D0x02,
>                            broadcastFlag=3D0x00
>                          }
>
>
> +40250 ms
> Verdict Description:     ReceivePacket!
> receive=3D0E00050014FF0A0080004000A00217001E00, CID=3D5
>
>
>
> +40250 ms
> Verdict Description:     Received CMD:LE Credit Based Connection REQ:
>     Code: [20 (0x14)] Code
>     Identifier: [255 (0xFF)]
>     Length: [10 (0x000A)]
>     SPSM: [128 (0x0080)]
>     Source CID: [64 (0x0040)]
>     MTU: [672 (0x02A0)]
>     MPS: [23 (0x0017)]
>     Initial Credits: [30 (0x001E)]
>
>
>
> +40250 ms
> Verdict Description:     Sent=3DLE Credit Based Connection RSP:
>     Code: [21 (0x15)] Code
>     Identifier: [0 (0x00)]
>     Length: [10 (0x000A)]
>     Destination CID: [80 (0x0050)]
>     MTU: [64 (0x0040)]
>     MPS: [64 (0x0040)]
>     Initial Credits: [2 (0x0002)]
>     Result: [0 (0x0000)] Connection Successful
>
>
>
> +40250 ms
> Send Event               HCI!ACL_DATA_REQ{
>                            connectionHandle=3D0x0010,
>                            boundary=3D0x00,
>                            broadcasting=3D0x00,
>                            length=3D0x0012,
>                            p_data[0]=3D0x0E
>                          }
>
>
> +40344 ms
> Receive Event            HCI?ACL_DATA{
>                            connHandle=3D0x0010,
>                            length=3D18,
>                            boundaryFlag=3D0x02,
>                            broadcastFlag=3D0x00
>                          }
>
>
> +40344 ms
> Verdict Description:     ReceivePacket!
> receive=3D0E00050014000A0080004000A00217001E00, CID=3D5
>
>
>
> +40344 ms
> Verdict Description:     Received CMD:LE Credit Based Connection REQ:
>     Code: [20 (0x14)] Code
>     Identifier: [0 (0x00)]
>     Length: [10 (0x000A)]
>     SPSM: [128 (0x0080)]
>     Source CID: [64 (0x0040)]
>     MTU: [672 (0x02A0)]
>     MPS: [23 (0x0017)]
>     Initial Credits: [30 (0x001E)]
>
>
>
> +40344 ms
> Verdict Description:     Sent=3DLE Credit Based Connection RSP:
>     Code: [21 (0x15)] Code
>     Identifier: [0 (0x00)]
>     Length: [10 (0x000A)]
>     Destination CID: [81 (0x0051)]
>     MTU: [64 (0x0040)]
>     MPS: [64 (0x0040)]
>     Initial Credits: [2 (0x0002)]
>     Result: [0 (0x0000)] Connection Successful
>
>
>
> +40344 ms
> Send Event               HCI!ACL_DATA_REQ{
>                            connectionHandle=3D0x0010,
>                            boundary=3D0x00,
>                            broadcasting=3D0x00,
>                            length=3D0x0012,
>                            p_data[0]=3D0x0E
>                          }
>
>
> +40422 ms
> Indecisive:              Received Identifier is not unique. Received=3D0
>
>
>
> +40422 ms
> Verdict Description:     Received Identifier is not unique. Received=3D0
>
>
>
> +40625 ms
> Send Event               HCI!HCI_RESET
>
>
>
>
>


--=20
Luiz Augusto von Dentz
