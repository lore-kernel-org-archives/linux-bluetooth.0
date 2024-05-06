Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B5158873
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024978; cv=none; b=EpMaNwYccIHVoMw5ujePbUtypa3FbL/ifiP3y8fOMDUmu3eLckDrykRzlZa36jBAEKkelQQPnu+xInwSxw+kKxVX9mCZ5SyiqHp1ORo6IV79o1hFFyElWwMZcknzFXd/orAa+E2qcxong9381aeCHTPPyB47hkDJrq4OOemMreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024978; c=relaxed/simple;
	bh=3hWWj+7eETFpPwlXs/4XQ4k8NBn9WBPoeQccB89C6Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rqZgm3Azjy8Hr5gNzb3mKrc3gBwAGiS0FhGBH8fr50M2pgdQezzgAj41PLuZnKbDKtmRnnzwIN8Mq37V2Jb1A3WO6IfdnzmrwI97b6z6RQG8JY/LrHoo1FQIXga3au+IAJczae/Erac0ckGVKnvTiiIFXkvpsuAIcQrlav3YF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ettn02Va; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ettn02Va"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so25901361fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2024 12:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715024974; x=1715629774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hWWj+7eETFpPwlXs/4XQ4k8NBn9WBPoeQccB89C6Iw=;
        b=Ettn02VahUBDhwyr+2wsZYkCSl03xTZEGMB0u4rrGLfAWotfX4UWew6V3p8fRg2Jsk
         Nfa9fu0Pbvd1LVunTdec/gf+1KKP/XeKthw7SLSBg3hNDWSyqEEB5L1ZXjDVSdmFaqNw
         TWH6GkMaOJDMy+a034KK0kzMRsWA1R7m0eL5Q0Lq91o4d0SJRGcJ0p7DTc6QPkfvblqN
         jDtA0DIVRrpaszF3hGv0mq4gqsWWEwwCunIQ+oX96TTCWxbtsKdP4tZSbOL5Ksvp5PN0
         FNnnXqA0ctLPUR75/x5ND/Yok/v7xI0OagZ6yquQJQOL/Bi6eb25wHmRazgUgaebrwku
         r2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024974; x=1715629774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hWWj+7eETFpPwlXs/4XQ4k8NBn9WBPoeQccB89C6Iw=;
        b=igR+p41lrSg239AKJblaQq4RpVuubVcBhTxhNL49zlT6H7guZCezFL+XXD8yDfroVd
         H4M53e4d7+73g4Ife+XNsxUzRPVePCauvKwe6LTFnMSvCcGfhLaGyq9YIptPa8RV6Fob
         2zTNhyasIuzbPftzTpYAjucL516hrSydeCbMyZDzd0bHsiOI8jCSLCT/9yg0nVWIk6p+
         de56aqlUIXDeMznVKE1C6QiI8Rm0qz1ZIA12bpT8oV9nJk1Gyhpl7QohiOmJdCo6ashE
         VShSjsju3A/l1YwAS4sZHUrocuNokT07g7qpFXe1y87MB+2bAlL7WwOevQgbJoNpZ0sG
         xUaw==
X-Gm-Message-State: AOJu0YzJjUB154G9cxuGHeF/estMFCcH8ZcXo1PBisk9Qx1by02CMrMl
	BybZz4DnHmXQwKvs4rwUR8/Ro4/JgOt4oI6cjvyxdnQnVaYFc96ZvxPA4mB6VBySk/DepQTjUti
	YouTyheDWhO+nrHt9LUOL6qJvIwJsDw==
X-Google-Smtp-Source: AGHT+IEmUGMOP/wB49ABgkRrbOpCF7mvkc7+XKNKD2Fhb1VKbmvt20a9j5Cx0fQGyn8N7wh8+gHjXEChaflmciBen0Y=
X-Received: by 2002:a2e:719:0:b0:2e3:bb5a:bef with SMTP id 25-20020a2e0719000000b002e3bb5a0befmr1009256ljh.48.1715024974317;
 Mon, 06 May 2024 12:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
In-Reply-To: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 May 2024 15:49:22 -0400
Message-ID: <CABBYNZ+FBwFtrqg1Hj72Q7_6f8hDSwVTNtkofP0XgEd98DRf9A@mail.gmail.com>
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Wren Turkal <wt@penguintechs.org>
Cc: linux-bluetooth@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wren,

On Mon, May 6, 2024 at 3:24=E2=80=AFPM Wren Turkal <wt@penguintechs.org> wr=
ote:
>
> Krzysztof,
>
> I am reaching out to you as you had the most important objections to the
> change to fix qca6390 for the warm boot/module reload bug that I am
> experiencing.
>
> For context, the problem is that the hci_uart module will send specific
> vendor specfic commands during shutdown of the hardware under most
> situations. These VSCs put the bluetooth device into a non-working state
> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
>
> Zijun's proposed fix is to not send these commands when it's not
> appropriate for the hardware. The vendor commands should be avoided when
> the hardware does not have persistent configuration or when the device
> is in setup state (indicating that is has never been setup and should
> not be sent the VSCs on the shutdown path). This is what Zijun's patch
> implements.
>
> In addition, Zijun's change removes the influence of both
> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts
> that those flags should not influence the sending of the VSCs in the
> shutdown path. If I understand KK's objections properly, this is where
> his objection is stemming from. KK, is this correct?
>
> Zijun's proposed fix can be seen here:
> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-g=
it-send-email-quic_zijuhu@quicinc.com/
>
> I'm wondering if we can resolve this impasse by splitting the change
> into two changes, as follows:
>
> 1. Change that removes the influence of the QCA_BT_OFF and HCI_RUNNING
> flags in the shutdown path.
> 2. Add the quirk from Zijun's patch that fixes my hardward configuration.
>
> I'm hoping that better clearer descriptions for #1 can help get that
> landed since the logic current appears to be at odds with how the
> hardware works.
>
> Also, I am happy to split the patches into the two patches, or (maybe
> more ideally) just modify the commit message to better indicate the
> reason the change. I just need guidance from maintainers so that
> whatever work I do leads to something acceptable for y'all.
>
> So, please help me get this done. I am just a user with broken hardware
> and a fondness for Linux. I would love to help do what's needed to get
> this fix landed.

Ive also objected to that change, in fact the whole shutdown sequence
is sort of bogus in my opinion and the driver shall really have some
means to find out what mode it is in when it reboots, regardless if
cold or warm boot, since otherwise we are in trouble if the user is
booting from another OS that doesn't do the expected shutdown
sequence.

--=20
Luiz Augusto von Dentz
