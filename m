Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968653F0A81
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411362; cv=pass; b=uVewXCCAYtQyHK0FSZiDyhZ65Hr8al7Xhuku6Mjy2+Ccwhc9rjtChDo+EyRn7vs7/PdtHNLvDZmsMnYc4uMrk1fUJyc7ay8F73jawULI3oBpyRKGd9XS3Dq6B800uXWjM/32FzRsMSg4Ase9aR41I3HY4UXoWp7N/lqYu/BKFL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411362; c=relaxed/simple;
	bh=ADXso+oQPFZJ7xpVosSBr6LJE1P0hy/0qyw9A6F2sKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtz8FNrG6VbDah+2Xig7Yw2/Fh6n0UbPsCW9KJPThp1O8/XS48HFXs/RAOm9OYiCty8IOAwsWUJwSYRsqhmvMMhknLLc8+QOzEYmkpJhdzJverS7NbM8cNRgYHUuJ9YtJiKE7a+2uOw6xp+bcW4vizgn9i3jYzb0g+HpUihh+Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEMJXyry; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEMJXyry"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66077e90382so2444072d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 07:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780411360; cv=none;
        d=google.com; s=arc-20240605;
        b=lRPm4CC/fD0cjcR84WCnS34E+2UBBbfAmTTsmnxNC4+iYOFhD4iAb9icqoD4ztGXJt
         593QOWYZsMqOIZTZG8tXVaHKW45Nm4hr3JxmzUkPdn1efZNhzMjFP/lu3Cm380Yx//Zf
         WRjghOrorfxJHMN07wt66uqzutv6/Rz7AJ1ya+kCgTIl8D2s32yr1cbzbAa4BEdYuTq/
         GerQ93vJBZ+lJu0p5b957ZXksYqAAT+cfvFgiKPjhEn/gmcKgMhdqTAQeathhqfOEb3t
         SP3kHZw/+kPcqF+pMQiUSkCzvOXy/frjELVexPuwYeRxcFUp8taxQ7tN6rGv5+y6ubE8
         jwfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iwkhuyiOCt2Z42K02jLJMy4qUn7sTv78SG+LDS2SumM=;
        fh=2DqQXOfvJHXMo1igz8u9erxgiACEuYxcA4BdaZ6Gcbc=;
        b=VWAd9Yil9+axSZDcbNvIqnio/Xbg7val47MYfX1CRXH8hqAgQaezkw+lD5j3lWEfr6
         dGqTWNnx2vhXN2ZhKJ998tPRKr7/FM1et63b4tLTocbeuNTiK1919CjhLqrSjkCaG4Nw
         jQoGzA5dXdCVMf0pU08hdOUZtx1aJbf5Qln6tk60HlzO/Z2oQGNuuJslSlMv7mf6Qusl
         l4xVcHLf3f20s/ZBL7uRc3XhY//7OoKqRzuHl6BeHRxdZktrq7yw0wG8dwraEUk8rKHu
         jxRD5jPE5IgyHSvrc6QOPFIVn2iRI/zskPv2H4Z0HBvZUgMzF1w1iutekI/m62zmoEPl
         vCiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780411360; x=1781016160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwkhuyiOCt2Z42K02jLJMy4qUn7sTv78SG+LDS2SumM=;
        b=lEMJXyryiS1Tl12oWZC/G62bJBx793JspW3L0UmOEG63Qw2JNgTi73+HwVru6zH8az
         NVhiWOMC9Vs7uEeWRn4BJQhDk3jwAoGjNBh6le09HKHOJ7u44CTpkv4uoN8oQ5PbmYY5
         0ifmoHNCTVS3Rm9vkomR1c7SDgQwi/vN+/IfBvsqitWKKQ0ujQYGL1MuVarZcvQPwhhZ
         S0/pAQoDCdJzNdkm9uiGNgBwH31TA4dhP7N7s67nohbLxsRpBYp00CvvhPO0yFYWGZ3r
         YVWkT8iNz3ORdif8Ki3znwwmMNxU5LmvzCKuESsId8QZO3+WxJUovrT2TzRgj+E5RW/u
         ppwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780411360; x=1781016160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iwkhuyiOCt2Z42K02jLJMy4qUn7sTv78SG+LDS2SumM=;
        b=ZpOComwpI4TUEafH3YWnknKcgtEHQEtO52rXQNl4twgp0WjRiDey1zppKL9mXqhUZj
         iDEK1atqtrY9C9SFGuWW+eHKSedoPhsnGN9e3tC7pBivaQw3Q11BAh26HJNGDaIdXIW6
         tD4PZmplJvvejo/n5XAzOjlF5JFC8nSExmKo6VTKjPoZ6yxImwJYJnrwx70FSnp8LBQ6
         JpIQGVrq+9cAL81UAj5F9xfk4GbglVtxDPTfRn+kw6xzmWP9p3BAbir6wRJ4WXdSf7R8
         pnlyceBTXXmWWPtqttYakpplV7p8PXjIB04su8ZX1IqPkY8YXGDnDoF7CY7bnpcA9K6I
         axgA==
