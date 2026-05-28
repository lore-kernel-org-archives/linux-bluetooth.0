Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5862E92BA
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001333; cv=pass; b=WfGgjEykJ3qTa/tIZrv/aZf0hBtisWk0L0dYMq/MtIHCMIpNuElgUJVoTQ37dScSqaZj0H/3QAupoJx13B0gvs2aOp408kahVOTigx4ZT1ljrR8+ADs9SZwvgXyplUeozB+qToZymlvxDUiIQ38jWZ2zHFYS0b4jyIbbGExAW0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001333; c=relaxed/simple;
	bh=CoNPhPt2tiUkwfqO7YWmkcJJc0LgjN5TC5Pc4dvmiVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXimJCmPH2rA+ovmAMAtC1XSElJd6xciF5OKQlhku4OaHAlH+ToGb07VWR2JYuai3+anyGiY3PdSxqqy/SIdW0flsKh/aD+l1SQtn2xqHaPI5gVFrxJSTQ8vDnkIeWfIYb2vY7i0M5MCj4i5Y9srytMC/bCp6ABX9XgOg3IwJb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK0R0TcF; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK0R0TcF"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7c307937816so125755987b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 13:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780001331; cv=none;
        d=google.com; s=arc-20240605;
        b=XQOKeBbTarzl7a7G2uzHQHNJP/l8peU8TmODgxMlZ1TSuqe7VnqImwDYpFnHwwQBTD
         NeTKptw3Hz5modYbb7J1wq3Up9rTHJgU0tOWFuvun0ruH2nXL7LtOCr/E44d2eCtidFg
         qrYgWMbsUdWBYStp1g13618bfKVAzmWHxV8IHk+Ijpt9psnF2IgtVrY/efZoIxxqr/G6
         Qr6Mb+9dkcQS/ZPrsXSI9DDLKea/V45xjcvNTyceb6BuE3PX+tSqaSg8odWOYMsLratI
         UBQf+Rda4nZ7x6vKymDWYsr+vemWqUXtozEVXR5oZ2qpS+rCRMiMiu+YGjNlK7UFwFSq
         qmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cSAJBflxoh4wE3LOaP1p/0BeOwkJ+iH7LL4vPttAj/0=;
        fh=U4Y+dMMPTez3fjWQOk3YMtVmWASM5C6hVL+FszuFWzo=;
        b=kaL7wmJJ60hwVTlnrkThzFB9k5ZDC3xlBkGoepCyjS32DzxMkHU6HQ5FuceEqHbEUd
         jTTfq/yvKNBW+K+PsI/Dw7I6NEZx+1Qmlfuf6uQCJo60HhcsQFTbBKoyT1UjGMn6Jb+Q
         tVaL5ECryXIOQcO1/xGnRLIwFDuUfFFhxSZH3RURKc615ANfTR3YNjgIXUHdOmXLQKv8
         XdKgnOXzcIVg8/ZAJwCqN8w7uyxWParG9PrNNRAY6mOtcHZwSMU76qdtqXVvwJ5uPEui
         Ie+vATiUG5XQhkBbD0G8JLs/VPQGmSMdT1d98jk/mw6F9efk8oxzs6Gd6EdZImPWM+gE
         NfJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780001331; x=1780606131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSAJBflxoh4wE3LOaP1p/0BeOwkJ+iH7LL4vPttAj/0=;
        b=FK0R0TcFr2ZEd9wumoA4sOIfwpLs77DwhJB3LSjs6a/OLbGEQkt8o5BnRIQLyk4dSS
         ehO/z2iVGgtJ0jjfQuD3Zf9GXr4cHkQ0zpWgkGhlX82Hjj0FZ8qflWSpL+n5DLir/p+K
         iLhJv3Us0MljRN83rjdsvXgAHNqPtIVFMGPdpawRdNHT6/WqSSr9RhIpZOpEQN7yKyxW
         YfwUGzbtrFH4TV+vWXpLggD5rsSMKrcSxacqP6jwp/ZdUCYHbTt2wrTrKxnhS6/GJT1k
         LMNuzODMdlSTL6G7ggDCuhNfqb3T9lS5R4VipQmnzb8cBOTP+3fO5wyaYGN5qfhZVvHc
         vzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001331; x=1780606131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cSAJBflxoh4wE3LOaP1p/0BeOwkJ+iH7LL4vPttAj/0=;
        b=NOwoB5zn+goYfwseHfWze17nwzBL0izpercdREgpF5QmTZerQWUirtiXnLNOJoe2fE
         8v3qXsAJ7i5N0XY99sXF6Bp4Y8X5eNmR8QbBu39nDfWR+ZDGRSh3sRXqCs9DSoI5nLu4
         lOj/vy/0R47uA5Fg15KmgnuWkbk8JEJORaa3J9ZEijwZurl/iPbGcFTBqP+p42dJmLQP
         3vpd4GUF8vCPZHvqMuhRwgw0jJo4bXSyZIhV1R1iQ0QJ0uG0CSBmPjvrczCB3PCPuB5v
         fmZoW7zoF4VdWe3FrhysGRLsSD2sGKMck2NrxUusoUdW/qdnQDCN1Mrj926hKZo6wPFZ
         szuw==
