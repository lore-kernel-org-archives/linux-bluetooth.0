Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33A3EA8C
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562033; cv=none; b=haA8JsU8rfppdQtNBbRFWXNNgURXUpR10lKeHjV1kYYgm4tOJe3nJlRL2BIj8FejB9oB6Vqzi1oA7RHYC1UIpiH6JopPUC4BI8V87vVkxnntKddIjeFmGAK2832I7ONd3AS6q5x3s0x2Hhbl5pQaBCH2joI0yISLv9/6nPYQ290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562033; c=relaxed/simple;
	bh=bA9J4Twnaw+UImgRYTbRKa7Xq/nJHaNSYFAX+dIGugE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGt6NjF7OV/holnYScxugAkoyUUexpcM3pf2ZlMQu6WtD2RoSVLRwOElDDHd8XSdzGrWYAL1puu9sexuHJwp8povZOMm8HXlI88kTOj1P7EmmWaxk52tQDB3cNO7vH21BRUoT4y989LgV4VusQ6+TDNya8ZhXpoQd492nZu0xso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/mAK1RB; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/mAK1RB"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so2561221276.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713562031; x=1714166831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bA9J4Twnaw+UImgRYTbRKa7Xq/nJHaNSYFAX+dIGugE=;
        b=q/mAK1RBU/Du1ib42hIZfz6dQldgDP+gdlv2gii/+aiUYVLoXkrJ0WKgAAcubW8b+8
         enMT7RFTHFiH9HUDPcONX1AC0ixfCA+C8RomlbAhelOwEQbRm58/TAMe5hOZb7pY2UeX
         MwIsiOW9w44AzvsTGeOI3K6sj3+BftANjJKLvDOPn9ey9LCpaxasWwTlb1vVnTXTmyQD
         HMvMVewHJC3V2T2t1omI1v0Mhz0rnoFYd7kFPd6dQneRSIblGziaZAq1eUIz/WdHiEHD
         AxTtPFAVys2QcWmaP9p8hRsvzWYGlACgXvfK9oH3M91nF8dS5L6zkQrXd6Z9fcWo9CMj
         q2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713562031; x=1714166831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bA9J4Twnaw+UImgRYTbRKa7Xq/nJHaNSYFAX+dIGugE=;
        b=U+3EWGDRjVe+lgtNrofSH+r3BiyTpWsc588ccsb9wo7eO0dlyrQslN+2SeBUbYujhf
         Lc2v2u3XoXkIUWU31SR7dNvCuiami6RcULGaqg6CEpMdTdxiTQsQ/bBmoq1NtINpzuC/
         w8CIFIzBXP8aXkNF6MhP3iM65WsmjrjbbRvnp11GWAu+RdalIg7HAFRZta4AEIRIsJgR
         Nnx3HjdOvP0DlpajfQk70gyvq96mYljTESl1mtBwlrKX8h1/DvRH9SyINKLQjB1Fyt3Q
         KH/n2qDIoi241rU8SaO/5r/E4tLAWoyvEEThe3fvs9wnkz/ZxAAbsqp03WIGwc0DQMbt
         TsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrDhu0u8tqqnAJcFUJ5Uq0n00MMQgHb2uN54RJODmEcGNHWug1O8xfMohdmiLAXhAT7i2rmwRbINC4eFbjKZqRIKBMd1uexRPXT5DmQ6ei
X-Gm-Message-State: AOJu0YwFZZeuIA7i4Mvr9a5ZGPn/IKByaaC/Zn7H+i8Mq0iecOpsXMLI
	yxUdWu/Z3iiNKf3KkMAyBdRk0KgeNgxKqjhyDRAzUhZc+JctjWLT1rbcj2h2H9NWDHjgE1or5wV
	JKyH4kWjPtQHcIlvWVALZXztvdZwhJOl2KQrePzXujdRxUhWxGlo=
X-Google-Smtp-Source: AGHT+IEfA0arH0E0F4/SnoGy8F/mTou7Uq7N3LEguIlCpquHAlD3g0wckzJ/CDKOWvmMX4fhPD3rEO09na494GTzKX8=
X-Received: by 2002:a25:9387:0:b0:de0:e3aa:e61 with SMTP id
 a7-20020a259387000000b00de0e3aa0e61mr3141335ybm.37.1713562030997; Fri, 19 Apr
 2024 14:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSevfE3wLhaz1z6A977JL5gOH62NThYWzybVqmHyR7pru=w@mail.gmail.com>
 <1ab7e6fd-68f2-4952-b5d5-bc244b8b7eb3@quicinc.com> <CACMJSeuTkC=Sho29HLada3eTPoasZguObhC1FwmgtJ0dqj=Ykw@mail.gmail.com>
 <d6aa48e7-ab87-4014-894e-5b6da4d42687@quicinc.com>
In-Reply-To: <d6aa48e7-ab87-4014-894e-5b6da4d42687@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 19 Apr 2024 23:27:00 +0200
Message-ID: <CACMJSesFObL9V9toRvnH7d4KNi5pnfzpff+7gZnrq68ZgP7vLQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org, 
	krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 01:36, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>
> On 4/19/2024 6:42 AM, Bartosz Golaszewski wrote:
> > On Thu, 18 Apr 2024 at 23:43, quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>
> >> we will fix it by right way if EPROBE_DEFER is reported.
> >>
> >
> > What?
> >
> will fix the issue if anyone meet and report they meet the error that EPROBE_DEFER is reported.

No, this is wrong. Anything other than NULL or a valid descriptor
pointer returned from gpiod_get_optional() means: an error has
occurred and should be handled accordingly. Please improve the driver
by bailing out in this case. Or wait until next week and I'll send a
follow-up to my patch myself.

Bart
