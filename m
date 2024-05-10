Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B614D9E9
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370537; cv=none; b=JoBpMTHsEN5mzES7k24/eFjfjEWpTgdwZV76WNeIEEmXEuGRw96wItc7RSdqAsbi1zNsiQpI3Htfq+Y8zODyY6MfGVX7XO4+tV73Xh2pa88aQdat3O0mwRjxitGirMnWbO2aJWrpyvCLHGxKRxM3a8+nd3BtrnW+2cf9bNoTE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370537; c=relaxed/simple;
	bh=ngLNEUzhzG5Q4S+ar+BpinXjlbqJe6hM9PJgSejVmfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrwGAbBy7mOBVxoZrZu90adxVp7Aj71Mn2oEg7MwFiJsVHHlututUkgGzcBPo6r314R0DN7oOGPEn7vA2MbCBKZFMGYeq6Uykby9+3jmXuHC73QgQjFdMDS+p/4hL4F+cn7BYVxzsbpWLFQ2z5iwAinWNcB669PxX686eHMXb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwzcpx4U; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwzcpx4U"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e4b90b03a9so26475411fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715370534; x=1715975334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngLNEUzhzG5Q4S+ar+BpinXjlbqJe6hM9PJgSejVmfA=;
        b=Kwzcpx4UPIwMzBgGNpABZEmdqq6uzMOzYK+wHlhKWlDI5hMW6IjnBLuTEPGN2ld+9H
         xrw86tSAc+EXZT708E837lPPYQkTpn05zl3QO+NizWBSQG2tEuywDT2+wSAfqybLOr/y
         TtmruZjNib+TQXP1en2CDLySMGGhhBC6qG5fQlveprrbWul+wb9N9AJd9FGEYAnQPd7K
         d8HHEvdXS7UMgjdPFKVRKSiolWaFI/MnjAP23cC/MsSg7rjfAxnoSL1I6U3F7rUBuBs6
         hbvFs7Hw6b8+UZWPAr+N8HujAbZFFsf+lD4HXz1IJ2tNtY4pkCw0Dsh1TIjklfyCsb6h
         zAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715370534; x=1715975334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngLNEUzhzG5Q4S+ar+BpinXjlbqJe6hM9PJgSejVmfA=;
        b=r9WZDd2Gd7RgKE5XrSL1ArctfY9wlt4UDYUVBZ+50DpIGZPUoZ2B/fbRfh4s4WMlvQ
         B4ZCjUhs0G5VVDQ9VsfzPVMSVj0gpQRML23Rdr9Ct074HSxydnyrUSF4thMBue1IIM0F
         7vseQavl0ADQv5D4UNMthnS5OghyPu9Z3YRNaTutjUe8MvhI0/SPIc7uRyKnihaouNOD
         o582qetRkyVQhddLbektgFQ7y+FJ9Kdf3JESn6ruVyyOoCSL1paXcxesaCk1Csyxx38S
         7Bk5Mmm3yoTKYOiAHD4Fudc51EmVX55asnQxxSJaYT2NCauDqzJ2jsgpMXkPeKJELtpy
         GL+Q==
X-Gm-Message-State: AOJu0YxrY/IZWo4R0ZrLDh0JSwNkpb/vWQVRaTqJSYSsEredM5R6Bnza
	/s5j8yvX9hy5VxDvy4MbuMPze+llr1n4SseMYgvNfUB21kMfgCxdfS3DlE/LIwPgft5yDKx1X1q
	82iTqsOH30UbICGiMbn3FuhFJ8Co=
X-Google-Smtp-Source: AGHT+IGZnOcB5H1ta9TvzWgjIKKBpXZka7YJRkK66QJunope6ibq+HJPuWiTWhWWSZDKb/zbxcP0B8uqgh7Os/DB3g4=
X-Received: by 2002:a2e:b01a:0:b0:2de:3421:9edd with SMTP id
 38308e7fff4ca-2e5203a4665mr20935131fa.33.1715370533311; Fri, 10 May 2024
 12:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
 <CABBYNZ+FBwFtrqg1Hj72Q7_6f8hDSwVTNtkofP0XgEd98DRf9A@mail.gmail.com> <560c5c03-563a-4f1c-abc1-1372ca73c421@penguintechs.org>
In-Reply-To: <560c5c03-563a-4f1c-abc1-1372ca73c421@penguintechs.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 May 2024 15:48:41 -0400
Message-ID: <CABBYNZK+FGe75VJ4YqsxxyGj-Ac+voeMb3CR9qRD+yz7d=d7oQ@mail.gmail.com>
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Wren Turkal <wt@penguintechs.org>
Cc: linux-bluetooth@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wren,

