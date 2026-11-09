Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794238760;
	b=1DN+OmKuJTsNRO/4A8+un+DEg+dVaCID9zdX8AjNy3zPKQsa4qDvOv4zdZgn5fk/KKUB
	 wKNRilSInFjWDETjROPmg3moHvtHwa4XfwI15gS1Dnx7gaKcQDBYdG+j0bTwkudCkg8b1
	 q5DP4FZwQdBGzFPUrAJ1kjU8ZxK6cy5sbLVXEw7lkq7lrbFW2ZYyK/2UwlYP3lOyLcM3W
	 o+q9civVDmPqdXtEwh/98p7C/KlMSfz5rw3zkiNWBoAiRNqeGYMJmsiJfCD/Aiv7AwH65
	 TMqVQ3Wc1q0aVR+Oqg+5cncjfvIEh4xeXE6r+9T1/s8BulDmCxcyvaNrJUO+/LI+Miw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794238760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lbJdCjOY+01b1axWJs3AoThngpScmqw8BY9LTUexfVI=;
	b=i+YzRG6Siz6E0jeXuem0N+E+3/LQAJxupbhp337OzWvsgXKUoSN+bGRbcJ3RamrYNZMY
	 WeAAxKZ1Be4yDJeMY4jM1oCQrKQ7vw39SrMQGVGtPoPz3vSYZM0mPGrtlkR5J8S9WAqzW
	 iWxqRTdfol1kl2GxM5AjSmkJJFkn5hHt0Hyc4IgihQgkLN3swcW1O7kwPbmlspoH5WqpZ
	 uYfHd8twwqprfLUIEfx0kWJNXCN/oXKzIUZBYU5V+5uKrCMCmHW9+ytI78hIamxexQjCj
	 iH5xj6pHZgjRy1xVybvufAi0vFk1738v5nXPpVp+a57K1k0gLQVMUJM75qAaRVKGmNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ytwBNeN7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4DC606A326
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ytwBNeN7
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-679334baa1fso1237380d50.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:39:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794238758; cv=none;
        d=google.com; s=arc-20260327;
        b=BtRLGKRxCAjow6VzqUqmKe2xskkasDWnQNPCbVhAMWEQELU7GItLrS5G64e1im+ubI
         A9yw/AxL2HOgsg2FBzg+uRWqfHoku5OlmUaGYmlVy39ujfBHOK/h4lehChyPc3R5Q8j1
         OSEdEmHDoT85CwNcP2uJZ/eoyYyBc1ZOZbpcA29BdJv+DwcEp9z3UPki+EmFdJ5pTXAz
         X5yVXMjuCkl0IMGRLi0TigQNlNm8NKG7y/6brLButZ6VKX6L2poOsA9FK3AijEj0VPCV
         TIIrReQOgGpDI91RdeJxI2+CQNuKTJGKlkVFwHkp0J1bRHOlUeMBNgAq7KEwjESvZ7r8
         UVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lbJdCjOY+01b1axWJs3AoThngpScmqw8BY9LTUexfVI=;
        fh=2AvbDme1J599LGJwCqIdZVHVOEvfAa0GrpeCdMwlDLA=;
        b=mbR1UWjUAfGXw7FAtbpLX+GbiIzMIlAa3uGvI4ycRZozUUUXptyhdbXX83+6eN6+iW
         q8zc731jjUF1egANG/SAi6ovr916NGFJbia0LoYw91S7jxh3yHtP1QBdI6z0zfmtKIRI
         J8p3rnzLPSY9fykrsa/lOXDU5nDl5jH943O43aXNcMn+9IyYfdlDDuIrpLt3lvb4HnmF
         BgtrRE+O3p9S8vsKXW7+wVk2TQoccBn3hkEpWprg03CjqGHOToX1vzN3xXesi9p1D9ck
         QH1/piSdoO7sW9E9RtHNAXK/OtlwTDqrqsPh8AS4q9tsKyTWGugwPWsrrJKkTAPiElfZ
         8kOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794238758; x=1794843558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lbJdCjOY+01b1axWJs3AoThngpScmqw8BY9LTUexfVI=;
        b=ytwBNeN7wbjgQasK/cp68ykE4ApLVCcKuFbLLHwCkl54MABT3j+plNsMU4DsOZdfk6
         T9u/KiSrVmFEXgbyUdFs5Qgo7pWIEDbsY6nALmyRDuOcJQKmZ3sM/Je0mcHHayJ4X4va
         AYoTlbCqCgzTZ9jm5E4Z+pCPFJfd6L/FUBNEB9yAW/lhowi6ORhyvV6yFluLNtxBP82r
         bB8h6Ad06aY18qidec709RCdopVIZkWtvr9AsQcr5LlSN7DAKCru0o3b3pYL23U+gIy9
         NppakJ8EDT+CRmYqYs/NcSHEK/d2NZioH1lDEynvMvnCi4ItVrM5rNm94USHpj5xXTZZ
         aaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794238758; x=1794843558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lbJdCjOY+01b1axWJs3AoThngpScmqw8BY9LTUexfVI=;
        b=Q9uOzVvJtu4MWG0erPLzSYK99rUS1lQeyzumiaO4xwHQ4C6x4hcWfM3ddutUHDx1lH
         ORUnHL3zYnRHi6VqtlYoDIRbotN3U0oMRAIURY/L9lMUOpRrHylNn48yhYEPTKLUC7cD
         /HiizgDvPm7Le/2JTDfuq60Bn07ybhFPLhl197YuyU186xaptTMWyM59kO21x5HLmJns
         cHeUrGoQltLMFUEPxHWU7uqn3Mz+FVIgZYjETThqSLHmIK/9UXtyg+JCgZXsZiKWayLh
         C1/+HulxdK2GuOATVN/s1fs/dfQsxpOK4UEvYDv+4iVl6cFMGarNkxp42zK1+k5133RR
         2DWA==
