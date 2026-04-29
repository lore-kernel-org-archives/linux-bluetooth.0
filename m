Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAA402BBA
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479310; cv=pass; b=rrOJkPQYxxrFSpwe5eLTQtquhkL222WChssrVvqo+PDAZht8kupToJKAYJuHhV5kvBvjQb3hL802Qj8TWDrCdqCtxzDaxxNCJl0pyt5N0UL8Tt9Hp0ofW7gTP02WZTNnFIC6pErZ8vNpsu2iPkN+xfSAzvaB5IuVNsg6JmzySLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479310; c=relaxed/simple;
	bh=UPLJnzuRXE0jM27gAHduCD71+a58v9ckdqbBE9VNhs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7aAa8900MqEvpM2RiuLZeJIZmvJjUsga/IYfn3pyVm1jX9+HNq/SneMikdEvvxq3MB4gHFBmeNT2VFdkNblN/JA9Yd5+D8L0aRl/pe8HCzBQVqlLeRWy0tg3gUbasrNKisxR4tsL9srqS15dTVBIW4aM9mV/1F0Mt131yASAl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmgGSNHP; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmgGSNHP"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651bf695701so11760247d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 09:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479305; cv=none;
        d=google.com; s=arc-20240605;
        b=EXwqzr7bg3tSvjXDOfuWWXi9DnhGQ6N7z7o2ogLyg+/iMWNPv3ayp/zu1jQcRvxyon
         XyNzF/hMkjXXDXcf8uw284VLwS3DurW1ZY3ByZSb7HF/N+z1tDOq5eWmfjCWtXG+2wCb
         OQFc64+fkLyf7p/mO1YopG8lC7m9YSH4FP/bl1VjTO416V4WhWu4vorMPYN/wApVbgkh
         LEVxVkqWfQi3NcIQBJPtn2zZvn5F56JO6d9QcjDm8ody2XfC9HPjqkB+N2kzGV3pMpUc
         ss9iMNyN7DyXahyrlQi8CvBUCM6e8U3G31GNo7yAHDhINbzkLubSwyB6zJeVuyPgnRMe
         iGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5rUkZAOipt+mPbY1AIV2H0jbdpVyPhjj9wOoigCLOxI=;
        fh=QL3zaYYtX5UWOh8pyx2wOf6ao2WMtmZhWIbbNy1Kb8U=;
        b=QeNpGGiDLedZntSufxx4sR7+8jacwlMzF2ruhOVl0Xl6xjCh+3nXd+Wax6xgjEoVXd
         E01LhIht2RID12f6/VQ004W36QCUCjhsDnJ/roeI4TlXKyUqqtQh8Q6CvQeunZK/gxPz
         fhc7RKfCcU9SihRAa+EEdjJww98H8HfFbmpT1j7oAv+mmqlOT+d9qusJX/zgD9VDYdFk
         qqR/9tGgOVgcfrw6iBQ5e8acrg6x8YKlSqTAZrP97umnB0vU1nubpp43JVKYUD52e9en
         XYW2AMGNT6g4/7ypddwehXQB+8BKs/7he9OaGXxwFvLAKLWHJYlQ1SVxuLVMdXvNuv50
         be9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777479305; x=1778084105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rUkZAOipt+mPbY1AIV2H0jbdpVyPhjj9wOoigCLOxI=;
        b=DmgGSNHPJQd8z9oeLhROIe3souBHmr82QlvKa8fZfnN34/t3sG1IetpDL2Sd05p/2a
         seC6ydAaG6p2Ny/jRMOJFVb3V7T9vD/yR4B3Zl+t+wQT7VQruDc5F05b1efeEhb32j3z
         xHZs3Luus1DpbA/hgDRKz//FbY3wXxSpyE71qYutyezixnRbi3Wscig7LaLT9a2q+oJT
         0H60oOewU+J++B/iB0jIGNFrEifvH3oL/1Wm+AMxeO5c8z1L5M2EY8luYcQBCRJ0ZG8N
         9aYslUm4oGpgCr0EJNyhF0hgCJG5mNnrMvolVJzscmQfNrq6kt5yEuDqoXmH92AjqAle
         qysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479305; x=1778084105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5rUkZAOipt+mPbY1AIV2H0jbdpVyPhjj9wOoigCLOxI=;
        b=hc+1Mg0LG8BLNutLaRD65uPTFJSIKM5pae9B6dB1drPpZzboHnsTKTPMs/bn9upgcZ
         XN7pHjYcr4OSiTFmGrNy4NiCfewgv4Ius9CMENBBNzYu2ZsgKq/O/dBJ/qt9N+qUq0Ab
         Gp6UhYFZMnskvEFLms4mFAj2GqAezuSdOVsAIBHMehaquHGdk03AEiiIvWyYhNQ8wDu/
         KAuGtu4reOwL790NI7P5vp4zT4l1Oue3bKmoyfn+/njOVgaLLWzS1kCA1Y/IiRTAHfys
         Og/kj2yM0a/x8z3fzxhwCSE4F9eWZxqjqrNtndIeSEou3KnRyRXKWfi8Rm9zCGWRcMwu
         qP4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8cQ+J90ALR2EFdsfFVNfoNiNDV/CRgTPXdAVNUHg4dq9k2Nz224rdlxPdI446UvLkSCrnT+/GFdeCHbDjfrzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ztioyCwEc0/+A5fFY59aX46dW0HG+Oe3UcXrMyXGqzjDHy3O
	JlYpZRgAFfJ1l+vT38KQ5G2JMT+MreTo97uUr/nZQbYIi+IatUiuYDPs4xPwEmDviych4zK/3ed
	7lC2Km73zUbHJPVj9u7CumvuEMS3tM5xB0qDuu4NbIA==