On Fri, May 10, 2024 at 3:14=E2=80=AFPM Wren Turkal <wt@penguintechs.org> w=
rote:
>
> On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:
> > Hi Wren,
> >
> > On Mon, May 6, 2024 at 3:24=E2=80=AFPM Wren Turkal <wt@penguintechs.org=
> wrote:
> >>
> >> Krzysztof,
> >>
> >> I am reaching out to you as you had the most important objections to t=
he
> >> change to fix qca6390 for the warm boot/module reload bug that I am
> >> experiencing.
> >>
> >> For context, the problem is that the hci_uart module will send specifi=
c
> >> vendor specfic commands during shutdown of the hardware under most
> >> situations. These VSCs put the bluetooth device into a non-working sta=
te
> >> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
> >>
> >> Zijun's proposed fix is to not send these commands when it's not
> >> appropriate for the hardware. The vendor commands should be avoided wh=
en
> >> the hardware does not have persistent configuration or when the device
> >> is in setup state (indicating that is has never been setup and should
> >> not be sent the VSCs on the shutdown path). This is what Zijun's patch
> >> implements.
> >>
> >> In addition, Zijun's change removes the influence of both
> >> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts
> >> that those flags should not influence the sending of the VSCs in the
> >> shutdown path. If I understand KK's objections properly, this is where
> >> his objection is stemming from. KK, is this correct?
> >>
> >> Zijun's proposed fix can be seen here:
> >> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-=
3-git-send-email-quic_zijuhu@quicinc.com/
> >>
> >> I'm wondering if we can resolve this impasse by splitting the change
> >> into two changes, as follows:
> >>
> >> 1. Change that removes the influence of the QCA_BT_OFF and HCI_RUNNING
> >> flags in the shutdown path.
> >> 2. Add the quirk from Zijun's patch that fixes my hardward configurati=
on.
> >>
> >> I'm hoping that better clearer descriptions for #1 can help get that
> >> landed since the logic current appears to be at odds with how the
> >> hardware works.
> >>
> >> Also, I am happy to split the patches into the two patches, or (maybe
> >> more ideally) just modify the commit message to better indicate the
> >> reason the change. I just need guidance from maintainers so that
> >> whatever work I do leads to something acceptable for y'all.
> >>
> >> So, please help me get this done. I am just a user with broken hardwar=
e
> >> and a fondness for Linux. I would love to help do what's needed to get
> >> this fix landed.
> >
> > Ive also objected to that change, in fact the whole shutdown sequence
> > is sort of bogus in my opinion and the driver shall really have some
> > means to find out what mode it is in when it reboots, regardless if
> > cold or warm boot, since otherwise we are in trouble if the user is
> > booting from another OS that doesn't do the expected shutdown
> > sequence.
>
> This criticism makes a ton of sense. I'm sorry I missed it before. There
> were a lot of threads moving in parallel. However, I am curious. Given
> that the patch improves the situation for users (like me). Is there any
> way we can separate the redesign of the shutdown sequence and the UX
> improvement that comes with this patch?
>
> Here's my concern. I am happy to do the work to redesign this. However,
> I don't think I have the information needed to do this since I don't
> have access to the technical docs for the qca6390. I am worried that not
> accepting some form of this patch is letting perfect be the enemy of the
> good. And I am not sure how I personally can help with that. If you
> think it's possible for me to do this without the docs for the hardware,
> I am willing to give it a shot if I can get some guidance. Honestly, I
> wish I had the skill to be confident about a change like this, but I don'=
t.
>
> Any ideas on how to move forward would be greatly appreciated.
>
> And just to be perfectly clear, I have tested this patch on my laptop.
> It greatly enhances my ability to use my hardware since I can reboot the
> machine without having to make sure to power cycle the laptop. This is
> not a theoretical improvement.

I would really love some explanation why can't the driver know under
what mode the controller is when it gets probed, because to me we
cannot accept a driver that only works under certain condition after
the boot and in case it is really impossible, can't even power cycle
it to get it back to cold boot stage???

Also the criticism here should be directed to the vendor, how long
have we been discussing problems in the QCA driver? And the only thing
I see coming our way are work-arounds of the problems, the address not
being unique coming from the firmware itself and when provided via DT
the address is in the wrong byteorder and now that the driver must
communicate the firmware on shutdown in order to get it working
properly on the next boot.

--=20
Luiz Augusto von Dentz
