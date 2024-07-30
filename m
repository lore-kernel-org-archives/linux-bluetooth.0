Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401B18C907
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369607; cv=none; b=BLu1WkJmTjIupblmP2iIbaMU32TEjHXC7k9HsGgxz6A1U/T9aO7Yh9pEyEX7XOUmcBaHpImMu6t7bug4EkMRZr+ZLRND/W0ITOE45oGdHdtaaCKBfqndhn7KPoETQ/1njVOiYo9dMtWhA7qDMH2pcjakT+tSWCVvtctqLFpgy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369607; c=relaxed/simple;
	bh=17mqQ6aBRQmb4DPQTGvud8jcFpWd5WVCNp8ByQ7Ry6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PB0NS1m/43Kf29V8r4RnP0/8cbJNDGJn5YZmCDEVcKUdotXB4/wqQvrmaVofXkuRNJF+oz0y/qknDAOMgQl3QJzgmoE60XRebIOPpPqD6J2TraNtwm6FAnxqACLkjIA4ZiV3kHXmt+eVuk4LO6JWLaLAwQz35oUhj3Hp8g1TIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tETgU/iD; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tETgU/iD"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66a1842b452so28483487b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722369605; x=1722974405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgVb9XhPQB1gngUTp71MbXgOjyUne3c6ypwNzETIFhI=;
        b=tETgU/iDPxaiUDgv9Ywu+rQMQSFK0D2SoU67KhS+nfDio2WBqs+SQSpsb0Mje7vz3R
         fP2+ZTwVwGqcMfH+pXsc5w0Y28xFr0lfNQp6HtzfsfIf6VXfK9bn93TMayM1nCgyLnqb
         6ItY91vtscr66qn4ojXk7KoUACT4PnVmf2N29Y58NCIkxVGK9wmBEz8YDtkv+q+oIlgl
         xXNLrpk0PLZGjk2FO1jklZMELUi9eEx6oDFxadegLUpDtACkikXIk8UAZWB2ruiHFh9h
         i5x0fP63ZNH8yxKBWAZSnFKbffUEoyr9F2gwvdf10FQUuBZeXMVI0QGrQQx/lebTZXi0
         7W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722369605; x=1722974405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgVb9XhPQB1gngUTp71MbXgOjyUne3c6ypwNzETIFhI=;
        b=odHCbi3nSMh7VkDBeYz2LUpH/3fZDKUTbyEicSmN3fpJjLIMzEGh/rOPgt3pvsO9E1
         Sfa4Ef7HP250G2GXWtqdhZRY0g0Mkmuo+VC/uLR1sRzlH+zx5JvzrYFCJQSlmDRo5xIN
         YGJpUe5BkXRvHAS/QtLWwN3TfEt6twrf+UVVGtvWucr+QRU/NluxPCX5/r4KTqL+iIEh
         J8YOCQa0i4mnzoDNgFNIBS1tax04z0n8MBMptGbUCVi9v3vtKx0oolYoGPMESFbKk09V
         mDOniZwF52Imj9aptEOLdKJbqdA2V9gPqNqeUDZW6X2VC2g6AXZ8HqxrpAHI9g2qKNnp
         F4vw==
X-Forwarded-Encrypted: i=1; AJvYcCXslqyAWH/W4e5sxb7p6ri93oe/L/UXcL1bXT31+u/fliuNMyrVLfPuavzD5gK2vHl3QyUC2/Z95qLvbT6wl1H2dibPysszp+NkeIkEjYVX
X-Gm-Message-State: AOJu0YxKMFiQGQabx2CkuLfgkigczEVRuuWNWoxW3o8kguLbO1GEN5Xj
	c593Vq5xqZ/mzpdLIcXw2V92i84lMyOf1RX9zSMFDNgKZG43+nwlf/4zI/mG396rVWwaOQfN7og
	ftQkMsYuohRQY4jWtqrg+jzRkVpCnwZed5+gWuw==
