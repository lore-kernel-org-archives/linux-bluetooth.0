Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDDD15A4A6
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079142; cv=none; b=R8ld94YFP1C2Y5QMbt9VqI9ikPEpVISJvGSqrB3U1g4XSNKPjVsR+jol+8dQOBmq9FkWVh+O5v/DHQoG/AMn2d4VKN2eqMMRNaqlG3TZCG9sgyrB399eUxKRXf+smcX/FyVZcdIUrWlLklRrRyULiUq3P0eFVt1NgPt/T3NKPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079142; c=relaxed/simple;
	bh=ZtOIphUh84S9j2kYzqs9h9/kHMtEVe3TZQ8FWswN3do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIA2y1ZvapcriXD2V3P/Zw1LQOTGDOA3qOSmIezi/WoUe8ZMfSXGe8TGzBMvlDcVF84k5jzF7wa6jyw+nyZKpgSAfwFj3Ru74iQhrDvBYhEqvIe26pQsBA+y2n00LkFdUbHLOtww0mffcyLfwxMVO0z2ZUKNk1LrfECuxt+A46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvvzwpTV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvvzwpTV"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d23114b19dso75820971fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712079139; x=1712683939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67jNyglPS57Dpra9dzWI9JrPZGA2oI7amtx0yoditzQ=;
        b=QvvzwpTVYp5dyJAJgZ+kOiiNz7Z10TfbNORmPP7JmfnY6wLevstVDmpDW/pX/TSavm
         u70fK1FFVpYzDqcjWh7gmVfTbRF7wo8h1O2i7vHSi7wC+DdBD7pWeUljjLTfDNg9sQ0n
         BEEecn0h7v9h/3MkXmdRQJRpPuJoECaFE3Lls5BpBR4cinT3OX9X47IYM7EexBeOu3ON
         fcppZFM1myJZnzo7V0AqcaM7K/WPJIGqxIe94/on6V/yQAUhVycoQ5r0BELkEwu3QwTi
         jsIFa43yDMCa3IeoHOjcpUZcXJIYbLesv6k8VWL15FaR8eFqD+NX8CbJW4tcfS93cuRg
         Ir7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712079139; x=1712683939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67jNyglPS57Dpra9dzWI9JrPZGA2oI7amtx0yoditzQ=;
        b=c6ncFG+zo3Muf3rarOqbsEHNHSqi6nS4XOASFWgcx0TUGWKP2VYW8aoyJNDQRtcAVo
         tA7RMszDk9wcKjXfAsCIympzju7d10KAh3p//r+uWBRGYbZkRbmAF/3F51urmEM9YgCa
         ljBi1toobxz6mn01Ec565Jjd5caAhcIwuqLmyuVTsfIJqGXpWP0TP1OpPXvM62ZibZbf
         ok6Wrc/rLiNjcIM6fHmEX6kSQ8zmiQHpc8kD1TBs55rMGaEnjoNdD3JyNp7/vX99Hb42
         AQJ0LR5I7TEZHRwfymbN+WuSHZnfSee84xtH43Ve4xC2FpxJ9meEO6/w/sEkrCy8SnwP
         5mRw==
X-Gm-Message-State: AOJu0YzaDie6ZomUQUmgh6WPy+5zzU2evdzbbVXgVvYiVRa3EFFZOMm1
	DJGOfWq+6cbXjdZ/aW0g+0iL8rllYYD7NsjwtVU4yYvZWgepL18wCXVPluXrshObkw1kCvJIHBK
	xNESjr8zlLd/SFqisycC45tYk0S+aDM8t
X-Google-Smtp-Source: AGHT+IEPcMfw2qsnQhi29xMmLfMHmaH+euJ4lS1i2sZepGTRqra8SqbzFZ/CQcxgle/kHOtX0xznTKfrbknyoEK4VF0=
X-Received: by 2002:a05:651c:782:b0:2d6:d351:78ae with SMTP id
 g2-20020a05651c078200b002d6d35178aemr7289033lje.29.1712079138569; Tue, 02 Apr
 2024 10:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712076170.git.pav@iki.fi> <dfac82dfbb128c79c0c62c72a75ccd1da67ec99d.1712076170.git.pav@iki.fi>
In-Reply-To: <dfac82dfbb128c79c0c62c72a75ccd1da67ec99d.1712076170.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Apr 2024 13:32:06 -0400
Message-ID: <CABBYNZL3yVm7h1T2ZQDCs_m-mRecK+fke=XTH=ng4pr4cwAhyg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/8] lib: add BT_SCM_ERROR and BT_NO_ERRQUEUE_POLL
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Apr 2, 2024 at 12:43=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add new CMSG type used in new kernel TX timestamping support.
>
> Add new socket option.
> ---
>  lib/bluetooth.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index 75dc960c8..7c310a69b 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -141,6 +141,7 @@ struct bt_voice {
>  #define BT_PKT_STATUS          16
>
>  #define BT_SCM_PKT_STATUS      0x03
> +#define BT_SCM_ERROR           0x04
>
>  #define BT_ISO_QOS             17
>
> @@ -239,6 +240,8 @@ enum {
>
>  #define BT_ISO_BASE            20
>
> +#define BT_NO_ERRQUEUE_POLL    21

Split this change so I can apply the other patches in advance.

>  /* Byte order conversions */
>  #if __BYTE_ORDER =3D=3D __LITTLE_ENDIAN
>  #define htobs(d)  (d)
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
