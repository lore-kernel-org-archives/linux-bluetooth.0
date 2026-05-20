Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289734750B
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281140; cv=pass; b=shSqns2pgzzI0qAkpP6fPXrn+NSYD7Kz3hwL/q3HAYBO9el0iwkQw4Cxds2lz2a+knbvBBlR4RqVK+J6XV5+iYWuUGSsqT6JYBxSdwwo6GZMnrx1oSFDZFSMDKVOwzFbcqLzYfae/cqffdToMwvThLK91b+nDSjYvtT3qu0f+wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281140; c=relaxed/simple;
	bh=Zr6fDgtgqQ608ihSJ4zPlo5bJFSyQdqQcxPawOC0o4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFRUfxbDMKsOPw/h2Z+RA2yfrE06eQUF8oSrWMeudQpxvyhN5ilp0NOV2O3cPXUNy2jqUzfP16ivy0Ma+tN/43aICiJKA3l6+am1YH5v41V71S2eTLBEWnoGyOQpm6D0Jg3fu4r/A4iAZiYe/T6hcnLH6ZLoKGMVMGnzOGqHbFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C59doYWf; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C59doYWf"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6530287803cso4872955d50.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 05:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779281138; cv=none;
        d=google.com; s=arc-20240605;
        b=C11HCVxRqjF8lcMRZIFSjodqtvIiejAP4GlNXXfAUBD6nQSOn8JrUQ5jxAwawEAsAL
         NGRU9Ljip5KF7j79n1lYu6ORmknikYs1DSGxE0E1H3BnF4hrgLPep7l+w+XLJrjCwuV6
         t4jKvo10f6+sNdMgwKlSWEsTKUmdVNaLFBf7e19PUqb7WdsGp3SCHBcqwpw17KHCdblE
         H/N32ovPRv2AQGXIt5XK6AnE0zpWUZ1d5JNpDlQxx0LLJVuiwVnZdodFYSs5apRZgMbB
         d8/knGX6Tl4fo71+/J4ilUO0uialCtDftk4im2ZqPHPeL5WQMIeztok6kwdwE60T5Pj/
         rgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=owE6/rk6CV8oIG5RVGVmceXWUUptpiMPhTe83gMGqsk=;
        fh=AXRpHkfgyMYqHNri0s95okkWv0qEBAW7zAFeTK3zl0E=;
        b=FQjNqIWEIwk2NPBFn6IpThJ0FtksGutVAlQAK1ZVQDOnSuWGgdsES3bxneGxuNWiUM
         fd/U8XCsl9hqL4mbcITSaG5uhMdRjyn9wgSDJoGh00mTqHQVaDxKJjc1NU5oCyYFj3Wb
         ZMRh1Xe/OQeGBvNaWXBsFQPFSMpBxvxvc0QP7/XjzrVwISmmpB7kxphBMD/uL6OFZh7i
         3m37ZWcRXxy1NwpNveuh4sl6RXdjO7ZxneBElwT/t7ljCHS7QAujfcslObqoPUvB9tK+
         9SRyHxQmnl7xhyNnL2E4yIoXFCoLQhYqEMgxeMA5A5I6qxIXJWPuQWPH4kEeLxtaaxyT
         hEqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779281138; x=1779885938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owE6/rk6CV8oIG5RVGVmceXWUUptpiMPhTe83gMGqsk=;
        b=C59doYWfAs/TqTaHrPNRY8YydQQJwKmlmax+EbsBH6HWM0021uc5j7Za6g61yvL8AT
         RfXRJWjtBVV7FIexpH5bvLtQAqG/Nw4rEpccNM1rK4uhFT5rGaF23xjI5A+WAMG/G9U2
         8QekOqfRawtDifzQ/HqTNGl584CaS52ZNu6WNe34xyDNm6uJinIW9ww0VtlGZvQbxr71
         cJDEL2lSReg4LPu1q1s9hf8NH7GIdir3xgcnrco3hOkWMTHbkqKX2G36njsALVrbFMSI
         uMj0hh3W//RD0tyYVrUqtctbY1qY4l0t8q47R1yAW69QZWsgpoGD3QconFYCS1SaCm80
         nzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779281138; x=1779885938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owE6/rk6CV8oIG5RVGVmceXWUUptpiMPhTe83gMGqsk=;
        b=rNKpxOgf4WKrSBluBbZyMEkXb5w2oYASLLqTZYqfZ+wOrvNBcF0OnuYXHb1lqO9bxA
         oJQ0Tb0b2YJspxnVzLKiKFLjM9ETxOYWlppxk8U2dQ5UeOkBabLrpn0A0GI1r7RPdIKD
         VUl4j8UfWPcORCq4JXqCOg7D187pjlN4q6WvHjG6xtcS5tJfX2RyFyoU2uYHXlZidQrF
         nR6HnlFtMh5X/tAr4lRk6NsGVN1sIOS/qbQAmmuy9MBjX4A0vQq6zohL95ADGt9MaHt9
         E3mxeRA9dLzniQMOPLoVDggMyTc7o9lMF7gvw8FxfYPMV8ZUApGu1k3SkS4ueLFyD18p
         4YUA==
X-Forwarded-Encrypted: i=1; AFNElJ8rWGwCP63fSIhEyhkodeptJzMtyPB0XmzCwmbFOsQmVeD359J7RF1TqWaGslT3RQQMyPfL55/qoqlX2QKaAQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrouWUclqdwPPvaNZoU1GMLw1oAA/N6RiuIsLU+lZWSI6Fkdl
	/cDqKM3Yf4pI4GcmdDszV7Jjm5+ad2kYMR/Q7uiTJM9NIh2LCR6WTnLs/WmMFwBn57ZcIIlI7lk
	fxRH7Mv3ugLgCU7hh0J5eVS1b0t6WUcQ=
