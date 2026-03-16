Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABF359FB0
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773693540; cv=pass; b=TO26SlZ3CP/AmINTHfWfJ38C97YEKfPlF4UIt+XHtB5TQjauhCWapXXYic8CeHPvX57DfVC8As6AnVe3c5CugBplAIccNgqPweknfAlYx0E+2W+Hvy4ucJ6XvGdS9RXK91UL52K7sHrYXV8hsY2s183O1TKHPm64+EfMyAfQzrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773693540; c=relaxed/simple;
	bh=PiwDDKuvImq9+SG1iPmWFte2niRBfGV19ktTfAlIsO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paosRbjmLDLorV6QK7K+5F2YRjwSHcsNdLyCVF9PHazMgVu3vKSqY9TlVEfPMMJTONzoihlCl/qp0k7RM97zjg8iYvx1YJjegHo2ost/LxiRvQ6ZwqJFsFUzSf4DwNtA2kFNsWHfqciMh/j65B/8iiJoG7nZCDiH+goiXZTTDCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VF+vAyC9; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VF+vAyC9"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9a6d68e5so4260274d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 13:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773693538; cv=none;
        d=google.com; s=arc-20240605;
        b=ZGevAF6q2/1aOhomEMZ7YKSOQI/wpFz3hNEUdakpThZZxKFcV3nnbgMI9bOA7W9+yc
         uQO6jr5ezxLEhogwTfskE2uumaEeKzN0GJvKqYa+SNriYDiLhn6h9hdiE4JgSnHGK6oH
         mGrOxJo0gPzPgu3QWKc0xlZ59eDO2F7nqYCJR5bf0CIl2q5ADepdTqyaRYKc4kIPyNtF
         YRnBjeuBVmFcvnf6NXbD9pPmS+0BE6aqPukFEUq+F4+yCu5jiBurTZ3xyqWA4Z+yTylY
         Nib0bQ4QQBJ/1w1YNoa7xDqbgM89rh88tAk4iK93J4q7sJEJb/uqWcQjZ7kWdi8W3BGz
         7kuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6vy8xzEVXbGBnEUE96aye4i8vL7xLGIQHvPXdmE/dA=;
        fh=YGcW7/kIvaoHGP95S6hWpccVS+oj4DLOwIzMTDL7wPU=;
        b=JSUCDi7Ta/+HOVVftI1nd5LqjMFdqEX7RVSCv0BjaXA5Y3bvZOA9uw0/jqlUk0d8rB
         OEJV8NNTRyqGZqkdKIouEPwu8t0P+3gxMhwDYRvNhmy2oFf+R0//lgax4HWdMPHwti/l
         fkz6CNGKOcqj4RWGEMgCvEjdlXRhpYsca1i3P91c3xIy/2eyRD2WBreKV/dh9XY6CGTE
         Ikx3CEsBo6+3TKvMBRzCLpo1IeWPJDXJR4+NAHOHD6aAZ8MNkuDpXls/AkS8PEJvLNMF
         FlTP3cT/svHBFR3/BjXGtti+T1dQSooJaq4Nf6hk3uR14wgjx/xwZS3F1Uy4ymzXDmZD
         TvRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773693538; x=1774298338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6vy8xzEVXbGBnEUE96aye4i8vL7xLGIQHvPXdmE/dA=;
        b=VF+vAyC9lGUwYctV+z2uYaxmmKa1i5fC3O01XGGjSCDwJsLkkiLJZ6AP6KlcWnmwqB
         O7qMpGH/CBs0c6oIHogxwv95iKlDhbpY0suXabdbeuz649hd5AQ49GTmUXICK07vF8df
         JKmGvoSNNub3kKDpPezGlHLDMK43T4nnj/hEDZ0TV5J7jqb7hbzLtnNsD/hC/aEmsdSF
         ET1AZZGSxoCnSPNNF//XGINNjA9IAhepNyvPgwwT1ev0IeqKnrHFk66o/ECB4U9SIpza
         sGoqpY5V6p7z5gUHXRl1RQ+FP3wBsnA0zdKyPoDY8e6fC2XM9liQQeLw+qaveOlyKodu
         KnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773693538; x=1774298338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6vy8xzEVXbGBnEUE96aye4i8vL7xLGIQHvPXdmE/dA=;
        b=D4K7KPpQ7mGpAWD+Fnvz5IY5yqOBdPnMdmT63nGphzjpqQnAp9ewlULGEzNfuwFM9x
         84WC8QqvD+eUjowdTTDiS9H0TnjS4gOjvplXPOaz8lsuA7BHWyUYkCd6zrhdG4abDcFU
         aRrZUlAvHimYV92AmKUsP0PFYwVrSiVZA/7JSUsWTnzwlBmIhugog4v/pdrB6qQKP2oH
         4nt3lA1mkG5/tnxoOoMPaqndiKp06U3X1Jjwui5sf/h31zW0kpE9Y98D+4MGVT7bKNPa
         cWetFqg8ok91alDXMKT5e1XHFGu3gZJh7nF1ohVzqjK9BNwDxU3Qdrcy7PpJG4d/uCkR
         Vi6A==
