Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FF290BBD;
	Mon, 21 Jul 2025 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104911; cv=none; b=XDc9txKs6wTYKwVnlMO4c30T/vCGw8ZOaHIZ7s4jQgTTUqKGcuYYbH79r/tZJuR9XztaPAOrT7YMBll5kUdz8XeogVUoNfA7XOUZpvFzM72f+hZ1Rubs4mxH/9lsaQZMQoBrVj5mbdBRAUanNNkcHTxzfU9iyRtVThb46v2Lrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104911; c=relaxed/simple;
	bh=heVfT7bflX2gxdQT0VV/G+UD9DZiY97K+xwUQLk8W2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgPZsoVhVcCz4kfil3nq3Eb5n8KMoYMLRZ+AJMCFUxSjAftqTCo2Ki+FtNFGXcMeAIzq3kPopXnT+dCmbjDJ2yuaTFusv/TbOYFPzllUJ9YW2RbfdVYdSPDBMHSyAuFdFsUKDhZ2CvlvWyhasBUMB19Ig8NXZKbezY/W4CpcAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlW0VLnt; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlW0VLnt"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-553b6a349ccso5507761e87.0;
        Mon, 21 Jul 2025 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753104908; x=1753709708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcOodTDasNSxnDbDQN1OlvA1R6+7EKNSyLdBU/fpTcA=;
        b=UlW0VLntJtuHw/qr+utVmxETquuvIs2uqUhF8Pz+7hZJuU1RouR0fpAQeqI5jvnSJ9
         jybaNf+9au0ziQA/sq25RFE3eLLUDjWLffF+gCQ+fE6GMlydvQirCyQIMvqa5DDiU0sq
         R8zVpaVNw1EMsJn3+B02OoWaI7vJtDEqKwtzpf2a/itv6NRkgzL5feQMfNvg8ahppoW9
         x5eMTP2amdZjkMonoqK3Z1oudzarechgBL7Ah8LksDQZXFR36hFfcBW8Q6GdXviB+myr
         TdYlMF0dWRb61CbnpCxE/RkCYpBulxtFdODbl9n1dah4nk2OPyX65WzlR4WEFmYCyLAh
         /0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753104908; x=1753709708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcOodTDasNSxnDbDQN1OlvA1R6+7EKNSyLdBU/fpTcA=;
        b=IUspiKO7xLj/pFxXuT6arXWHhBI3xtRCJTDlQnzEUaL8rYMNH7eGy6TzuX3ZUWHIL0
         ZsnMmJuferlEaCDLOoqjFXNDK8cqL1O4bUNMAsR+MEm3Jo5pTp4RKCzfC5ocvA2lVnpU
         7A1Y+DoKkYKANJFCeaREz6k+VLSffyQSRhueb8ZSCgGuNRQZbfHMgaw3AwzriYUncAZN
         yQRJBTz6hOdGFEu8p4y/sNcBH9iaS20fwf5wUmREHgktVZQj7MOjmcApr9M3TYqTEDP1
         6rMCyajrO0usbFrFx1t/n8gYSb/GIkXspekNGvJMDsWPaxCh2wDM3qM2KDDS8V3mk7CT
         tnnA==
X-Forwarded-Encrypted: i=1; AJvYcCVNXoUf2eZu8iKg47Hq4xfQNqrDuK1UTJfVQ9qRB9BuJlIChrPEsZS6pp/aAPE95jkfRl5VNFfYuSsZPJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8z1bWlUxsIec/lR4HDVh3a2cxh002vUlNB469A7crfybCyzo1
	FFwD3MIZ/4+pUKlRPO1zAJuCxv/fxFyCfqyxpEhtHpz7291JFSRUVOlm8wJXjJfuLgSHUhWAp5h
	mLSxA3on8QdQCVnkigOv8AsXh1Z3fAHw=
