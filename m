Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5C7494;
	Thu, 19 Dec 2024 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634886; cv=none; b=FQn2DJtKIekjm9ZCqWHkQEMfWwF5Fkz2q3KU9wmCRaUCqxkt2mKDoF/lnIyslu0xsLYEUUEbVGSTvmEQYtTNh/P5S3XkgRWptdmXkfWBd45VZ1cAkKxtr1z5gV2Yi0vTDjHZyp8k6jpAx9mnn0dutWxBSvQqzpcG2XZ2hgKwDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634886; c=relaxed/simple;
	bh=b0+gv3uyTV+HosiffGvaIVPnh0kk6aGQ66cZGpzjL7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHbsZ54yFfG2lQ7QhuwuUQw2q9HZW3MKYrJIWNOSUoq+S6qCtMXCWiM5Ft7U9yZcdWVTFPap5Z5TinLhpUrK91c30mdQg9kzTryFUoWF5GqJJHn/bb0f4cSTUnm7DyeKxwvfPPbWto8PhSycrE9aw8dTHOC2Eh7Y+t43LkUIwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byTArJB0; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byTArJB0"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30167f4c1deso11152031fa.1;
        Thu, 19 Dec 2024 11:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734634877; x=1735239677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGHTyRr+NEqJSmsLQoRsQQ0M1PdzWmBL0dwj3KFEFOA=;
        b=byTArJB0D4T+lBDYPvf04B8T0dMvFnm/bvxMJzsZUfsM2w1T+RMaKjaENCB+7LJhvM
         ZofhfoOtfex4JLCQf7AyKma4bkEUo6mAuSlRhfl9lczbEVKAo9QzY5ROvguMjtaCLYa6
         VGCCh2wudFSpG4bZRvYphTLGXY5nB2UD7f/xT5NS9aCgjrn2TK37Va7N6jzaAPA46qlS
         SmqGW8SARnG3EhkQhGcS1AdpSjEhIpyGM5wIfIMA4r8PFVvLojvQVS3nbq24fOHX259z
         DyXOwss9l0jLRAW4mfDKzty0b27OxukP5o94ZmwSISbs7PGvcvqPzrI245N+YzdzQQxX
         1c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734634877; x=1735239677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGHTyRr+NEqJSmsLQoRsQQ0M1PdzWmBL0dwj3KFEFOA=;
        b=VPE+rC8/q5NrWwGpkz0/wo7rukF0/yxtN2HMlb/m/nkgSPbHmehBCmaX0caYBjhKa5
         4Zxhe1r784ehTh/MuF0SEUM+TUzH9NUD0wp3VxfEiIKMZJNExCxutPE0+d8kczqNgHrX
         uZeuKo7gD6iFjsVMhMTgTkO335MjRZ5V1XT0LyXDJbLckKw0XtcBU1tcul/uXYRn2/Am
         SFKQJiTluc33GtKCu+gC3c3WC0D6mBkOl73ELkOBrkBHIKkqLZZ5Vfh1YlV9SCJ7s7AC
         H9XIs5IYAqz60VIYzBrfQMk60XUa5dW+Nt3wzUbmLTO2TE16ivV3B8EHYabQOD1G5vHW
         BxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeQ9opNUS/d8MuU7Op7qhiYpfhooGX+WfigJpf+pn9hg4gzFzr6W/tB4fnJTI9iGtUDEqBWVLOtGxf9Ib5@vger.kernel.org, AJvYcCVSdY+4220I2Pk+HwSXc2zIw7TcBm+FyrvvrZzWS3tiJlbiDledy1S1HEBoNjA3MbbNnQ15OBZfTYAxpSA60EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoJgmwPBCrdGf9Ki/W9hYBH4cCxJGN8rPN3JjUCqOdwSuD9J+
	rBv0tAB0vIdtgmqDETsggONWSXcYF37jYsM4HkqtiUsoXnxa3Oaw9DEC67eSV+EVEvJDWqwJWvU
	Mhp023C15NJPxUYaRgY/dVOHs7xY=
