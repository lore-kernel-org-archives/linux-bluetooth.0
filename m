Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A143A784E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901210; cv=pass; b=FQPyLCYvIChtmNxPKCBy/2jToQ3LBYtxvi6yNL7dIn2sCb1f14nJwKOmrqHAu+AfCIcUmOP9KessdXqqQu3IPspuMATEdbI1AOZYw4aDfxaMCdlyqmWC6kcWtpZ+0whxWzCWgIsRpZZVCIycCOnLGqRE32qPs7yL7qxtfvAWxgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901210; c=relaxed/simple;
	bh=rWQPOX2rN4fPlWhJiE5JCzH6fz7W6t38/10QBhgrqqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLXFufZe0QEwI42yeLGbP8SfJhON+BLIU4RQl/5diTx1Ghi2Mtrlr2lccNeK+yQGmYWARsbXs7oelM1HtfILy7Q4RLs5e702qsXz+BgMOTr7kzZVW68STkWQfsdgVfNJqHYJf6ZcjZI4Ct5vG1D6odHZ4uVF5fMpfCajSt8bNl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwZI9Z10; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwZI9Z10"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-855a66e5b5dso41928657b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 14:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788901207; cv=none;
        d=google.com; s=arc-20260327;
        b=QXoXOeN2Ydjc6aa0GqNKQnDCfcweMk0dXyLawNCunshDZ/ORWCI0294vIaYX8vdiKn
         pepOHHDDa6zJ5GLp5/0aG/ravtq45UZHZ4U2yGyHeOm2X2TI7nuITPkD8TiI1ISnD+hT
         1llcx7ws63t8FY3sWn3Xfpglbxyaw/fLmbWnqa+SbkbMkkeq4OxhSNUZHsTAkQWD1cKF
         BPZ6VIYClMmDNHYWTljGqiCkuUnR3FHkkU6uAA+NzTCRc9159zXsQF9pu37dru6pwnt6
         qAHUvQEMDOsZXZPtUVCu1/ZErCSGLVUsrlxlWX+7kcDHzOpgCKqxQeleebBO+ZyF5pmq
         ILWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r03JHVqatUaUPMmsv4urfr2IsvkiMywhjIlOj6S9eWU=;
        fh=XRvLU/Z8Tjw9DiDESW7gmHVRWdah2SRPLFEa4dB67jE=;
        b=lY1JZrkPMkEf+Qs9r1IwLEPRO7opcKDFMJHYTxznZqWYYCRLndYU13Fu7gK7ff8G5e
         5+nn+MpMXbnItSjGHrJGJwjV4O32FmIMHWUAsOBZSerQBThXGhx5nxBAvcNvgTzv00tL
         J4QVFGt+8Ap+sSXk313RdJMBTKV/3QyG2XoUsZkkuugZj2AO3//frbkLxjC5YobEF9+E
         QBLlzBEEc8G3eFWRBpjFAVW7hma0T5AtlaPeBBTgSmpH+vhI0WA3Lzqxi47sgBOi/hfH
         9BmWVgdJRugv1Hl1KzG/oazzyMhsQ9qJJIwAeowxAXTPhYcUsHfGuOTd3DFawBfOU5lm
         YDsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788901207; x=1789506007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r03JHVqatUaUPMmsv4urfr2IsvkiMywhjIlOj6S9eWU=;
        b=YwZI9Z10cyNcrjK1YbuuKAb9yu2Hc5hN5KzUSbNzvoXbLLYWxs62dPjOyLdx/GjChD
         dJZCLZdGaVSdU+FG9N/zJvinzQKW2P55/FjN7gEjsFo+2HlpZzTPqeH7+flU8OgOx0l5
         DSICeKrLJArJ8nrk1eJPhiZ+J72u2UnbFbYAht0/3WX70OgrPA9F2ZXbyEXJGqMsj7/8
         Vks5O0IRxwqdNKh3+/YzmpC60vcmoUdAKtVtx+cF4LWVsmsbhYAuowV0qVyDyR6AAT2s
         elD2WxYtbBlKVx8Fz8RJFl7LnvOaYL6kxiGqJyVcb38Xr8WW3FMNru/SWcsfgOaaZpx0
         KwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901207; x=1789506007;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r03JHVqatUaUPMmsv4urfr2IsvkiMywhjIlOj6S9eWU=;
        b=qaHt2M/dAZ8dBWIGDGmOcODUpDSThHYu87AcqpxWEZP2E4mNC4Bm5uW75y7kxVbGjh
         QsQs4AzsTfPoqdzXdgPotQ48mdpn1t5/E0nY3DQBEOg0xsOKKo3tyMrEEb65KlsXLwMz
         m/QgszqAhWq+ETyF6sWYL2W/yd50QNBrjWpYukStq923Y1YUXw5MQLDiTxZD/60+MQqi
         9c8Qxl9WJhC3Gs/7jhkzATbpyFOWdwW9goJdUXuy3QV1ETkpzdnQ8OWorqxax+JORd7l
         vynyPuouULjPL8f/+ZTnM9st+rjvKsSDRtI7/SipFor8oQrwnCLnDr1L1y3t19JREzf/
         KAWg==
