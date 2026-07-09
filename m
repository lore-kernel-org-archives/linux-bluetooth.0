Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC153ACEE2
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631158; cv=pass; b=qpHc3tRIl65jdp/wGPekMcCRphTt5ibCTCUkatOrpPQqQENejn0tMPVfkitENXmAh8cvbDX+cIDjGs0lnwc+DFfI9wIspTcDszabJq9Wx42TqkoPI1GVzZsb3BND/pRflbyMoyoOR4iGEVJLe7Vvac20Mnk2KLzbJwzJl67Du5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631158; c=relaxed/simple;
	bh=/C41jxtKenll5BIssYP09zDrWutfkprHkOjpO9rpivU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnQQzyFmFqUSnL6irLn2SUQ4QyqJWcunTgxbo8G6FzJ+qIG3q8xJjxPCQQ7gGLkWMmfmxnkGFjowVDyZ7vtDtkYmw6R5AR1xuXFbcK0Vm92aBUCqMC8VWHN2IBQMiZ3AJC6Pi4/MZq6QGHSIP7kkZ/9kZx4TeukxjI97OAcpM/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=W5so3R0/; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="W5so3R0/"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caed617615so1927615ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Jul 2026 14:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783631156; cv=none;
        d=google.com; s=arc-20260327;
        b=S042WfPcC21YJmH6SdBjobXrZp0LWMosIzFhv6jqphvNusEP5ExwO4hpJ9YATNUvye
         eG6g+MYTUk3jTR3EHBkGXy83f/eC09DCGXZUtU31i3G9UJisi7zo78TbQGLTQ43QrnQ4
         1SDQSn4u6JlA+BaNPGwpTeozUo/0ua2BsXQMidooKi0wxVvCaViAQ66NqP41kABwrn4O
         qNzWIv9+F9sLOQnDBOS+3pa5Q7pMzhTrInZFKoZzufnwj5Q4jMoT1z9Z72VeIAQrbIC/
         X8oobwaNvkqzucmyvk8A8fGPY8EqaXH/A14IgVIHxfHC90EmwhAABdMwXA/6qM7G8SyB
         d00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2Mbytc2f5T/npbdUHn7lZOFk/XSgQNmPUoq1DJdzknM=;
        fh=ffM9w1MNg83xPurSSMyOkGpmm91bt6oklPWpplrioAQ=;
        b=n0KFxiJWRRAXIS43ZecNdciaHeBes2HRZapFK7NabdaIRkbij0E9oVw7WapCphLCf+
         OXm3mEFPQmMVMKdHFmAw3u648qZ5gGcDdke8HffK4PkuBZ1sBvUkiFaOUd+QT0Gt47DE
         vOvPM74BC+8VgD/CpS/nJ4B1dm8DFjISg/AD0p1kookR39/4IINtaOzPqvD39W0b9MfK
         LJXtUxm19uwKHiGHditcSI7/ziuiOJWLPeJM6q2U/C3FPlAhRcm7tJQ1TOwMgUjcwvH6
         5194rntgl9H4JaICjOA/Q0+1lquRQoeudUlOpyoVfDUtFmpmv7UQHun4WsVjBB2/hB9C
         7L6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783631156; x=1784235956; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Mbytc2f5T/npbdUHn7lZOFk/XSgQNmPUoq1DJdzknM=;
        b=W5so3R0/pMOk2CFOMEC6wN34ehUOCZVp6hXEvhk0/N43+J18I+6ulEe9v4u4NXtlsJ
         DM55k4ON8ZUUcXedmuEZmWfrB4Z66ro54xZVkPvGQsar9jPuOZpqmmlALCyFOUoUZkrS
         kkB4CsdFyMqIYcdFZH9E9ZbXbdYSTN25e5ZgJckB4yqj5TPZW9NQqfnXrmvFbUB9oeJz
         BKZ1gi+6hFqio/lXqNoqNEVaqk81vnAtm5KDxwgmORtQNscVSIgHaGS85k6A79bdT8wn
         l36RxaP+i3Ljj9+ZOebxrXh9C1zJcT7xTAmS8fkKp9kLU2r+gVIqgFKnDslVnGuBYsyO
         b+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631156; x=1784235956;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2Mbytc2f5T/npbdUHn7lZOFk/XSgQNmPUoq1DJdzknM=;
        b=qgE3sxkj4n6av7Kz9RKADeDPzor5hmhY79wpi9fJDSNNUOUd1yPrqwoy4N341Gz0vt
         wR3x4GlxrL+CanlgM7KHDD7ElkFkoRrRtdxQoAtGFUO2BbMhoqJqEv5rTqOHIZbh2OS7
         cBfHGuWhP+EqdiiXHIb+Pb7enByAaWlaLHZKs5NRkQ+wYLfbFgjbYPak0Kr3H1OSZyGr
         LR9MEYlXqYNZ3wHslnVOR8oHD6IPUCTXxQHcpcKWuZm7KZEcuWgF5qlrO/RK2rgIic/P
         s/4ISPVLXhK7trlHUtd86tfpcp23JLBxdP733AqYmwgMs/opGxIjraMJzqUumjRpxk3U
         GrQg==