X-Gm-Gg: Acq92OGfR9P/E+phX5iHLXFQ8ACxa/cH2LjPcZNmvJvuJOEUPISAviZBfGpjQ6Vb3hH
	ja5d/gvmVnFugKVyl0ywRHGJrBZkfbKs0uPDzDk9hdiwpM/XT8K+Dr1VXegtmOc1cah1FtxawYa
	tBYHKfjr5r8dXlXII/j0Ilrjn9jjQ6+yPeTnJwRFyASZt62zNPGHnbBc36Q6V05dCOOcxM9UDEB
	WF7SN174hhkgFKEAowKENwUV3qpKYpxsNimm7blncjCtnhl2XlN4nz1EmYCaXt4WY4bn2NOkUCB
	47By1u8krpggNWPSzJVj0rO7MDpsdoLTqM9ScG2adH41279uCGryn2TXSfhLEgfSridn3A==
X-Received: by 2002:a05:690e:4290:10b0:65c:2208:8c6a with SMTP id
 956f58d0204a3-65e227dfa70mr18799613d50.42.1779281137588; Wed, 20 May 2026
 05:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429121207.1306526-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZLP+rBrjhdKJLE7N47Bg-g4-6E3vS3yZXvMKwYQ2rMcUA@mail.gmail.com> <cf77b8bb-5427-4d0c-b212-51947704378a@oss.qualcomm.com>
In-Reply-To: <cf77b8bb-5427-4d0c-b212-51947704378a@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 08:45:25 -0400
X-Gm-Features: AVHnY4LANykzFlJjohSPf1MUwg4Jd1zV9n22FmYZBRYzx2u9wrls38xdDxN_sf8
Message-ID: <CABBYNZJpW8=KtN9_G2QOp1YqD3ZJhWGVriyLBh7jUGRFEHPyYg@mail.gmail.com>
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

On Wed, May 20, 2026 at 2:26=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> Hi Luiz
>
> On 4/29/2026 11:17 PM, Luiz Augusto von Dentz wrote:
> > Hi Shuai,
> >
> > On Wed, Apr 29, 2026 at 8:12=E2=80=AFAM Shuai Zhang
> > <shuai.zhang@oss.qualcomm.com> wrote:
> >> The Bluetooth host decides whether to download firmware by reading the
> >> controller firmware download completion flag and firmware version
> >> information.
> >>
> >> If a USB error occurs during the firmware download process (for exampl=
e
> >> due to a USB disconnect), the download is aborted immediately. An
> >> incomplete firmware transfer does not cause the controller to set the
> >> download completion flag, but the firmware version information may be
> >> updated at an early stage of the download process.
> > Hold on, if the download has been aborted then the version should be
> > reverted, or rather just update once the firmware loading is complete,
> > so this indicates there is a bug somewhere that needs fixing, not
> > worked around.
> >
> >> In this case, after USB reconnection, the host attempts to re-download
> >> the firmware because the download completion flag is not set. However,
> >> since the controller reports the same firmware version as the target
> >> firmware, the download is skipped. This ultimately results in the
> >> firmware not being properly updated on the controller.
> >>
> >> This change removes the restriction that skips firmware download when
> >> the versions are equal. It covers scenarios where the USB connection
> >> can be disconnected at any time and ensures that firmware download can
> >> be retriggered after USB reconnection, allowing the Bluetooth firmware
> >> to be correctly and completely updated.
> >>
> >> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> >> ---
> >> Changes v2:
> >> - Update code comments and commit message to reflect the correct logic=
.
> >> - Align the commit title with upstream conventions.
> >> - Link v1
> >>    https://lore.kernel.org/all/20260108074353.1027877-1-shuai.zhang@os=
s.qualcomm.com/
> >> ---
> >>   drivers/bluetooth/btusb.c | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> >> index 572091e60..70abbabea 100644
> >> --- a/drivers/bluetooth/btusb.c
> >> +++ b/drivers/bluetooth/btusb.c
> >> @@ -3550,7 +3550,13 @@ static int btusb_setup_qca_load_rampatch(struct=
 hci_dev *hdev,
> >>                      "firmware rome 0x%x build 0x%x",
> >>                      rver_rom, rver_patch, ver_rom, ver_patch);
> >>
> >> -       if (rver_rom !=3D ver_rom || rver_patch <=3D ver_patch) {
> >> +       /* Allow rampatch when the patch version equals the firmware v=
ersion.
> >> +        * A firmware download may be aborted by a transient USB error=
 (e.g.
> >> +        * disconnect) after the controller updates version info but b=
efore
> >> +        * completion.
> >> +        * Allowing equal versions enables re-flashing during recovery=
.
> >> +        */
> >> +       if (rver_rom !=3D ver_rom || rver_patch < ver_patch) {
> > As I said above, this sounds more like a workaround. That said, I
> > wonder why it would print an error if the version matches, it sounds
> > to be that if the version matches it should just skip and consider it
> > has been loaded already in case the actual problem is fixed by setting
> > the new version only when loading has been completed.
> >
> >>                  bt_dev_err(hdev, "rampatch file version did not match=
 with firmware");
> >>                  err =3D -EINVAL;
> >>                  goto done;
> >> --
> >> 2.34.1
>
> Just checking if there are any updates on this

I had the impression there would be more changes needed, if this not
the case than let me know, also perhaps we should consider adding a
Fixes tag since this might help users experiencing problem if they are
dual booting or somehow got the wrong firmware to be loaded.

>
> Thanks,
>
> Shuai
>
> >



--=20
Luiz Augusto von Dentz
