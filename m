Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1323ACF1C
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465034; cv=pass; b=R9IGuvRIjYg/YJkdXY43FTOBh1R2/aZQnijS1J5TfCKtE1jboGe+EjN3TNiAZRMSRi1hx5fTNoccz62ER0EshjCpmCtDOLaFe5HWBacvGu35r3YWW1DxhfFbV6uhNg5qkxuWfAkZGQJ73JetPtvWHrgnquzTjwx6OlNQ84vCQv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465034; c=relaxed/simple;
	bh=h4iMOJ7aC7AFtPHkao50UPtVJGw5zRYGJ5+WW069uzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBPISXRRrlMLi5vLq3fOlgoH0hphStyrA56/hYzrj/8XEjc1znJuKs9TKHlsOvwwYj5bLKG5RxgSVcx7Wx8IpIfdha/Hc2wfJzWORU9yFVHkNfVfBFQfFKkYHThJOEghAmY6/trA7dxCi+WCO/rg+vbV1x43hkERE/YDK7LslsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hASVAq1V; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hASVAq1V"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c88cc025f54so455493a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 02:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465032; cv=none;
        d=google.com; s=arc-20260327;
        b=leNJAx9k7zGNfDAQ5uDx2Y5kI3D0d+k/OEGzh5gfdo4TzWVh9274DyqIMTBIOntxz6
         qgRduhou+sXgRsq1cvJWfmjsEkiyVqhjHWxK5u4nwYDnRZlUwhG5nO7nBK03vA/zmx+s
         JjZry1dNUxajo6z2xL+rUcrh7IXLc73medplfTDdNjjo/WaV0A+q21tk1sOkCMW4cs8e
         zD5zY5VG5fxHVpBqsnTabTuHIL9gETtFGQ/Mxbu+gWW6DFNI/7zlJoxmWjM3W+Xm89X2
         ntJoROaWKmQgTqY+emd+nsmvG9qLzrw1XDKtZN4R9AEz2aRNmC/zpdnQMnJUERc6mJdS
         XsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zVx9uhhbtYTe/AIcStVrOICr6l/3HoLAAsOQ/59Ktk=;
        fh=BC4/PQOsgfvLcxJoUUX6D2nZvSudqWu8zFE6FXDQxQo=;
        b=TaA2JMedbxv6yiRuwPpk8jjr9A6gd1iUVBCzhMPs119nHjZNSu/h7BceIyVovcHDS2
         OONrcyRwutl+FirYodzKXRxxMbDMU6hNz/4cxIjftIQ/b6WANR6fKWQqD0fMPFkFEuhc
         uVZUeJ7FIasg6ffTo4AKWn7PEL/nZxziRB+1QXCJVVQSUx2ccaH7J/OHW28kfhtN0FFU
         ZXeKa+7I6SqA507bo5cD59EEVzYrQ6RSXcjO20MsbnFN6wD/FmK6rd5F2WQXJrjycyGu
         CmDsuSLKzs+9Gwx4aNy5UHmPRMadpwG07hH7kgIc+5Z8Kq6F4ViMd2ALsX+GaZsI3L+3
         XgNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782465032; x=1783069832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zVx9uhhbtYTe/AIcStVrOICr6l/3HoLAAsOQ/59Ktk=;
        b=hASVAq1VW7im8JBogr0+UW5NGEafndpM4Shp1kgFw30cMTJ814OT1o8BZ6W2yTJkD2
         yqONaUCvqbb1QA8BrXA9KmAlCF0Od5Gan5JfKFALafhcgOQyzM54rlbTcz75yTkCqrTo
         pv1fSGW/sQGwfTVRT775SFeiA4wVrYS7oja5Pc4V2U6USvFwj0x6ZzBKGzSSAmSSBz2o
         odFvJEmiOBSwMWWfzpRUan8n+uYNZlHdd2MPpnSenJexx5iGQ386BWl6rbV6xAnzfrJx
         qSj7moImKNOQ95AMCYnxYEvjSqPD+maY/RDSqUARAw0aPctAia+H31GlrrQ5nuG2SJ5h
         0z+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782465032; x=1783069832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zVx9uhhbtYTe/AIcStVrOICr6l/3HoLAAsOQ/59Ktk=;
        b=JOR7l9D8P3dtt5wdPhTvLjnwdsLKiEdNoJtKIfN33T6mlUTvZT5BTn9wa6N9/UlojI
         dwwUQR2GFf1z6tWnoJU5FKPlu69rjbH1VmOey5AlZqghn7vXYY9+UoDuV/ypoH2Ze5P9
         j9DtmELoq3PHffJR34P5Xaa84BPFK/wPJRm8Oj/7GbNEdnqB+aPIUiHMqDwD7BFaYU0d
         h/TrvNPtEDBBYrr+APmj7ePoO0rZtQWmMeFmk/JwcYGebHaDa2a2uA9l5fXQYysGvodt
         JsmkvxdG+yg2fbaoQBelP2qhVHY0GDP15pW3X1UUtNY9hgC/sGTvCCaICijj8Qk27i1V
         BXag==
