Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4822155342;
	Fri,  7 Mar 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359782; cv=none; b=JLA/LLShr10C0CmRXVieYuYuy9uR1Oxu+0EMDTDbSrPLFABR/3fPwpH0LgTHzxd43tazn/LTDqhUA9YIuLtsSh1pdDE+z/QlicV+SSxg30nRVj5IPJqdAJgT+VUsVbGvgn6eK1CVWmMw7axfOQOC37RkMQ5y2beoZFF/Ssp277I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359782; c=relaxed/simple;
	bh=2sn5q5F540xMeAvwbPbZHiitLTVXFn/dDYoDxee1Ydg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbNNxY9kBNroEXhyVFGm1TxrAwUS90AnjMitJTwSMdxkfsUsh1ZMX7qc5Bm5ePnFlIYLrPK7J5qLVRF3xJir9X4JsTtsiQKJ2ZrTL2T/X/bmsdSiOitA2ss8gWr12mjw1qkJPVuTvoHnfHaGYjawEXqDPaMLIP8FI9UCdJv4NbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LM/6X+Y9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LM/6X+Y9"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a04so20616371fa.2;
        Fri, 07 Mar 2025 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741359779; x=1741964579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJe0bNeCyyLIrsUyV751ygPvbRMQaDREYBG7uK+LWKQ=;
        b=LM/6X+Y9P1Vw9phMzRF2kEaEMputBGXSd+yqmuTZd1hjoBcdSZF0MpYJr3PI0LGrhH
         NpzFkQzuU2fXbS11GK/8dO206nOR7LGIGE8RxDL4QtvUv0q08uekctAVplZG/H06sXdE
         QQG966jAxRUgqsBj4+U/hT2i5lPZ8ccJyOifzwnf9K23MunLSpeqgN7AS9XR6wdT1Dx6
         qKEc0f09fBwnoK7Z26tu4nAf8eLbBhp9el0BQDhB77dEEg7/QXG6pu12gAm7aFmdbMzx
         tFOj4cqSnmJVMQMY/m2KYkfpWITjnnBq7PxHHmfAwgfb6H5KKZ9rQ0HZqd1kvJ5Y3ANj
         NoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741359779; x=1741964579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJe0bNeCyyLIrsUyV751ygPvbRMQaDREYBG7uK+LWKQ=;
        b=jVrvu9/FRVqywHcBBfFPyCp+ikDAAr3HuyelZQXPH53ZBLufmZCGZoK9TlaE2ptHsk
         MHC3fSPsIHpIBs7M5PdqCEK6mA5ag6NDprDb3iCvAJSNV14E76L3gkOgoVUbd0vWyofW
         JO1U7YTFBKUtt+9h1rH8/s++YGrsygvKCyVH4ZunMbWqmt6aoNgErIIt6CPYcXE0XEFv
         t2FsJxeGZALY7v7KJtyXCNDX9WGyw3H6TfWbNGu9kCa7YoiXCNS55usfJY872fezADhN
         /58Tpo1eRsqrono8YJ3igzHSsjfqU5WTPnfQbYGjMi4n4NCVCTYGnn5QZ6/KLKjS1uhn
         8tXA==
X-Forwarded-Encrypted: i=1; AJvYcCU7E0eOZ0CcV0Q+7BOntSqO2WNeYrAFj8isjoc1n++URnyXY2Wcwg7KZRN9WIVb9XbD+6IRJ0BklDEQKf72@vger.kernel.org, AJvYcCVLSyV6lBPud1bQLAPZhvS0s7gCylFtKiVTsw7pFTv0rT7Z4Tbs27NsgCjSSMYsAJ5L/T/R/WHFyze9qY1wVVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6IablG7sOq8CbOPCWM0uJCgmxXFSX+dyPfUm3bypdmCrOogoi
	fOfvj2gLWNIsRPIPNmhas7vQ2ms/7st/Dd2JTJWYM6Me54NnQm8QptFTzQK7shzJwImPyHGeKGA
	fi5jzR2p223Vc6UqKHXf7DDuFxqw=