X-Forwarded-Encrypted: i=1; AL+hErH+QfpzGGcR4c5DmCpML2Sk0t6X9KU9aCdm8isR1vo0324NnWfhtQLEgQWd+5otYeZZlxTPkUVVeTwFXcSA+H0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xUTUJLBYPJu6C11SZb5pyF+dfdENTxaOWxWyNRfJsDr3lXhqj
	rtV+g5N6UyfRRE8aN5Oa1oifBIkclgEx+02v/gtFPhQKhzEQznieaPbvG8IGo1cQ1lDJEQIpIaf
	/sxVImZnuLNUl7SPxhwbJPL7tl2GWCKU=
X-Gm-Gg: AYBFou2A7tXhlOy0gD+xrHfhskMReyagjmtKpLqrZb3vU//nE/FQbxe5WU3OiWPYPdv
	/u0iM03UkfMhyL+5S3XhjjGJfBdDgjOQQsuqltXeJas3YOMdTI6dB/fgdtYBfpyQnzyhmOPkzcw
	snlyo9RTquGFkpgqyGzCMMpgdM0XA5lmq1BlAhM2Gfegj3ttxktLBd9xgUizv+KSmV6zXyQspRy
	liYqnm2kr96QRyt2C6C13h9ELC6+VeIhmPGImP7zXU1eZ9Y3eawM5cR5Gqny6X/XPmL9zVMb7zf
	k32E+7xWLYruh9pCXyAK4ceKEE11Jtrxbjo6VdeqtwCjKjSeDj+WUeIOkGS6r3efSj3zzGlqJZD
	wbaso4uZIi+Qk9RYsaQ8mMwRL5wRDebB2mI3lSu3MYiXzASLBjs11Fx7my2V1QEl0XnBlTnE0n8
	9GAacmKc2XoZlqiY/BxhyGfAGE136e3RWDO6YixTcon7ctpLrix0xXfKm4
