Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3754DBD6B
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815003; cv=pass; b=eMnEaKM6voqp5JaW7InCcR6BB7qasEK0Sg5Vg63kF8L2NjWbsArFv5udx2YsE42OEvR2i3XW/4sMsWbAwGd9FPI+BobNQk0T/PaTQWkiXs+3IU3IXySHDBjDu5dkQRy59whfCkcHI2CiTX/HbGjBxnF+736/v4huolzIatGWIFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815003; c=relaxed/simple;
	bh=xjmPkvMo3vo4zOSGLQm7Dz4s/9swrScaecsfTptuZv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1+8+FZFeDqeHnXh0UllKhy7QVQQcg3bVLw9HAL1hViLAUUrlsMpSYd42uyb56eAgSwTJk+jslrq2mBfP/P47skMwaxULNxAhA5jQ9iJsAc6XgYe2JF/pY6UsHax1QBa75Kel0XyCJ2S/RNdVfr/CzxpcIHN4VsabCYG/WFn9CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek0T+59I; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek0T+59I"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81f36179d72so6045387b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 06:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784814987; cv=none;
        d=google.com; s=arc-20260327;
        b=bVDVB4b/67fnsqMKOY+mHDQMyyHvHb/ltwVSCQlUjTAvND8fEvvpc5IwZpgybpUFHC
         CwyfYkjpbqjuUTRyzVhDv7KsipCroHH4Rt+iroAEoZtZbijt8Wi62MWxjxvYTceaxrCe
         0XD2+fClwtuwtr5Qvj3VwtHYmL3ZHR4eBKBbRK76AlrtDmel3RN3fHvTLjlzuzYslSmY
         xGIwMvX/AghUyc9stRcd0if/qJ0c36EHW3iqTyy5abyE0uiUve2o00QfFXHF5yjw6P9i
         ojXyz7xuFzf7MqMZH4qwnNmk2vAyybnVP7mtV7cXcvGCnyDMYJ35M4EIePBs0y7m1jLP
         DYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IFJ92pBYTYD/uZeF7jXVQGmoK/eZ5fV6naeUmAq0dyA=;
        fh=tc+Cp1CAxMrbfDIIMmfyZg0lDXBiTPfKoyckCY8Miy4=;
        b=XcdSJIUODlKZR+vHyth4ogReczYloH7Up8qM1vtGqWJT5HSOsNqhIivpcAbA8aYa5W
         tf7fNx6n8JQUJPlG7BGSINDtItjUB+oxPqGYjYsTmYu4FT445QJXXfQCyGshi7oRclgp
         DDyVGI+JA0LK5fNgkRVknK967FIabBmWIRDN20SV9rIkXYsfRSbE5n8sE0deCB0pDHd4
         pBPyAZ3egYpgHATJCgt/uvNe6JvYxMhAIBwXlZMC39E4SwvHZHtFGRrfYzPz/cOOpRUF
         puTIdR4Dp9WIXY9Xtkn9bjOpwqyNtbs2h+qHMsPKgH1HyunRGFWYo2q0jPA/2RrDCMV/
         NJZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784814987; x=1785419787; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IFJ92pBYTYD/uZeF7jXVQGmoK/eZ5fV6naeUmAq0dyA=;
        b=ek0T+59IQU5fhvBa179YL/r2SmoJRndcET1bFMWI1Eoqq6HwiKpQmB+OvFRBSlbhLO
         bV07ZiBv+rufb67o2/eMPRth4qOiIQtJvP77/IgrN0XUe+WXkabcfdlysr1ISoXJ4HBh
         sK5AwebKigfDhpi+XbvnQwsPKasMO59jN8ir9o0jH/swmv+qC9iNyukpdaPfBRtSCwxJ
         8Dploxymhwjb9B2Uxsj+dCYVV/IgVUUvoLxIW+eXM4PGKALOcDHrnVD36w5rll/SHMGr
         phiozwyZc10uNLe/w/B6e9wylq9rWXKVXKtXJ97RtEO35L2NSHdCxitVFV6OfDzBMzNp
         ph0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784814987; x=1785419787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFJ92pBYTYD/uZeF7jXVQGmoK/eZ5fV6naeUmAq0dyA=;
        b=YGITtP8/GUcPRS/MPAdedkmEkM0JSb6cbJBbKwk4hZcW/Kukb224xOPRCTAG7dd+mJ
         l802i7Pilj79GXd6FwV/Yg4bBGEeDLnZy7alMhKBMnHXNXPUAc9mCscomcahQBPlanSl
         BYVe/jykTiT08fnUdyp8RqcDfRDwYnz39IKCpJP9o0urrpWTH4VisUsg5bqpB/PMLXbR
         W34ZbbHkYW2mMyjmbtiyM9jR64tzEBmS+XvnV3hLJB4PcSQUDGKq48Z4i7b7QOIseIur
         pJSmwZX7NW+vuklCV4j4Bgl67+1Jc2pW8NqG6yoRgjTeAPI2kHnX9f2ICTB/c24AKpTq
         PSIA==
