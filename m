Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B9271A84
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157144; cv=none; b=T6ujwxuDul3rWxbmATYZGXmSvBr+U+5F7/y6hcjsAK44MzC0ypwQ0yOzY1AST4M/WUc8dr6n9QHu+Tgc1iWGXBVk0QHzKtKYUK/9ZB+77g7WN/mVSSgbGCuEd0kvGrhBJfKCoApFokAkSue2+0HWIulHwHPwqugkBI67LKu6dO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157144; c=relaxed/simple;
	bh=oEQ/x0dY0kNGAWfhYKRJWYj+mHzmWk1s5K3JD3k6Ii0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoeEEdRAuP5ozFmXcA7366DEz4WuLV//lanTlThX2ItU5BTK/Qbpi6a0VLGw/0bwEfSO/JV5EQBOHoC1npGLKezysZK0bDxyyMdn7D5ihoXvQ7LbFhjUUBLsdZLujiNcaHarY2X7O4xG8yd2scRwEKla41h71VBhlPa5r5+Ug/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=D3qt60sn; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="D3qt60sn"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so2461720e87.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752157141; x=1752761941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRPHLltBMzeDe5jIxfPi59kLql9c4fXU4cd9YzbhV4o=;
        b=D3qt60snEaCbtFEVFVtcoGb44O4DG6QDvuDfYU/b1IRoOjyVG7ImLR3yKsFDXmZup5
         yrOZ1OvKn2ugokeadZBoWXBkNYUnICeIkox+MCcx7FYUSkeuiihkFfRPvoBrgbs23Gne
         hqlA6bJbdY5HZTLVpRGdOo4skcp9stOLxU039I+suIM+J8p4ctgEF3myTMYbaiToKVYM
         J4+7JPZu0l478pYppmQ8rBms59bU/jCmk+fdhkVYXzy+NHul0y/aVs2Nrd9nju6BPnyj
         nSDvubBrVe8LkkYK41qDGeBEySxcpWC26CBpJyxIOAbhOXyYoWuCcDxLX86qcKA08qqP
         MoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752157141; x=1752761941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRPHLltBMzeDe5jIxfPi59kLql9c4fXU4cd9YzbhV4o=;
        b=pFJ7t5BLJ3+L+znegMBQA2KaBh2lE/SVnthDQRteeqazlTWY7ewRpgNJ26KrOVVKzo
         H5QiAC6sj5QwEct70yj4BRMQG0lF7YNA5Hqh4+MtOLapkrhr4lVBMDoqL1eTchaVqkdO
         uJcCuuyqg9nJOQ3aOTdI0zPy6JyzPVFQ1I1d5I95kHgmP1/FPZYB1bCFhVhQKFtfxVMD
         Hn95WE6hxVEUrrhnnT65ENVD4qc7PS2oxhspxkm41YBlx9e6mlwQT7nz5XkX55N8GULm
         T9muLHfQNvmHp/Ey5Kft/AU+CSDj2ThEBgW8PHdczJcWcIejaLU99udLWSh1zKWEyUfz
         8tjA==
X-Forwarded-Encrypted: i=1; AJvYcCV3ADH8GetRe1nZtNsnRVA+h12WZMJ1pCwkdnfHpMPKCv0NM/Amv/WE2MlmJid+shU+rofoHw/iSN2rs0cfj0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08TTCWobNoDWsVabq/vy0VM0XGzC0431GRl3bava3pJJnN5MC
	xAaojBK8UJ4HokbpdzdNP1IYvdapS56LPME2z+H/sHmz7o3c7dkS1IDIunr9ugtevFZUBwnChMH
	hvjHHcgYwbNAWAxLc8u/eAu8YUuZm8tLbdIzpOQ5w/Q==
X-Gm-Gg: ASbGncsQFZiqKDCKnP/YTYi3W25vVnb7NSo2iAlaSTzQlSZr6N73wbatXenPB+P6Ehx
	88GJ61EpAd5I67+AH+COoE+13qDNZtn1RfYs8Zsk+JmoTFCAqq/iYfDkF9Sj2hBR1JM2+rxOmVm
	vTb597cguIhIijTw75Uk1ix+cRrxCX8MY0o4Jb9OR0hxN0YBUuAwB3SUmuJx+G18GgAA7URbhAX
	FY=
X-Google-Smtp-Source: AGHT+IGjaU4rKpa8CqG5pu0KCCEMGlHrurb1k5qJX9u+E2WEI/JPgsWZwxZnIfescabddMghBfCvSskJKJ/p+LQUdH4=
X-Received: by 2002:a05:6512:1322:b0:554:f72c:8192 with SMTP id
 2adb3069b0e04-559006c631bmr1170872e87.5.1752157140814; Thu, 10 Jul 2025
 07:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709144728.43313-1-brgl@bgdev.pl> <141abf1f-2739-4ccf-8a2b-3451c299ef49@oss.qualcomm.com>
In-Reply-To: <141abf1f-2739-4ccf-8a2b-3451c299ef49@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 10 Jul 2025 16:18:49 +0200
X-Gm-Features: Ac12FXw57wqi3gyfzBD_lV_SmnPhS5NgG7-5dfbuNvEr-NTt537CCC_khbehbx8
Message-ID: <CAMRc=McYqNm4gVgDir=Er_TdOCFUknapFx8a7q4cdyY63sb-0A@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: add a sub-entry for the Qualcomm
 bluetooth driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Shuai Zhang <quic_shuaz@quicinc.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 7:06=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 7/9/25 4:47 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to the
> > linux-arm-msm mailing list so that Qualcomm maintainers and reviewers
> > can get notified about proposed changes to it. Add a sub-entry that add=
s
> > the mailing list to the list of addresses returned by get_maintainer.pl=
.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > Changes in v2:
> > - add remaining QCA files (Dmitry)
> >
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index efba8922744a3..d018923ddd3eb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20464,6 +20464,13 @@ S:   Maintained
> >  F:   Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> >  F:   drivers/net/wwan/qcom_bam_dmux.c
> >
> > +QUALCOMM BLUETOOTH DRIVER
> > +L:   linux-arm-msm@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/bluetooth/btqca.[ch]
> > +F:   drivers/bluetooth/btqcomsmd.c
> > +F:   drivers/bluetooth/hci_qca.c
>
> + Jeff, maybe you/ath would like to be included there too?
>

I suppose this is material for a separate patch and MAINTAINERS entry?

Bart
