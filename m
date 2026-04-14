Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA12BEC2E
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 05:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776143015; cv=pass; b=DGJgvRuqvYvzMw79JVfNt1azN4rDo7wVK1t/SANUTVfuXTlhXyNKsLAMoRE+Vso7qU1yelpU7PJuUua2NPZY9kSpwdPs6S/GWqiLNMS7chlgurVac6ikbojBgOWSt2MkAlMETcUIy13quufD69qe2O1Goz1wXX6x1oO2bIdtZio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776143015; c=relaxed/simple;
	bh=/ONKg0B1L6p4zm87A4DLLkuv8Uix/xcFzs6/+rsavpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6U5BYu0vn3wotd+iYFNuqz1c3vPxt/+aqQWl1vKOzOJ6CE3fT3s6qYK+97pqQ8In6DTi7pZFP9gnQgSKX5WbaMQG8W4cP7ksR2rOnIomET5ROow4wI65Vx4kS8M1EM2Nbb3FeusRbi2pxE3KV/C2vCYJOdHbLs7MOk55a7t2No=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k9UhoHTv; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k9UhoHTv"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3d1561e38so3747556e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 22:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776143011; cv=none;
        d=google.com; s=arc-20240605;
        b=TCpBWcOs2UyFcW6aNiuB7iG9X3w4OqAwQj/HtAbgwS1CM3i8hhxr2iI0nwqfM9cxXm
         sTxNSlCrtT89DvacQ/tQwktdQt1jGfuu8VmYBebGQCT+3EVivXkKq9QP3rVDUyMq498c
         7ytGJip+997mFeT136VAH6sSvXL/zfPAG1RnEohHsxk0vURq4f5Qx/clwIWrhLgF4Nf0
         J6vQj3o8L1MpljLqHrKoGA0Hy34wItJpE+C/ID0vF9SUsoF2tlTImGENJLHpPxWAABOZ
         VOj7w8FfzDKlK4BDY+tUSEvYdYlbnEhGgqjoIMj8vTJYeipz7CRJvxQe/EcixncOSCrQ
         oOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        fh=yygJdMx6cxdVq++8uoMuoPEk5LzmZ3CW8/hw4IznHCY=;
        b=LuPRcJSW4CbGSF2WRbg4CpU26UpXdQ34grJq7UtdmAdjyA5cL2QVl4fbHJZiWRvZa+
         qSy06LaRLQNSKxL7zltshv9MW7UDWyhjOw+FsFufFeFpXX4+2hS//ZoHSQb0qfddvKem
         ksRqmaeQcvx39+zkPkREDD58SRx2Pr+virnWqOLYOeqf1VqQPnO2+dhouFCgnbdH9WbC
         9T5JN0sBmEPYTDJx7TmYY+tO1YgNI1AFI9RYFzsaar0WLAqT9zxpv+JuXsuEbv50eb95
         krETzHsdMpHmprlYFLVnkb5Nn8Cn9ikYQoxgfw7eA291L/f2x7NJJ06tKnqlckAFafYu
         MEcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776143011; x=1776747811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        b=k9UhoHTvwzyqW/zmjESMuicoMoBBYBtJZXWbq6QFAeMa4+SEzlP6xCid/jUtzhFNq3
         xJyIyFiHJqJBGmq6f4Ky9U44OV4gO45TCYbUBhdVkQgRk0UOyIW4aLZGwJkQoWb01xih
         L3eOsn1bPR/InfQYoUdHiO8laGxXIXZU4L1Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776143011; x=1776747811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r5Pf27EYmY3rBtqc75kC82+zV4ukf34OCg9xmpmqAus=;
        b=dSDXjxuKR+s3aQJJFjGLF7uJR2WUiwnjDAKRTgNJML1y2JhV/ZmoPfbDi4zsenOX5n
         IOwt8pHbfJYCqCCrdVpgKu/fKbVsx1/go9+WdgyXB08rZ5tzH9Vq/SV2H68SPE03yZ6l
         XyoBGtPWnbiIduUQ1Per5za6gE49gDwPaaLVamf93xIIbIUom0rgP/kmW7k9V5peH0FL
         AiGxq/eqjik53Jc0WgjDnUocfXtTWpFEuMJAa2l0YT9U9DNbdLiDupWTHoq7DflOzOst
         ptdV5KNfkQ2a+FHUNdkK+YaozUxcQPbxelu9vMyXYOd6uunFgKPSJ1UX1xo5CXaCXpPh
         noZA==
X-Forwarded-Encrypted: i=1; AFNElJ9oMfGpnNXW2zglr6ky1F5/zQ6afqbpsHGNl6yMrcJ7nQvE3AGyAfZLMk159zQLUxWinzPkfjQzV/MHqjuha9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVX737SHDuWbDWZ1kspAzbQJmAIOZSSbinVct4viD+NerT1Gy
	jgLMDtT2b0++Fy/7wsV5T1G0FHVaoHmiF0vzTjzYmZAhfeTqPlNILfxRMROwi5zVHt7gbLGSt85
	uhGdO5qQy0j5gMoMcopCRDy9lp2suFelU5CvpLdWB
