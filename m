Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C048034C
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040239; cv=pass; b=l76+bxooWZ9zxggZfWZxDbxv9DHyST720z6M3IEcb/rZwzvbkYkloatQrlIHFaBUJep957nGIAjH77Dwnvus2i4PwnQikxc8GN+Uos2t3TxkrzP1NLXTVhcWnNOLsCt+ZVYtXLfouBkH9USCq5BH9PSoumMl+0JquGXqG4k75DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040239; c=relaxed/simple;
	bh=8y5dxnzK+22XcUOAYUmBQS8rxfrmlMLNh9AzXGy7wkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKQDT2cx/8VCzrfpA5TNzLUIWRoN7vNX1yWYIHWfKoFiZU6hDZ2/67WVm4qJ7MeKaje3YrbsWQqT1vmbBDVSPoYBJXCgOqIIGJxs4Ksf6mHUy5a5P6E7UK4nkX8qK6Q+CcqyxGcTKfq1NDpEY1Y+ja1vnleyGcHQw7Y/L+jstQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCsFXtRl; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCsFXtRl"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e86df8987so53991047b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 07:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784040227; cv=none;
        d=google.com; s=arc-20260327;
        b=e8eAFxC/EWrYxyKhiSTgdx4dLLGZNe60+1DH2gRznHfB/iA5EZmRs7pJhuB1aMPbES
         bbCDY4kGViB0WAMczoZxVgtySOcCvWze9SYVUAsV9Js68azQGU3sn5mjQYgW1qpUwFRk
         5+ba2iN0UjTmieY4tKnDH5i3W8mvXGJo6/hsFNA8XENjjfjtwEePVmrDHjX/k4TVatr6
         I4EEXEAlY9ABQmooSLSNGwKnEXAQ3OrDSqJ6uZ5wJLinFY5XBJRmihRnCBnQwIvob+DE
         qU9W0Ek0DTivuMNkhhN36dB3Pz4ONd0vLV9h9O55s+WmBAbXx7D7mabRS8UqTiZqhGDb
         GHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuKd7MsKDgY3GsTzKgE+Id/ByDFAoPqrGf61N4kYgVw=;
        fh=PeJsqsHv92CqXw+MJdWYZcx4Hv3EyR1QyntuhOF5PpM=;
        b=sKGT3ykhPPwqRHs7kq40v/DRRbFPtnl3kNUEmt/Rh6e1iS/FSZFxBk+nuqxUVaRDRC
         LvQTlQ8jZxDvoRiStMVh2qkgiNyTe0X7SRYxcOdGIftioqtOfPcRz4hvToqDh21QyBba
         nN1KfssJaCbvgWHpo4VskzA3lzZQ2GQaI/Aw0tmnES4jm8s6OJXI+qmlQ3WOesS5vZtv
         2+fYd1MPhd0RHbyUyQIJDzJ7YgaZjaXhXdETNkJyTZHQlhXwLsjqqYvY2l6SD39kiKqB
         76/JkyluRyUb5SvZqelgx0+GXUn96fqk4AjIAYozJC2XMvftc0pC8iRB+AIelvtbh++B
         cRyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040227; x=1784645027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuKd7MsKDgY3GsTzKgE+Id/ByDFAoPqrGf61N4kYgVw=;
        b=eCsFXtRlsDj+avp+Pe8+FThqws24aFG+GOk5sKerJYvSX6zTwKro6R42I1V4MrCVTC
         3PoDi5CzHiSIMmlCobfVcM3u9la2laiLDJLZF5TuHstRlD+j/CSw9UOgvxd7qCEbN25S
         rQWSZOddbvP03pkW2YOQ+2Wtuo0EC30foLJBgTMfB9rTWe6oAARi+TYTt18q9vLRsjFr
         gk/1QXUIGrFpVJspwFKx25t5R4n0LAQgXLOP7CEy9pObJvAtb7+pdR//sGmMPGkuOl15
         zvv5jU9HHwj9fV1bAwEDUsXBNnamTDNJvuM37Dx+0fxbUWJsBV5ocT+f5AwlG8WOM+Hb
         I0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040227; x=1784645027;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuKd7MsKDgY3GsTzKgE+Id/ByDFAoPqrGf61N4kYgVw=;
        b=LZNiYmQ+x5tug2ds+SbPoeexWaYwz+lInp3u+wdr9jF+JDGpngnx4mhAg26wej4uQT
         lewTlZnL59Ow4gBaKR0Xf05+vZ+EZV++zOUeW+LG5PXUZozzzFXuBUHulRXfPw/m1n2c
         ckGjAfnyg4TI9+0MYqc6/PyAac5rT0OCwEQjWPScrkB6PPDGnwKELQxzwitO23r0t6Sh
         rkSne1+tPSUkMU+wrKP2tD+jYUB5GEesVXLAfq5cM/XcwyP9x5rSdZf2tHYVP+VxXnFd
         d8xPZ5d0aUhmoHA5VOr2lA0QyPLiZ4KoqFogUYq99I7lqWpTAXZp0jKNJHFaJlD8ag9s
         V4lw==
