Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795446105;
	b=MzobjxgK5vYCt/ahzIZASrHwqnwTAzIEjAQRttumEg/4AvK8MFfLsigOpyUQVhTdzLdq
	 VFa7yp3BoVWJXdjB7NZOdnnM/WvDZ6PXN6HOfwIapizDcxHT7drV7gG6dqcNtsR74VG55
	 ZzAjg4akVI31PAhkOLuWCoqBeISS0ItZ6yjPJ5SJR6ObFVEDVtGfirGFZVX6oYHp5ao4P
	 pbGAAjVmGixtnYkgA8ka0gFeWakEF8DJKb4xMWszFLyMhLGUvW1H99zmAfF27Yj9EZUoe
	 +cv2jyEpTmtzlDbktKRxQXFVhrsZns9E0iUtWX/6W5R0ybh9dKOUR2Pg+X7WwNxjVRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446105;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+QESOHzzELjsrdndZtI1NBqD1FunF2g/iOduG0a1KYg=;
	b=v59A4fPBEqR/53CZgaVRHkmUyJxfAeE/Ic11T2QMnW2hqXc6ya8PyycDi7rF3ke+mrK/
	 qJVwwNharEDpi4+cbXIc7a5ZGyyfkC3DyxhCjvtrKnbC+uuqWHwCrZFtTDuu3QxTeOq3F
	 dm3a0z1h7Ye+3JbUqKbuG9JunELop0WqaGVNVNbYtnW6UIIgm6lNfcKoMvxrBK9bh/Fue
	 exfGVxsl8P+YXUEEvYr5wHLJnwklamleJIoZhv1/VPqDuawhZpgynr42gMIE+k9d3HzeG
	 rQcF8RrXtGHNV/aupovsS/4P0oW/oDVogcBJo0HEWawTnXC2jO5kgzMMo39z8oi6M9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vX7YsGhD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1D606A31A
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19B1D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vX7YsGhD
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4e04eda5aso23537897b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 07:01:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795446104; cv=none;
        d=google.com; s=arc-20260327;
        b=iVJZHPBuNdaT9cmtgKzzYuyENdKW5ycTZ/UGcszSIqVzhSxuSaQMXyyL4FvcseJyrX
         DN6QvjzJTHPCeS2Obv7fcSXPBKIKmsdYX6LpA2JCRkkHikthswxWQLq6tWRZyph9m1eZ
         hXlhyM8hFbICOtn+YNs3e6FLVTa4yumcBqROY4imNTzdVCpOYI6aZx+GXo7S8iGhMUlR
         kHqsx+wqQ142msAhZQn4IoV4w2TG/ADdJ6SbSeXFEdTzTC/xo0rpxlkNVwI+5XmQmOHN
         kN1kDMYqM2g20L6FsdOv0DqunTBCbLJ2HB7A+yz1wbkJO3NvSWSuji2usCV9fZfWT5Mo
         4JzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+QESOHzzELjsrdndZtI1NBqD1FunF2g/iOduG0a1KYg=;
        fh=XJYgDvkETP4e4OXOI39kHnN3Aa9uPpApAZWb5/OMrns=;
        b=o3Yy49uRmTFcgv77VIYYPTJ+/pXj4kioSy17scdIFyqtVd9AtWXxGYCBx3ji/AbH0D
         2JhWAgIP8KutwKC8Am5ygkqrnRRNjzKU4FAoPoIYX2cczbSNZbpwHjAC8IQTl7p55dLE
         sCGVCfpNNklMK1P7o4XIV4He+xzHgfPP5XCOXpmTgUu6/88h30JJJiiSw41dl6qY2qrL
         fmAzbwXrmlpQuANXz7qgawStbgpQqKDr7A72iUqjDnTzOk/hDeNARGLvgJ/Z4VOEM8dj
         khVc91yAT+i+N8MM/9lynS//ZggxDbB0ExopUO8WNpa1UOENI3c0FR4ndVng4GR23zuK
         WwlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446104; x=1796050904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+QESOHzzELjsrdndZtI1NBqD1FunF2g/iOduG0a1KYg=;
        b=vX7YsGhD45Tn2xUq6j9vQ9LkiQ0xwcMS6cPpp667nFRSeCuxi4zXNfIrECwvLabTiz
         aeDOHZEpYPt8Afr3/qGJQxusFoJ/gu7GqOWBNetNZXAcZqGqTICEmn+Eev4LSjhuRGlN
         kbG6Jpdlu9yKUjFTc9PNoGjlCRw14AFPRj6ADsdtFh8c1hwFKD8kBF3sZRgsqYMe/NHU
         m9cZsHVURYm5Uosv0RnWYNgVFAJ6WoRaiOueia/p2gBGPP/1QhmRTvsVG4hyZm5Ze56B
         QN077wg06ZOSjQwMEOzmrBgUNLkCb4beYYBT3T9AKUFCjB21X27WvRpsfRU3YKrOf9AY
         Se3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446104; x=1796050904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+QESOHzzELjsrdndZtI1NBqD1FunF2g/iOduG0a1KYg=;
        b=sX5HSGTZkSeLFKz1xAMGHRXnP1/vQQ1G8Z/KqzCrgK+/zsUwA4AgXTRCW4vn6uE3Qo
         PK9LkeYZwstIPSzaKEQUduihg19lm8l/U5JbHvcXf8XczG3eQjxcXpm6YWNS1ock4AcG
         4+J0IGp3NGe4fRCGv2W7GAd73O0vtH7z9hIyox7+0bQ3oSZROgyd6liwjnIWtv/eg1V7
         S2WBoTQ/iUA0Mzmd9hZDNA74DBvaAXu2sr4JNNuY6h7zbkd7pGHLwom0fPHUXyE9YHO+
         rVVVJC33HwSUP5XVJzC8NMdouXDSmIhYO2Wxl+SVw50E1YS6TWaj6cofp3c5Lnvewmh4
         5PjQ==
