Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD917F5
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537069; cv=none; b=UxgHM7eI+kPwMUVH/MPyzeJos19y/OPOSc+qbiVcts4dF7H4s129biiRUdqFZ18v4wWfqC08utNYVK//VHqLBuyomf/EFcxxFMvBfto2UW+d1NT5arrGo99C0rwcMw2jIDdKDawrMjX30cmM4zJdZsf14L1/wDjlJgrAnQsWqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537069; c=relaxed/simple;
	bh=vmVrJTM05U1UNR8w2msyFi3Sc8aecWnQlR0EDkMd/M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwpawDXI6PxJ5VpzdgRXg78fltL3mkUb2jmSjEXg+m4OjsmF0LMO9qRNWpC4b+bifOdHE9wrje534+hbai2EXC/uPepH+KaE5dCJUf5hilQLtMuHjQltOsBlivsiZ1w1+QTkirb1l9oQq9rUmzmb3VYUvHNmqu2nSUeW9uLneVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH+bVP6K; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH+bVP6K"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d28387db09so35197511fa.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710537065; x=1711141865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeHcUIY5/RBgR37oAK6rtiMgtON6wL4RtufL5DorhXY=;
        b=BH+bVP6KB9JxCJOlYgZTZKDpHgwlK1hG9P+Ly0JtXNJaZtgujMyDnGov9WJPmuyn/R
         jcIngmjfUf4K3PFSfgGzLpHTIToW8rzUHSnboqh62q8eJB7f0bNbH1DIKtFxX2E4fV9U
         LtARHE5Q7qoNEvnXrWmiJhBUQsqyazHSo3riYRfE+LM3DTZsWAwJSoWO6gXWGB7fdKWy
         sQ7JPUu4ntFnQlC5BXkLCd+5odNhGwYW1v1dKBNZC/wn38F1+DCZ1oHnJjj+scDWKtkC
         MkTK3fwGLtSHDOgDlxmOcrtYsqRzUBBjSOP6BH+sauru4WDx4Kuf10kqdPx5FDCpUJN1
         0JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710537065; x=1711141865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeHcUIY5/RBgR37oAK6rtiMgtON6wL4RtufL5DorhXY=;
        b=Dk6Yc1lbIxeI7Gj/9JYGw9ac3y8QaZ7q2EJhwdF3XB5vRBcOMO+G6ZJxuw4nyQg3wH
         70kybId+X9K9aW8TZzCEBBmOFcDq8p4DNFbGg+VeDfdI8MzRQUxJzid6WJQpkWyZ4U6w
         y4E8BmzXawWBXmGGj+69ZG4XGs6b3LoHXdHSmZ5QkiA8wK6C5ZPLcCmokIMMW/QKFDvq
         zcxwtANmtij5WeTBwb3UYaDN8xrQL6BCW+WK6CS6A8QDTKAfqUQwObRHBkqxyhBoS5s+
         2WcCjHJotupsQi+9jINC1ZQh/3q6n+gqhqf0HxG7Ux7ArFOmS1sacXO1PDE6DMV2j0hj
         sRnA==
X-Gm-Message-State: AOJu0Yyw9A5cYKgS2xm8oRuYncZl5+4NdpelQLJC4FtpQuvPrNcKTvbx
	+SViajXNpw5ABYgPMuIc+VWhqz4TOSIIYPzJakJEE/Q63rZBOGR18CBrVwKbk3F3grKTTpDHpY2
	ThzuheAwE9aNPKkgOyS7PtgrwrBtoVBHUydY=
X-Google-Smtp-Source: AGHT+IEMBnAV5QDB3G/j/bnbwmygldIjerPA8UbYaAfeZFJjIBLOtCyoYaEH6VhA+0mCK/QFwtykWsNAE4B/fI5mA68=
X-Received: by 2002:a2e:9581:0:b0:2d4:3dfc:af88 with SMTP id
 w1-20020a2e9581000000b002d43dfcaf88mr2613839ljh.7.1710537064290; Fri, 15 Mar
 2024 14:11:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR14MB530075545340A73BC4BA353EFB282@PH7PR14MB5300.namprd14.prod.outlook.com>
 <CABBYNZKNq=8OUjDRBRhiVGrC216af3NHgdMGHynwiNZoMyD=Cw@mail.gmail.com> <PH7PR14MB5300C5E6F45A73CCFC0BB96DFB282@PH7PR14MB5300.namprd14.prod.outlook.com>
In-Reply-To: <PH7PR14MB5300C5E6F45A73CCFC0BB96DFB282@PH7PR14MB5300.namprd14.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Mar 2024 17:10:51 -0400
Message-ID: <CABBYNZJEHQK5VGQ1p934UAp6nx+mGyV8KTwzvAaiXp19niuyRg@mail.gmail.com>
Subject: Re: Bluetoothctl Fail when typing power on
To: Chris Laplante <Chris.Laplante@lairdconnect.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Fri, Mar 15, 2024 at 4:07=E2=80=AFPM Chris Laplante
<Chris.Laplante@lairdconnect.com> wrote:
>
> Hi Luiz,
>
> Thanks for the quick response.
>
> I am using btattach.
>
> Btmon shows Bluetooth failed to set mode: Failed
>
> It seems like there is a lot of messaging going on so communication HW wi=
se appears ok.

Just scroll down to the end:

< HCI Command: Reset (0x03|0x0003) plen 0                  #83 [hci0] 37.50=
5694
> HCI Event: Hardware Error (0x10) plen 1                  #84 [hci0] 37.50=
7119
        Code: 0x00

Btw, it might be a good idea to attempt with a newer kernel since 5.15
is not that new compared to BlueZ 5.65, so you may run into
incompatibilities depending on what you want to do, and if you are
looking into central+peripheral that landed after 5.15 was released.


> Chris
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Friday, March 15, 2024 3:48 PM
> To: Chris Laplante <Chris.Laplante@lairdconnect.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: Bluetoothctl Fail when typing power on
>
> EXTERNAL EMAIL: Be careful with attachments and links.
>
> Hi Chris,
>
> On Fri, Mar 15, 2024 at 3:40=E2=80=AFPM Chris Laplante <Chris.Laplante@la=
irdconnect.com> wrote:
> >
> > In BlueZ 5.65 I am able to attach. When I go into bluetoothctl I can se=
e my device address. When I type power on I see the following error:
> >
> > Failed to set power on: org.bluez.Error.Failed
> >
> > I have found a few threads online where people had the same issue but t=
here doesn't seem to be any common denominator.
> >
> > I have tried rfkill list and nothing is blocked. Regardless I still typ=
e rfkill unblock Bluetooth but I still get the error.
> >
> > I have tried to stop and start the Bluetooth service.
> >
> > systemctl stop bluetooth.service
> > systemctl start bluetooth.service
> >
> > IS there something in the build environment that may be missing? Any su=
ggestions?
>
> Well if it can't be powered then there is something wrong at kernel level=
, does btmon show anything? Are you using btattach to set it up?
>
> > Thanks!
> > Chris
> > THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE
> > AND IS INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE
> > INTENDED RECIPIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS
> > WRITTEN PERMISSION OF EZURIO
> >
>
>
> --
> Luiz Augusto von Dentz
> THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE AND=
 IS INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE INTENDED RE=
CIPIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS WRITTEN PERMISSIO=
N OF EZURIO



--=20
Luiz Augusto von Dentz
