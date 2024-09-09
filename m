Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D672A18C33A;
	Mon,  9 Sep 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725917030; cv=none; b=s5bQbteNa9Lq2FNoH5et2ARMECqKo0itCWsWbdnGqdVmrKuemjPygPFfUtKZXDpvvmKK+QKtaAm6nL00W6+dE8plIERiONmmjcH8aWDK+GD1CMCAepxYGsrdyhwHuIAV0KdsfKWB/81fmEKfrykasBUV5LocB6V8C8X1bTjEEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725917030; c=relaxed/simple;
	bh=LJycY7wUCB2mnqi/4rp/m+7fAW+Ob1l/t407YniIBd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WY0UnSqCuqBwllpbeXvWLfgC2Y04UX1wfPZhOrf6pY1oMheiTBcAzfdzz6kYPIMS32HVSWVqiqYdg5l7qetoVRvIrjoYQ7Qe1I6rC2uaUY8pXdDocWuqlRPiQT0+TirY+SG8WNnN5+TU75sokciHX5eT7ZmbCxWsJcPtvB1GCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCjVTiJg; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCjVTiJg"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f6580c2bbfso49429451fa.1;
        Mon, 09 Sep 2024 14:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725917027; x=1726521827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF/r4+qQtlkpT6+w0E5eY/DCQQmMuW8PUgpZZm72sBk=;
        b=OCjVTiJgf6+XbqqxmveWOHKy/ZxoEdsvHGsOP40d4/hH2LG4eKbo1YrYzE/B1LuKkJ
         5skb7P+L3QY1+323ILoowcuNIHG7HuoiOGrAPUyknrey9TTCUlLnxDRuwE2BlBhITTdt
         0hTHHt96y/VZFL5tacoT8AIB96pn+ohMSL15h3MTWEH2ZZP+db1X8qGAIj4hIFs3Q0Pi
         e6IJ6XLVG35HBPnCjB6r+kk+dapqR5Z/4IKKLCF7IVDhknlEe+h/25+7mh2Vl2VzxKSr
         zfK5mvTDFcqhs8W4F4Fs3juRTgcGIvU1PbRqfun5NySi6PBaybOuOrkE2KMsJwbNE/ua
         8GUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725917027; x=1726521827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VF/r4+qQtlkpT6+w0E5eY/DCQQmMuW8PUgpZZm72sBk=;
        b=Tvvn4WngLQ2Vk+nysU1yoKTj0qH5Z9ylA1DoQl0sDZywuqnAKFzCwfaQXUv2M74SzB
         qlAg3bfXSXtFmsNAgONoANkbSLAUpNg1hieB7WN6tMSMAvWsLEBF0oQKmiGvP2zrBlcw
         rVSPkU24qetDfzjp/43sgTDchZyQAM5SL4sKc+XQm4ab38W/OafdfEiUEf4AfppWpmgH
         FXYXxwu+qSDvgkYMbi/m2Ojmn1FfEPcGsRzEQBaBug9r+kPtp5Ar/yckDr0BGHicc4pb
         lr3biudH9UROvkp4DnRaSyjWe2hmOce/pZvp5GHDM3yoRj5U3PzNkJJXZV9AHAV6hXsC
         HZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCU/3NIUwT+y9jME1E/wyQyMev7vOtYLr5tfvYouzt/OEPxc8wElPR2CxURK4PuoTb8fo25IOr7NN2qvK7qRfp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzStJgU7TazSvSVscGh1nAlhsVKJSAdR4mVWpY2N+TQ/xbIPA5w
	zyeNviycmBxiZ9sMJ26YsAZU9C4Hy94Zw2DTlT/8RW4EiJLrW8L9fw+5fCb+acZGf6Oo+v7KRHU
	OKb3hO0EPiNNdvOQvL4Cl9OF4xyRq9RfX
X-Google-Smtp-Source: AGHT+IE8r828tWLfEiuUn0wZC/opaltdjLbmW1H2wPR/VUjtzdDywTX/IUL4Valhglw38IMiyFscn8vClMnapQFWT1Q=
X-Received: by 2002:a05:651c:1a0a:b0:2ef:21a6:7c82 with SMTP id
 38308e7fff4ca-2f7726fb55dmr2144811fa.20.1725917025989; Mon, 09 Sep 2024
 14:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOrC7GfMagHXiZ3GzxmPMRgguWi0g1rUgcpgQFYHstfkaSstBw@mail.gmail.com>
In-Reply-To: <CAOrC7GfMagHXiZ3GzxmPMRgguWi0g1rUgcpgQFYHstfkaSstBw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Sep 2024 17:23:33 -0400
Message-ID: <CABBYNZKJH3916j3V17Jc51Rr7xs22aFq7zA3FVvBo50hguXJoA@mail.gmail.com>
Subject: Re: Initializing bluetooth using socket.c userland functions broken
 after upgrade from 6.5 to 6.8 (and mainline 6.9, 6.10)
To: Julio Lajara <julio@tvisioninsights.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Julio,

On Mon, Sep 9, 2024 at 4:58=E2=80=AFPM Julio Lajara <julio@tvisioninsights.=
com> wrote:
>
> My company uses pybleno to initialize bluetooth LE devices on our IOT
> devices as GATT servers.
> This has worked fine from 4.x kernels on Ubuntu 18.04 up to 6.5.0 on
> Ubuntu 22.04 for us. The Python code interfaces
> with the socket.c userland functions AFAICT.
>
> After upgrading from 6.5 to 6.8 kernel on Ubuntu 22.04, the kernel is
> now returning
>
> "[Errno 22] Invalid Argument" from the socket.c setsockopt function.
>
> I have outline as best I can what I checked in the downstream pybleno
> ticket here: https://github.com/Adam-Langley/pybleno/issues/63
>
> I could use some input on whether on not any of the recent socket.c
> changes between 6.5 to 6.8 changes could have caused this and if
> this is a regression or whether not the Python calls to these socket.c
> functions which have worked since 4.x need to be rewritten as a result
> of an expected interface change on the kernel side.
>
> This problem exists for us as well when we tested with mainline 6.9
> and 6.10 kernels last week and our only current solution is
> downgrading to 6.5 .
>
> Thank you,

Most likely:

Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Apr 5 16:46:50 2024 -0400

    Bluetooth: hci_sock: Fix not validating setsockopt user input

    Check user input length before copying data.

    Fixes: 09572fca7223 ("Bluetooth: hci_sock: Add support for BT_{SND,RCV}=
BUF")
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

I wouldn't be surprised that people are actually not using hci_ufilter
struct when setting HCI_FILTER and the it fails at:

static inline int bt_copy_from_sockptr(void *dst, size_t dst_size,
                       sockptr_t src, size_t src_size)
{
    if (dst_size > src_size)
        return -EINVAL;

    return copy_from_sockptr(dst, src, dst_size);
}

--=20
Luiz Augusto von Dentz