X-Gm-Message-State: AOJu0YzIQJTz/q+xYcpfsmIpAmnzrhwbmMpr1DpuTwyDgjammyLMNQQq
	ROt/HxAnQEUhFMZhHwzEr5dxM4HYfoFFsQv1QpncRw4pfGP5qQA1DCUajiyTMMvtP60oAe5p8Xa
	d3mUtGmuapNvww74Ncm43aH9yOxUq1NdDGfE4FFU=
X-Gm-Gg: AfdE7cmYrGP4MjDqk8ToiB2DEH9lW2LuYZSkqKUrb9qlngc0HMU6f/AnBOsRLOiV+mI
	0BY4k+j6tOnsfde2VlNjRRV6cNSVMBPSKHcJc8aAcw04hrVbS3/hwiOsSRUZgGPEQU2cVyAB1p7
	zXqGffpXV/GjShxCPBnu7M9ve6uW9BL2/aG4Ww/eE7At9to7CI/Fm/zP+/YQ6i5Iybp481ZNNwa
	yBsT9370cF6gU2C+uy/yxFBhjHKdTsbZ4p00n2O8BoWZ9jI5aPXm5a0WXYx6E5lWASwKegx6Lhx
	LspZnNQ8E7ZISondan4w21Z31cZ2bVbqBR8XPBTy8XEipLDm5MVDeccB
X-Received: by 2002:a05:690c:250a:b0:81e:68a2:89d5 with SMTP id
 00721157ae682-81e901b3d89mr104179727b3.55.1784040227391; Tue, 14 Jul 2026
 07:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_C252270EE8A4AC5702E228978CF8ABF4E109@qq.com>
In-Reply-To: <tencent_C252270EE8A4AC5702E228978CF8ABF4E109@qq.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Jul 2026 10:43:35 -0400
X-Gm-Features: AVVi8CexmbTE5mhUjPt0MimMyv1GKo5bVp1SHdFRN0sW-4qUvYtebEYCKeh9iLs
Message-ID: <CABBYNZKR_ft-ofL9--z1CJ87jMuaKM6uS-Z6-CcyK3+t9r=Dmg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] adapter: Trigger profile connection on inbound
 device connection
To: Chengyi Zhao <chengyi.zhao@qq.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 14, 2026 at 4:21=E2=80=AFAM Chengyi Zhao <chengyi.zhao@qq.com> =
wrote:
>
> When a bonded device initiates an inbound ACL connection before the
> host sends an outbound one (e.g., after resume the remote wins the
> race), BlueZ accepts the ACL link via connected_callback() but does
> not establish AVDTP/AVCTP profiles. The remote's subsequent L2CAP
> connect for PSM 25 fails with "security block" because the link is
> not yet encrypted, and the kernel does not retry. The ACL link stays
> up with no audio.

This sounds like a problem on the remote side if it attempts to
connect without encrypting the link first for AVDTP/AVCTP, so this
seems more like a workaround. Or it is a controller problem, perhaps
the Encryption Changed event has already happened but is arriving
late?

> Fix: in connected_callback(), call btd_device_connect_services() for
> bonded inbound devices. This initiates outbound profile connections
> from the host side. Unlike inbound L2CAP, outbound L2CAP is queued
> by the kernel until encryption completes, so it survives the race.
> Safe when the host already won: the function returns -EBUSY if
> dev->connect or dev->pending is set.
> ---
>  src/adapter.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 4ffa32a52..4f1bda4ab 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -9606,6 +9606,9 @@ static void connected_callback(uint16_t index, uint=
16_t length,
>                 adapter_msd_notify(adapter, device, eir_data.msd_list);
>
>         eir_data_free(&eir_data);
> +
> +       if (device_is_bonded(device, BDADDR_BREDR))
> +               btd_device_connect_services(device, NULL);

The policy plugin is supposed to handle connection policies like this.
You will probably need a grace period to wait for the remote to start
connecting if it is the central; only then should you start connecting
the profiles.

>  }
>
>  static void controller_resume_notify(struct btd_adapter *adapter)
> --
> 2.50.1
>
>


--=20
Luiz Augusto von Dentz
