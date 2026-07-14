Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ACC448CF6
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039379; cv=pass; b=BP/PhTNHd8oU/1Bz8SsLpaYI7DEIxtNTsvZHMRQc4oa0joPhexAolwwvKW/+QsDAhSMCR5vpoPqW9os5FO/K98dmVNOrJIlCC5sEuuZLOSxngzQrf49LbdrDrFoFKLJJuATjeWbOeehRtyQIWxH3MNbXvzUIHMwTH98MnFWYr98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039379; c=relaxed/simple;
	bh=T1PcUP93DIGnYog0L/wZqAF9YVPvRMahVM1DS3xX3as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ic85vnka/JJNJ85NBPOCpAe7YPQ8RdB0BHjj+xGw1gyccJQDDT21sFGjtjzjvVKlUWffihV104JIFhEqRi65tLsFEieQaw1adW+xV6nmMwnaWji3AAR8tYT9IJoYb1Ep75QwmBvns/XYHyZ3HmyX/jimCqQEIGGNIZlHzUAKvY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeaZH0Nm; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeaZH0Nm"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8051ad12d23so10121687b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 07:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784039377; cv=none;
        d=google.com; s=arc-20260327;
        b=VMtOqOBluAKdtWDPsQ9dztZE6Ncs6dk8CnVt054rWj2bc97qJCI8Yh7nJS+Z39nxO/
         AjFCKLkVZ5RMmahEvx0/HNUfuZcpkv2fBBR+rojmd757mAzOjXFdsCwlPPPy/twi8lhf
         i7uS8Gu31AN48JkSnritj7/oZVyDeX10x97wZwsmm29zJz4BnIGCQDwi61EvkXi1PE8R
         X5Iwv6a2H26aSPvtFrefk7GTECefFRpGt3TkTgvr4Bu5BgrP94Dfwp23I9Bv/eITI8Xu
         nn4xJfUpJEVHMPzaqKmK/vr9mn1gJYct/AHidwsxTyveOkDDxKg90vt8nTxLx5tEUsOA
         t2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V+nXasnD6xVRUVlvFoJBrHp/vP0vGiCb1Eh4HdVkwG4=;
        fh=f6Z5kcv0/JTot2yABn89Ik4MYkN+lY6tWxnk97i+UYM=;
        b=FQaC1a4PFy5ZonPhd+Jycbea15Dfje8v59pxSJ+6JUSqQ+fIjSDwKuDIgWq64DmWTJ
         YBWc9E15aMqZExqQp5aKydRr0MyY0rdKeQAdIG5oySDRQRC9v/hVxZ3dCVy7pHu/VC1h
         JwNOmEAvBdgwP45lucICFtkBLXN+Qj2CRoro/stGE9ZRB88KcCxwpk0zVpjm9JLLNUe/
         ADuTy4uXsWMZQclQWHbhiuK/HrXZJQ+wZuupfmGnPFyRv49uXie/MgB7m6sKhDhAhxI5
         56tvFXgtvBMUM8NH0W3YSwZu0YBRfPJdzMJXP35JLN0VPPD3P33eW05W+o5lmPgboR4s
         zZyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784039377; x=1784644177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V+nXasnD6xVRUVlvFoJBrHp/vP0vGiCb1Eh4HdVkwG4=;
        b=GeaZH0Nm1ToRQQCIw3cRFG9wOWCRRSZOzywJgTl+/KPB7NPpsrg5OIZNcT+V9OjC7u
         VfKRcvdUO2wMAZWYnM3598zSNvGGFuJQgmnMkGt4eFUOum6E08uvxpBt2ufPAPjmInlf
         iGI7Qkwk2hi8xxxcHszDnS550yPQSbU/uMciyO19El/lrjF63XX+ixdx2o07LHbAyupf
         lNLnloaYqOGKm5bC5At1hTlcsqdZnv0yVZysoVlfdy6tFRqvbww6eyXWyGmLguxG38AB
         VEs+Bhi75+Vr8m8YxTR42Qicg5Rbc3RMjbsodUidpJ7mfjH123Dh1PAqLSyvl/VZeW2/
         H2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039377; x=1784644177;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V+nXasnD6xVRUVlvFoJBrHp/vP0vGiCb1Eh4HdVkwG4=;
        b=TwN/w4mbNE+OMr+ZOnN2+Ouz0h+1SesFL7sKdZDf/50qHSNaC8Il0jlh1znh64NMEB
         89I698KGF+3IVJPNHpFDH53CDvBrtzgbxF1un3J+cZvKCmJS9udhPMWxhjDXcY5COn5t
         dQXlm3uejK3Hf//MdJOU2rV5tJ9ATMsC4jNI37E1iLklubaLEoQxyo/SezzK2Rp/IuSS
         Z83eIS91jqbNmoU8mhlcti59jH2TS9m+kwe39rUHaQ3gffyopMzbD0CAgcC6X6LZ/9mP
         bFCRzKtcjYTT5jKpeybuEJR+JraqnxfAS+hJuK/t3QpaHsa4OgaHvCq78Inbt+55kcGu
         nPVg==
