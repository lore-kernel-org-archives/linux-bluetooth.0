Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0CD31A07B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760461; cv=pass; b=Ej9vjRdCUZQd83EdoFm1ljxY9Lh5QZz4R5c8l7j/Hj8SZbrlOr0WN7ErJPhrlIotl0ACxd/jpIdQk+e4GAhwWsSE6A4oc1gh6yfin0Y/2ndi2dg33ezsnbOpRcFyHZDPkkzTdhC5VsYy/5v39kM9MCCxRh5eGt9dLPJ/XseLVcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760461; c=relaxed/simple;
	bh=JXUN6kxkPF4NxCF5P5ymHjmcNg6Kq/LVopT7u4rV7hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMxB53gQHUGy30oIgrTML0QqYSRhxaliP4cYBcAvzOUeHEd7dxn/5G7QY/w+HW0eiPwSyBxgJISdVWn7XpXVIz/g+pkkxafh1C9v6HSoiFfqKbWnIyn2BV55yTZUO4OaoLT+UySKJ8tuTbilwp2lI3eE9NQOfxZuCet+smiiN2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLIPmXIw; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLIPmXIw"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-67fdb2afaf5so596678eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 11:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775760459; cv=none;
        d=google.com; s=arc-20240605;
        b=SKQo/lzwCTi+v/ctTwP+fDG7OqIWc4YO/MpeQpUlZCwbB9vpv5QvC4ZtLWwl8qhsNL
         4NWJZuflDqqldnUAu5CgPkyRZTjLPM+F6b4sfmUnL/R8nMAYjkunabwUneze4U4oOWAH
         hXENlV2acMc5LqsInHWm/tuvf+S8pH+TkqLS/ERumyJjVnm50BwWVHRgqIsE2knGPXdB
         byJlme2UdS6ZRjPn/g96FBWIfuHouPtc1gbZADpkGbbmVs4oFlXro+cGQVam1yDqn88J
         oHo9vLDVYs7B6aanDt6ywZBlzSXP4vYp2ouSSvpiT70lnixE3ADcgEuicVH8qD01SRNH
         aYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gqEWZoNrYqvfRKLtaqCl49MiKn1GlnNr0ogAKD2ArbI=;
        fh=PpdLmUdnum3vdcR9Amegc341CO6DvUjFN0ZWYd/7PfY=;
        b=izhGhoFPrhWmWni3tLuVGiJsTxhwfXRE80WG/cExaQp/V6VPVFSXxIdNO4eYAc/gUw
         QA4576pTf4Hlp6VwyeQS1XWtXCKcNi8usfnUqIbwAH/mheXYl3W4FurkdYSr7hePq8+F
         B5W2+urRgV3ETX9a3kkIs0kcNcxGiDW1V2CXHMcSykQHVk0Ce6haEPUpblD9/6+5zRBr
         3Mi88fsnOAAke+VIc0P07xEb6rUNVde4oqZWLuI01S+OVjxVmSUsAkPooHhvtYx1iQVR
         qA6/ppxZhnErIV0V6iNK9rmPnf+uOcYoOWXZm0SjFY8415ABEwlHyLQ757N4BOGYEigO
         r0Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775760459; x=1776365259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqEWZoNrYqvfRKLtaqCl49MiKn1GlnNr0ogAKD2ArbI=;
        b=XLIPmXIwXj8HRZMUAHxdC39vThD32e5Q1zFsQi/4Y6PLISCJGNpIQYs1XMBLhh/Qc6
         OfZf8NWIiOC69Jypmws03Eg9Sb/eMwRWxmeLZuIPMwHwS7pvdo9CjXQdHwmSfQuFSRpW
         WxpTDNVdiq563YYm9nmlGnpbgl65bTwX4N862KRQQknd56XtgAyu5A6NxQqE1jKRfkXb
         ByzuFCABlnp64e1C6qjWocJTWWyatHRbljzYFuQZUK6495g3LGEhCTuwy9mFwOmOfhVZ
         tKWKGLCMhlC+T04Qv3bREIoC7xoYNjIxv/mSAC2FTLOZqhmcb8eGIgVGrwYFklptqHgz
         BlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760459; x=1776365259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gqEWZoNrYqvfRKLtaqCl49MiKn1GlnNr0ogAKD2ArbI=;
        b=csfMp9fwikGf95UWP4SQrPyA2nd1FlIOVuNVQuOVyPa3p4gAXwlWU8xzDVn0rNXEZ/
         DyzYfcB23D1+t9RMMaJooRmCZytR/Z7Q0IgdRuGAV4InR+7TT3L8K+n90JjIKT07AwUf
         rGCmVNBmhG0c4dstV1Zcd1etrVCy6roe5zjIgJiS8lOiHBS921EGP1USbZXe+UEmyNYR
         xAfnRB93ua76D/6Y22RjpDCRqYdDIQUsHb2PJ6onCb6wX3bK7e3KYOzu6nLSU4k8bh1Q
         GjFgxVFJHPEKG7UfGQwB50s0QJjWm7t2nrEcpR6Axdhh2Nur/+XeEYh6djf7ruMPutjU
         gurA==
