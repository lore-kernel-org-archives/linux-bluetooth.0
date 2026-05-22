Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C5356767
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466956; cv=pass; b=D5NAFUckTJ863HDk7Bgi4OVLdBvmu+/KdcXVyHEwMPxLmByD/54rSL78G6aKiweqY8Sn+74srNiR08cIlh/FFd5I/CIN5MrZ7zfdPZ8MhWqaugIkX+TLxH+h6oDzEnx+CfbUk3KZqhEimWoBa6h4iGTQuIeSx23Bu8euMLMUUxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466956; c=relaxed/simple;
	bh=nxDL5wbIW5pkhBBgQjLoIFOrjNVlK9PS1v0vc3/+klM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjUxqj3+E8TT/oGrWjt1G3UYRD5LZdMO29tGnpEo9HRQOPAmOp/HON3PSOrPdSqu3ZSV+5gnIzUUEp/t02GjM0k3H3I9Ny1nYCcGEUr7HbzsOrf25tib3K/Semfdb1/rqL3eUxf8WD6nCGveUvWryabwzZVv71AyQFhHrpMO+8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcRC9yO8; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcRC9yO8"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6563f83ae9fso7457171d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 09:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779466952; cv=none;
        d=google.com; s=arc-20240605;
        b=K/8XdxTW5QNP4f5CQv3hiVNDKXrliBVRcUuSvAzucUs6GherWqkfFsWeu9bw7+A29G
         n1VWu0GgnL/ucx6qFLowrLfT1H5+ZT+JChQawEffjxoH4sZyZFFhsKWf57FTGxE5iTns
         KidVesmc0tXXnQ12mnfEAV/q/YRkb2YV+V3RnlXKiz8KwE+1xSseDkxc9IR2qbPcWM95
         9EkwnLho6PpMh4qcZ+OzmnkFIKWa4NBImvv3AZ2vS2XVHXT7xg/pY/YVkwmIFio+3d3L
         Ulz/jIFG2mGsPOOh8S6r4dJXXbqkQrvI4HXcD11odjwiNQnnoAgOAMYOG/UDRnyO+2Yp
         JRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vimbPXonM0vzfVvoUxK3iQItdTAAHoqaETC2qpf4r48=;
        fh=AwQ53A24R9J3oSju77FsptSDNcQ1qmpjrymvTdw4H3Q=;
        b=A4EwEV2M9/u+PbqkgmZYOitHRaLYG1FNJbJ3ID7czEVfyCLUrwRGWK4rHqQQkXEH4k
         UTl04DkKClTIUYIjUEU0BST+YRiyU4uQIn6WxHZJ6l6eGkmFvxlymBsyk0gczuFi/Te4
         8X5xVwcdMgt5CN0yiwciLuoLT+CTvw5RDHRXkTaoQ1u04VYasTWF2UuyfJWFauH9Sir7
         g3JsU5ds/FafR+U0970u9BvWYJaeT/Xcs278IMYfzCySckHZM/0P9WG1is4DyY2/jxBn
         X0QYJMqt58zb9i+DspSVuK/fHpYTD/EbQ4Sbzt0mjLqOtBWE/Yb3ED8Vc3I6ngqJgzZl
         KwHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779466952; x=1780071752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vimbPXonM0vzfVvoUxK3iQItdTAAHoqaETC2qpf4r48=;
        b=WcRC9yO8MfwgMcr8gL/GJ662vWIJtrsLWM9Az6xWycu4oLhECy2p88ldJqlRgVQP9r
         zbLg+Xuq7rhwXutbL2ve2uM/QY3nLCoZ+Wf/sZ97TInnf+1SdpKvPETww5tl5AXlQB1i
         OjwS8iWuvOFj1eqEqdE5sbeCvL+rZjWPyzytNpXKqu1aBnxXW0Y2w4E0RvDYpxnWjAgl
         NiFAgR7dg1anAu+Jk6/X389XP2vTop+SFnbhMGCpYesc4Bo7anMBxIXRItLOytg/FQ8K
         4bZJh/fb6Hx7VbVpFGpbiDe2CwKlKU2pKa6Tx0XXj0EeYXpxVy2un1mucme7XZzpNEr8
         G8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466952; x=1780071752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vimbPXonM0vzfVvoUxK3iQItdTAAHoqaETC2qpf4r48=;
        b=O5/wWUK53nhFg0tmxXperB8VuKxb09cxhh8OUCQDOYgmK/bOzQ+MK5tEF/lAJ70339
         swU4j9qmmosas2rvudBHaw3QdI/OKqDFceSJCykRjvcaOZllc/DdpScL2V4KuOc6E9Oo
         +BJzISxzxTVLlTEuJ73QDtHUSA8LAExfLbDWnlfxcvhBaF+X82keVCEMUEYGchTmyLV9
         edWlXyNUVUwEjioMjBImzBIi09cGG8eWZxWFB7T+MoZ4AIriA7GfSGtg/lDE0htw0r0I
         aU6NkGY/edxodQxM0C1BIF3gpZP7EbhKPIucmnQtu/wlfGK8rGBB4dQoL7LU0Icr5aTi
         pBQg==
