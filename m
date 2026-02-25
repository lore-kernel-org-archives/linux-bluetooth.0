Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F783D6684
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039687; cv=pass; b=irp+6ph1gYpDULg/O6pJcAc3j8FOcPzVAXiOGCJh+TRhxt+cBi7/RbHUJ2lwGKEpV68uo4avVzASj3LzRVmXidwjpeXWslEoaQrjh1Vaq5Dyba7pTIE8rnfFLTGVL7ePi+hbrVNYsoBqSBUANDFhc7MmbX8RC1Z205H1o/WHdRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039687; c=relaxed/simple;
	bh=G9XeQd+PkYiumoPZ//vz9gkebQiRZ6DTiC3+eewkCsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhpN4NkRITP8Q01/EQ+88w7r81CXOrwU35+mPWORe4r5EyiX5tg/DrRGUcrt+SC6erq0RU4pH3/tl63xhstxcrKydXJRnAACjyK5uRf3ql6qTaC85tlLZYS+0Sone9pjBOxfMSAzAghZ/NE8XxUGdsSjz35suvRXXKoMAni1LBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpA4fPlN; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpA4fPlN"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-798374d0f44so16913787b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:14:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772039685; cv=none;
        d=google.com; s=arc-20240605;
        b=dp/x3KFRoB1mxZPtGgMRv1No5LXmuyV8/RqeR4Jx4cr22adAVF8Ewo+H3CH5bE4Qgp
         +EI16KKQfOwYfdF3kS3qh8l+FUv6Mo7K9rh+sbAYeAo8DcXrC7jk+EC1NUJtUG1YpHat
         0tg9gRp3SRkBWoywM9UZCa7mWO2L/ilhZEekOWnNNxSqUf4Q7t5Ic2QGTeqR1ktS2sF3
         9lAQVZiRrOWvQACq/0dkG4sEzIGQiR96NbGXGjUPXmpXOlYEszIwzMbXJZcpZE2vvkeX
         zyFi+x/uWk7kz9bBY4EOSOYSKPGUTbtbgsIaMnlMB82aG2IXLp3DV2zTvLkiA2DbxCRW
         MOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WD4tYb2GEL4uvQV0O+hiYbC+0GLw/+2g89cALZ6+4ZM=;
        fh=ANo+pce2kMx0aoUf156W/rnC+EPTUoh3qXTjPJNpl0Q=;
        b=LCJCouocPYhtVVYNFFTcnujEf3ubwFodfBnyJh6lFsJH2Hqzowu83jrtJcSkXkDTGe
         TV8zxKYF26S94FBN5fRHaLf8KOmtArX3oF7iUEXKC0gAcdggTHQHk12g/4rZ5iTkANHa
         rB/eCtX0jibINH3MuiBz/oeHEoKfx8MpJ6zaFQtRgL09XvBwGJylfAwhJnYUjLVtQ4Vg
         GX1MRH+a/PEBzrW0F1HoHh0yj+RLOj8TMhtHzXkUbD+bC+1Dch7QPEP3JsQBZldoUk8Q
         8GT0sIekORFJkTRx4i9xW3hPgekbOAXVuDJ1yNimz+QC50Hh4QX79m43xu2NpJDn0HrF
         P8Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772039685; x=1772644485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WD4tYb2GEL4uvQV0O+hiYbC+0GLw/+2g89cALZ6+4ZM=;
        b=ZpA4fPlNW3sWLJ9hnGBvLpTf3WofIdtQEE6B78CbLALAyNW+ZbwVN7Emhm+ynWZ8qV
         LSQMvkn+xLBzssaTKV8VGTEPaUQVR+PX1JbbOqvOJkmtzzMnZC9VuSgNpCboeLb+e8J7
         /z6yQEUYCttSM6ZY2n+aTdfp7cmb7ICc7EsjFRYeSEoNO0lNrDAQZOVk5KZ/+E0uVHDH
         EV2WUdKdWKl+FZGn/PBcUdb6tiDsehOJHzB3IsduzvSM6obrGQW/MDdHJ47MnoSzdbxn
         1iHNsvsi6jn0L9YiiST6FuSc5cMREQYAgGpF/c7dOUh9/votbitU1yS5AVRg3t3Phidt
         aWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772039685; x=1772644485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WD4tYb2GEL4uvQV0O+hiYbC+0GLw/+2g89cALZ6+4ZM=;
        b=nc8Z4lwj87zzAMh3cMnRuEPtXzVWOuvSQm+TbL9kU/Fyv/Pf07fhePN7iA0sGdkmUV
         NHNU0fZ0c1JWhVbpXxhjBEkp0dLbgXBO9/tgqBDmwUwvQIUun27//LmptLXoHsOnAXQT
         S5OeLNQPiKAVTAElCtTv8BcH3o+5xQcS+Uone+FA/O0B6mS1VZ+9SHSccTk+K4mwX5BR
         r45QLddgD73CvuP+/L2nO75lnpy0InZYwAggE5wdIlHaAYk6EGgS+iO8M8X6wDtHE3Bq
         ILqHIFexa6N07vyw/FgrSLt87ashqjY1b36jVKeQ0TfLIoUitNvT5AGCZlZBSkAaO2pu
         rr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz/NyYljfgxr4AOiZVldJlg+EedOjQAz5gIAQeO5w4a7T+lM/aIFTTky9uwh5WBclmFLNkQsGbcsGbddCR3eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTO+APAZj2XBUrCfDXPn8m2wbijhRz9Y7989U34M+B7xvyOV4
	s2Sybb4Kb4ziEKVmKbEHiyEe0DVqPb5CownmjQU1R8ehMgiOf+8fh4ns4HG8z2aAY6TIPK+znLT
	4JYujc5fKcZBHMAksRc8ihZoIEJ6tbIc=