X-Gm-Gg: ASbGncu/3F+XBeB/lI9kHPNs2/bBUwzYq1GJHyVHD1Jlomi1860kWsuL3LHqt7L9syy
	ivAG6EZ+qpdJJhy71tTVrKs7YXhWeBPk9KGrWzPk=
X-Google-Smtp-Source: AGHT+IGtbrC8/XD7gxUIBX5lD9OI40y8fVDtukJ8JmQ6CQbSDa4Zp0CnfE7zYNCdR2UzvgrwosulvSLloWfbIBLmabM=
X-Received: by 2002:a2e:be8a:0:b0:300:3a15:8f22 with SMTP id
 38308e7fff4ca-30468593419mr610981fa.21.1734634877179; Thu, 19 Dec 2024
 11:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d159c57f-8490-4c26-79da-6ad3612c4a14@salutedevices.com> <4ef9c3a9-a8c4-fb98-2244-ed2770f71c17@salutedevices.com>
In-Reply-To: <4ef9c3a9-a8c4-fb98-2244-ed2770f71c17@salutedevices.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Dec 2024 14:01:05 -0500
Message-ID: <CABBYNZKXJAvOQie37yCgNUTct2HXzPYNNqNN5Am+pGViGe1=Gw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_uart: fix race during initialization
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, oxffffaa@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arseniy,

On Thu, Dec 19, 2024 at 1:42=E2=80=AFPM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi, sorry i'm new in bluetooth subsystem. I get the following
> message from CI:
> https://patchwork.kernel.org/project/bluetooth/list/?series=3D918554
> Where one of tests was failed. Where I can get more information
> about failure:
>
> tedd_an/TestRunner_mgmt-tester  fail    TestRunner_mgmt-tester: Total: 49=
0, Passed: 483 (98.6%), Failed: 3, Not Run: 4

These looks like a false positives, your changes should affect the
tests since that run with hci_vhci driver, not the uart ones.

> ?
>
> Thanks
>
> On 17.12.2024 11:12, Arseniy Krasnov wrote:
> > 'hci_register_dev()' calls power up function, which is executed by
> > kworker - 'hci_power_on()'. This function does access to bluetooth chip
> > using callbacks from 'hci_ldisc.c', for example 'hci_uart_send_frame()'=
.
> > Now 'hci_uart_send_frame()' checks 'HCI_UART_PROTO_READY' bit set, and
> > if not - it fails. Problem is that 'HCI_UART_PROTO_READY' is set after
> > 'hci_register_dev()', and there is tiny chance that 'hci_power_on()' wi=
ll
> > be executed before setting this bit. In that case HCI init logic fails.
> >
> > Patch moves setting of 'HCI_UART_PROTO_READY' before calling function
> > 'hci_uart_register_dev()'.
> >
> > Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> > ---
> >  Changelog v1->v2:
> >  * Move 'set_bit()' before 'hci_uart_register_dev()' instead of
> >    adding new bit 'HCI_UART_PROTO_INIT'.
> >
> >  drivers/bluetooth/hci_ldisc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldis=
c.c
> > index 30192bb083549..07b9aa09bbe2e 100644
> > --- a/drivers/bluetooth/hci_ldisc.c
> > +++ b/drivers/bluetooth/hci_ldisc.c
> > @@ -704,12 +704,13 @@ static int hci_uart_set_proto(struct hci_uart *hu=
, int id)
> >
> >       hu->proto =3D p;
> >
> > +     set_bit(HCI_UART_PROTO_READY, &hu->flags);
> > +
> >       err =3D hci_uart_register_dev(hu);
> >       if (err) {
> >               return err;
> >       }
> >
> > -     set_bit(HCI_UART_PROTO_READY, &hu->flags);
> >       return 0;
> >  }
> >



--=20
Luiz Augusto von Dentz