X-Forwarded-Encrypted: i=1; AFNElJ9FGHtzpcYvuB40lUwiwKRJex7WB7PkScerYk6dIt/gkjiiFxlBoR114JoyoMCyv4f2JXuu4qjAJEYP7TS7r9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzedI+Z+kVcouDtZ02pNsElPiUorX06NU+Am1db9EATCy2ONSWH
	T/uPHHs2qQJATR4yuSlJVM8mKVD1il2Io5R4qmq8RroAfdQHaAsOn/KcWvNYbgDRIN6rN9mO1Q7
	SAE4EVETN+ApLywA1/0urHT2RuvUPFig=
X-Gm-Gg: Acq92OH9311gYSF1n35u1aRZyuYounN8rnEtNc77wA9LUv/v/zkmKN4hMlAWP3O6Hpp
	zUnpMGTKlWYuGfl4KZfo+WsjoYwePBb8ITdxDlS9voOl+GEm2VcTlW8kyaiNVbYTxY7Ga6QkEN4
	9fWrRasFjH3zOJChnVzN3RLrGEzj25gEfbR2dVUH/2VOXmc57fUZ4BGrTnGSPdAu9sbcwyZ7bC1
	KIry/fsUakimReJ9NgdY/Y2sNvNPX3u5nOUuVsEqm7VWNBRta9c0pyBeufJiqYyG+K+Wj9ZTpdv
	8IE+zkGq/T/Nk2gGqeVYSHVAAPWavyUTOGvp8oiQ3DadxRG4auNg7v4aVrGpRsQiCR0=
X-Received: by 2002:a05:690e:2505:10b0:65c:2360:dfc8 with SMTP id
 956f58d0204a3-65ec97cb46emr3504100d50.19.1779466952292; Fri, 22 May 2026
 09:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522110838.1158643-1-shuai.zhang@oss.qualcomm.com> <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
In-Reply-To: <1b8e8129-4f42-429e-bd70-5e368551739c@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 22 May 2026 12:22:21 -0400
X-Gm-Features: AVHnY4Inv2WF9EZ8468g95mfpM_6fOpWwRbf-9-010PGY44gyz3kDqoT-LBJp3U
Message-ID: <CABBYNZLQ5m-24twTZaHXzi6QHqgGdvuDt1aaYwbEi0Vt=R2Dfw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Increase SSR delay for rampatch
 and NVM loading
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Shuai Zhang <shuai.zhang@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Fri, May 22, 2026 at 10:50=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Shuai,
>
>
> Thank you for your patch. Please mention the delay in the summary/title.
> Maybe:
>
> Use 100 ms SSR delay for rampatch and NVM loading
>
> Am 22.05.26 um 13:08 schrieb Shuai Zhang:
> > When bt_en is pulled high by hardware, the host does not re-download
> > the firmware after SSR. The controller loads the rampatch and NVM
> > internally.
> >
> > On HMT chip, due to the large firmware file size, the
>
> Please document the size (> X MB)
>
> > loading process takes approximately 70ms. The previous 50ms delay is
> > too short, causing the controller to not respond to the reset command
> > sent by the host, which leads to BT initialization failure.
>
> Maybe paste the log?
>
> > Increase the delay to 100ms to ensure the controller has finished
> > loading the firmware before the host sends commands.
>
> Why can=E2=80=99t it be increased to 1 s?

Why would increasing it to 1s be a good idea? Actually a _proper_
driver should be able to detect when loading has finished, not just
use an arbitrary timer and hope that works and the controller is
responsive afterward.

> > Steps to reproduce:
> > 1. Trigger SSR and wait for SSR to complete:
> >     hcitool cmd 0x3f 0c 26
> > 2. Run "bluetoothctl power on" and observe that BT fails to start.
> >
> > Fixes: fce1a9244a0f ("Bluetooth: hci_qca: Fix SSR (SubSystem Restart) f=
ail when BT_EN is pulled up by hw")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> > ---
> >   drivers/bluetooth/hci_qca.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index ed280399b..184f52f9c 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1680,8 +1680,8 @@ static void qca_hw_error(struct hci_dev *hdev, u8=
 code)
> >               mod_timer(&qca->tx_idle_timer, jiffies +
> >                                 msecs_to_jiffies(qca->tx_idle_delay));
> >
> > -             /* Controller reset completion time is 50ms */
> > -             msleep(50);
> > +             /* Wait for the controller to load the rampatch and NVM.*=
/
>
> Missing space at the end.
>
> > +             msleep(100);
> >
> >               clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
> >               clear_bit(QCA_IBS_DISABLED, &qca->flags);
>
> Is the time it took to load the rampatch and NVM visible in the logs?
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