X-Gm-Message-State: AOJu0Yw8J4BebPTlUs0ZnIU2MD/vZfQhQJLC/lzHeZUU4wvIXBOsSNyd
	TonxCJNaUbUX0/Y5aQG1Aub5qRF4FaNXxykEsnPm6MFTY39sw2n3+TtbavGNveCzmHTkyg9e09B
	cYjIUsBd03fSxepLkrBmNd7fzB5+S2va9RmgvOd8=
X-Gm-Gg: ATEYQzyLaXdnsR9kBsuX07cPiIU16ugcznhQtcL/HzCdysUdb7OjoYoiojMmkfVhK5Z
	m3D35OKBia4kHoYsHB93ifFWpW+p79iClzJXSnae/Qj+eQfZBi3RwCIEi2Dycj45FXMAs13xeFq
	hiAiqXSkd0Yqb2WAjXAxJx/AjuAhSyiZ2BbWSoVowJfOlF7yEAbyEE8t8TT72EGRg7Ug2VEcDR/
	0+uPilImEBP0mBufK0zQgCWSwL1zrOW+Kya4Ej4DZsq9hlE/CxXoi5y4L88nObXiZV3Qdbui/gX
	8l7qs05+baNH3wZ/wXZQeMIq0Bqfy+JhDU+/+qfOe7cWUMvqyLCpipNkK5CwlsdcWUPz3A==
X-Received: by 2002:a53:d056:0:10b0:64c:ae15:5677 with SMTP id
 956f58d0204a3-64e62f3d106mr11163154d50.26.1773693537637; Mon, 16 Mar 2026
 13:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d62d5cd.57f7e.19cdb8402e8.Coremail.pengpeng@iscas.ac.cn>
In-Reply-To: <1d62d5cd.57f7e.19cdb8402e8.Coremail.pengpeng@iscas.ac.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Mar 2026 16:38:46 -0400
X-Gm-Features: AaiRm5383QYCYbDsJ656XQPeJlEVANNeio_FlrdP9C8jZKmaXy1dKvht9ahLwV4
Message-ID: <CABBYNZ+PDWDN2Bn8=Trwu3PP4_qYzKa0P4tj0aqGNYu_zSFqrA@mail.gmail.com>
Subject: Re: [BUG] `ad_replace_name()` copies AD name payloads up to 254 bytes
 into `utf8_name[250]`
To: =?UTF-8?B?5L6v5pyL5pyL?= <pengpeng@iscas.ac.cn>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 11, 2026 at 2:12=E2=80=AFAM =E4=BE=AF=E6=9C=8B=E6=9C=8B <pengpe=
ng@iscas.ac.cn> wrote:
>
> Hello BlueZ maintainers,
>
> I would like to report what appears to be a real current-head bounded sta=
ck overflow in the advertising-data name parser. I rechecked current upstre=
am head on 2026-03-10 before writing this report.
>
> The destination buffer is:
>
> ```c
> char utf8_name[HCI_MAX_NAME_LENGTH + 2];
> ```
>
> with:
>
> ```c
> #define HCI_MAX_NAME_LENGTH 248
> ```
>
> so the total stack buffer size is `250` bytes.
>
> The vulnerable copy is:
>
> ```c
> memset(utf8_name, 0, sizeof(utf8_name));
> strncpy(utf8_name, (const char *)iov->iov_base, iov->iov_len);
> ```
>
> The length passed to this helper comes from `bt_ad_new_with_data()`, wher=
e the AD element length is read as a `uint8_t`, then decremented once for t=
he type byte:
>
> ```c
> while (util_iov_pull_u8(&iov, &elen)) {
>     ...
>     if (!util_iov_pull_u8(&iov, &type))
>         goto failed;
>     elen--;
>     ...
>     data =3D util_iov_pull_mem(&iov, elen);
> ```
>
> So the payload length delivered to `ad_replace_name()` can be as large as=
 `254`, while the destination buffer is only `250` bytes.
>
> I am deliberately not overstating this:
>
> - this is protocol-bounded, not arbitrary length
> - the maximum overwrite amplitude is small, about 4 bytes
>
> But it still looks like a real current-head bug:
>
> - fixed stack buffer of 250 bytes
> - copy length can reach 254
> - no local guard `iov->iov_len <=3D sizeof(utf8_name)`
>
> The fix seems straightforward: clamp or reject `iov->iov_len > sizeof(utf=
8_name) - 1` before the copy, and preserve explicit termination.

So something like:

diff --git a/src/shared/ad.c b/src/shared/ad.c
index ac238014bcea..b1d1b84611aa 100644
--- a/src/shared/ad.c
+++ b/src/shared/ad.c
@@ -278,7 +278,8 @@ static bool ad_replace_name(struct bt_ad *ad,
struct iovec *iov)
        char utf8_name[HCI_MAX_NAME_LENGTH + 2];

        memset(utf8_name, 0, sizeof(utf8_name));
-       strncpy(utf8_name, (const char *)iov->iov_base, iov->iov_len);
+       strncpy(utf8_name, (const char *)iov->iov_base,
+                       MIN(iov->iov_len, HCI_MAX_NAME_LENGTH));

        if (strisutf8(utf8_name, iov->iov_len))
                goto done;

> Best regards,
> Pengpeng Hou



--=20
Luiz Augusto von Dentz
