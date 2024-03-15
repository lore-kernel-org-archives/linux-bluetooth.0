Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F2753381
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532068; cv=none; b=BYcrOo3Amnz1YtzSTfHMaSwa4AIn//u1ad2jDGBvdCdJtgTFMf1b/eQ5K3CyA05m4cP+NixeQtoJj2ySpPh6xDMvIpzWJK3kzUSptcw7f1z7sGl9ZNDC5fu5nTd9nqHC7KPYo8BuWVpvHwFSiKn4PQpMRalpFjgO1Oik9Oz8tdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532068; c=relaxed/simple;
	bh=sldx7w4YO3hSujTNsC1VQZXNzYHcS16XWet/87ILlnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcB5hP0ewcYtE1peoYFm8Ct568Vc3W63MjMGNAxzi39WC0Ad+bvMho9SkgVGrpSeM2OXUjzGvRvguS/1Xmiuhp4cDHUl4/NQic4qR4pb/E06eQHKv28p/ucFAXhk2EvKBdNQiFXbVn0O35evdZ5pkXK3tA7YNqGq1jLpLcjVdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC+KMQNT; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC+KMQNT"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d288bac3caso31228431fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710532063; x=1711136863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sldx7w4YO3hSujTNsC1VQZXNzYHcS16XWet/87ILlnk=;
        b=LC+KMQNTtxnjJon9IPF41Fbld9EUskxGCajge1XGpKYYMWYWhW+m+8c6kaUj7So+y4
         A0pjphn5neXDE18kXTA9Zjjc36wE2ylbbBF7dCIA9+MXkRVHSlQcYC5vcnbi7meQQW+b
         KZkjyTzzuvmR0Up28nFclEv5OonxhA7AYt/7ygOi992YTUVyzLoOWTMMmRAqsLMrA4jB
         E+OrvQ16JY/yuokDvAosFIN8h83MdWFY9oEiYcy43zdmStlIyNymjAVrgMox053rsuJx
         L00PPnB6E0j1IGVeissOWcyKD/TK/ipE6BRyzB7FRW41NKX0u3C2rXRu4DbLus50WoHA
         N9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710532063; x=1711136863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sldx7w4YO3hSujTNsC1VQZXNzYHcS16XWet/87ILlnk=;
        b=d1ri31Kb4wqV6ZyGSNaVTR2QAZju7Fl9hripIgAxQNikgOesfFliPbOUn0UqPhM0W2
         94rTv0qjCBaHjRKu0EkB4CS/zo77xM0uNnbvB2ThwmItSoSrfyB0QDP7rNxMJSY2+ZEr
         wrZo7YLZZ0xoeliIsc7v5iDXJ84IYTSybTWj8n1iNUoVpmYFBcQA0LF+5ZbjKSkhLt2X
         eQTX9dZwxi4B8nDK94JiTtPJmdI/nRVflDDcI5m1aaIOivkfndJkCaV71OdFNNxY2dTI
         zcJoiPQ+tTY/IcDtx6gLlnDw71cuQry0Dmttkr19dbwCJsiGLd9gsMdYPLWPglDhiIOm
         R1NQ==
X-Gm-Message-State: AOJu0YzEvifVkFk/p4po/SXeA1Bf/IrK1BRpkKbkrfz1jX2yUMZL1jaH
	TnshfxZ0ce5G2M9ZdP9R/dpwkMq8L+4KVclhwaOvJxUq4iWP8XeH6zLCIUe0+0UScTvEKk63RMy
	FKf4kNC96fs6Zwlm9jFbon9n9bf3kEn2C
X-Google-Smtp-Source: AGHT+IFCWBSaemXFSgHTtr771f55krWfaZ8R+3reLxQeEYtwuoZYi6uxKvV/rAjf2sAhHgBKeWBOrAfQIEOWHxENkcU=
X-Received: by 2002:a2e:7c02:0:b0:2d4:2958:6daf with SMTP id
 x2-20020a2e7c02000000b002d429586dafmr4025177ljc.20.1710532063073; Fri, 15 Mar
 2024 12:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR14MB530075545340A73BC4BA353EFB282@PH7PR14MB5300.namprd14.prod.outlook.com>
In-Reply-To: <PH7PR14MB530075545340A73BC4BA353EFB282@PH7PR14MB5300.namprd14.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 Mar 2024 15:47:30 -0400
Message-ID: <CABBYNZKNq=8OUjDRBRhiVGrC216af3NHgdMGHynwiNZoMyD=Cw@mail.gmail.com>
Subject: Re: Bluetoothctl Fail when typing power on
To: Chris Laplante <Chris.Laplante@lairdconnect.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Fri, Mar 15, 2024 at 3:40=E2=80=AFPM Chris Laplante
<Chris.Laplante@lairdconnect.com> wrote:
>
> In BlueZ 5.65 I am able to attach. When I go into bluetoothctl I can see =
my device address. When I type power on I see the following error:
>
> Failed to set power on: org.bluez.Error.Failed
>
> I have found a few threads online where people had the same issue but the=
re doesn't seem to be any common denominator.
>
> I have tried rfkill list and nothing is blocked. Regardless I still type =
rfkill unblock Bluetooth but I still get the error.
>
> I have tried to stop and start the Bluetooth service.
>
> systemctl stop bluetooth.service
> systemctl start bluetooth.service
>
> IS there something in the build environment that may be missing? Any sugg=
estions?

Well if it can't be powered then there is something wrong at kernel
level, does btmon show anything? Are you using btattach to set it up?

> Thanks!
> Chris
> THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE AND=
 IS INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE INTENDED RE=
CIPIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS WRITTEN PERMISSIO=
N OF EZURIO
>


--=20
Luiz Augusto von Dentz