X-Received: by 2002:a05:690e:1381:b0:679:a943:7da4 with SMTP id
 956f58d0204a3-67c3da0f652mr1782262d50.85.1794238758509; Mon, 09 Nov 2026
 07:39:18 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108042008.226295-1-hex@freenixos.com> <b83e0172-2f64-4e28-9750-1a5fb3dd6b41@oss.qualcomm.com>
 <CABBYNZLJpDXTPmE_=rJ=J3oUMWRzybHhut4y1kPTEU8y2AKKiQ@mail.gmail.com>
In-Reply-To: <CABBYNZLJpDXTPmE_=rJ=J3oUMWRzybHhut4y1kPTEU8y2AKKiQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Nov 2026 10:39:07 -0500
X-Gm-Features: AclHuK8Ua3BvW7Ntl2pXTSvYx8bjEsraiOh6exVKsi3Zf5C_AVV5uG4LIDs4_gE
Message-ID: <CABBYNZJdeHXP1XjYcTwUdCe_SFfxMETpSQbF7t0FHyxY4YfZQQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for memdump
 segment data
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Hex Lindqvist <hex@freenixos.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Mon, Nov 9, 2026 at 10:35=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Zijun,
>
> On Mon, Nov 9, 2026 at 8:21=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.co=
m> wrote:
> >
> > On 11/8/2026 12:20 PM, Hex Lindqvist wrote:
> > > struct qhci_vse_memdump declares segdata as a zero-length array in a
> > > union. Zero-length arrays are deprecated [1], so use DECLARE_FLEX_ARR=
AY()
> > > instead.
> > >
> > > No functional change: segdata is only used with offsetof(). With debu=
g
> > > info stripped, btusb.o is byte-for-byte identical before and after,
> > > built with GCC 16 and Clang 21 on x86_64 and GCC 16 on arm64, with
> > > UBSAN_BOUNDS and FORTIFY_SOURCE enabled.
> > >
> > > An AI assistant helped find and check this change and drafted this
> > > message.
> > >
> > > Link: https://docs.kernel.org/process/deprecated.html#zero-length-and=
-one-element-arrays [1]
> > > Signed-off-by: Hex Lindqvist <hex@freenixos.com>
> > > ---
> > >  drivers/bluetooth/btusb_qcom.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/bluetooth/btusb_qcom.c b/drivers/bluetooth/btusb=
_qcom.c
> > > index cc4cfcde2afa..97be9078e045 100644
> > > --- a/drivers/bluetooth/btusb_qcom.c
> > > +++ b/drivers/bluetooth/btusb_qcom.c
> > > @@ -533,7 +533,7 @@ struct qhci_vse_memdump {
> > >       __le16 seqno;
> > >       u8     subsys;
> > >       union {
> > > -             u8 segdata[0];
> > > +             DECLARE_FLEX_ARRAY(u8, segdata);
> > >               struct {
> > >                       __le32 dump_size;
> > >                       u8 first_segdata[];
> >
> > NAK. Please keep this as-is. since:
> >
> > 1) segdata[0] is a familiar GNU C idiom and, since it is only used as a=
n offsetof() anchor, is more straightforward than the
> >   DECLARE_FLEX_ARRAY() expansion.

Maybe not DECLARE_FLEX_ARRAY, but [0] is not recommended for vla see
the Link tag, in fact the first_segdata[] does follow it so this needs
to be fixed anyway.

> > 2) I guess this kind of isolated cleanup may not be welcome.As noted in=
 Documentation/process/maintainer-netdev.rst, simple cleanups outside
> >    the context of other work are discouraged
>
> While this maybe true if the above code does produce new warnings then
> it needs to be fixed anyway, from the commit message it doesn't
> mention any build warning but that perhaps is because it is enclosed
> into a union which mask it or something, anyway trainling variable
> length should be accompany with __counted_by; so the compiler can do
> bounds checking.
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