X-Forwarded-Encrypted: i=1; AHgh+RoGdCQXhKK2absEh1/zZfw4ac0U8MsCaVJhdHfr3B8pIrED7LNybP4WnLX/10dyaNmAsG461A016qmw9tiLmR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1ZOqREnk26w0A4Qb/9ciRgaQnCZ2MI5vyFVpmLPV3WjbHdVJ
	Hz4YeB4V3PMSYqBlAKE4Ey4gVlAKIMoEG03MkxCDJl3ZgwcRy50bRdtErUvEQ/9DPci1hQWprQt
	K1iqt9UZBtKulYyJSdCDkYbhqfp43YvT9DhPn9DOV+2rq7GF5l+Ly2QMRKog=
X-Gm-Gg: AfdE7ck7LdJdbs7YJsgXGe/gC/+bf1dazU7HQXG2nty0bvm0g/7oSL16EUZuW7X+4TX
	AK9Lvq2CLG9KsLuXNf4CZUd3kHpO4ue0ksG6j+snOh5Zr1P7SZ06M0Xob14EuNs5wYAhEYqtmbK
	lHqatrsXxtvd7YbxldvCyr6D+p1UiGOjgerTdwfDsgt9Xg9Q7feNETa/WPHh1JbF8BzqVj4D2YZ
	7oeELNnQqGBqp28cZlL/xLh91zUBWuxQr0oIGMU7zAWYc4Gos72gDmycoFI4eRru7XUnOZv+SF6
	VohLaBhgFFg+l4r1akHjKj+W76COkDE+ZRNQFzbaFvzjUJyx5EDISu4d8OHBVgcJsC9GzlA=
X-Received: by 2002:a17:903:2a83:b0:2c7:ef3b:e17f with SMTP id
 d9443c01a7336-2ccea489320mr98226595ad.36.1783631155734; Thu, 09 Jul 2026
 14:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705115650.81724-1-doruk@0sec.ai> <f28eea1f-80da-4def-b11f-33a531a1b595@molgen.mpg.de>
 <AS4PR04MB9692E00192B16910C3F3C011E7F12@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To: <AS4PR04MB9692E00192B16910C3F3C011E7F12@AS4PR04MB9692.eurprd04.prod.outlook.com>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Thu, 9 Jul 2026 23:05:43 +0200
X-Gm-Features: AVVi8Cdkzqa-f-Il9d6LSREN7qAcZCWeuHYqDS6LpZWVeqr8yyG_4lzRg21oYkA
Message-ID: <CAPdMp1pcsmnnH9vXKfhxSo5q0Dr+TiLL+0ZrN=Pz-eZtWQjutg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btnxpuart: Fix out-of-bounds firmware read in nxp_recv_fw_req_v1()
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Neeraj,

Thank you, and sorry if I'm missing sth!

That patchwork link points to Zhao
Dongdong's "Fix use-after-free in probe error path" patch, which addresses
the probe-path use-after-free rather than the firmware-download read.

