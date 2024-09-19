Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D4135417
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775811; cv=none; b=K0eVAxf4SL/HbkXhVw4kBFLWDoG2G9dXoiC2yPAYvvAyUsXZqMe1ta+o0+O1/UfZ/mC6f9RC9sIgA9Q8EbMl2vrEefMGAXIypTF2v9oT8VVlQkqebMMSn+e0t20D6chX6VGzP9dTg9tX/NP9oVZTaU654D/zlkz8iiD1aZu6gNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775811; c=relaxed/simple;
	bh=wzT+kIkNDtBU7VWooPlP2DBTh5Yx9LQPxPHacyu1uxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3m8Hbak4h0DbVyKQtOQX6MszE9lz7xoEeLWfWmP9VV8hc19iEcWaV52f9gCAd1wcfQAKU7ddsFX90VDno+yq1FKgomDwF2l9U1YqpvyslhBOyCAdY4HRcqvmATS7qV0/DpXSKrFignqqf8djdRzgSpxFEUs/HYO6ePtcFLKKhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEEGL1JX; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEEGL1JX"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so15509981fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726775808; x=1727380608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Slu54z5rlVY3r4V8DeS4aRI40612QodynxvtRboPVhE=;
        b=FEEGL1JXJSkRrcQ4qNZNC1Opx0Xtw/BX2fL464Kt7v/P/AaIZBZggDnb0329DxR+jk
         Sw6vs7XhTaxqb3VKpq8VOHw4HJ3e+RolFvCerzmY2NWSGqmGajTPyMBrZDOGd6LzoUCR
         y1HzrAsZsXkN3C4mvCuiUWf/Z3x2WjC4cq1aK84DSap1iYR6jmMeHNu2BEDhtBxxh+8p
         aFePfp9fw+crdnq9YRSeUBccENbv4xTTWF0hTTF3PGzXi2p0+GysJcnzUDaRKTH08BVb
         qTt7uHfkPMgJcgONnSzIUZZIjuj2iQtpy1InjZ0y0vc5cLFmhpe6lVjtgYwk/5Qp6MQE
         Bhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726775808; x=1727380608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Slu54z5rlVY3r4V8DeS4aRI40612QodynxvtRboPVhE=;
        b=q6dqLu9PTX6DCNJN1kzUkah9M+3F/KiS3eLVMpPtQKryTxu2sAtKqhTC5wuxKZFMRy
         5+/hkV6W1Iy0GuJ+y1twHKbsQTQiOAH+u6yUMy+/vYw16qGrnC+3GXaVs2/JpbprVwM3
         PJqXJz2PImOLGLF5MtSM/g3V/sxG5x0Knx7BuIYmKYYNAoQnSsxVCGG0OG1PYEg6XgMo
         r+URJ7dW6vXSMQ7F+72x8gwFdqW0jlFUat/dKCcFHyae1DlCCAeXU/ubelYW7HtuAYVH
         YLKns2T6+KHRzqCZoaZieTmZA2pD83/HQhTzs0t4+v6hrqX8tIQS+lqzHrgwB3k2cSzy
         2wjQ==
X-Gm-Message-State: AOJu0Yz/vdQApR+qJKHle+Yh+GM3CM/s6OYk7ixNxXoeE91Zm++3gBEl
	qZ2nM6UqdtP9+wFifQ1Tw4jS/RFyCX4uO1vWEm7bWKk2uTKh0IAxdKtkJSQmVy4lF8OKudJW5Jx
	kWryD90hMV5Jc5ob+vaNSoYrAUpo=
X-Google-Smtp-Source: AGHT+IEY26XkZZZ0y9d26MY40ZFnbpYOWGvzcHuDly3JIm2+nZFI3iHkojZKETnndBIqeHmGgAFKlPaHnoCha+jR9XU=
X-Received: by 2002:a2e:92cc:0:b0:2f3:df8f:bfaa with SMTP id
 38308e7fff4ca-2f7cb37c05amr3320641fa.36.1726775807855; Thu, 19 Sep 2024
 12:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907204941.8006-1-vibhavp@gmail.com> <CABBYNZLVcMqXVXeWf7pSX50yRQNP-NMTUP-u91huuO-kpjU7ZA@mail.gmail.com>
 <CA+T2Sh07fL3jq5CnCK9ZxjUtK8pNkm73ft+VYn3T-z_BZZF+bw@mail.gmail.com>
In-Reply-To: <CA+T2Sh07fL3jq5CnCK9ZxjUtK8pNkm73ft+VYn3T-z_BZZF+bw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Sep 2024 15:56:35 -0400
Message-ID: <CABBYNZ+_F=aZzaK0DGuWPmUPL_Zss4BBz114nXPYVB5HzdXz6Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] device: Add ConnectionType property.
To: Vibhav Pant <vibhavp@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vibhav,

On Mon, Sep 9, 2024 at 12:36=E2=80=AFPM Vibhav Pant <vibhavp@gmail.com> wro=
te:
>
> On Mon, Sep 9, 2024 at 9:00=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Vibhav,
> >
> > Don't really like where this is going, if we need bearer specific API
> > like this then we need a whole new interface, besides you didn't
> > really explain the reason why you needed this, is that to determine if
> > there are SDP records to be fetched?
>
> ConnectionType is needed only to differentiate between LE and BR/EDR
> devices. This is because the NT kernel creates device objects for
> every discovered Bluetooth device, and BR/EDR and LE devices exist
> under different paths/hierarchies (I suppose the equivalent would be
> BR/EDR devices existing under /dev/bluetooth/devices/bredr, and LE
> devices under /dev/bluetooth/devices/le). Essentially, BR/EDR and LE
> devices can be differentiated in several significant ways, and I could
> not find a way to reliably do that. The current code checks if
> AddressType is random, otherwise tries to see if the device object has
> org.bluez.Gatt* interfaces to determine if the connection bearer is
> LE. However, I understand that's not reliable, and doesn't determine
> if the device is connected using dual-mode.
>
> That being said, Bearer does sound like a better name for the
> property, and I can modify the patch to that effect. However, I don't
> foresee the need for a ConnectBearer property for Wine. Ultimately, my
> goal is to implement Bluetooth functionality with the minimum possible
> API surface added to BlueZ, hence the small (ish) patches.

Ive left this out for now, we can revisit this if we find out that it
is really necessary in the future. Btw, how is the wine support going,
perhaps we can put something under doc or in the guthub wiki about the
compatibility with windows.

> --
> Vibhav Pant
> vibhavp@gmail.com
> GPG: 7ED1 D48C 513C A024 BE3A  785F E3FB 28CB 6AB5 9598



--=20
Luiz Augusto von Dentz