X-Gm-Gg: ATEYQzzrYagp0vbLIa1qyb1AP4XzCA8lZEKXHcsjAKymJDZZk0Z03ck6Osnu0jsCYWV
	+8pLlgq/JfZlsns9o2V7sPYAp3EQLETL/xFq0BLC+FLRBaDdPbYp3/crXhNbJLI2hSp2OkftrT5
	RT1godNDfxiRR2PM4zL0WfHt4sFW5zvIm11lQ5gZQ4sHKQJuMmiPYC1gexD0UrJVkqDDLJ5TDmS
	V4Bfn4dMDYp5hmz4dgShQk2wj1lt8yjdRyGnZnHGLKrOAoHikRyuTR+ACy+E5kpprHYguDnUf3l
	bb2Pj5RVOEeIrAIxibClisbr8ks2YpE7YqZC+tr4ecj3fi3Prxy8SfqpP00vBDGa/sg=
X-Received: by 2002:a53:ee43:0:b0:644:4eec:22a with SMTP id
 956f58d0204a3-64ca60dc51emr2870116d50.2.1772039685172; Wed, 25 Feb 2026
 09:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225170728.30327-1-ceggers@arri.de>
In-Reply-To: <20260225170728.30327-1-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Feb 2026 12:14:33 -0500
X-Gm-Features: AaiRm50cWadyPcnl-D43367XooQbns1JJYchHYyNZNIb5KyxK8BaUb-7FHYSsd4
Message-ID: <CABBYNZKnnVLiCRCJBwJQtqazsZ8_56dCpM4oCQvPbutxP9sKBg@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: L2CAP: CoC: Disconnect if received
 packet's SDU exceeds IMTU
To: Christian Eggers <ceggers@arri.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Wed, Feb 25, 2026 at 12:07=E2=80=AFPM Christian Eggers <ceggers@arri.de>=
 wrote:
>
> Core 6.0, Vol 3, Part A, 3.4.3:
> "If the SDU length field value exceeds the receiver's MTU, the receiver
> shall disconnect the channel..."
>
> This fixes L2CAP/LE/CFC/BV-26-C (running together with 'l2test -r -P
> 0x0027 -V le_public -I 100').
>
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  net/bluetooth/l2cap_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 2dcc5bb907b8..ddac5b9270bf 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -6664,6 +6664,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *=
chan, struct sk_buff *skb)
>
>         if (chan->imtu < skb->len) {
>                 BT_ERR("Too big LE L2CAP PDU");
> +               l2cap_send_disconn_req(chan, ECONNRESET);
>                 return -ENOBUFS;
>         }
>
> @@ -6690,6 +6691,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *=
chan, struct sk_buff *skb)
>
>                 if (sdu_len > chan->imtu) {
>                         BT_ERR("Too big LE L2CAP SDU length received");
> +                       l2cap_send_disconn_req(chan, ECONNRESET);

We might want to update the error to something like ...SDU %d > %d
disconnecting... so it more descriptive by informing what it received,
what the maximum expected value is, and that it will disconnect
because of the error.

>                         err =3D -EMSGSIZE;
>                         goto failed;
>                 }
> --
> 2.44.4
>


--=20
Luiz Augusto von Dentz