X-Forwarded-Encrypted: i=1; AHgh+RokH+r+tYUJfmrW3922S7rIGzuXNpJ/Ykt4oHo4O2vTwCmskk26BdyYAXBWYJY8nwGSrh6ZcaW/3RnTsTMISoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwToeKZUXG6r2LS7Cpc4qvnDCo9j5/KFHXyE3M9xp1tzWUV1/M7
	qMuiiYiAnwjaTPb2htDlqmxTzNDYlnEHj6CB37JpPgKwDg+/3G4dvb6oXPXXkV2+2tDmZqqQdNo
	dCRtv0KgiHnW9ctlnX8yXg4D8D97dYmc=
X-Gm-Gg: AR+sD128g0ypNWlknRywA1SbnjYILMyBGohPA7ZJqh6uChoFmDuCvCoyROGXSiwjZfY
	irdmz/lbRCoSpCFDIUc4Vs66IWTkjl2PeU7Rrvl7cqjfQR1FlpcS7XmSXRM0AOdjYlSVC9c/msU
	pOTgBVmFnrvwsBMXZEwU1Mo/K5Odizy0k75pvJBHwrEZWepfFhKb3EK8XjNfOD8SlpGN7aDVVBc
	dDOlXe8J9bY1UGMpR223egzLqnwl2h4ELP7+FgPfu9ROAGy13/OXccxoPE0F0P67Mi1Q7xYPmHB
	ChChp4w4+5oEQjX9ODxpNdBDHuai8hNA52MIdMxd4gZaCMjHzl9D
X-Received: by 2002:a05:690c:600c:b0:81d:b439:64ab with SMTP id
 00721157ae682-81f4c1a0af6mr9988377b3.1.1784814987415; Thu, 23 Jul 2026
 06:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
 <20260722-support_vendor_hci-v2-3-132b506460a4@oss.qualcomm.com>
 <CABBYNZL7ApV6wzTOLGu4gRxBU_89x+D-JNd27tg0X-sOmXqEog@mail.gmail.com> <c17cedf9-a013-4ba1-be0e-46f5650ddd89@oss.qualcomm.com>