X-Gm-Gg: ASbGnctzDG6SykGBtC1EE9945UDkS5FhzVqE1Nfp+YuOh3ze+r+tjiBHnoL94ZiMpMN
	umVTLvxA4u4KiplQirPfv/pmgNw5BqL96ziy2bbladoyqAQcF5QVIbEIJt8qfsXxu/eAXRFUZdS
	nR4LmgY0846vVJFiAEWUmlcOVB
X-Google-Smtp-Source: AGHT+IEtW6v/7aTnFHwF52LOmZ/tMOL8C1lamhsu7wwMnJTJa06ZeHkeHeCLsIyhfCQKIO0xY+G9HlWcQHZu388iqYw=
X-Received: by 2002:a2e:9111:0:b0:30b:ef0f:81f1 with SMTP id
 38308e7fff4ca-30bf4523798mr12352911fa.20.1741359778374; Fri, 07 Mar 2025
 07:02:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307080907.218398-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250307080907.218398-1-neeraj.sanjaykale@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Mar 2025 10:02:46 -0500
X-Gm-Features: AQ5f1Jp-F8Dt4YrmS3Z--RPaEvLIehTazO0Kh1J6eNmrHbhZndyb60YX9n7mr6E
Message-ID: <CABBYNZ+rHFdnxOtdV-FAFr3vKw1bAE2NMN15yc5_soOXc4d_5w@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Fix compile errors due to BTNXPUART
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, amitkumar.karwar@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neeraj,

On Fri, Mar 7, 2025 at 3:07=E2=80=AFAM Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> This fixes compilation errors seen due to merging recent patches.
>
> hdev->cmd_timeout was recently renamed to hdev->reset in following
> commit:
> commit f07d478090b0 ("Bluetooth: Get rid of cmd_timeout and use the reset
> callback")
>
> Renamed nxp_cmd_timeout() to nxp_reset() accordingly.
>
> In latest master, the check for "local-bd-address" device property seems
> to be missing. Added the missing code in the patch.
>
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503070951.EcxRrnHK-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202503071045.5Ac2pLEW-lkp@i=
ntel.com/
> ---
>  drivers/bluetooth/btnxpuart.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.=
c
> index abe2ccd92604..b3454227c7c6 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1318,8 +1318,8 @@ static int nxp_set_bdaddr(struct hci_dev *hdev, con=
st bdaddr_t *bdaddr)
>         /* BD address can be assigned only after first reset command. */
>         err =3D __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL, HCI_IN=
IT_TIMEOUT);
>         if (err) {
> -               bt_dev_err(hdev, "Reset before setting local-bd-addr fail=
ed (%ld)",
> -                          PTR_ERR(skb));
> +               bt_dev_err(hdev, "Reset before setting local-bd-addr fail=
ed (%d)",
> +                          err);
>                 return err;
>         }
>
> @@ -1422,7 +1422,7 @@ static bool nxp_wakeup(struct hci_dev *hdev)
>         return false;
>  }
>
> -static void nxp_cmd_timeout(struct hci_dev *hdev)
> +static void nxp_reset(struct hci_dev *hdev)
>  {
>         struct btnxpuart_dev *nxpdev =3D hci_get_drvdata(hdev);
>
> @@ -1721,9 +1721,15 @@ static int nxp_serdev_probe(struct serdev_device *=
serdev)
>         hdev->shutdown =3D nxp_shutdown;
>         hdev->wakeup =3D nxp_wakeup;
>         hdev->set_bdaddr =3D nxp_set_bdaddr;
> -       hdev->cmd_timeout =3D nxp_cmd_timeout;
> +       hdev->reset =3D nxp_reset;
>         SET_HCIDEV_DEV(hdev, &serdev->dev);
>
> +       device_property_read_u8_array(&nxpdev->serdev->dev,
> +                                     "local-bd-address",
> +                                     (u8 *)&ba, sizeof(ba));
> +       if (bacmp(&ba, BDADDR_ANY))
> +               set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +
>         if (hci_register_dev(hdev) < 0) {
>                 dev_err(&serdev->dev, "Can't register HCI device\n");
>                 goto probe_fail;
> --
> 2.25.1

Ive fixed them in place since they were not pushed yet to the net tree.

--=20
Luiz Augusto von Dentz
