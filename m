Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A51E480
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863102; cv=none; b=ot20UGz4nZaunX5dCzcZW+tlkDumSND1IAldrUovof1M1JR7o4DJT0/MaqE0Z6ZE2KWyM8lO6SEsBPvBnA4/PkRUSc3BFtPjO0Szzr0W6yh6kAW/1BD40iPNrTMmMF+1Xy7z1AI2DeRH6NFS0qC+8Yv/9zHXsX4AX1qvCJBZHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863102; c=relaxed/simple;
	bh=Zb7R2igeCp9i5EpvZYRzDwvBvhaaxF8fI+yUB3eruZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc0/mLw7SErzduP/Ij3XVgfDZwK2lkJwUraLv9CPh0AQZnlLfrxjwzLdsNsEVyofVRrvaFAa/uRZobbR08KwZP1vXIG7yR49q0So8LfDhPXFiqi/VZdeZtrj9tyixP0zBwmgYqToKCY5WG20GZ/QQRZs297mZrTKvvgwdel26GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SODWkqBj; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SODWkqBj"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso120297681fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2024 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722863099; x=1723467899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zb7R2igeCp9i5EpvZYRzDwvBvhaaxF8fI+yUB3eruZk=;
        b=SODWkqBjp2fwqVp5D1n5OZCDILYo+NsuwAFsCOQ/T/HrImfY1ywRlwxxevVUtSAMrP
         y8H0nWxj1tCOq9Z+WLAJcyss/PYRGXCxz/MfXFyIvGCBl6lbz9yNYmmqJztSnLd6IoG3
         TJ0a2a+mu+VG//WxsfBN583m64p4RHXuHsz2Q92B307SWD3eYtLMqgmviOQYXq+finYS
         lbNfuWJFXYog0xg+r6Xo0RjE4zDRokUMazUe52XauJuhzzlvbnr3S17u1OXmpwzUPFxu
         sIPiuoMQobjlBtEv9S/gXzGSGCGHDrfc9dvR14xSknAfLnvQTFP9N4AGgJR9WUDJ2CbN
         f31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722863099; x=1723467899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zb7R2igeCp9i5EpvZYRzDwvBvhaaxF8fI+yUB3eruZk=;
        b=TJl9v9/LY7nTgOiojafQAbnBWhfIynaoZ3RmLQau6sSE4NaQ9L5eH9Pa7Jcz9z26y7
         wY7dDdlagTPjjzr6pP7L+FTRHVZt886aF7bWc3efXMTN66APnSrAagzZ0o4aH/Rec2ov
         DMjk8B0jsrd9dfAQIhy0u2zDV0IjBiwmytQQbgt3d4k1hDTq3PllS+XLbRD8kYmpGD3J
         KYG8Z+lmABhXAvjXEnpz87b5ufUeuUV9nbqJR8GD12qFglqSSI7HVpqqlKXfEZ/+hsiX
         jhrcMyyNj7WeD24zailJV9qWUBR3lgxCrf8v2EtCbdcG/SxW2MdVEoFmE7v6o1r80vKB
         26VA==
X-Gm-Message-State: AOJu0YxFzBAP8Ve7d8m+GqHmBGszk52Bj0WDjaZ+3FH+jBZ7vGPrDr3d
	TRNa/GYrl2e8xCG+V0S1PS7VoFQ1CjF5GFIm/EqYb0gqYm6wlvSMwXikCC62LY4Cvp2PG513U7/
	Sf2WwACvkdI4bO04yKFMErlLa+Z4=
X-Google-Smtp-Source: AGHT+IGJnWR03wJlBNo2KFNvKlcMq+9B7OmBm+XX1Ujkgc3rgwQD5zondQr0rcUof3nqqt4lBpr+y3xdWDMMckqKKLM=
X-Received: by 2002:a2e:96ca:0:b0:2ef:2fcc:c9fb with SMTP id
 38308e7fff4ca-2f15aafdb0dmr78897651fa.36.1722863098671; Mon, 05 Aug 2024
 06:04:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GVXPR02MB8256E67B738C97EC57D1FA0F9CBE2@GVXPR02MB8256.eurprd02.prod.outlook.com>
In-Reply-To: <GVXPR02MB8256E67B738C97EC57D1FA0F9CBE2@GVXPR02MB8256.eurprd02.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 5 Aug 2024 09:04:46 -0400
Message-ID: <CABBYNZ+HwmhFhUZsSnhW1KU-cXQhHKGt3xJeCX1sxt6xyBBnHw@mail.gmail.com>
Subject: Re: GATT characteristic for only LE or BR/EDR
To: Alexander Ganslandt <Alexander.Ganslandt@axis.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Mon, Aug 5, 2024 at 8:31=E2=80=AFAM Alexander Ganslandt
<Alexander.Ganslandt@axis.com> wrote:
>
> Hello!
>
> I found a previous discussion about this here: https://lore.kernel.org/al=
l/59CDEBDF.3090200@digi.com/t/, but there was no conclusion. Now I'm having=
 the same issue 7 years later :)
>
> I'm trying to pass BT SIG tests but fail on two test cases: GATT/SR/GAR/B=
I-34-C and GATT/SR/GAR/BI-35-C. To my understanding, in order to pass these=
 tests, you need to register a GATT characteristic that is readable only th=
rough LE or BR/EDR, but not both at the same time. However, when I register=
 a service+characteristic through bluetoothctl, it is automatically registe=
red for both LE and BR/EDR. To verify this, I use gatttool with and without=
 "-p 31" to connect over BR/EDR and LE respectively, and the characteristic=
 shows up in both. Based on the previous discussion, and based on reading t=
he BlueZ API, there doesn't seem to be a way to only support ONE transport =
for a characteristic? Is this conclusion correct?

You can detect what bearer it is connected via:

bluez/doc/org.bluez.GattCharacteristic.rst at master =C2=B7 bluez/bluez =C2=
=B7 GitHub

Looks like we are missing one of the options is link which can be
either LE or BR/EDR:

bluez/src/gatt-database.c at master =C2=B7 bluez/bluez =C2=B7 GitHub

> If so, how can one pass these BT SIG tests? In the previous thread I link=
ed, the "solution" seemed to be to write an application that simply rejects=
 the read request for a certain transport, but this seems like more of a ha=
ck than a solution to me. Is there any other solution?
>
> Very thankful for any thoughts!
>
> Best regards,
> Alexander



--=20
Luiz Augusto von Dentz
