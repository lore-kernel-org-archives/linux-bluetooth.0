Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0701A6166
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416113; cv=none; b=QtZ8zmpH39ZfOStFhZFh7HrkrvSQCgChhQQ0JdiKhHAaKyrtJ1LnC49+OFXSoHCP8cB6IfkPVRN3NbsosYErOetlcPIebG255pkb2Je320NoBAtGdojJtJEXZ5+lfvggRpKYFKhHE3VZkYYJg9M8wmrZ42/Ic3UPoY7wS/p8szI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416113; c=relaxed/simple;
	bh=zFCO5VLWX2LmDOn28b8CxQSGY3J/zEQ07QUV0WVLsdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3HOuRejZ71Je8ry/OMOFqY5R67O18Txm+3ZEdz7e3ijvWAO8TnXQZqU6qWPXregU3Li9xB9RvsZsqk7M9k7qRMt/F1JagkzG6u5cnnu9ZZXEy8wCBwVYTaeW5lXw5sNRo/RMFyiZCsUFH/aDK7a7hRRNcNFcrx5cbRXEPg4yu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pso9TEFJ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pso9TEFJ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-664b4589b1aso5814617b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 01:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722416111; x=1723020911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z9N/LDrrixma7bOF/IOqaey4NddnCNSMVcapchat6gc=;
        b=pso9TEFJQKl0TY5mCNTEnsdl8ZrmeDEiOqB1dsU46eEMcXSFPCruR2AYy5gZHp4RVY
         giSUwxqgtA96Il8Jx99hOpU/VneuavmOdIinRImO7OjKf14X7CaWUc8BKCCUkyX1DWIX
         PBrNGUrTQbj/ypARxirG2R9vpCZiEs1C5wP8ByOZsKKjRYBuUVgabYK5b8JkpmwMWPEZ
         0LIElCSu0Ejpl2sVTLLmS0NNU5Ze7HUfWglEY99skxijGQk19RKtp5cvDkPGiAS7ojeB
         lhrVpqsRu/tOPSXVcM1omKNzDSf8hSxNQ3U1Sv1I4MRcVgI7Q05LgikEXtkXQQl9jgf1
         I0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722416111; x=1723020911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9N/LDrrixma7bOF/IOqaey4NddnCNSMVcapchat6gc=;
        b=GXoQbTkowkD/V8zni75xNSl6YeC6cm7a1v/eM9Vf1wkPafrTo7wCOyDhGoyqCfKHIJ
         5a3e6xwa9lHM2X88OgWfRrSKnerOAiCTUo0gQ4eTUx/+yA7r8m6HXR/QNrw4Dh9XBeum
         s9a3yvuOrEA9wnk4r5K9NnfbYLkPFGF87GUWwQ0iCSHH8PNxMp72PuICbwC89wUQ31Zg
         lAYfVSNnTWDDxQ/iSm4JUHVQXkF8gQqgYkK3me+av0I3rajO6zVaLbfScckCyCplO3rw
         wA9T2l5kG5ktP1x1VQt3HJdcz85LmvYEM8Y8eKTwQkyhZI+90HehWqF3qdbFu65X/ZuF
         l/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUvyk0o6NC5DsHtzvObGg6mrroD9KzVpiRzdAcdj+q1ipyZnPr1+TGdV3aNScLaKxSb4Od5cjfbz1SGCzayARXJI5406zdHE79F/uuCmFC/
X-Gm-Message-State: AOJu0YzGtF9FZkMTmUQCln+2HQWY1zF2ULjo41KaOiOECgCef0XUbDIQ
	MnAGcvNadp4tmE3KAqORir3eVzpWrgn0EXPefqXI3Wd4VMtRaHKR2s9jLqrxXMEVtGJ73NtjzRf
	GN3AowiJDUOd1aH4d9JXuSmSFnwzc9X/eVsXD6w==
X-Google-Smtp-Source: AGHT+IEkJOt8i7a54I0u7pXClgxFdcnZ9SnsG3A2KX0QvuS0D5mv1PgJ8J7wDLmVzk78+6M8YEcbuv04++I9KDiFgdY=
X-Received: by 2002:a81:a787:0:b0:65f:d6fe:5de4 with SMTP id
 00721157ae682-6826f9fb99cmr43046327b3.21.1722416110893; Wed, 31 Jul 2024
 01:55:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org> <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org> <b1061ec0-5f8f-44af-8955-2d6fa11f94b3@penguintechs.org>
 <CACMJSet3H3B1rz2eZyxUr_ySUOdhTkAognfKpFZ=Kzto8UsxMQ@mail.gmail.com>
 <534cff38-7bbf-4e9d-90c5-c4a4ba331a8e@penguintechs.org> <CACMJSett7WOHWnfNGwtWL0sQQ3K9rqr08W9KDF5U=rJbpBZfzA@mail.gmail.com>
In-Reply-To: <CACMJSett7WOHWnfNGwtWL0sQQ3K9rqr08W9KDF5U=rJbpBZfzA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 31 Jul 2024 11:54:59 +0300
Message-ID: <CAA8EJprdmXfJYx2xk5fcV4UgWqeBPekrgv1iv7F7FugaBH6=KA@mail.gmail.com>
Subject: Re: QCA6390 broken in current kernel
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Wren Turkal <wt@penguintechs.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Zijun Hu <quic_zijuhu@quicinc.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 11:51, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> On Tue, 30 Jul 2024 at 22:05, Wren Turkal <wt@penguintechs.org> wrote:
> > >
> > > Hi Wren,
> > >
> > > Thanks for the report. I was made aware of this yesterday. I had some
> > > more regressions on my plate but with those now fixed, I will take
> > > care of the Bluetooth breakage tomorrow morning.
> > >
> > > Bartosz
> > >
> > >> I will next try Zijun's suggested patch.
> > >>
> > >> wt
> > >> --
> > >> You're more amazing than you think!
> > >>
> >
> > Thanks! If there is anything I can do to help, like test a patch, please
> > feel free to include me. I'd really like to help you, if I can.
> >
> > wt
> > --
> > You're more amazing than you think!
> >
>
> The issue Dmitry reported to me happens with qca6174 not qca6390 which
> makes me think it's a different issue after all.
>
> The laptop you're using is not supported by upstream device-tree, is it?
>
> Is the device tree publicly available?
>
> I'm thinking that - since we switched qca6390 to using the power
> sequencer exclusively in the driver (we could do it as there were no
> DT bindings in place that would say otherwise so no ABI contract) -
> out-of-tree DT sources could potentially stop working. You may need to
> update it to reflect the true internal architecture of the qca6390.

Please allow me to point out that QCA6390 supports binding via ACPI
tables? And it might be used on x86 laptops with no device tree.

Dell XPS13 9310 is an Intel-based laptop.

-- 
With best wishes
Dmitry
