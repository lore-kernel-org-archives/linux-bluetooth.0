Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ECC3E16A8
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785957429; cv=pass; b=mVYUFq+6+uAnlx0l39qYHH1TUaw/mqsiUX7/+j7TNXoz9YqN70vkA4v6P9cjwCkQ/AKM6IVNl7FSf+UPGEG4SOlx0GGvMiD+8x9D02WvlnMAd/HTz6wxWANcrVQuD8eiFbq1YNVv1MkDrJBxyK/ubEkRhaNCHQVOqm3S0Zj6SyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785957429; c=relaxed/simple;
	bh=vAGc6aYy53n8Ge9kSp0L4eR4cVBIMAXOr4qdllGJ4L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7QhUHaSYmE3jURQZN8UKh1Ur27eQi2NN9lIjdKBmBNokwQlv6VcFCp+YSnwfKPEbmCDQcri15U1wlr52izVInl19/FVpW+hqg5KEPHvfRN/QVp9A2eawrPNIlBzP1V91vTShhial6VmnkpKDF2fpRTytoRc8HsMN4asZ//GAn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqiCxx3D; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqiCxx3D"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39ca300db70so13290771fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 12:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785957422; cv=none;
        d=google.com; s=arc-20260327;
        b=mTkkqGbEnsiqi/dR3BjUauyj/KslsoxMQlDdysYfWtIO/sOU/mKFdxQ8MriycE9/Qt
         Ax0x34jpEM3gghg337Nj8KkofkF8entQTWunamfsCiBpAyO9x8fwaWMuwN0z0AWpp9+C
         HX/bHJIVEjDb3jbk/Muj7FKtdlwcrFJuPsygnEp6HtamgO9h81MjQ5SJWhSHUEy0TUXt
         AjaQNzLdeTr0Zn2O2qgHV/hOCg7/wItp2+2pi8CsH5xkIaGQsIusY5F97q53w/SUhp8+
         9Ng3J7QtwJdlWHIYMEuiTldO00Bq/ns8EHEju1YhokfcaIeGQ4P0fLfKg70TtsMs7NmX
         IK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVhqHKh6CPIoyBOn7HJSUD7+ux8Hn/mWJpjfZX2/nAg=;
        fh=cv6ISHtDLr/X8oBhvmIrhqbOsClmSkigyXZlgRm4tF8=;
        b=Vcul7ChjSQWJn2MpOclIZ8fjMFWn1Z4zwcobs/lqh5o9jBapGulntoWktvPc76uawr
         fM6dlr2RhGBZB74Jh4+pqKYnOPeeNA1CkE6Dg5EBuYgWCHiBxuDqcnpoEwasvC5eOOiR
         YbihgmCcbupRxxzwM1IDecUAcmZw7xzhEiggexfZM0x9wm0RkCF3286YevXVooRE4VOt
         8xHXQ3fZz8OBhmNoanhdYztNjwJ4n3X1VbgMQ8t8KwPFLcHi/liAF1QT64dFKsb4SNuM
         2h7wX8gEjld6SU6U7ErcfXeN1ZVe9+PgC8uREgaRpLJNg6mGQN3uv54Cm7BJcEjTtUYb
         BSmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785957422; x=1786562222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVhqHKh6CPIoyBOn7HJSUD7+ux8Hn/mWJpjfZX2/nAg=;
        b=DqiCxx3DiTaycwe7AdZtoPwcpH2Pjb6vGcDysi2Z5gmyJ0HAE4MzwObahewCbTGuYB
         pxFM08wLxt4+RQvjmLRVSnFuMNXwUlQos4d9dajUup9wcZ83pLGq6aJrlO7Ew2ZwCptd
         QcyWR+s3xKKV+FpJoH7z5ZEb4tjMjX8VP1Cccanh98THWVPxgoj+rDH8Mtr40AGSmtg7
         TM29Kxv+VWkfaR7MBWzZDS+NQIwwrfMGLvoYf8IVUPQlUeP5EjzQUtr7lCuL9oNmQfS0
         AgC/fwweAN0pbPzO0VtDZN8K8zDHkWMNxf9RqR0Cu5HAZXApTA4kIJWT7NTHXXRxs5N8
         sDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785957422; x=1786562222;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVhqHKh6CPIoyBOn7HJSUD7+ux8Hn/mWJpjfZX2/nAg=;
        b=MUnOS9eoFeeEeFX+mLYksONl/GckhVtg2Q/+PmH0sEW4vF0ZSWe55XpPDjsTm8xiCh
         D3a+eE77JG0fvtXgReIL2IdiaZHNmTQSFTPXdrgvX5fK9NIsbBpmcpNaNTCFNjj2PklY
         j/Sggvu0Go5cjQKVy9Te9OJSC7x1yoJoRii43eSVzY7x2yhj3XQynY5Zu8prf85JijVp
         KQiGdDWDNcxiM6cDLyse2atWuW2j7HRyWpWG2Cmi99nSx43+QBU52zyQ+njRU0av9KcN
         fhwk0925GAcm2Apxne8gH4fz4e0rT0XGp5rBb+1zrXjcU/idpWVxA9NMS1V6nEBvlFke
         fkzw==
