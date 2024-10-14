Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBF64A24
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 01:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728868855; cv=none; b=O8xl8ZqAYnrTGrsS7ZYq9as+Ri83MmfBuNYHKydssoHkoub1K+RZyQHj3CK+amg8xbPwQw7SE597dI7NxpzydPJCnB18sqWnSLMROkvFCNYdPublLiRD9kIvQaHDrOKPKw4RGu7Tu7EwgGmg8YkAWk6+jrUanEznCmMSyzuwWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728868855; c=relaxed/simple;
	bh=XlGanDNPXYXzHscGM9Y/ZeFm388Gr/6sDbKfuEcp86M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAVhPmDTuzJToCupzMZDkB4KzLCbALDrPDDhbrB111ITW07yEPv1XH4JgbckkebHhd3LqIHhcwHVG/UQ1vQrGb9Zq37z5DnKCRe5mKNOopBRE2mNAXaWNhNEr/utajadQGQ0WeIRK614i21VpKb2ddqmtCnC/3ANHiSvR39TIyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqYM+9ay; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqYM+9ay"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso5081311fa.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 18:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728868852; x=1729473652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC/qXYO1BIIROI/3fm3cta6oH+jygr1MsDTGNpe5RYs=;
        b=SqYM+9ayidBiflcS2o456luQW8mK027YbAR9NwMSqe9aKqDOVnCaaYhLuplfLiIDa4
         /gjJyd7hK2LysqDeaQXrz6Y0S+3YyDRj4cThtg98qhddseFy8O6UzSyA8yjzCaRN5vIJ
         TwQebNGxWoFx0qz3RcDQ8OtzAthQ/eL8zTTOHcsWUvmlHj1MEHp791C/rkD48VM34/gm
         SBccjeKR2LTw4RDWQToOGqwbLyD36jOX66HFgoH0RkEf+grkJ+6SlaE5LE4MdiexnHDq
         xmKfpuPKlRBIKCysdAWpdm6OpJJBi3KWxdfqxCgp8es9GUWFd66wAq/2Le0D6NBeg9UP
         fluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728868852; x=1729473652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC/qXYO1BIIROI/3fm3cta6oH+jygr1MsDTGNpe5RYs=;
        b=SvaWDLJV6LoeKccqq7plgJpLLRuxCcuiygdzVMmTP1LeeAQPUS4sOL/bu3BhmGV75N
         cpDh/q9hoeswSLHwRhTMW7AD8osMQlY5fVF4uQfo9f0Ze7gEKiv/QO44mfdbVeIQJFrp
         VR1QpVZSCJ/4pV3NPS4D96YLTVF4TDFJq8JXObnf2vzLloBQKiGNjmPmgPO0aoxesfH+
         saq1XRdCWkd66BSVKfc93UIXvzlVdWja0X2LI5vA5/HqX7LXIU7YbZBD6/XvAdj/4Y6i
         M7pthM8AGsGxcEC3OcTAri8dUxaAywCB86akCEgB1cdQySFcKkCExYCIes8ZA6o+M5DE
         vOXg==
X-Gm-Message-State: AOJu0YxusNvk6/+7/qMV1bSZV0BQFApJdMaB6+LidEqsCZXnHPtGIDbe
	siB6aSjx0msvJYfmB5CsOOxiFLnJRrlaw/pd5k/7b+J5XcynHvRnUDudWT6GH2GkBO5f9DlAy3Z
	/r6mhb3tOZ3SwmOwRpNX04tNZEuQ=
X-Google-Smtp-Source: AGHT+IFadJQGDR4rNOUmDqs5gy1DGK+MhkvMxBnu8T640hCviWxtNGaxCaoJNrdnW3fotoa+ryQDwKbECRFQ6OjTjHk=
X-Received: by 2002:a2e:be23:0:b0:2fa:fdd1:be23 with SMTP id
 38308e7fff4ca-2fb3f2c7269mr21736721fa.28.1728868851521; Sun, 13 Oct 2024
 18:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410131540.49DFer5C020925@randytool.net>
In-Reply-To: <202410131540.49DFer5C020925@randytool.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 13 Oct 2024 21:20:29 -0400
Message-ID: <CABBYNZK9W64viuGnvQRtgfwTiOCdZXYVrnUOTN_UMEu0tN96BA@mail.gmail.com>
Subject: Re: src/plugin.c:init_plugin() System does not support ccp plugin
To: rbell@alumni.caltech.edu
Cc: "The excellent bluez mailing list!!" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 13, 2024 at 11:41=E2=80=AFAM <rbell@alumni.caltech.edu> wrote:
>
>         bluetooth stopped recognizing any of my controllers Saturday
> morning.  (They work on a different computer.)  I get:
>
>         Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: CSR: Unbranded =
CSR clone detected; adding workarounds and force-suspending once...
>         Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: CSR: Couldn't s=
uspend the device for our Barrot 8041a02 receive-issue workaround
>         Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: HCI Delete Stor=
ed Link Key command is advertised, but not supported.
>         Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: HCI Read Defaul=
t Erroneous Data Reporting command is advertised, but not supported.
>         Oct 11 09:59:12 mydomain kernel: Bluetooth: hci0: HCI Set Event F=
ilter command not supported.
>         Oct 11 09:59:15 mydomain kernel: Bluetooth: hci0: Opcode 0x1004 f=
ailed: -110
>         Oct 11 09:59:15 mydomain kernel: Bluetooth: hci0: command 0x1004 =
tx timeout
>         Oct 11 09:59:25 mydomain bluetoothd[30412]: src/plugin.c:init_plu=
gin() System does not support ccp plugin
>         Oct 11 09:59:36 mydomain kernel: Bluetooth: hci0: CSR: Local vers=
ion failed (-110)

Probably related to: https://bugzilla.kernel.org/show_bug.cgi?id=3D219365

>
>         What does the ccp plugin do?  What support could it be missing?

Not really related, ccp is experimental and requires hardware support
which old CSR dongles don't have.

>         Thanks for your attention.
>
> russell bell
>


--=20
Luiz Augusto von Dentz