X-Forwarded-Encrypted: i=1; AFNElJ+GLFZS31ZxjSdzWZ+kWZu7vH5hNK9FerFHXkfQVUC1lACh4HPqY4u8Y4hDPKa+aT9A0laplQoNIfH+IzcIhEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEPVWev5ThKnrDJ3laN01t7TeNNTXchrGgLeQObgVKl+GUDWw
	4pS3TbxTStC1+wezeFovOa0SBS68EKrnjG5PxonAk9MKp2Jc6LoH/XLjwZxxhlRM7Gzb8osyeDm
	omFce+XLL8HLHK8Kb/d1OJ7LLLj+PDyo=
X-Gm-Gg: Acq92OEVLIO5pbiQ5Xwj/7yNlVeo8iLlfP2Rd4UNaGDKx8yv2fmC/T9xRRBrpxrkmAT
	9iXqlt7sNDSBumcslCHw70pS+4CZkxjsi18sRJXZHXLOkcxjl4UIXNtYGGId5ajTr66f3aNSJwS
	CiqqSD32FC0ctgawk1MdQ5MiK2smNtlScWNQE8hDuZPQx2O0UKUO3MRQmKAYt38I7pjf1kotfxY
	sCFDuQmLRsm4tjKJ1euOAJS/kOlIWoO86UAmTYn8xTTw0aiu8ZayeCmtlxqeeQALG681u49JCdG
	vVxvMPINwf3VympdsoKIUmOVuug3Ve9hBbeNTQ4tDWSedK3DvIlBMk5UZWbO+p3pLRYmnwZjRj2
	hN0PL
X-Received: by 2002:a05:690c:6c87:b0:7dd:3463:6872 with SMTP id
 00721157ae682-7ddc3fc9cd3mr8827517b3.41.1780001331307; Thu, 28 May 2026
 13:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521052611.1815693-1-rollkingzzc@gmail.com>
 <CABBYNZJ7aETr9KdUFdU5uVkcr8RMzOyBS5xv4vpb7ij6Di7FOA@mail.gmail.com> <CAB7XQsF72-2zPMKFjko5pKvR-scqyOCT3463cghQBY4G5O4arw@mail.gmail.com>
In-Reply-To: <CAB7XQsF72-2zPMKFjko5pKvR-scqyOCT3463cghQBY4G5O4arw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 May 2026 16:48:40 -0400
X-Gm-Features: AVHnY4LDpA_GPNlkwhvNfnd7x64BXo9h45UF_0L3M28dPrM3mVs-zV2R6c5p0O8
Message-ID: <CABBYNZJt1dLQyFk+vfn4bzktF-a5=LKghXjDDMAomeJMe0NW=w@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: bnep: reject short frames before parsing
To: Cen Zhang <rollkingzzc@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 2045gemini@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

On Thu, May 28, 2026 at 9:30=E2=80=AFAM Cen Zhang <rollkingzzc@gmail.com> w=
rote:
>
> Hi Luiz,
>
> Thanks for taking another look.
>
> > This still looks incorrect to me, why should we do * 2? If look at
> > BNEP_FILTER_NET_TYPE_SET it just use the header to pull using
> > get_unaligned, I know this is an existing problem but except if the
> > BNEP_SETUP_CONN_REQ header length works on a multiple of 2 this makes
> > no sense to me.
>
> The reason I used `* 2` there is that I read that byte as the UUID size,
> not as a total payload length.
>
> For BNEP_SETUP_CONN_REQ, the byte after the control type is the UUID
> Size field.  The setup request then carries two UUIDs of that size: the
> destination service UUID and the source service UUID.  So the intended
> skip was:
>
>   UUID Size field itself
>   destination service UUID, uuid_size bytes
>   source service UUID, uuid_size bytes

This is what you get if you don't know where to look at:

struct bnep_setup_conn_req {
    uint8_t  type;
    uint8_t  ctrl;
    uint8_t  uuid_size;
    uint8_t  service[0];
} __attribute__((packed));
https://github.com/bluez/bluez/blob/master/lib/bluetooth/bnep.h#L79

It is in fact a tuple of src + dst service as parsed by btmon:

https://github.com/bluez/bluez/blob/master/monitor/bnep.c#L104

> That is different from BNEP_FILTER_NET_TYPE_SET, where the header has a
> 16-bit length field and the value from get_unaligned_be16() is already
> the total filter-list payload length.
>
> That said, I agree the patch makes this much less clear than it should.
> The comment says "data (len * 2 bytes)", which makes it look like a
> generic length field, and the raw `* 2` is too opaque.
>
> I can send a v5 that names the byte `uuid_size` and uses
> `uuid_size + uuid_size` with a comment explaining that the two parts are
> the destination and source service UUIDs.If I have misunderstood anything
> here, sorry for the confusion. I would be happy to help with any
> further changes
> or testing.

Probably just reference the above, but the fact that you couldn't
mention any of the BlueZ references really bothers me. Although the
result was correct, the lack of references makes me believe I'm just
arguing with an AI prompt which doesn't have BlueZ userspace loaded as
context.


--=20
Luiz Augusto von Dentz