X-Forwarded-Encrypted: i=1; AHgh+RrxsZ2111eD5Y2lZIIxG7kOjC2NdP2NkmuIMkXs6bYBpC0KMJdFzD/SHKOsvmRAlJb0FRXKoZVTgkbzhoFq7m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIOnXVzRFT7v/AC1rRU1Uox0YPcEGDNcBOw5EB7l0zZTofraJU
	xFT4PW2jgemlRsa4Wt7lnrpOpqbxzYNNVNlaoI0IC+nGh8X6rL4pRPWzLUp43B0W55d6oOxn1nm
	xjbA03fP/l/KxxW5JrqZYvMSbjIXtcIi3KOuLfjfU
X-Gm-Gg: AR+sD11hyP7PREdUh42lpaLk1/TLpXLtdjOBEdGwGMgY6tKkcpnj1+3yBpzMTE3yoyr
	ZXCEAsxNc18dd2Unn4WTAQHqX9ZFx4xNZDlWcOXkbQDrapLYwzpUkKC4+PXDUJ7CZsf6BkhFIV5
	wNH2F8HJYmBZo0VTppSBFWTpw7ujjfsoa9rLeK9DxWBKhOOgaoQM73Tera/oFx02hvZOlx9Fprl
	C9dYQZnIGZkI7NUnVZyXYctfVei5QI8c1/r0Ho1ssuRuA0HKjOFj8gYRJUV9tpKbRUvg8MbavsP
	EwJZQa3oyw1rBYP/gGCpNtbJKoQZmVCgF0UXh6jlIYbVdFzzhKQQBFikm/79CExF4nGeZIsgJcH
	YZBD0Q5+KP33XSv/9kGgB/fCfmZHR4YWdD3NMtmQ+TFm7Kvyj6A23ai44jbIN731yJyTdK38hmw
	RBifvDyjGkOqxoKEpdR70HEpja84Y=
X-Received: by 2002:a05:651c:221e:b0:39f:bc94:eba6 with SMTP id
 38308e7fff4ca-39fbc94ec7cmr11124031fa.14.1785957421590; Wed, 05 Aug 2026
 12:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804214406.750710-1-tkjos@google.com> <20260805011006.stable-0007@kernel.org>
In-Reply-To: <20260805011006.stable-0007@kernel.org>
From: Todd Kjos <tkjos@google.com>
Date: Wed, 5 Aug 2026 12:16:48 -0700
X-Gm-Features: AUfX_mw1nkkw5kkLj8bI2FW2wAiOLfVkEzSktWrAkzdsdv_wgjivU38R77dZlH8
Message-ID: <CAHRSSEz69qwV6KzFuhU_cMq3QDBAotSvGrkW-rpHWWubpqqY2A@mail.gmail.com>
Subject: Re: [PATCH 1/2 5.10.y] Bluetooth: SCO: Fix UAF on sco_sock_timeout
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, kernel-team@android.com, 
	Lee Jones <lee@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com, 
	Xiangyu Chen <xiangyu.chen@windriver.com>, He Zhe <zhe.he@windriver.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:13=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Tue, Aug 04, 2026 at 09:44:05PM +0000, Todd Kjos wrote:
> > @@ -192,7 +200,7 @@ static void sco_conn_del(struct hci_conn *hcon, int=
 err)
> >
> >       /* Kill socket */
> >       sco_conn_lock(conn);
> > -     sk =3D conn->sk;
> > +     sk =3D sco_sock_hold(conn);
> >       sco_conn_unlock(conn);
> >
> >       if (sk) {
>
> I think that this hunk leaks a struct sock reference on 5.10.

Yes, you are right.

>
> Unlike upstream and the 5.15/6.1 backports, where the sock_hold(sk) sits
> just before sco_conn_unlock() and the upstream hunk deletes it, 5.10 keep=
s
> its sock_hold(sk) inside the condition:
>
>         sco_conn_lock(conn);
>         sk =3D conn->sk;
>         sco_conn_unlock(conn);
>
>         if (sk) {
>                 sock_hold(sk);

This reference is not needed in the new version, since in we take the
reference above.

>                 bh_lock_sock(sk);
>                 sco_sock_clear_timer(sk);
>                 sco_chan_del(sk, err);
>                 bh_unlock_sock(sk);
>                 sock_put(sk);
>         }
>
> So after this patch the function takes two references (one in
> sco_sock_hold(), one from the surviving sock_hold(sk)) and drops only one=
.
> That is a permanent struct sock leak on every SCO teardown, reachable by
> any user with repeated connect/disconnect.
>
> While respinning, please also drop the Change-Id: trailers from both
> patches.

Will do. Sorry about that.

>
> --
> Thanks,
> Sasha
