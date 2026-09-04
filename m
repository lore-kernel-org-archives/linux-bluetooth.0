Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2333381EAE
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532317; cv=pass; b=lTdNp3FHZVxv8rendUszrAZ3di7b0YioRd2FfmLnLKkpRT4UoWEhkS+JWwWVZ+G86a/Y3gxZS0M68nO59HhnZlNftVMO03r51btpmRicwqCr7gDSJSNY399+vLRlCkPfJFDXo6bC9JCvBPbV04SOaIWi5Uz6t5bqQ+HavGanSPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532317; c=relaxed/simple;
	bh=EUrFNP9BCg9WlG2I0gakVeSl3LFCWv3korj723trdLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYwSUPWM0S8BKkl+CwLN28fqmWW9AOayqxgjA7qvdFtBR0WzVhVVDWeIS31X3eb1pCvlW6U2Ig3S+ghAu4B0knwCi/moTxFWncGML54kMW2AgGI0Q4ZAE/JE4ThBjtrZlaOySON43LaN6sUXNItxXXMrSO6EB2UWexDHz6w5nPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFmpJ7GP; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFmpJ7GP"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8588583a7c3so12605067b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 07:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788532315; cv=none;
        d=google.com; s=arc-20260327;
        b=d6x6PdEOWE+Ut+yD0LFrpNqdvjd2oaVg5LXqtoWqDdEtZCMueRQ6QGym1eXSNqfcLO
         uhBeJXDHwDgVvEMloXX8vvxwHxMFPrTuBk8/NP+JP8caegS3Uq+w3fOgBD+wQj5diKuu
         DeEjmy0oLT1DNx0TzdrYDXYYebD81u2MIIVvuiQ0009Gn82xyW+QIFNeaOwrnfynjZRN
         Hx6Aqt1kTZxbG7az6LJ4RTmZA+ijyUK845BXogO8nDIRrc3/tYBqot3d2W3ak+CjCleQ
         qBH/q2JIROXR1dGxAzI9p1NQmEV5ZbYxSaaYNGrM8qZILdAJWJUIrNsGz4OsQeLeqoJB
         3zJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YqCN/HI5RYWhLWtsiJphq0wPY50MMDouXs3XXBcYcls=;
        fh=yr6Zr+L1VND2s1vQD1H8FSIalTDsqnT4Yd2Af36Zg9s=;
        b=sVcDxCL9xaP0yM1bDaCRLTa/j7LJvKJZDB3d+YWrnUo8JhUjSMKsI6KEG8zJBDJmbT
         1VM9Ry/i4Ed0tZCXt7ZZ5ke2J9naCXyaTbj6ZID0fFdRWflhBieX9GMr4jjzErDXEVu8
         9+JmmuRWGwA16Egt+2yGzD49hg5UYuBpfI0j5bL7gcRPmu9JPtsB4yyfCbMtFj99ZLkp
         34MfWFlB7Xcz0T5lP+4FviHB5mFefrtytMULnZ5sLa0zWhUrHPnwcq2W4vCXlIzblESB
         PRsZUgugp589CH3QMwsB8F10TmLCWBKbo2QFPUe3YwxQsOjiPySfYa1gPma1n/JMmVMT
         SbHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788532315; x=1789137115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YqCN/HI5RYWhLWtsiJphq0wPY50MMDouXs3XXBcYcls=;
        b=kFmpJ7GPvpfybDmXCyRQLCycWcO+Cw76yl1kmm5ay1/tW5QroRLKMvPjefER3aJ74u
         zWc/UcvMkY9Vq7lBny/IHZEQxH9Tqe0Hk+klKy8TRwItQbK6oQE+rvlvBOBnqMEpGSBW
         q8zeh07x471DDmFcpk7Q60DjJoOTkPez+9/QBGGu0b5dwcOb3PUNQ3yCP9Di9ISk7FS5
         QYRdhokoA/EhKzXX/Gf6hnyLQtA5dVoL3pAKM7YFbIK+LPdA/wJvY/8c0JZxA7M7AxW6
         s6D3TIitoCE75rDamRmbGrMwR5P2BxTe1TpyjALC7buFxa/QjM8JNOcK1FT3yfXsO6PF
         EVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788532315; x=1789137115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqCN/HI5RYWhLWtsiJphq0wPY50MMDouXs3XXBcYcls=;
        b=cjvos6sieCD7JNOrV12E8s+q3xxPswlc9FLUs8N/caI57E9qyKE62W5DQhCjm9juuP
         pNB2BsiBEugs0ltzwmcHRKSSwafaFXNgu8MNNCsRXLHGjOrvRwUFiJR77u6UQMnx5Bb8
         DEAqpZTJrNQbK5CvGHzfn7LnDxTOvEukpR/Rtc3LRtavPHhAPQcUlm2lI8hvoJy3q3Ta
         rlFZEkp3iqCBMIo2HxDwruPZvrC8Q4N0nrisnPdHlZulxP/RICj8PxwEHVH6yNH7mbee
         PGri+y5Nu26VhDs7jAK0mS/iqg38pvqUevhLNpjRpqVVCAZ8lCOELZnTLrPEXLFAE4B1
         PJ+g==