X-Gm-Gg: AeBDiesZhnJSK21/zqyP5OFPqAZ3cV5iMkTJikt0ipx15cmcy8H2i2O7fava8BEsJvw
	oTnZYPZd7uSl08SU140VcQWzXRdoivi2kp5+UOP9bcOVr83Soiv5JWq4/NqvBY5HFO4tH7Q9TbA
	f9sgBamMTCCRpo5Gy/k97eynQYXuVLQ//0barMBv8iiUV9A0f4fcvojpxGnkcQuWtdb2nhCLVbT
	MUCmDA+W4olmAaZWTVycKY3fp6ufsu9b5TLBZlEG38HFkbWvI+IwX+BW/Qs+dgPJ7GlwN632tBE
	CqS8QegXS0wd3VustGNDHvyN+gbVZXE+AMx69vWhC/iqwhRT
X-Received: by 2002:a05:6512:3d07:b0:5a2:bebd:45b5 with SMTP id
 2adb3069b0e04-5a3ef702ba7mr4942397e87.4.1776143011315; Mon, 13 Apr 2026
 22:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-pci-m2-e-v7-0-43324a7866e6@oss.qualcomm.com>
 <20260413075459.GA2626902@google.com> <fpcs4p62f35a5qyqwgm5ysa73stbysxcr62tkmmkrrcvsuf4t4@4ivukyqjey57>
 <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
In-Reply-To: <eeytuhqpgdz4do4tgtbmfntub2femtyq7bij7svhodpyjwaylx@j3gmvq2a2zqc>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 14 Apr 2026 13:03:19 +0800
X-Gm-Features: AQROBzBGpczfuo3hb4EM0V1LAlLdphdlu-SZQrzKHBW63mwHzThEUJagiFr7yFk
Message-ID: <CAGXv+5E=tujhtZjwi6Qm7hk3Ks74UzTQHWq82NiTEw1+vYod5g@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add support for handling PCIe M.2 Key E connectors
 in devicetree
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 12:08=E2=80=AFAM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> [Resending as my previous reply got bounced]
>
> On Mon, Apr 13, 2026 at 07:33:12PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 13, 2026 at 03:54:59PM +0800, Chen-Yu Tsai wrote:
> > > Hi,
> > >
> > > On Thu, Mar 26, 2026 at 01:36:28PM +0530, Manivannan Sadhasivam wrote=
:
> > > > Hi,
> > > >
> > > > This series is the continuation of the series [1] that added the in=
itial support
> > > > for the PCIe M.2 connectors. This series extends it by adding suppo=
rt for Key E
> > > > connectors. These connectors are used to connect the Wireless Conne=
ctivity
> > > > devices such as WiFi, BT, NFC and GNSS devices to the host machine =
over
> > > > interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds su=
pport for
> > > > connectors that expose PCIe interface for WiFi and UART interface f=
or BT. Other
> > > > interfaces are left for future improvements.
> > >
> > > Thanks for working on this. I started playing with it now that it is =
in
> > > -next. The PCIe part works fine. I'm looking into how to fit the pwrs=
eq
> > >
> > > A couple questions:
> > >
> > > - Given that this connector actually represents two devices, how do I
> > >   say I want the BT part to be a wakeup source, but not the WiFi part=
?
> > >   Does wakeup-source even work at this point?
> > >
> >
> > You can't use the DT property since the devices are not described in DT
> > statically. But you can still use the per-device 'wakeup' sysfs knob to=
 enable
> > wakeup.

I see. I think not being able to specify generic properties for the devices
on the connector is going to be a bit problematic. Another use case I have
requires specifying a bounce buffer / SWIOTLB for the PCIe WiFi card. The
PCIe controller does not have an IOMMU behind it.

> > > - Are there plans to do the SDIO part?
> > >
> >
> > No, not at the moment. Feel free to take it up if you have the hardware=
 and
> > motivation :)

Ack. I think I still need to figure out what the plan is after mmc-pwrseq
is deprecated.

> > > - The matching done in the M.2 connector driver for pwrseq_get() seem=
s a
> > >   bit naive. It simply checks if the remote device in the OF graph is
> > >   the same as the requesting device.
> > >
> > >   I think this would run into issues with USB hubs. If I have a USB h=
ub
> > >   and two M.2 connectors, with both connectors connected to the same
> > >   hub, pwrseq_get() is going to always return only one of the instanc=
es.
> > >   This is because the USB hub has one device node with multiple OF gr=
aph
> > >   ports.
> > >
> >
> > Yeah, this is a known limitation. I'm trying to improve this part now a=
nd have
> > the WIP commits here: https://github.com/Mani-Sadhasivam/linux/tree/pwr=
seq-bt-en-fixes
> >
> > Once the merge window closes, I'll submit these.

I couldn't tell which commit would help with this.

In my head I think we would need to extend pwrseq_get() to add something
like an index parameter that the provider is free to interpret. The M.2
connector driver could interpret it as the USB port number on the remote
end.


Thanks
ChenYu