X-Forwarded-Encrypted: i=1; AHgh+RoRpWMWVKf639auxXC9UXqxw3oMhqv2k55esicMKx3b72tlc2NkcZSEXq6khhVSw5u2UaMHMpucX6kopDwAnoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBx+zQzXV4D9W0CS9HO6PUqkOHr/11/h0GZ6YBRGV7SY3rQakz
	AgbZdmyG+gkOk34eH6iSNmogbaCXYw7o6EUiazwPqEvcLJ4lpXlAUlxU8uojUTabsiDIPWN3W5J
	EHaqceX/LixgUovpanutT+SWEviT4On8=
X-Gm-Gg: AfdE7clM+wQ5ERiccdG80flhkJoCsI/+yeVNwjfk4qHRZwGb2HrixCHegv+SX+kzO0+
	Ipd0QdsLmqIycB7xicTMzGsApK892g9AC3alrtehGwkujbgUcZVirYaX9G/6qbLaolzYDKyxcFx
	o6Tecf6xt/359bbKfrmrr1lORtIVVTxRP6FD96dkk89Fe3T1DetJ0CsYS4q+gvufNvwylacTzas
	uQ0Qjr5J8JTvfnddd+nXCeHZvgSYCbbhfXugzwu22LX+FcFlHuo5QTtbkS58iQXMnzumzUZzUQy
	SCIwcYiRMjyTFK1uD4RcaNA3QUN83hpwfioXPttfrWMfXxf5Ykfooc3o
X-Received: by 2002:a05:690c:c503:b0:81e:bd02:b02c with SMTP id
 00721157ae682-81ebd02bd27mr24322667b3.1.1784039377285; Tue, 14 Jul 2026
 07:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-btusb_qcom-v1-1-39cabc0dd601@oss.qualcomm.com>
 <CABBYNZJpdeoZ16bObLRPhng2dfyNeK9ix9_-z_hMZhJ0QxTxGg@mail.gmail.com> <3d681f10-959e-4d0e-99e5-a471ef8929a3@oss.qualcomm.com>
In-Reply-To: <3d681f10-959e-4d0e-99e5-a471ef8929a3@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Jul 2026 10:29:25 -0400
X-Gm-Features: AUfX_my43HCicIFUhMDV92d4WGqO4msi9dtCUXgp9U4F6In0ZjVFSkRP3NOruCQ
Message-ID: <CABBYNZJ0zoVVVxuM48L=Km==gnrQuskrbjB6q_aNV0KEEY3+5w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add support for Qualcomm QCC2072
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Tue, Jul 14, 2026 at 9:48=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> On 7/14/2026 4:45 AM, Luiz Augusto von Dentz wrote:
> >> To avoid adding large vendor-specific code into the BTUSB main
> >> file, add btusb_qcom.c/.h to support multi-subsystem BT chips.
> > Ok, so this is not the first time we are seeing the driver want to
> > have it own processing of HCI traffic, but instead of doing post host
> > processing it is doing pre host, which creates quite a few issues
> > since 1. you can use safer skb helper like skb_pull_data and 2.
> > requires to do HCI processing of traffic not meant to the driver,
> > besides not being able to use something like struct hci_ev table that
> > would help to avoid having the same bugs we fixed over the years.
> >
> > So what we might have to do is some way to for drivers to register
> > their own event table, provided they don't conflict with the host, or
> > if it just HCI_EV_VENDOR then perhaps that can be done with just
> > hci->vendor_ev callback.
>
>   Hi Luiz,
>
>   Thank you for the advice. Let me clarify the design:
>
> A.  Why pre-host processing?
>
>   QCC2072's endpoints carry non-BT frames (PERI event and PERI ACL) along=
side BT frames. btusb_qcom.c must first reassemble the raw byte stream into
>   complete frames =E2=80=94 of either kind. Once assembled, non-BT frames=
 are intercepted and handled locally; BT frames are passed up to the stack =
untouched.

Well they are still HCI commands/events aren't they? If they properly
use the vendor command/event range I don't see a problem here. Also,
if you pre-process, it will skip sending to the monitor, making
debugging much harder.

> B.  What to do with non-BT frames
>
>   There are two options:
>   1. Don't let them reach the host stack at all, or
>   2. Route them through the stack by an opaque channel such as HCI_VENDOR=
_PKT =E2=80=94 defined by the stack but with no implementation yet.

We have vendor diagostic packets already in the form of HCI_DIAG_PKT.

> C.  Why not skb_pull_data() for non-BT frames
>
>   We want to preserve and log the complete frame for diagnostics, so we d=
eliberately avoid skb_pull_data().

Yeah, that is price tag of pre-processing, but even for vendor packets
if they don't reach hci_send_to_monitor you won't be able to see on
the likes of btmon.

>
> We'll also look into leveraging hci_ev table for non-BT frame handling in=
 v2.
>
>


--=20
Luiz Augusto von Dentz
