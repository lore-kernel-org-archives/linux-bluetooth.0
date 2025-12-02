Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E054774
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685870; cv=none; b=n4/ep9cMxXJpK5yPeiLlROqF16D7G5g1XG8qnK7u1nCPryeN22oIpRqDxwcP0kmMNU6pmWUcqxZkg+Zz1NAzeJ4ErLrkkwTUsR4sPxJNLf2JsGzNw/faQMdYr72BgzscMGRhzroxoKwhvTO14nDtTIrgWr1FTA6CXH1nbCWb0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685870; c=relaxed/simple;
	bh=pcqt4XdjF+CDytCzwvAyGUFPa5+W/Fdo3rdQgQfLPh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezM6q4wzkkzJa523TBzKfT7xfwZ8u7gjH/yhA9+hZvH6LAvEvkXKzCrIJlctCqOwaD+3K6Z25hGKlgqoyPwr9L8utrpf3mQ2y6gpEYfZoByxmnLtxlHoli2wxzlAgy+WmPo0gVzXSG3mMROMlTBYfWFly43Fdu0Ai8Iqf0b2N6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIqgzVZP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIqgzVZP"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37902f130e1so52260281fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 06:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764685867; x=1765290667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0PCMs54UXzZSdH1jgNNXPaRPg4CaAgu9x8m2HqMwp4=;
        b=bIqgzVZPVBGAP5NKddiABgDiBrDEMeGNYELasWpm4LeVX8tmzHCHOnlgHMgAS9Wvre
         BotdXkRIiFC3KT9E3IwSNktvJ4Kk9dvuVoXhm6X0gL/zgRbggSEnv2mBrxXyyY/GR6oy
         f8Ia1gdWgdK4XBJg3ixE4oUtQDfwaxA32ZycaST4TvL5Wk5ITc5qn+++FTlqi1f/x/c7
         iFRf7GBaZTKVr8/i/a7/N18vVN1Q5ddcE+/wiCa8gMT9hcET2oKuF4lloxFrjYAOj4f4
         tA5jzilI0e+I08HA9JS8nxb9fm9uUArWkgs/p2VbDR7vE7IqmXXkBwtsgPMwpCadZEFz
         4m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685867; x=1765290667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0PCMs54UXzZSdH1jgNNXPaRPg4CaAgu9x8m2HqMwp4=;
        b=jI9ORg0omSG3lTIcdMETQmTHUxEx9ifkUL15cBuUkIQ97qzaYFyimihwG9I/55u+s9
         mA51qnbnf5SlTnZHbYIT453kyvqohUyEHgnV4Siix0ggDGTr67vdKzW+OidyYqtT2edM
         OAYFDrwHRBVy7Pr9HMvmw2SHa3MpsGepWzePQTfMkR5g43/Eospu5X5TSf+gzDarC3kw
         cV2D23/I+jLzGbrBzcMMz1JDSXpWhKvlwDp4+mNWLOtK15CIlTvIGIef0cpdhBKoB0gf
         NhR+Lj1BINZnjK7rDw4/wYzEB6qnpsFifbpVGAmjo8eXS59YBWAebfhGiKz1BI3DXEbI
         VsBg==
X-Forwarded-Encrypted: i=1; AJvYcCVDurXb5hf3tS4ey+0q6oBgZ3/6a0JsdDqNvSC20urtCL84J0CCVFcNBkBlbTGqEDLwcPKw4ph4i3Avud8PZdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo12swMCDxLPJcq6kyblx4Hk6LhcPAVoD5Pz25JYOUfBmExrvk
	NkYRMJfLWZ0lADXT6cQv6QnLbz2Po8/dCR21e+lZIIdIOIIrzo06MzEOiRG0zAN1eUim4mFrEZe
	mQnq6fJ4gvd/ZlRQVBLSkFaM0EcANadw=
X-Gm-Gg: ASbGncsnLOV3QXICSrZx9uwQYr1gRFMd+Wb50D/F6qeWLeA2yoyyt9bLTioApfI8rMq
	JjCYRM9nT53xsF8ZBPX8L0o1DV55dY08UJYrHD4ZMeycXPVMyO6OZuSrpQwsG9Gljb3NextqQLK
	H9dqFYnyCRse5DJBqXlPHYmEc0rTWQKNKOS7XWrsxu2yEfnQeyYY7s6lAmtwxCZ2OXH5/jEYvCW
	RkvcRDtYSGAnKPLq+N3s/5C77MkGheEjpgT/T/bBVz9HNE466z6nYRkCUQ6Atzm3A0xOWiRSts+
	TmOJ