X-Gm-Gg: AeBDietMjtMSgyjThii7rInESRxoBskGMNn8L6bSceI2HZC3NgSPdgsHAFcrlMSQmMo
	zisPPNh6hxLHICqweIxUvWj9aqcqjUIDC+rm/yaaNDI2tVTLagQP4/TnTncBVBQg8PzkYKqmgFc
	0BsUn4JNfqnDxHL38dIBL+eL7l3lSuoseWdSGl1haDxRescvSPM9Yiob2xjdMR4sjzXis/xA+be
	opdYZYDXvrtBO0GID0Cy4ChH3UAofG8ybsQ/vbvNMT1S7P3/4XLhierCzO0pXqqIVjfGrfgZoHv
	695ZGgamjsfxS1r11KCTyqyZfTocEszaMzz9mTXStWO1xhP3a75dzmIEsGzNv2692J33ekyjGz/
	BwWha
X-Received: by 2002:a05:690e:4253:b0:651:c71d:8a4f with SMTP id
 956f58d0204a3-65beee95f1bmr5622309d50.51.1777479305063; Wed, 29 Apr 2026
 09:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429121207.1306526-1-shuai.zhang@oss.qualcomm.com> <CABBYNZLP+rBrjhdKJLE7N47Bg-g4-6E3vS3yZXvMKwYQ2rMcUA@mail.gmail.com>
In-Reply-To: <CABBYNZLP+rBrjhdKJLE7N47Bg-g4-6E3vS3yZXvMKwYQ2rMcUA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 29 Apr 2026 12:14:52 -0400
X-Gm-Features: AVHnY4JV2GGTpDCEOLEPMF8tGxsFSpeGXdY9sYwkj4hNwRvxAWwRpBteg7c9K1E
Message-ID: <CABBYNZKbVT2xXqedwoenuU0YroJO-3gyhJGSixt0zvodLez0qQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Allow firmware re-download when
 version matches
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Wed, Apr 29, 2026 at 11:17=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Shuai,
>
> On Wed, Apr 29, 2026 at 8:12=E2=80=AFAM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
> >
> > The Bluetooth host decides whether to download firmware by reading the
> > controller firmware download completion flag and firmware version
> > information.
> >
> > If a USB error occurs during the firmware download process (for example
> > due to a USB disconnect), the download is aborted immediately. An
> > incomplete firmware transfer does not cause the controller to set the
> > download completion flag, but the firmware version information may be
> > updated at an early stage of the download process.
>
> Hold on, if the download has been aborted then the version should be
> reverted, or rather just update once the firmware loading is complete,
> so this indicates there is a bug somewhere that needs fixing, not
> worked around.
>
> > In this case, after USB reconnection, the host attempts to re-download
> > the firmware because the download completion flag is not set. However,
> > since the controller reports the same firmware version as the target
> > firmware, the download is skipped. This ultimately results in the
> > firmware not being properly updated on the controller.
> >
> > This change removes the restriction that skips firmware download when
> > the versions are equal. It covers scenarios where the USB connection
> > can be disconnected at any time and ensures that firmware download can
> > be retriggered after USB reconnection, allowing the Bluetooth firmware
> > to be correctly and completely updated.
> >
> > Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> > ---
> > Changes v2:
> > - Update code comments and commit message to reflect the correct logic.
> > - Align the commit title with upstream conventions.
> > - Link v1
> >   https://lore.kernel.org/all/20260108074353.1027877-1-shuai.zhang@oss.=
qualcomm.com/
> > ---
> >  drivers/bluetooth/btusb.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 572091e60..70abbabea 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -3550,7 +3550,13 @@ static int btusb_setup_qca_load_rampatch(struct =
hci_dev *hdev,
> >                     "firmware rome 0x%x build 0x%x",
> >                     rver_rom, rver_patch, ver_rom, ver_patch);
> >
> > -       if (rver_rom !=3D ver_rom || rver_patch <=3D ver_patch) {
> > +       /* Allow rampatch when the patch version equals the firmware ve=
rsion.
> > +        * A firmware download may be aborted by a transient USB error =
(e.g.
> > +        * disconnect) after the controller updates version info but be=
fore
> > +        * completion.
> > +        * Allowing equal versions enables re-flashing during recovery.
> > +        */
> > +       if (rver_rom !=3D ver_rom || rver_patch < ver_patch) {
>
> As I said above, this sounds more like a workaround. That said, I
> wonder why it would print an error if the version matches, it sounds
> to be that if the version matches it should just skip and consider it
> has been loaded already in case the actual problem is fixed by setting
> the new version only when loading has been completed.

Btw, the following also seem valid although not introduced by this change:

https://sashiko.dev/#/patchset/20260429121207.1306526-1-shuai.zhang%40oss.q=
ualcomm.com

> >                 bt_dev_err(hdev, "rampatch file version did not match w=
ith firmware");
> >                 err =3D -EINVAL;
> >                 goto done;
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
