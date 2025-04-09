Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54458264618
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744204636; cv=none; b=pybuL74j3kptcxXaRpRQlzGpcqqE/cWn+TA82MGzTlXCgt4hsPtrBjg1ODhH40MKOe1v8SMQkTIrzoDpnvW3RPxEIa+pOLmIf/WlKlwdwR0Gm5Gz6KEb8yvFrucJ4HL5qyRv4RcUkOLsQWcPNI4tLCoIAaXchEZlSmmduU2+wTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744204636; c=relaxed/simple;
	bh=HdYUDeZTObKEBDHCi01QKPUZiC3RO2BYFzKPvjQgEw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eIYClRcChYiRblixiuTzOEs60eV1YLd6rke6X2ujnDwlclv5teVqR25bGH16d96REGYqaAty7LdUlW1x5iMZHW1ORA2tG7Zw+lsu5sjY6gh3rG/KqEYNceTNMhC/7ppT8WeOIffjWKQAD6feJA5zq5YwFpXOSOCnq7p92Lxa8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzOTanzh; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzOTanzh"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bef9b04adso63585261fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744204632; x=1744809432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr6vPILkeIGu/ii7F9WWGF9cxCmgHElCiLk3ffStoAo=;
        b=IzOTanzh9bw8I+6qnosDMv8cHcC4yBzJrbXbltFGlTCg3vwabQlG7tnnwfUWxxFLHJ
         ep95c4FdZO78/RK43RhuyGYz+mh/SeQElIfahIecVy4aT8mxMb43kwW0JAlWpzcVNFW2
         Gn2JUKfRNOFk1fO3Am4SIBddgisTKm2TYBEMSTShEoToXToIy29v5fcYqUaqtQcW48nM
         7mIZx/L01iFBzBP78mvJxgLq46BwBol6sYNO5QWX/EKHYUafzVe45QBg5Ho8t3NZVRFV
         Oli2AIEXfpX0zJA2o10W/qzux8qYejBZ9dMoE04PiPypu7xq/lPJ39P1lqPeNKKg8IC7
         OcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744204632; x=1744809432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nr6vPILkeIGu/ii7F9WWGF9cxCmgHElCiLk3ffStoAo=;
        b=mVi/UHLlGtyA7/DswUE8p3ol1hZ+V1G1h2sqNuMkzETlA9hQFe+yeAbRc98DQ4jMcr
         SGr9MQ5VS5N3DTYmH757ttyGgHNv90rdTxWFXUAcnBJGNk3D/SojvEgiJ1f6B5pMP9ms
         y/yvKMKjFwoG7D7VkPZCPvAq3X2wqiPkK8wMU5MGYHDprgKLLxFmINGA3FYxYQBToG6Z
         CFMTlRwsGqshaNxI2r8gJ4HToIS7Xdv4Kj+/UXdNu7vZFBU9j4ng9HFKhFTlP7CaTk7K
         S4zAXjJCEPEUutQPW4wU6capvZ6hU0IOHNE+uLExzESm2yqOgLhFuWBVs2xpxifegeim
         jeng==
X-Forwarded-Encrypted: i=1; AJvYcCUceps6ckgBnVkUxPZmD5vo835WtuwS6Xw5LdidLGmNv1swWIcp4uKgiTZ8gfP8VEUIgPLO315r77zai7WOCsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmsQt1qgcmmmKiyAbg6dlqhkfpfqv49u4dnYeoTANBxJlpg4H
	AqkPQKID3bMfcqSABv9FrX7bDE1Vx4q6I/fX8+W0LPXVJAT0/YWCHkCVmcDTvm4mo1C/uvni73R
	PAEdXDyn2yBUD4Zyxuvh8Tz41eaY=
X-Gm-Gg: ASbGncsnCINWNmEDioM9ld4qRM79XboMYBx1wbUfmUL+13XMb8WxpdLjmANh8xsmefO
	jh5tBnoHmkOnPdjZND1u2OFAF0V3/lnVdoJXMlUFE2Bo3hTNOrMsAduj4V2BTzweLli+FCWcG5n
	l2r8ChG0VfRTAMCX8+dVCMDViw8nmwuv4=
X-Google-Smtp-Source: AGHT+IFfUKkJEEnXyoSw5bO75YHHZVELVfznxXY3gimTLlv8tJbzd0oQgjhoauYalVdaDKrPsmX/bE71h1SFp0h0ff4=
X-Received: by 2002:a2e:9a09:0:b0:30c:1017:e5e2 with SMTP id
 38308e7fff4ca-30f438a2fe6mr10381241fa.26.1744204632108; Wed, 09 Apr 2025
 06:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408115146.2300584-1-quic_shuaz@quicinc.com> <46521c87-ed61-420d-bb2d-d5499d119f5c@quicinc.com>
In-Reply-To: <46521c87-ed61-420d-bb2d-d5499d119f5c@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Apr 2025 09:16:58 -0400
X-Gm-Features: ATxdqUENWCPDpJKXh6iJrcVETZCH3QACGE1kG6iPob8mXGZy9vplL_E8jifwwBs
Message-ID: <CABBYNZLL7C=C-X+YCFmwh1PNQ-uq5cbVi8o6FXPHPkEBxFFGPA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Prohibit establishing of ACL
 links during poweroff
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org, 
	quic_bt@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Wed, Apr 9, 2025 at 5:13=E2=80=AFAM Shuai Zhang <quic_shuaz@quicinc.com>=
 wrote:
>
> Dear Paul
>
> On 4/8/2025 7:51 PM, Shuai Zhang wrote:
> > If turning off BT during pairing, "hci_acl_create_conn_sync" has chance=
s
> > to be left in cmd_sync_work_list. Then the driver will try to send
> > the HCI command of creating connection but failed.
> >
> > bluetoothctl test step:
> > 1. local device pair with remote device
> > 2. once pair is complete, local device will immediately perform power o=
ff
> > 3. powe on local device fail

Doesn't look like the real commands to me, can you create an init
script out of it?

> > Check if the device is not starting up, that means powering off,
> > when establishing the ACL link, and cancel early in this case.
> >

Ok, but if the controller has been powered off, or is in the process,
then hci_cmd_sync_cancel_sync shall have been called so commands shall
not be pending, or perhaps there are more then one command pending?

> Do you have other suggestions? Please let me know. Thanks.
>
> > Change-Id: I72802f306a20d43282dd374dd33b8cb1a22f48d8
> > Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> > ---
> >  net/bluetooth/hci_sync.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index c553b637c..c4f1c0f30 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -6755,7 +6755,7 @@ static int hci_acl_create_conn_sync(struct hci_de=
v *hdev, void *data)
> >       struct hci_cp_create_conn cp;
> >       int err;
> >
> > -     if (!hci_conn_valid(hdev, conn))
> > +     if (!hci_conn_valid(hdev, conn)|| !test_bit(HCI_UP, &hdev->flags)=
)
> >               return -ECANCELED;
> >
> >       /* Many controllers disallow HCI Create Connection while it is do=
ing
>
>


--=20
Luiz Augusto von Dentz