X-Gm-Message-State: APuU4Z/T4k/dDGArRrEL/rFCP6hVAcu4leQaD81XId042EQe0CS/n67U
	QqsjFAzQGj3UVbP3p0SGeGdmD1m21MJBqka4lCSme1t7yopv4l50A7iEUqgSGZlTr2j/QZizprR
	vcZuoR53/pQ/buIGcLY8KQMgiLZo1p5BAJWTG
X-Gm-Gg: AZFdTZc0SDfib+UofpxSw9OKBvO0p4w56PcB/68gXQUk6/DhElBkWvsireJfa3V0NPN
	dqyZeaZkZB5c9owtIzyznum8QGy3XQkkm+57gLQxwZ0OljYgxyVhajSN8AUT71AN5S5AtT2zeh3
	zobFophFwkouJiU3Wd19ggK8r3t7GnMpwqTZEzFDJ4JURhYN9GqWSnV97cgFTvD8z585gJkBQW0
	nqAj9t840wyN9wqiXsOnJVuG+kcS9NUK3P4hAGBj+AeEHKSDcPhxJC78DxKJqqojPG835lKX5h9
	7v7nGsYDvkmpu40h+3RkL65NzGOaV9MWBy/BdJ02flYzKwpU+WlNkntOio533CROiv1LyrFtgxD
	8hAh8NY41rIyTosrEx0xZuPDaGwv9JjUrdXSfYGqhUg32ZTelzJ8ePXh/guHstpCV6Uy/hoXJn2
	gtgpQs3dIeXoRZoVanWL431NGxe1SeAIJLobj9s3m4ttAaO8AJrAG3QNu5
X-Received: by 2002:a05:690e:47a0:20b0:671:70d2:5284 with SMTP id
 956f58d0204a3-67df4463f33mr3553044d50.71.1795446103647; Mon, 23 Nov 2026
 07:01:43 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com> <6b037d71.59d373f3.3ce46b.9ab4@mx.google.com>
In-Reply-To: <6b037d71.59d373f3.3ce46b.9ab4@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 10:01:32 -0500
X-Gm-Features: Aa3M54pWHjel0JnlDgQDEJgdhkwBBuKuIkWF3pUbO_EX9P-ZL9HGXzUZgMbogn8
Message-ID: <CABBYNZLXaa1DHnuozEEH-OO4F6Zjohtz=tTNa1nj-cmpTDW6yA@mail.gmail.com>
Subject: Re: [BlueZ,v2,1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
To: linux-bluetooth@vger.kernel.org
Cc: simon.mikuda@streamunlimited.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Sun, Nov 22, 2026 at 6:41=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1218934/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.89 seconds
> GitLint                       PASS      0.67 seconds
> BuildEll                      PASS      13.71 seconds
> BluezMake                     PASS      207.89 seconds
> MakeCheck                     PASS      12.85 seconds
> MakeDistcheck                 PASS      106.71 seconds
> CheckValgrind                 PASS      254.73 seconds
> CheckSmatch                   WARNING   183.83 seconds
> bluezmakeextell               PASS      66.09 seconds
> TestFunctional                FAIL      964.96 seconds
> IncrementalBuild              PASS      235.19 seconds
> ScanBuild                     PASS      718.77 seconds
>
> Details
> ##############################
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/=
bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of =
flexible structuressrc/shared/bap.c:317:25: warning: array of flexible stru=
cturessrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: w=
arning: array of flexible structuressrc/shared/bap.c:317:25: warning: array=
 of flexible structuressrc/shared/bap.c: note: in included file:./src/share=
d/ascs.h:88:25: warning: array of flexible structures
> ##############################
> Test: TestFunctional - FAIL
> Desc: Run test-functional
> Output:
> FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts1=
1-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed
>
>
> https://github.com/bluez/bluez/pull/2878

Copilot flagged a problem with these changes:

https://github.com/bluez/bluez/pull/2878#pullrequestreview-6023408098

--=20
Luiz Augusto von Dentz
