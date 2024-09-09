Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F718A959
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915482; cv=none; b=KPwhTMouRSzFcj8MKKbn0UXya5PjRmvm4xoTezTzcTxHNMvG7YrEOA37HAGLcdDvXTWhcamIXJhU95IcXkoGZKsZLKT1lBssybOl6KYKDmuCtBwhqn+HyzCRCP7SxRTBxOjKHq69GKyK0xWpodVecPuOa2WcLTajC7RV9cVZdCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915482; c=relaxed/simple;
	bh=lGLdY1ylT3wRFiKmV/y6n60Cr/2cy7pdFUH8q8cqxfA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JlY8KsxMwFNUE5ZK6gofvmHlmjL7fMAuzFRv3SjtE3EBxzunRO2A2YUtFi98+kRTzJs/+FZtc0MqzalCFjNBhyKrrIQjCE/pEakWqrgjkJUV4BprnOF+LkqgIqXkVsWBBaszZjtLiXwAW0P6g4X+bAuxlWwZaBqiyGhBusHYysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tvisioninsights.com; spf=pass smtp.mailfrom=tvisioninsights.com; dkim=pass (2048-bit key) header.d=tvisioninsights.com header.i=@tvisioninsights.com header.b=UGl0DmRF; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tvisioninsights.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tvisioninsights.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tvisioninsights.com header.i=@tvisioninsights.com header.b="UGl0DmRF"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d6a3ab427aso36864457b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2024 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tvisioninsights.com; s=google; t=1725915479; x=1726520279; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lGLdY1ylT3wRFiKmV/y6n60Cr/2cy7pdFUH8q8cqxfA=;
        b=UGl0DmRFxCNwB1JVwsFN/vmEU6zhBo/D4G/0+E4ZGl1IIHUpWT7w7+rVm42q1VUqm2
         DJUL36J7VYF/ee2DmrU8dm3ResKUo3NqsXifEONj7P8v+Lpn2UAnndT+PYRLyfBM/xAV
         xJUaC4+4ISMnDjVS5e+i1XbpuXO897jyChLC/pHZ8BUc76qdr+R/Ij719AqNSDRzIBlu
         VBOmZIzIyrN0C6E4vwEYupTJ7cRl7OOMNO5jB06/QrQMCClFf6fnTfkcoISudfMyq8hk
         ZfkU1ibZubboxkHaBoZYs0ImJ31it5wzYG14P2yp4qJJKEcjHuoixWJcp8v/3IOtCCMD
         bQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725915479; x=1726520279;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGLdY1ylT3wRFiKmV/y6n60Cr/2cy7pdFUH8q8cqxfA=;
        b=gn3YZkvxkXYM+48Jr5atZznXDNk6nWPOhLe35aWXCL0Vt2sp4vj69FmdNkhfpSGH31
         /JoEatSI8Ca6B8G9SGmj9ipT5+/s5HPuJ9JY0wdW8k4CGqs3AMS2+QU/GTLRewziAQID
         M32MrQP+4urd4pHWH4IrdhsxFK18a0Kpdqt2cwcR/xWEsLrr8iMN9eq2ejpGxLmwkIkV
         KRqAz/YY3EOBoL3s+eq/PAEiotoDpiOuJpyDhLpqflf73tDX2Op/2o1Wk9tTAavaOoPx
         gfGatNPcHia3tbQZ7jnwP4IdI6fMmm8QtknRtq+smsps4EDG7R8nWTyu/rryb2VMtw6j
         PNew==
X-Forwarded-Encrypted: i=1; AJvYcCUKYOOeQMdr/G5ZZqGPagqXlX4Y7en3H5jsd+DLMh47u0YPu/FquegEXbNvkpnh4PX9BWdyh/PwR9tnC5/FNiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAL1OtezKKoQ0Se77ro7Ps+P+kt4DOnT2vzlECLh9Mumxk5SUF
	ulkQPUxV6j5cz1R5S4aaVQj8T5dJ+0H7iw/7FnD+a77lOXt4EMLNLdzXJZswWcD17rzP2mmRfoq
	VPE9H9Nv2RVH7AXEOhp9HWEecEhqPEYyR6eqkbc+kLXf4ak2tiZo=
X-Google-Smtp-Source: AGHT+IF1orA8emKndjOJ/2i/tad6xxCgsRxmQyBlQGvdH9F9sv7UvwrvEA/tsy5zVBWAnjAOG13yOWajqFxSY0gauFU=
X-Received: by 2002:a05:690c:6a88:b0:64a:4161:4f94 with SMTP id
 00721157ae682-6db44dfe5damr115813387b3.20.1725915479053; Mon, 09 Sep 2024
 13:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Julio Lajara <julio@tvisioninsights.com>
Date: Mon, 9 Sep 2024 16:57:23 -0400
Message-ID: <CAOrC7GfMagHXiZ3GzxmPMRgguWi0g1rUgcpgQFYHstfkaSstBw@mail.gmail.com>
Subject: Initializing bluetooth using socket.c userland functions broken after
 upgrade from 6.5 to 6.8 (and mainline 6.9, 6.10)
To: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

My company uses pybleno to initialize bluetooth LE devices on our IOT
devices as GATT servers.
This has worked fine from 4.x kernels on Ubuntu 18.04 up to 6.5.0 on
Ubuntu 22.04 for us. The Python code interfaces
with the socket.c userland functions AFAICT.

After upgrading from 6.5 to 6.8 kernel on Ubuntu 22.04, the kernel is
now returning

"[Errno 22] Invalid Argument" from the socket.c setsockopt function.

I have outline as best I can what I checked in the downstream pybleno
ticket here: https://github.com/Adam-Langley/pybleno/issues/63

I could use some input on whether on not any of the recent socket.c
changes between 6.5 to 6.8 changes could have caused this and if
this is a regression or whether not the Python calls to these socket.c
functions which have worked since 4.x need to be rewritten as a result
of an expected interface change on the kernel side.

This problem exists for us as well when we tested with mainline 6.9
and 6.10 kernels last week and our only current solution is
downgrading to 6.5 .

Thank you,