X-Forwarded-Encrypted: i=1; AJvYcCWmegQTt/dOF7N8/QmeL5riF4wjVF2PkxjW7BGwZ19NwhkUJNtZ5ujUXyk0KkvrJD1Y+O9AKTqDXNWSX2X3wRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynD6lBk249zC8BNYk5u54uRS5bp1Lw0KmhDc2aJUPumeB3JLw6
	7JZ6ximDTr+BRrO/3vrAiHHdHY06+yDcXVeWt6N/TWu4Nwrc9OxwCuD+Iy2whbwvIWTgWot8E7s
	e851n61H+1nLEL1lI5w+d66T03qFlT8o=
X-Gm-Gg: AeBDiev6rwHQhF4h1AxhQ9Nff10nE11OtUTQxIGnSU8vkhDi8ka7duKb7Aig0PyjMMQ
	HyIqYC+9yFDKqggf+pfrHHUzFkyJ//SBqfOBsxb0Z1HGVgZTTywZ2etl1iH9Nl4Px/XqUIQODbd
	fEOIkppVeWv+F8Bs8g8Kz+DoC8DXQt4UKieYJvbUXwY2YXp1NyxGL0Bt+nLeTQYPGDHNFDZF9KN
	x3xJP8zfItmDZcn4/tdUdL5REO5jxkCSxqeVZqkcBTPKcVKBE/KqUaNF8XqtNAylx98LX477Utn
	vCQvh2tvNqibyCxnxAjsIj86hsf7R9AtXkzk6w==
X-Received: by 2002:a05:6820:4b86:b0:68b:7825:e68f with SMTP id
 006d021491bc7-68be88eb815mr118055eaf.49.1775760459276; Thu, 09 Apr 2026
 11:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408155638.95927-1-devnexen@gmail.com> <CABBYNZLMMbjy5ZsravMc9pCCvxMKGPNPVsaOy76LdZTyFPkfhg@mail.gmail.com>
In-Reply-To: <CABBYNZLMMbjy5ZsravMc9pCCvxMKGPNPVsaOy76LdZTyFPkfhg@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Thu, 9 Apr 2026 19:47:26 +0100
X-Gm-Features: AQROBzBhH6_Vwvq4NJQQRxB2RWsyQEYxsSTsWieTG8kl8hdvUy3gdzM6w0rsXc8
Message-ID: <CA+XhMqyrwC3qYTQaO=nuiuVPHRO3KunS8WCbb33YVSabnL_k2g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: validate connection before BIG creation
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Thu, 9 Apr 2026 at 16:19, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi David,
>
> On Wed, Apr 8, 2026 at 11:56=E2=80=AFAM David Carlier <devnexen@gmail.com=
> wrote:
> >
> > Add missing hci_conn_valid() check in create_big_sync() to prevent
> > a potential use-after-free. The connection object passed via
> > hci_cmd_sync_queue() could be freed before the async callback
> > executes, leading to a dereference of stale memory.
> >
> > All other async callbacks using the same pattern already validate
> > the connection (e.g. hci_le_big_create_sync, hci_acl_create_conn_sync,
> > hci_le_create_conn_sync, abort_conn_sync).
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >  net/bluetooth/hci_conn.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 11d3ad8d2551..be522fae0058 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, =
void *data)
> >         u32 flags =3D 0;
> >         int err;
> >
> > +       if (!hci_conn_valid(hdev, conn))
> > +               return -ECANCELED;
> > +
> >         if (qos->bcast.out.phys =3D=3D BIT(1))
> >                 flags |=3D MGMT_ADV_FLAG_SEC_2M;
> >
> > --
> > 2.53.0
>
> https://sashiko.dev/#/patchset/20260408155638.95927-1-devnexen%40gmail.co=
m
>
> Seem valid, I guess we probably need to use hci_conn_get to make it
> safe to use hci_conn_valid and then on create_big_complete
> hci_conn_put.

Indeed, I ll look into it. Cheers.
>
> --
> Luiz Augusto von Dentz
