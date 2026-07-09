Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD18310763
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 13:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604460; cv=pass; b=JglpoXsaNVRsALaS8FmBiJ6IXq4g4R9JcCsP3e/nTJcq96L4AvEW+cUPHkBzGP2fEgU4jp2uETiSK46o/PFXPHxOP7h5XVvIfTdAhJqPpyL7SxfC1zveFoX4jNJSMks/YAF7HISTIVC+EfoYNBRh92JouLGWrBV8VdwtC7uEMVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604460; c=relaxed/simple;
	bh=f0OKqojaP6EGFWNLxp3oYMaKq0OKK5euIo72gHAf4sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofc8Nl15dMD7rlV11WcS5JIKuVZ3rpITj1D20rzD1PQNh9+SyqjD9llXxqiUCX96pyHDYZj8Ejf6oJVjF3O83mgbI2BpFabxOrK8L+lXAVOKiXIJaQIhGqqy4aUez4ZoBpLCkee+3exx+sws9vIB5SParp3IOBfqYp1A4DQSB0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw6d13ai; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw6d13ai"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66766d649fdso2613286d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 06:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783604454; cv=none;
        d=google.com; s=arc-20260327;
        b=mobKNdJa9R5ExNkhwtfLSSBUAUsSLcNIegrAnZkmgf91peN7FbhRQE+kbFgo74C9J7
         SEy3aQqoELukFmpuhvYdUfMaxhNeySFdAivL+kOPnybo2lcJCwjB7BYldupf6J5bgKwt
         LDikvZnJ3W5NO9G6+16uQq8HSdEZ4RPlmCpEuKIt55yDIvmzgxnRRXf30Lt5f4qDFrna
         LrtyZewPqlg65+nlLKOuuj1MXri4VfTDDl3qDh3C1oQUm6qB2THY9QeJ2f1S5m8w56W3
         EKul6Q7e4m8pEgcHvVc0HoQl7y6o7x3E2DzGR3K68UKIrfkX58KwBohx0EdmrBFtXWBg
         BB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nx5EW6H2he5Bd6cAlWfGlqVVwQemvBQ3yMILnCo5faM=;
        fh=0FBKAqEqr4zw5SH9S4w2NHuYyBo1vlRJ2dPQ2SIzRrY=;
        b=au7dt8m3XAmikqnuaI0HT3mLTixZcLvFwwO39/GD/INR0BFP3KIOAlezjP1mlvKPDD
         e3V8So9y992hC9cq6bCRiCZKXKk9NvsGpJodBGhOlNfJ3yhqUTZoZFUthF9Ew7sJDJxC
         qNXRNePxo4eCF/wpXoxje4zgNQVCyWMBSIFpHnAGXNVJnnx3Ikfc3+TZCA2bodkr7zAI
         goERMDGGqcpYAXuxytgPMOIJBsQ+BYhSK+r1MUfxTJq2froZjnLfWOnH85Fha8qUtT8X
         5prUX3bbmFK5Ef3O6vKerYq+O1cBfRLFtsrwNAgb44vRDaupdu8gqSPbAsURErbOIULY
         Vvfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783604454; x=1784209254; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nx5EW6H2he5Bd6cAlWfGlqVVwQemvBQ3yMILnCo5faM=;
        b=Rw6d13ainYxkzatUU1pEyFIccDDZxNCHtFzrvA1Sq6tGIJWvnk4nmvy2JJb/PFCJKY
         VQkqQLm56Pkzj81GQYes5ciX5gNkQtFSX6VrKgc2EgmHBZNCUrwuDoTWUpBeBWZhRZ5a
         Z3w1O6kN3XA9efKW7m5ryKTCbWZLt3KRfBbhNdiHzCcDEip13TBMYvOkavJkHiuy0STw
         2rx0uiegA5+S1V1MyHqnTR3gz99I63c3wdrXRIkAqzgJA7/PclXgGB/aWoLSE59e8Z/E
         RbHO+wsY5BML7PfZCjfSL0A/lBcs9Kbee7LJl/GtG1W4WXIZmPLTHzJ1Uwt8RjRMMMkT
         VqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783604454; x=1784209254;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nx5EW6H2he5Bd6cAlWfGlqVVwQemvBQ3yMILnCo5faM=;
        b=WpKCIgwKMriumSu1CpvQ7uYNf74kGrcoGpJTNF58ulYu36OcN8FxnTYhmGLWp0MeMc
         5jx1HF93w6lrdRRNi7YUgvxB6BVcb/Al5hfpS8VGYUIzmtFvj8Dd0b040Bw2/Fxkj2IN
         WtJDGsvJaiI5HvOIWct7UdH3xTyoAAxTch2b8VTCxrz69KBsg1X3q5q4SRPUjMTuhA4S
         273YiBYXg+OD+jKoa6bC39sWFDqVnnS1vbt3mUCU9rYdE8QWvLkUqpLElcHZ5v3YWnQv
         skqQuTNAa6S1k1ci1QeyT9y3yc7wIAHbne4JEzdqTx2Y1P6DP7n7gxd2V1CWVsJcaPsK
         LIxw==