In-Reply-To: <c17cedf9-a013-4ba1-be0e-46f5650ddd89@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 23 Jul 2026 09:56:15 -0400
X-Gm-Features: AUfX_mw1EEFtqsshkz7ndFETEJSr22dJAFEjPkKaj_vdp6HLiRCcdhIzqoW0LNc
Message-ID: <CABBYNZ+2O_xMbYYPyO-kcL2AzV0pBGow1OWEVWf8gAYh5UhzHw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/3] Bluetooth: Add hdev->recv_bt_vendor() to
 handle BT vendor frames
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Thu, Jul 23, 2026 at 7:18=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> On 7/23/2026 12:46 AM, Luiz Augusto von Dentz wrote:
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h
> >> index 428261591288..12f3720f6cc8 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -646,6 +646,8 @@ struct hci_dev {
> >>         int (*setup)(struct hci_dev *hdev);
> >>         int (*shutdown)(struct hci_dev *hdev);
> >>         int (*send)(struct hci_dev *hdev, struct sk_buff *skb);
> >> +       /* Return true if @skb was consumed, false otherwise */
> >> +       bool (*recv_bt_vendor)(struct hci_dev *hdev, struct sk_buff *s=
kb);
> > This should be probably called recv_vendor_ev or something like that.
> >
>
> For BT, besides VSEs, some vendors also reserve ACL handles for special u=
sages, e.g.:
>
> | Vendor | Coredump | Other                                   |
> |--------|----------|-----------------------------------------|
> | QCOM   | 0xEDD    | Enhanced Logging (0xEDC)                |
> | MTK    | 0xFC6F   | Firmware debug logging (0x05FF, 0x05FE) |
> | NXP    | 0xFFF    | =E2=80=94                                       |
>
> So this hook may need to cover both. Any suggestion for a good name?

Derr, connection traffic is not handled as events and you have the
likes of  hdev->classify_pkt_type(hdev, skb); to reclassify them to
HCI_DIAG_PKT. Don't tell me the firmware it generating Connection
Complete, NOCP, or any other event, for these because that is totally
against the spec since the handle wouldn't match any connection.

> >>         void (*recv_vendor_pkt)(struct hci_dev *hdev, struct sk_buff *=
skb);
> >>         void (*notify)(struct hci_dev *hdev, unsigned int evt);
> >>         void (*hw_error)(struct hci_dev *hdev, u8 code);
> >> @@ -2329,6 +2331,7 @@ static inline int hci_check_conn_params(u16 min,=
 u16 max, u16 latency,
> >>  int hci_register_cb(struct hci_cb *hcb);
> >>  int hci_unregister_cb(struct hci_cb *hcb);
> >>
> >> +bool hci_recv_bt_vendor(struct hci_dev *hdev, struct sk_buff *skb);
> >>  int hci_send_vendor_frame(struct hci_dev *hdev, struct iov_iter *iter=
);
> >>
>
> [...]
>
> >>  static bool hci_req_is_complete(struct hci_dev *hdev)
> >>  {
> >>         struct sk_buff *skb;
> >> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >> index ea858391c789..94c02b66bdfa 100644
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -7801,6 +7801,11 @@ void hci_event_packet(struct hci_dev *hdev, str=
uct sk_buff *skb)
> >>                 goto done;
> >>         }
> >>
> >> +       if (hci_recv_bt_vendor(hdev, skb)) {
> >> +               hdev->stat.evt_rx++;
> >> +               return;
> >> +       }
> > This seems too early actually, I would have expected it to run after
> > hci_event_func or within it if ev->func is NULL, that said we
>
> I don't think running it after hci_event_func() works, because the VSE ha=
s already been
> corrupted by then, as explained below:
>
> msft_vendor_evt() is the handler for all vendor events called by hci_even=
t_func(), but many
> VSEs are not MSFT ones. Once the MSFT extension is enabled, it always cal=
ls skb_pull_data()
> and corrupts the non-MSFT VSEs.
>
> Besides, running it there is asymmetric with the ACL path: the event head=
er is already pulled,
> but the ACL header isn't.
>
> For ev->func is NULL:
> it may mean we don't need to care about that event, so the current behavi=
or of ignoring it
> is reasonable.
>
> > currently assume HCI_EV_VENDOR=3Dmsft_vendor_evt which is probably not
> > valid, or maybe it is which then screw the whole idea that 0xff is
> > only used with 1 vendor specific domain, now if we try to squeesh both
> > a vendor event and a msft event handler their opcodes shall not
> > collide otherwise the whole thing doesn't work.
> >
>
> let me explain more for recv_bt_vendor() for BT as below:
>
> Design idea:
> let the transport driver consume whatever frames it is interested in firs=
t; for
> the rest, don't care how the stack handles them =E2=80=94 it doesn't matt=
er even if they are
> corrupted.

Well I already told you that by doing preposing we may expose driver
to the same type of bugs that existed in core in the past, so we maybe
reintroducing parsing errors and since this requires to preserve the
skb it will not be able to use skb_data_pulll (which internally checks
skb->len).

> Motivation:
> For the VSEs and vendor-reserved-handle ACLs that transport drivers are i=
nterested in, move
> their handling from the transport driver's RX path (IRQ-disabled context)=
 to the stack's
> process context =E2=80=94 i.e. avoid pre-processing them.
>
> Advantages:
> -) Avoid skb_clone() in IRQ-disabled context of RX-path to improve perfor=
mance
>    take INTEL diagnostic events as an example, btintel_diagnostics() skb_=
clone() them
> -) Avoid re-processing VSEs that the driver has already handled.
>    Intel diagnostic events still arrive at hci_event_packet() in hci_rx_w=
ork(), even though
>    they have already been handled by btintel_diagnostics().

What does btintel have to do with this? Are you saying there are bugs
in it and you are trying to report them here?

> -) Log them via btmon to help debugging
>     Several existing transport drivers consume these frames directly with=
out btmon logging
>
> I'd welcome your thoughts =E2=80=94 especially on the hook name (point 1)=
 and whether the
> placement/design here is acceptable. Happy to rework it based on your gui=
dance.
>
> > Anyway, I had the impression you would be using a vendor packet not a
> > vendor event, or you use both?
> >
>
> My PERI-HCI requirement is already addressed by recv_vendor_pkt() in [PAT=
CH 2/3]
>
> This hook, recv_bt_vendor(), addresses concerns raised during the BT-HCI =
discussion. The same
> problem exists in many transport drivers, so it tries to address them for=
 BT along the way
>
> I'd like to use it in the upcoming QCC2072 support as well, once these co=
ncerns are resolved.
>
> >>         hci_dev_lock(hdev);
> >>         kfree_skb(hdev->recv_event);
> >>         hdev->recv_event =3D skb_clone(skb, GFP_KERNEL);
>


--=20
Luiz Augusto von Dentz