X-Google-Smtp-Source: AGHT+IGOwZkzIdsHmSn2gpBjqwrDNfc/MzCaS7PmviqdeiZnZ71DelU/4q3Fv5ydrP/RTxp4VEUkETh4E6PuIjrFBo4=
X-Received: by 2002:a2e:9604:0:b0:37a:3123:fd9a with SMTP id
 38308e7fff4ca-37cd928dee4mr83694971fa.42.1764685866823; Tue, 02 Dec 2025
 06:31:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916140259.400285-1-quic_shuaz@quicinc.com>
 <vipw44g3fmaf7yhv5xtaf74zbgbkwhjgyjtguwdxgkkk7pimy6@eauo3cuq3bgi> <c87533fc-768d-4b70-a1aa-2639e5329058@quicinc.com>
In-Reply-To: <c87533fc-768d-4b70-a1aa-2639e5329058@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 2 Dec 2025 09:30:54 -0500
X-Gm-Features: AWmQ_bkO_gk7n3itmkPSV3EaCnil9GDPcWHRKQKKXaQMjQaimc77N6c5fmhHKig
Message-ID: <CABBYNZJ=C3fYy=SXQyv9x-49vGSjXd-06MsQJ2N3Ps0egMRCuQ@mail.gmail.com>
Subject: Re: [PATCH v12] Bluetooth: hci_qca: Fix SSR (SubSystem Restart) fail
 when BT_EN is pulled up by hw
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_chejiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Tue, Dec 2, 2025 at 4:08=E2=80=AFAM Shuai Zhang <quic_shuaz@quicinc.com>=
 wrote:
>
> Hi Luiz
>
> On 9/16/2025 11:01 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 16, 2025 at 10:02:59PM +0800, Shuai Zhang wrote:
> >> On QCS9075 and QCA8275 platforms, the BT_EN pin is always pulled up by=
 hw
> >> and cannot be controlled by the host. As a result, in case of a firmwa=
re
> >> crash, the host cannot trigger a cold reset. Instead, the BT controlle=
r
> >> performs a warm restart on its own, without reloading the firmware.
> >>
> >> This leads to the controller remaining in IBS_WAKE state, while the ho=
st
> >> expects it to be in sleep mode. The mismatch causes HCI reset commands
> >> to time out. Additionally, the driver does not clear internal flags
> >> QCA_SSR_TRIGGERED and QCA_IBS_DISABLED, which blocks the reset sequenc=
e.
> >> If the SSR duration exceeds 2 seconds, the host may enter TX sleep mod=
e
> >> due to tx_idle_timeout, further preventing recovery. Also, memcoredump=
_flag
> >> is not cleared, so only the first SSR generates a coredump.
> >>
> >> Tell driver that BT controller has undergone a proper restart sequence=
:
> >>
> >> - Clear QCA_SSR_TRIGGERED and QCA_IBS_DISABLED flags after SSR.
> >> - Add a 50ms delay to allow the controller to complete its warm reset.
> >> - Reset tx_idle_timer to prevent the host from entering TX sleep mode.
> >> - Clear memcoredump_flag to allow multiple coredump captures.
> >>
> >> Apply these steps only when HCI_QUIRK_NON_PERSISTENT_SETUP is not set,
> >> which indicates that BT_EN is defined in DTS and cannot be toggled.
> >>
> >> Refer to the comment in include/net/bluetooth/hci.h for details on
> >> HCI_QUIRK_NON_PERSISTENT_SETUP.
> >>
> >> Changes in v12:
> >> - Rewrote commit to clarify the actual issue and affected platforms.
> >> - Used imperative language to describe the fix.
> >> - Explained the role of HCI_QUIRK_NON_PERSISTENT_SETUP.
> >
> > I'll leave having the changelog inside the commit message to the
> > maintainer's discretion.
> >
> > Otherwise:
> >
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> >
> >
>
> I noticed that this upstream patch has already been reviewed,
> but it still seems not to have been accepted. Is there anything else I ne=
ed to do?

My bad, please resend it so CI can pick it up for testing.

> >
> >>
> >> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> >> ---
> >>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 33 insertions(+)
> >>
> >
>
> Thanks,
> Shuai



--=20
Luiz Augusto von Dentz
