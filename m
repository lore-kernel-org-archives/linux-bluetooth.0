Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98961FEB
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501653; cv=none; b=oU5nXJT+6LsfDHN4lyUWrZbBiuKu0GHJHH0uA/4GAexCrjmZZtz1OlhKvwVSkUUwtZ6GUOMvCVLjudSUkDWOinLO15QgayQh7n3KaaKl+mc5HDvEIo3YxMJ+z6kV33GWtm26orJ9fah/HxW8ME2jCv++JJIeE3QYJdfg4m0XM/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501653; c=relaxed/simple;
	bh=JlNJGQijXwNivCATTvHX+5svICCbW6qqc1j/h41swfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4TN4ZH2VZEboKkNGWhLqmgoXz4CFVT+zJAB/1HNQlt22J66ey7aJANAycrrmn36DQYvnxBYwtwgI+OeGj/smHQPkKZ2aDxguel97PwH9Qwf2Xfyw/HdWRNZFk/bOiBSIIrJmOZSKPOF1+Sq+3y+7Re3fGpVaklKnM/6mhHxAXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i2o+C69g; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i2o+C69g"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-66526e430e0so54852757b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722501650; x=1723106450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JlNJGQijXwNivCATTvHX+5svICCbW6qqc1j/h41swfM=;
        b=i2o+C69gdxdkr2sas0oewncflWkjFgt970tATaZGCJXzTkLQNNOUPfrL+5VM75vK/6
         Ux+d5wfuOHe9QaD1R0cuTqmBLdwH8NYxameNV9BvaCbvlkqSwmXDr96QuI7NoSonJIAb
         Avz8pHzF/m5sUaVlWuxtOhix0PjaFL3p2NljUQQAj2Fqtu51mHTTeTA4M2pTCXDXVuui
         ATcoV4GSzWYGDZxUPTHDvbOF3eMjZUK9UWLvDVqgZrqNFQ/IpFN4nlvCvntqxdG2FtWQ
         UncFbqJGVsme7MySzCEZJ1AQfywU942FddgeeImeK/rJACEIr8mSWsBj0BL3kGwywAeY
         vSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501650; x=1723106450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JlNJGQijXwNivCATTvHX+5svICCbW6qqc1j/h41swfM=;
        b=vOM+T7g5OQUL9HijCRnfi7RQrOuSi5SikiyzedMAi1sQx9FyDkcXWvs0AZlOExTKj4
         0kNrnNhlhO7TXogpmSbGqWCGps3jObT8/4j0bJDCcsRkk20KkXnfYlyd528RwGkiCyBB
         WMPTXAkmUAswRqIQxXoAKrLFZPUeLT3GPsdbOFS+Gic7WDXIvdJxDhavB8VSpyVOnFh2
         eM5s3Eb5TUgru6KeqaOh7JrQ42x8SSYxw7mJb7tJ0oa9rWI4bsPQoIZvskjwPxXE61L5
         rjcIrCkhUaQyKrEpob2NLxR8R9xmnMiF0JFEV7sv6v226iFXBdMW+do0/SAMTe2PDa59
         9d/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz0w+UVMUgFuaKMQnBXTSrByQ90PIffViN0g3dxXriOAkbMBonpClYm9mJl84/f3NZ8AEsN6yGwRtIMvBxkCYwaiXz0/xi/nQ26HZs9FA/
X-Gm-Message-State: AOJu0Yw0kNWUV+xB0J0hTm0cNTnZDDOXUS9tiZ/uh2CLNiYjbgNwFYtv
	xCfzfek55raq3NU+ycpioGm1ZcqR54y2BaK6rotn7u4GubO3xqmONL3O7O7T3pFtIID9d8Ml5GH
	0ZuOUHvZO1/GYUWAL9uFk9EVCe6RpuUTBlKN0Ag==
X-Google-Smtp-Source: AGHT+IEGtPOpKTWsawu618UBDcFNKvGgvOuo9xyOmO1Gh+FzPyxNaoG1skCftff7ezLyttGv5WkHKEW920tXdrU9ffk=
X-Received: by 2002:a0d:c303:0:b0:64b:bad:2108 with SMTP id
 00721157ae682-6874f604541mr10583587b3.39.1722501650304; Thu, 01 Aug 2024
 01:40:50 -0700 (PDT)
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
 <CAA8EJprdmXfJYx2xk5fcV4UgWqeBPekrgv1iv7F7FugaBH6=KA@mail.gmail.com>
 <CACMJSesML_Q-Z79XyAZd0sJuE=AbGQ-TWozPWTRmdF3sMh7VHg@mail.gmail.com>
 <3dc56ebc-d378-4ba0-aed8-03c93e0aea20@penguintechs.org> <CACMJSetaLXr8a9ffpSN3GpH6YOcHn-o2seL4fj9q6iFbfEUxDg@mail.gmail.com>
 <549619fa-958d-4e9a-a53e-d8d73686ae63@penguintechs.org>
In-Reply-To: <549619fa-958d-4e9a-a53e-d8d73686ae63@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Thu, 1 Aug 2024 10:40:39 +0200
Message-ID: <CACMJSetWLnDH=U8tXVPMz=jVEFy0731SRjozqE_WbtufTUEgMw@mail.gmail.com>
Subject: Re: QCA6390 broken in current kernel
To: Wren Turkal <wt@penguintechs.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Aug 2024 at 10:36, Wren Turkal <wt@penguintechs.org> wrote:
>
> On 8/1/24 1:09 AM, Bartosz Golaszewski wrote:
> > On Thu, 1 Aug 2024 at 09:59, Wren Turkal <wt@penguintechs.org> wrote:
> >>>
> >>> Indeed. I don't know why I assumed it must be an ARM laptop. I will
> >>> come up with a fix shortly.
> >>
> >> I have a question, does this fact have anything to do with the problem
> >> with failing to initialize the QCA6390 BT hardware on my laptop after a
> >> warm reboot? As I didn't understand the connection to DT in that other
> >> issue, does this fact change anything about how to approach that issue?
> >> I only ask because that issue still very much exists.
> >>
> >
> > Can you remind me if you had bisected it to a specific offending commit?
>
> I don't think I was able to fully bisect that one. I was more focused on
> the fact that the BT hardware didn't work at all even after a cold boot
> in that previous issue.
>
> Zijun suggested a fix in
> https://lore.kernel.org/linux-bluetooth/1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com/.
>
> That fix was landed (mainline commit
> 88e72239ead9814b886db54fc4ee39ef3c2b8f26) and reverted for regression
> (revert part of merge 033771c085c2ed73cb29dd25e1ec8c4b2991cad9).
>
> I do not know how to move that one forward. I was hoping that this
> pwrseq work and the fact that this laptop doesn't use DT might be new
> facts that make it easier to move forward.
>

With the fixes from this series the driver should theoretically go
back to the behavior pre-pwrseq on your hardware. Is there a specific
kernel version where it still works?

Bart