X-Google-Smtp-Source: AGHT+IFZyCNoApPBqkmrekNisD8InLharOF9v8nQbJqMBHwURiZ9Vh3SXUVeCcMOUIjoXkQJ8BtArdviyFa3jzm3I2c=
X-Received: by 2002:a05:690c:3811:b0:64b:6110:281a with SMTP id
 00721157ae682-67a072b8250mr163166637b3.21.1722369604815; Tue, 30 Jul 2024
 13:00:04 -0700 (PDT)
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
In-Reply-To: <b1061ec0-5f8f-44af-8955-2d6fa11f94b3@penguintechs.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 30 Jul 2024 21:59:53 +0200
Message-ID: <CACMJSet3H3B1rz2eZyxUr_ySUOdhTkAognfKpFZ=Kzto8UsxMQ@mail.gmail.com>
Subject: Re: QCA6390 broken in current kernel
To: Wren Turkal <wt@penguintechs.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 at 21:03, Wren Turkal <wt@penguintechs.org> wrote:
>
> Luiz,
>
> On 7/26/24 12:25 PM, Wren Turkal wrote:
> > On 7/26/24 11:52 AM, Wren Turkal wrote:
> >> On 7/25/24 1:47 PM, Wren Turkal wrote:
> >>> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
> >>>> Hi Wren,
> >>>>
> >>>> On Thu, Jul 25, 2024 at 2:35=E2=80=AFPM Wren Turkal <wt@penguintechs=
.org>
> >>>> wrote:
> >>>>>
> >>>>> Hello BT folks,
> >>>>>
> >>>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be
> >>>>> broken
> >>>>> at least since commit 720261cfc732.
> >>>>>
> >>>>> The KDE and Gnome bluetooth control panels appear to think there is=
 no
> >>>>> bluetooth hardware. Rolling back to 6.10 appear to function.
> >>>>>
> >>>>> I have a Dell XPS13 9310.
> >>>>>
> >>>>> I will attempt to capture some kernel logs in a bit.
> >>>>
> >>>> git show 720261cfc732
> >>>> fatal: ambiguous argument '720261cfc732': unknown revision or path n=
ot
> >>>> in the working tree.
> >>>
> >>> I gave you the sha for the built fedora rawhide kernel package, not a
> >>> mainline sha. Sorry about that. I thought it was a mainline sha. I am
> >>> trying to bisect the problem. Hopefully, I can get a mainline git sha
> >>> for you soon.
> >>>
> >>> If it helps, the build date of the kernel is 2024-07-19.
> >>>
> >>> Sorry about the confusion. Hope this helps track down the problem.
> >>
> >> I have managed to get the following commit id range for the issue:
> >> 80ab5445da6235..e2f710f97f35
> >
> > Narrowed to 80ab5445da6235..586f14a6a182
> >
>
> The first broken commit is 9a15ce685706e73154.
>
> commit 9a15ce685706e73154f03341b35ff5943e46d039
> Author: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Date:   Wed Jun 12 10:01:50 2024 +0200
>
>      Bluetooth: qca: use the power sequencer for QCA6390
>
>      Use the pwrseq subsystem's consumer API to run the power-up
> sequence for
>      the Bluetooth module of the QCA6390 package.
>
>      Tested-by: Amit Pundir <amit.pundir@linaro.org>
>      Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on
> SM8550-QRD, SM8650-QRD & SM8650-HDK
>      Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
>      Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>      Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
>   drivers/bluetooth/hci_qca.c | 74
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------=
-
>   1 file changed, 59 insertions(+), 15 deletions(-)
>
>
> Bartosz, I added you to the thread since this is your commit.
>
> Luiz and Bartosz, is there any other information I can provide to help
> in getting to a fix?
>

Hi Wren,

Thanks for the report. I was made aware of this yesterday. I had some
more regressions on my plate but with those now fixed, I will take
care of the Bluetooth breakage tomorrow morning.

Bartosz

> I will next try Zijun's suggested patch.
>
> wt
> --
> You're more amazing than you think!
>