X-Forwarded-Encrypted: i=1; AKwUvByJIp+CWBulTIp0stRBMqd9HQDodePGLt/Q74n4W1nZCFhuR2Pg2vOyLyRmobtX1xL6LLaqy978PCzA9hvNAe0=@vger.kernel.org
X-Gm-Message-State: AFuF++nb7OUcFJEAxZvmKxBlQuej2kjQt+CGHbZIuCunm4fYVQVe6YhT
	QXF0wSev4eX25c43tP92t65K+C3aM8ipuO4TiG/878N1Cfp2VS/1D9lCdW/nY1o7B2XxuHz8gpL
	lp+PuhO6tGAyDZ0LK+dsmNko/yLh/aYSaixoO0II=
X-Gm-Gg: AYBFou0um2raDLZsbpSxSIP7I2hJvQC2nEtG5p0rkBTtB59EEIAlP3woeK+eKE18ifJ
	SCJHTAuJdzUzRP8kpaKBkbYZ2B4+u5HN9Hf1a3p31g79mtD0oyUhpMD+hNIoI165KYuglxaA2h5
	bbwucRxuBiYeLUa2eWIyJJ6VhhpZvJUCCOG+EcLr/AtP7Yrk/3BhBlkRIUMcvqyw1zRjFVLsnn1
	GTdyXcUu25My42nFmzNPAQRIGnl9cGVEg4FZsBEYKHoWENICFOlVPE4s25s6e11TiV8O3dfMyVR
	OcCWsEUaMPf2PB5dLO/eMkQqfVKnfiNFg7FVQup18dM9yCeyyZJL0s/GgXW9CJwLpFKyidC9O6X
	Itwx6/N0I5YdihfKO0HKnGuYILENg8mU=
X-Received: by 2002:a05:690c:e647:b0:873:5bb2:6c0d with SMTP id
 00721157ae682-8735bb26f36mr3450037b3.55.1788532314495; Fri, 04 Sep 2026
 07:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903-vendor_hci-v3-0-015d62a57c91@oss.qualcomm.com>
 <20260903-vendor_hci-v3-3-015d62a57c91@oss.qualcomm.com> <CABBYNZ+1PqFXSqAPNC3krSaTccv4VT7ERNRWkO-pCg3k+qCH9A@mail.gmail.com>
 <985c44eb-38a2-48f9-96e8-292b0a39e29a@oss.qualcomm.com>
In-Reply-To: <985c44eb-38a2-48f9-96e8-292b0a39e29a@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 4 Sep 2026 10:31:42 -0400
X-Gm-Features: AcwNN1X7ssfGIul69kfUsJjbvYX0NYdULav0ZcJTvPLb7883mahkR3tWYmSMfk0
Message-ID: <CABBYNZLddwpM42-jpbGbi+wpiJgqwU6UB4TKc1KjC9pR=aM95Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 3/4] doc/hci-protocol: Add BT_RECV_VENDOR_PKT
 socket option for HCI_CHANNEL_USER
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Fri, Sep 4, 2026 at 10:12=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> On 9/3/2026 11:16 PM, Luiz Augusto von Dentz wrote:
> >> +BT_RECV_VENDOR_PKT (since Linux 7.3)
> >> +------------------------------------
> >> +
> >> +Control receiving vendor packets, requires hci_channel to be set to
> >> +HCI_CHANNEL_USER.
> >> +
> >> +Default is disabled.
> >> +
> >> +Example:
> >> +
> >> +.. code-block::
> >> +
> >> +    uint32_t enable =3D 1;
> >> +    int err;
> >> +
> >> +    err =3D setsockopt(fd, SOL_BLUETOOTH, BT_RECV_VENDOR_PKT, &enable=
,
> >> +                     sizeof(enable));
> > I don't think we ever applied this socket option to the kernel,
> > though. Anyway, I think we are better off adding another channel,
>
> Hi Luiz,
>
> Good catch =E2=80=94 that socket option is introduced by the below kernel=
 patch, which is still under review:
> https://lore.kernel.org/all/20260830-btusb_qcc2072-v2-2-5c0e0c9dd98b@oss.=
qualcomm.com
> I'll drop this userspace patch in v4 temporarily to avoid confusion.
>
> > e.g., HCI_CHANNEL_VENDOR which can then allow packet type rather than
> > just the known ones.
>
> For this new proposal:
>
> 1) Is my below understanding correct?
> - H/W wire: BT and vendor packets are serialized together.
> - Kernel: splits BT and vendor packets to their own channels.
> - Userspace: merges both channels on RX, sends to the corresponding chann=
el on TX.

I guess that is up to us to define, HCI_CHANNEL_VENDOR could just
serialize everything, so it supersed HCI_CHANNEL_USER which only took
care of known packet types. That said I don't think it would be an API
break if we decide HCI_CHANNEL_USER carry everything, but since you
are trying to introduce BT_RECV_VENDOR_PKT there maybe a reason not to
enable everything to be send over HCI_CHANNEL_USER.

> 2) How would a HCI_CHANNEL_USER user, e.g. Chromebook, send and receive v=
endor packets?

Would have to switch to use HCI_CHANNEL_VENDOR, just as it would have
to use BT_RECV_VENDOR_PKT, but then again Id rather do it on
HCI_CHANNEL_USER if we don't consider it an API breakage.

--=20
Luiz Augusto von Dentz