X-Forwarded-Encrypted: i=1; AHgh+RqN4FkjSq42xJeT2uaWdq1VpTpRmprX35XxSm6Hy6mQTRNiOBLuA6xOfsjFwBgJVv06RE2irwaXtEN7MCDCUsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqJ5MupJDU4HrCUbl/49f6Gt2mV1jULNTLFDXWQM9lcp82W4F
	e3ToVilgcOW4zp6FmfE6l5z3n0TEOoRCv6S/eYQvZU/5Cb9Jh2uU0ezNzTQyQAQv7ybd4JimzX4
	80He713bL/KDbqaeLNyBYKBPjJoFJLAw=
X-Gm-Gg: AfdE7clf6DKfigmL3BHVl5VGewpLEFW9F63PK2eP3RMQE6kjdf+6yE4L/sHSnLeCP1B
	TRecs8KJwMl908hzIGFrt+Z5Ik/cz2bDzbv4Ru04yQcVirwAwM7Wp6yTOIF0zVaRdWQj3DcVsmJ
	/hVjtPi0O1z5YEhFTDEhLbZNr7jDbUX1RQqNEenqo6ixM7ZyPncBqSMPXoYh2bwgweOl4Xs5/RQ
	JwgpQP27hX9CXXvm8ZxMJ/n0W4wa0m6sM/Ddq3AIyKWa2n9hlXxISvY/bPlhI+k1BQUzize9m68
	4VNI0bQc9jwmcI2pm1EiRow/xqBkfKbpmOGOMXSPMvIEB5JLFFX7HiUcbFM=
X-Received: by 2002:a05:690e:418b:b0:667:8c05:9f99 with SMTP id
 956f58d0204a3-6679f303427mr4921280d50.109.1783604453782; Thu, 09 Jul 2026
 06:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-btusb_prep_qcc2072-v1-0-d835b187fd01@oss.qualcomm.com> <20260708-btusb_prep_qcc2072-v1-6-d835b187fd01@oss.qualcomm.com>
In-Reply-To: <20260708-btusb_prep_qcc2072-v1-6-d835b187fd01@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Jul 2026 09:40:39 -0400
X-Gm-Features: AVVi8Cea91uJevjFXpipHhNoBPpR_U866mqf7zbVYsuwpe5M0_DOOTvWnzWAnGw
Message-ID: <CABBYNZKxEm2rR4nB-1EE7X_S2d3BmLnNWr3WtDjLgk09CO4uXQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] Bluetooth: btusb: Build the driver from multiple
 source files
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Thu, Jul 9, 2026 at 2:15=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com>=
 wrote:
>
> Allow the driver to include vendor-specific source files by:
> - renaming btusb.c to btusb_main.c
> - making btusb.o a composite object

There is already support for including vendor-specific code, see btintel.c.

> No functional change.
>
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/Makefile                  | 2 ++
>  drivers/bluetooth/{btusb.c =3D> btusb_main.c} | 0
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index e6b1c1180d1d..8b436c6de8b7 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -51,4 +51,6 @@ hci_uart-$(CONFIG_BT_HCIUART_MRVL)    +=3D hci_mrvl.o
>  hci_uart-$(CONFIG_BT_HCIUART_AML)      +=3D hci_aml.o
>  hci_uart-objs                          :=3D $(hci_uart-y)
>
> +btusb-y                                :=3D btusb_main.o
> +
>  CONTEXT_ANALYSIS :=3D y
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb_main.c
> similarity index 100%
> rename from drivers/bluetooth/btusb.c
> rename to drivers/bluetooth/btusb_main.c
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