X-Gm-Message-State: AOJu0YziKCHtkLReq709O+8847BrOrZLdUnhiKC9/lg97OJBfdJlcGbM
	96ly7FWvrlctlc52H0c4DxhjPKVUTmdwEaibINMgBpR7GpEzU6yBJDqwcf8U2GWd1uSiTLonp5N
	elRnYoM/dfxxw8FGWYAAgQ1NixXaekSiGJ73G4Yw=
X-Gm-Gg: Acq92OGmocxquWEZOzioMjnj3lDM60KItTUzggxjNjpUGIt1uvuy3EyFarhNtGmQ75d
	qeiOQuPux2i2dpYlWHV8X+rS1Gsv1muhq6PnM+mqfZRbqUFnE3tg5DgjayELvpn8A4N/2B3nr3L
	ovi4D+BddiQFW+91SlFwA9shXwiyLGHBd1O+QDHdjilelG3zrmqCxH0JoINDP6vlLyu2qn4R+mv
	DKJQ7nm/q11W8j9tozEGgus34Xzpoeb/X5mqO4IY6hn8NtyIovTQ+6GaRmWq6/odcGJXEYPZ1Ll
	HEh2PtPaSQSWe2QTE6CRZzW/+Ac4aGEzmwKMpU7v+As3L8QEFPgiMfl+JmrkLufXosoe7KRcNws
	Zpg==
X-Received: by 2002:a05:690e:120a:b0:660:406f:61a0 with SMTP id
 956f58d0204a3-6605fc53f99mr13384497d50.65.1780411360303; Tue, 02 Jun 2026
 07:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522054015.431152-1-wei.deng@oss.qualcomm.com>
 <20260602031719.679979-1-wei.deng@oss.qualcomm.com> <CABBYNZ+vSQWjJyajPxoBs3endFOkU2JGOFoBKvePu8YvZSMEXQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+vSQWjJyajPxoBs3endFOkU2JGOFoBKvePu8YvZSMEXQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Jun 2026 10:42:28 -0400
X-Gm-Features: AVHnY4J7vLCJyR-7VuSbULzULXVjOEZASpOMcALlqvr3JXKTzkeRhcaN9A5Py1Y
Message-ID: <CABBYNZKZhamDmBjpKW3GjtF3jrNfLXUTzYaNyz1vbdrgM_Lu4A@mail.gmail.com>
Subject: Re: [PATCH v2] profile: Set L2CAP IMTU for external profile listeners
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 2, 2026 at 10:21=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Mon, Jun 1, 2026 at 11:18=E2=80=AFPM Wei Deng <wei.deng@oss.qualcomm.c=
om> wrote:
> >
> > bt_io_listen() in ext_start_servers() creates the L2CAP listening
> > socket for external profiles without an explicit IMTU. This causes
> > the socket to use the L2CAP minimum of 672 bytes, which is advertised
> > to the peer in L2CAP_CONFIGURATION_RSP.
> >
> > As a result, when acting as a server (receiver), the peer limits its
> > outgoing PDU size to our advertised 672 bytes. This leads to small
> > OBEX body chunks (~669 bytes) and severely degraded Rx throughput,
> > while Tx throughput is unaffected since the peer's IMTU is not
> > constrained by our setting.
> >
> > The obexd client side (obexd/client/bluetooth.c) already sets IMTU to
> > BT_RX_MTU (32767) for outgoing connections. Mirror that on the server
> > side by setting BT_IO_OPT_IMTU to BT_RX_MTU in ext_start_servers(),
> > so incoming connections advertise the same maximum receive capability.
> >
> > Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> > ---
> >  src/profile.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/src/profile.c b/src/profile.c
> > index dfc5f7161..297959f3c 100644
> > --- a/src/profile.c
> > +++ b/src/profile.c
> > @@ -55,6 +55,8 @@
> >  #define MAS_DEFAULT_CHANNEL    16
> >  #define MNS_DEFAULT_CHANNEL    17
> >
> > +#define BT_RX_MTU              32767
> > +
> >  #define BTD_PROFILE_PSM_AUTO   -1
> >  #define BTD_PROFILE_CHAN_AUTO  -1
> >
> > @@ -1411,6 +1413,7 @@ static uint32_t ext_start_servers(struct ext_prof=
ile *ext,
> >                                         BT_IO_OPT_MODE, ext->mode,
> >                                         BT_IO_OPT_PSM, psm,
> >                                         BT_IO_OPT_SEC_LEVEL, ext->sec_l=
evel,
> > +                                       BT_IO_OPT_IMTU, BT_RX_MTU,
>
> This is doing it for all service registered via ProfileManager which
> is not going to fly, instead we probably need to add a MTU option so
> the profile entity can pass it instead of getting the default.

Actually there are no options, it's built from `default_setting`,
which doesn't set any MTU for some reason. For the OBEX profiles it
probably makes sense to add an MTU field so it gets properly set.