X-Forwarded-Encrypted: i=1; AFNElJ/R8CMdQsge/3Qek53AqZdTXukTHzrpRtqTvZaWPOz1257km+l0xfMew2PHE6OlTAxzLkbs07zG+cAwEQbiWjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZwNXHfjtmmGPPqpNA66xGPSl8J3td+QWwyZNR3RLe37Q5U7n
	XEZSup9I9oQP5vF855dayK4hMX3jU2+gNKwbD6QIYrsEvDUw9sM7qMeVasnjkimrafmTjErMzdM
	tBzUI9FxNhX6+eC0tzz6zQzc9v+Z2kYry5us=
X-Gm-Gg: AfdE7clPOVN/YVuwYekt/QImq2ET/Vgm/KAQGjawkE8+sBfKyPLJwUFmKmSwazopWoI
	cVwLx6QSnpCv7mNDaub7uyny7s8nkyEt5zPQob+dlIBLc6VcJC8K70kyGcMQAOKoER++SOChqNq
	1ERNjWpWPiUrvzQtz1UIyvo8gUU700OzCgOtTuWHAcoSKUOt+YjN4MHrdCyMJrdBFL4cb+jn1HC
	oJe2wv9JqNVcPHGb+1tVKcY6mORp+fsFw2c0tc5DGkBhLUKx2e5KSpm0jzdIlZe8MK1O/jCDiuj
	6tDcoCzcvN/quqX8r2LAU4Hl6VlcB59OmEVaPcrIsQRqbaGrUi3KwTvVLBdYFeaAkhX6ypUlG6X
	lcqK+BEImZHaDTzLa
X-Received: by 2002:a05:6a21:110:b0:3b4:895f:6ac7 with SMTP id
 adf61e73a8af0-3bd4ae42686mr8002447637.22.1782465032522; Fri, 26 Jun 2026
 02:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626085506.37500-1-mhun512@gmail.com> <AS4PR04MB96929E70BAAF5CCE83969D37E7EB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To: <AS4PR04MB96929E70BAAF5CCE83969D37E7EB2@AS4PR04MB9692.eurprd04.prod.outlook.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Fri, 26 Jun 2026 18:10:12 +0900
X-Gm-Features: AVVi8CcqJ8WLN8H1sztJIF09TAhIzMNcN1-ZJsZBPEqxklLUjousw4JXmxOZCvQ
Message-ID: <CAGEsz8FJx8ocg27P2xKFRvt+ZbL0CoOHXyo4y7Hw-quWB__ocw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btnxpuart: unregister HCI device on probe failure
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: Amitkumar Karwar <amitkumar.karwar@nxp.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>, 
	"zhaodongdong@kylinos.cn" <zhaodongdong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neeraj,

Thank you for checking and for pointing me to Zhao's patch.

I missed that pending review. Please ignore my patch; I will defer to the
existing patch from Zhao Dongdong.

Sorry for the noise.

Best regards,
Myeonghun

2026=EB=85=84 6=EC=9B=94 26=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:07, N=
eeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> Hi Myeonghun,
>
> Thank you for submitting this patch.
>
> However, a similar patch is already in review and approved by me:
> https://patchwork.kernel.org/project/bluetooth/patch/tencent_F2E2AF1B6F51=
0577B10C6897ED768BBBAF07@qq.com/
> It's awaiting Luiz's review and/or merge.
>
>
> Hi Luiz,
>
> Can you please review the patch mentioned in the URL above, from Zhao Don=
gdong? I have answered your review comment.
> Thank you for your time and review.
>
> Thanks,
> Neeraj
>
>
> > If hci_register_dev() succeeds but ps_setup() fails, nxp_serdev_probe()=
 jumps
> > to probe_fail and frees the HCI device without first unregistering it. =
The
> > remove path unregisters the HCI device before freeing it, and the probe=
 error
> > path needs the same ordering once registration has succeeded.
> >
> > Send failures after successful registration through a new label that ca=
lls
> > hci_unregister_dev(), then fall through to the existing reset and free =
cleanup.
> > Keep hci_register_dev() failures on the original path because the devic=
e was
> > not registered in that case.
> >
> > Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP
> > Bluetooth chipsets")
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> >  drivers/bluetooth/btnxpuart.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuar=
t.c
> > index e7036a48ce..6778b883ab 100644
> > --- a/drivers/bluetooth/btnxpuart.c
> > +++ b/drivers/bluetooth/btnxpuart.c
> > @@ -1907,13 +1907,15 @@ static int nxp_serdev_probe(struct serdev_devic=
e
> > *serdev)
> >         }
> >
> >         if (ps_setup(hdev))
> > -               goto probe_fail;
> > +               goto unregister_dev;
> >
> >         hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
> >                            nxp_coredump_notify);
> >
> >         return 0;
> >
> > +unregister_dev:
> > +       hci_unregister_dev(hdev);
> >  probe_fail:
> >         reset_control_assert(nxpdev->pdn);
> >         hci_free_dev(hdev);
> > --
> > 2.53.0
>
