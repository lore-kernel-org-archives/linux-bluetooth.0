Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CF250E2
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Feb 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707074340; cv=none; b=JY2XavuNhBgkmNy77y50JV+y9Y0JjxKXa3reVA1tCOSpotJPAZq/dzsBOjXdVP1ypR25MWMSWBdswx5xJMAtUsvbZV9PoUNkJ8mM6yeeSwSWJdS2g6ytk7lXze1k31KJX9rHZPbnqcsNISd5GUnOWfwhpua/Ngp41E/CvErlyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707074340; c=relaxed/simple;
	bh=U7fuHKCS7P0gibNRuhCi/+lWNbl//hi+bf2tD9GrdHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uEO5j7K2ghBGEyF+3R/Ioj4x4Q3/BkTgPEQfDCz3DShE5KGXRaazWCnWJmBTA4F0CLd+W8XymOLQ/k7dlqimRZwmDSG1tM2W6+ONP9ODzc9lMagxlEcLXJFxXpkyDmGtAft/2OSExJca6494PT6y4FeTjwhZn67Et8E7gsRdFto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OoyrtVtH; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OoyrtVtH"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bfd0e99154so169776939f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Feb 2024 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707074338; x=1707679138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7fuHKCS7P0gibNRuhCi/+lWNbl//hi+bf2tD9GrdHo=;
        b=OoyrtVtHrVGc2XeI/zv7GteSD0rgrVV7Zm1CKj+zBeRYXCnoqxy4GZvG395QtuC7/X
         g1/T27YUxx0t8Ua3E8lghdv0Hd+69QaWAjOePCbSxo6Uppk0DsuFN2WI+6C2EO9px4PN
         eyrsYFqKPl74A5ktS2WvogEmKlMkugznf7jQRyk755BFPktvr1ce6GLWv7od0EipZ3DN
         xe/SB0vHCxS3oOL7qSr+Xmvaqr4KdWqEdSr6wOIzbnHcEcwoQwSLiY/flcOa+1wVnson
         DIjdM5C9cNypkvbwtSS6bhNuYixH+PmkQcR7VKsGPayjha7oFSwu6RmTNRoqj4IOj2Er
         in0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707074338; x=1707679138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7fuHKCS7P0gibNRuhCi/+lWNbl//hi+bf2tD9GrdHo=;
        b=rBWJ2ZP1lGc2ty5LSCRxEVKzTVmnkr9V0VLwda3zXgcMzcdNPEc3W49SCawHIgUzJp
         PQyIlMz5TzdqzYr2d1XoRtspUQyWP1v96Z338bS1qfbTkztHBz5W1OymjmhIs+QJ9pTK
         WfhqiegNnc4Bi20XxsGYJ3B0HvXMuyAMgps/cRZZyElrGLweQ+jryV3qv/ka5yTZQovb
         IaJwwy9eV/0igwXOioK7aymivjc9aZvlE6JpzU67k4+L+A2rbTXz/d6A3NU6+LmpWn87
         nShkUyY3vK7rt2wACREiNG9D8iWURLp9zohE6qzNVSG1vAFD4agoIf+kAvO7H+mzKbRD
         ohow==
X-Gm-Message-State: AOJu0Ywll5i7FtCicP1/+5HvoGP2TPHBHsFJbrNsOYDgKmo3MilY6cMW
	0WuniaeDcsDKQuXzqM5rNHMOqF7E+rVINBEc1/gfQILoE6Zb83Xv2/Y4r3HfhUmCv2GevV8Yrpw
	kzk+fUs5FtStKoHMNNwPw3+JVdCMhY6DRJ5BVrw==
X-Google-Smtp-Source: AGHT+IG030GFNoRO+D9HsQtpRkpxOEHuKCB6i5c74CD190x3V48aR41aB7RFrMKEewt7N4ui/ox4/rbyj64984Kw2d8=
X-Received: by 2002:a05:6e02:2184:b0:363:bf96:560 with SMTP id
 j4-20020a056e02218400b00363bf960560mr4301345ila.15.1707074338436; Sun, 04 Feb
 2024 11:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <20240201155532.49707-2-brgl@bgdev.pl>
 <CAL_JsqKq8AngeC7ohsbYB0w70uALD+PX-df53cswTDUY-Rrdgw@mail.gmail.com>
In-Reply-To: <CAL_JsqKq8AngeC7ohsbYB0w70uALD+PX-df53cswTDUY-Rrdgw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sun, 4 Feb 2024 20:18:47 +0100
Message-ID: <CAMRc=MdxgETs-Zx3Njao3msmE3T+DeKkPc0YMD3CvVW-Lj2qoQ@mail.gmail.com>
Subject: Re: [RFC 1/9] of: provide a cleanup helper for OF nodes
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:18=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Feb 1, 2024 at 9:55=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Allow to use __free() to automatically put references to OF nodes.
>
> Jonathan has already been working on this[1].
>
> Rob
>
> [1] https://lore.kernel.org/all/20240128160542.178315-1-jic23@kernel.org/

Thanks, I will watch this but for now I'll have to stick to carrying
it in my series until it gets upstream.

Bart