X-Gm-Gg: ASbGnct8qYJGaPHp2AcAE5HNpo8UOJS2Isl/s7DYr5w+4gdcN+5HVM/Bsq/CvmhJGpM
	+2Xj+1APf4kfozX9nYgslq9/8s1BUyTeStlU1p5Lergq7Ts8g47hJG6ooKbAF9QOS4EYCiFtAO8
	oDsmCXD/EqbEgMB/eoikinx4+qX7fl+Ze4qJfWyiCzyS7hg2qsKqOocG/R4PrVJLKJtIKqOzHwp
	+c7APpI7fOHwdVG
X-Google-Smtp-Source: AGHT+IGkssqGHiOQ1Ix4X4LVM/mrFKi71UzuiAn57mpgmWKAxZEsNsi4CQq2EqD3mHWjHn8TEFYMG/ik8JKa37wTfHs=
X-Received: by 2002:a05:6512:618d:b0:553:358e:72a8 with SMTP id
 2adb3069b0e04-55a23f46d37mr6240281e87.38.1753104907248; Mon, 21 Jul 2025
 06:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aHfd_H6c9MheDoQP@chrisdown.name> <CABBYNZJo48983SWhxcB7UzWXPeUofRCMhQ8mJjih-rJoTET3_Q@mail.gmail.com>
 <aHoCQ_RfBl5Zm4oQ@chrisdown.name> <CABBYNZJ60JUyz30u8QXvv6OO5dAu1A5-JDB_jJ=H_yR6+WYfng@mail.gmail.com>
 <aHvCA4YFoQPbFChv@chrisdown.name>
In-Reply-To: <aHvCA4YFoQPbFChv@chrisdown.name>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Jul 2025 09:34:55 -0400
X-Gm-Features: Ac12FXzhWwVi6w_dbds-BH3u0dsrMnDBPxscNZqEVcBBcILTJXYJGhhYa-Ec_w0
Message-ID: <CABBYNZKTiZ0tDGpwhnfEuTTpRX1ww3dURvXpRswpfU2byrww6A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Mask data status from LE ext adv reports
To: Chris Down <chris@chrisdown.name>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@fb.com, Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Sat, Jul 19, 2025 at 12:04=E2=80=AFPM Chris Down <chris@chrisdown.name> =
wrote:
>
> Hi Luiz,
>
> >Try to capture one of them using btmon and then add to the patch descrip=
tion.
>
> Thanks, I have one now and will add for v2.
>
> >> >> -       if (evt_type =3D=3D LE_EXT_ADV_NON_CONN_IND ||
> >> >> -           evt_type & LE_EXT_ADV_DIRECT_IND)
> >> >> +       if (pdu_type =3D=3D LE_EXT_ADV_NON_CONN_IND ||
> >> >
> >> >I'm not sure I would keep checking for  LE_EXT_ADV_NON_CONN_IND, mayb=
e
> >> >just return LE_ADV_NONCONN_IND, LE_EXT_ADV_NON_CONN_IND is not
> >> >actually a bit it is the absence of any bits being set, so I guess th=
e
> >> >only invalid adv are the ones for legacy which seem to require a bit
> >> >to be set.
> >>
> >> So are you thinking of doing this?
> >>
> >>    if (!(pdu_type & ~(LE_EXT_ADV_DIRECT_IND)))
> >>            return LE_ADV_NONCONN_IND;
> >
> >We can probably return early on if (!evt_type) return
> >LE_ADV_NONCONN_IND since there is no point in evaluating it if it is
> >zero.
>
> I guess you meant `if (!pdu_type)`? That correctly handles the 0x40 case =
(where
> pdu_type becomes 0), but it would miss non-connectable directed advertise=
ments
> (PDU type 0x04), right? Or maybe you meant something else?

Yes, we can just test for !pdu_type and return LE_ADV_NONCONN_IND
skipping any testing of bits.

--=20
Luiz Augusto von Dentz