On the firmware-read side: commit 25c286d75821 ("Bluetooth: btnxpuart: Fix
out-of-bounds firmware read in nxp_recv_fw_req_v3()") bounded the v3 handler.
My patch targets the v1 handler, nxp_recv_fw_req_v1(), where (at least in
today's bluetooth-next) the header length is still read at
nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)

with no bound on fw_dnld_v1_offset, and the payload write still uses the
non-overflow-safe "fw_dnld_v1_offset + len <= fw->size" form
(fw_dnld_v1_offset is u32, so the sum can wrap).

If it's still open, I'm happy to send a v2 that also logs the
offset/size values,
as Paul suggested. Either way, thanks very much for taking the time,
and I'm happy to defer to whatever you have queued.

Best,
Doruk



On Mon, 6 Jul 2026 at 06:20, Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> Hi Doruk,
>
> Thank you for submitting this patch.
>
> However, a similar patch is already in review and approved by me:
> https://patchwork.kernel.org/project/bluetooth/patch/tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com/
> It's awaiting Luiz's review and/or merge.
>
>
> Hi Luiz,
>
> Can you please review the patch mentioned in the URL above, from Zhao Dongdong? I have answered your review comment.
> Thank you for your time and review.
>
> Thanks,
> Neeraj
>
>
> > Dear Doruk,
> >
> >
> > Thank you for the patch.
> >
> > Am 05.07.26 um 13:56 schrieb Doruk Tan Ozturk:
> > > Commit 25c286d75821 ("Bluetooth: btnxpuart: Fix out-of-bounds firmware
> > > read in nxp_recv_fw_req_v3()") bounded the v3 firmware download offset
> > > but left an unbounded read in the v1 handler.
> > >
> > > nxp_recv_fw_req_v1() advances a device-driven download offset
> > > (fw_dnld_v1_offset) by fw_v1_sent_bytes on every request, and that
> > > bookkeeping runs even when the payload write is skipped, so the offset
> > > can walk past nxpdev->fw->size. When the controller then requests a
> > > header (len == HDR_LEN), the driver reads the 16-byte bootloader
> > > header at
> > >
> > >    nxp_get_data_len(nxpdev->fw->data + nxpdev->fw_dnld_v1_offset)
> > >
> > > with no bound on the offset, reading past the end of the firmware image.
> > > A malicious or malfunctioning NXP UART controller can drive this to
> > > read out-of-bounds kernel memory during firmware download.
> > >
> > > Bound the offset before the header read, and convert the payload write
> > > guard to the overflow-safe form used by the v3 path (fw_dnld_v1_offset
> > > is u32, so fw_dnld_v1_offset + len can wrap).
> > >
> > > This was found by 0sec automated security-research tooling
> > >
> > (https://0sec.a/
> > i%2F&data=05%7C02%7Cneeraj.sanjaykale%40nxp.com%7Cc82fdb86e33f476
> > 570ed08dedad83110%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> > C639188819230990815%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiO
> > nRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyf
> > Q%3D%3D%7C0%7C%7C%7C&sdata=z6YC4OGfeSW45U2PbFFlFz13DG3%2FSr
> > qYeFKMSNTiMBI%3D&reserved=0).
> > >
> > > Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP
> > > Bluetooth chipsets")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: 0sec:claude-opus-4-8
> > > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > > ---
> > >   drivers/bluetooth/btnxpuart.c | 13 ++++++++++---
> > >   1 file changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btnxpuart.c
> > > b/drivers/bluetooth/btnxpuart.c index 6a1cffe08d5f..88d9ebf25a8f
> > > 100644
> > > --- a/drivers/bluetooth/btnxpuart.c
> > > +++ b/drivers/bluetooth/btnxpuart.c
> > > @@ -1041,11 +1041,17 @@ static int nxp_recv_fw_req_v1(struct hci_dev
> > *hdev, struct sk_buff *skb)
> > >                * and we need to re-send the previous header again.
> > >                */
> > >               if (len == nxpdev->fw_v1_expected_len) {
> > > -                     if (len == HDR_LEN)
> > > +                     if (len == HDR_LEN) {
> > > +                             if (nxpdev->fw_dnld_v1_offset >= nxpdev->fw->size ||
> > > +                                 nxpdev->fw->size - nxpdev->fw_dnld_v1_offset <
> > HDR_LEN) {
> > > +                                     bt_dev_err(hdev, "FW request
> > > + offset out of bounds");
> >
> > Would it make sense to log all the values, as I'd think, such an issue might be
> > hard to reproduce and gathering the values miht be difficult?
> >
> > > +                                     goto free_skb;
> > > +                             }
> > >                               nxpdev->fw_v1_expected_len = nxp_get_data_len(nxpdev-
> > >fw->data +
> > >                                                                       nxpdev->fw_dnld_v1_offset);
> > > -                     else
> > > +                     } else {
> > >                               nxpdev->fw_v1_expected_len = HDR_LEN;
> > > +                     }
> > >               } else if (len == HDR_LEN) {
> > >                       /* FW download out of sync. Send previous chunk again */
> > >                       nxpdev->fw_dnld_v1_offset -=
> > > nxpdev->fw_v1_sent_bytes; @@ -1053,7 +1059,8 @@ static int
> > nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
> > >               }
> > >       }
> > >
> > > -     if (nxpdev->fw_dnld_v1_offset + len <= nxpdev->fw->size)
> > > +     if (nxpdev->fw_dnld_v1_offset < nxpdev->fw->size &&
> > > +         len <= nxpdev->fw->size - nxpdev->fw_dnld_v1_offset)
> > >               serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
> > >                                       nxpdev->fw_dnld_v1_offset, len);
> > >       nxpdev->fw_v1_sent_bytes = len;
> >
> >
> > Kind regards,
> >
> > Paul