X-Forwarded-Encrypted: i=1; AKwUvBwPRA3zXos1qtDd8L57SsJMt3sKulZhL7hkD2K5DSRKTOqP6kyMBaLbmHYZHVoGGWZAK/9rBx0AWkff6tZfIaY=@vger.kernel.org
X-Gm-Message-State: AFuF++mSqlqYmyMO70l2SxctImpnwF1EfDFdTE1YUvk2kjl6nQmQl5Pa
	JAaSq9TcLWv9URmrLessMDCNBTjLAa7D+eKHM1Q/O5rJY8PeUb8Ye69hF+oxWMuKBSAR8OgQ5cM
	KqzJD5YE65iy8eqOMCQ8ZsKh6nGcfnkY=
X-Gm-Gg: AYBFou1oicSTS6bGMMw27OgrxW/QRbXaBc3Pvdj47D3Jo+rFCk609Ukb9JXfgc5AfQ2
	JZ13pmEn6YnGkq/L4V5SY6CYKxDRqrkrN007VmGb6ydnQq2+xTRDxaflfxKixeL7SSFPAJSY0a/
	c8gYqxbBfdw4RF48v/2NJWsQCp6u1liciRtSv11BmBl2B//QWnBLE5zhhuTdOlEKqAkClYN88Pf
	rZhPiaysKTDE0p03lBruxPeWKJrEaQWcTzcnyr/NOPcTTL2OC52GD2H3jPgToCl0LYNMhIsqs/9
	jy9mTuU2VaRrpxP1BxCyhoR7ixDQ0GZH8nT9S+/cKGkS+Sibin02LBWlHYysCb/XlaeoYUCTddJ
	bbTVk3pvgX0Ucj+z0ft7LpSDTGr2GsDI=
X-Received: by 2002:a05:690c:e64e:b0:863:82c1:b161 with SMTP id
 00721157ae682-871263cf533mr89991517b3.10.1788901206968; Tue, 08 Sep 2026
 14:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907172648.457103-1-luiz.dentz@gmail.com> <20260908135708.552fcead@kernel.org>
In-Reply-To: <20260908135708.552fcead@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2026 16:59:54 -0400
X-Gm-Features: AcwNN1WuAAHTkwK73g9kYNmbdnD0_ziuS50YK58JF2Zh8xNx0-nW4cfl2Wdo7sk
Message-ID: <CABBYNZKsDJHUiG8exN1R699BC6w3sC39qfT+jVQOe8nHf-RQtQ@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-09-07
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Tue, Sep 8, 2026 at 4:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  7 Sep 2026 13:26:48 -0400 Luiz Augusto von Dentz wrote:
> > bluetooth pull request for net:
> >
> > Core:
> >
> >  - hci_sysfs: Fix NULL pointer dereference in device_del()
> >  - hci_sync: Fix not setting CE length properly
> >  - btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
> >
> > Drivers:
> >
> >  - btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware
> >  - btusb: mediatek: Fix leaked runtime PM reference in reset
> >  - btusb: Fix leaked runtime PM reference in btusb_reset
> >  - btusb: Fix UAF of btusb_data by rx_work
> >  - btusb: Properly disable remote wakeup for MT7922/MT7925 on Ryzen pla=
tform
> >  - btintel_pcie: validate packet_len before skb_put_data
> >  - btintel_pcie: fix tx_handle bounds off-by-one
> >  - btrtl: Don't leak return code when parsing firmware format v2
>
> You're missing a bunch of your own sign-off tags.

Yeah, I will respin it in a moment.

--=20
Luiz Augusto von Dentz
