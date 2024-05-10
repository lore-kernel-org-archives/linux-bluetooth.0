Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A05F13B2B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 21:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715376324; cv=none; b=l4L3uzlwG7NOyj6OD5Kwbd6m3JxzfFzBGR5TCMIG6HC6A/lyoju1usEUASVD4iCiRhqtkawe4yLr6gmBCNmDCOIAoK9GCaC0EoziXh6zxVcWKGQEQGIItkjdpn4exhW+TudFFKqKwejTVgH6zLdUlQLSo8MMb5HUkwomCr35+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715376324; c=relaxed/simple;
	bh=xUFviK84qTXkC9kXPjMLjteGyj16DYAPFlH94s5sWiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+WeFmsi6mEiHlKdff5n9AAeSc/X3sZ5Ua4JuPGc+i6mw6LXFB8ZL2T8eBenKHHyBTpdw9i8V8Ts4w4x/KdKEfon6he+ijBZni8bsqLA8Gc2mXqxN3tn8Ybsug/NwhWBeTNwrSZMkrNYhQGDgvt4fLLh/J8KBaL2dO1kg1mNFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyVSEG2n; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyVSEG2n"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so31447511fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715376320; x=1715981120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUFviK84qTXkC9kXPjMLjteGyj16DYAPFlH94s5sWiM=;
        b=lyVSEG2nywCx0CGrjjh7cg0IYkl6FGiDHJxDysEqFIOi8n0ovJxXSpsnGv+EJZU6Q9
         VScAnOuK+JbvLHl1zKXDL3yUx1FzAKcHJidw50dnCyybSvByjDw3mqKFMFDP+Uz7RcsE
         Ht6qs0G8JTsVb/LKXgodiAFJNguWeTnBXe5YQ9bPAz1nL+HWl8FqiNtn7H3awMzpmEdh
         voSeWp0h7WUR3D63YI9eDtWCREbaTe5qng93AP4pDRMUr3aKKWXnHi3mZdyxxyTCL52y
         TN3jTQs4I6ErTYsEvaFG8ZpFgyXQmE/X9eHlAXR//kfAtYgEqjBt3fOPGJxuKhGknxac
         zO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715376320; x=1715981120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUFviK84qTXkC9kXPjMLjteGyj16DYAPFlH94s5sWiM=;
        b=eF70YWb4id4fKfVmE14zNfIysxXw8dzAHhCI7Yp0ZzSr4QOCftks15w9gD0LIC9zd9
         aHOzf2ZCku1MzIXIqD/agLG1GYU/Dkkl3gPYiekw8Pb2XDepKWlFSCGqBGLHgxlB153F
         QTHubkRUfiuca+aqpiyn0e3q2sOLmK2qJlFR9uDCWEDCI6pPahlSLsYUcw+Ag2L5IPCP
         p6eOcau4GbEoZU7DGayKsVh6SOZjs7yISFJvpHYfsbXqIT32e/Y6X6INvrZ/Br+cWWyY
         q4G4TVCXGPZ10/3GROfu8nsKMrKGCq2/cFUuGXn2h31scbOJ9u/+/a5ZwEBXlP+frHku
         h9kQ==
X-Gm-Message-State: AOJu0YymhnbLFMJnGQaaZHEbzW3ANE/983UgqQzbCPbgQBCHlR3Yi5yi
	gtx5y6R+aNrjRWZvjPbXnkeqOr5Upfii2sb0WCLM7y3CTOEVZBHA+2zZGWSEkbUSN8ZSjAb0Ytm
	0rzeenUTELLc6ZP3DqwSEOFEQxxA=
X-Google-Smtp-Source: AGHT+IFUq0dxU8uR43rmqTpPQ9UlPIhIl846Oe24IA/SyZk0Z4Zk5y4/4X7WyW7sixHyLhER5s6vv+ItOYkKw37ad7o=
X-Received: by 2002:a05:651c:550:b0:2df:b0e3:b548 with SMTP id
 38308e7fff4ca-2e5203a4a63mr25651661fa.42.1715376320229; Fri, 10 May 2024
 14:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
 <CABBYNZ+FBwFtrqg1Hj72Q7_6f8hDSwVTNtkofP0XgEd98DRf9A@mail.gmail.com>
 <560c5c03-563a-4f1c-abc1-1372ca73c421@penguintechs.org> <CABBYNZK+FGe75VJ4YqsxxyGj-Ac+voeMb3CR9qRD+yz7d=d7oQ@mail.gmail.com>
 <44b75302-1349-445d-90ac-8df8a1fb91e2@penguintechs.org>
In-Reply-To: <44b75302-1349-445d-90ac-8df8a1fb91e2@penguintechs.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 May 2024 17:25:08 -0400
Message-ID: <CABBYNZ+KTV7y-UxWE_6jaHT0wDiMN-xReHW8zLT0WEPHCsyXQQ@mail.gmail.com>
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Wren Turkal <wt@penguintechs.org>
Cc: linux-bluetooth@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wren,

On Fri, May 10, 2024 at 4:54=E2=80=AFPM Wren Turkal <wt@penguintechs.org> w=
rote:
>
> On 5/10/24 12:48 PM, Luiz Augusto von Dentz wrote:
> > Hi Wren,
> >
> > On Fri, May 10, 2024 at 3:14=E2=80=AFPM Wren Turkal <wt@penguintechs.or=
g> wrote:
> >>
> >> On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:
> >>> Hi Wren,
> >>>
> >>> On Mon, May 6, 2024 at 3:24=E2=80=AFPM Wren Turkal <wt@penguintechs.o=
rg> wrote:
> >>>>
> >>>> Krzysztof,
> >>>>
> >>>> I am reaching out to you as you had the most important objections to=
 the
> >>>> change to fix qca6390 for the warm boot/module reload bug that I am
> >>>> experiencing.
> >>>>
> >>>> For context, the problem is that the hci_uart module will send speci=
fic
> >>>> vendor specfic commands during shutdown of the hardware under most
> >>>> situations. These VSCs put the bluetooth device into a non-working s=
tate
> >>>> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
> >>>>
> >>>> Zijun's proposed fix is to not send these commands when it's not
> >>>> appropriate for the hardware. The vendor commands should be avoided =
when
> >>>> the hardware does not have persistent configuration or when the devi=
ce
> >>>> is in setup state (indicating that is has never been setup and shoul=
d
> >>>> not be sent the VSCs on the shutdown path). This is what Zijun's pat=
ch
> >>>> implements.
> >>>>
> >>>> In addition, Zijun's change removes the influence of both
> >>>> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts
> >>>> that those flags should not influence the sending of the VSCs in the
> >>>> shutdown path. If I understand KK's objections properly, this is whe=
re
> >>>> his objection is stemming from. KK, is this correct?
> >>>>
> >>>> Zijun's proposed fix can be seen here:
> >>>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-1961=
9-3-git-send-email-quic_zijuhu@quicinc.com/
> >>>>
> >>>> I'm wondering if we can resolve this impasse by splitting the change
> >>>> into two changes, as follows:
> >>>>
> >>>> 1. Change that removes the influence of the QCA_BT_OFF and HCI_RUNNI=
NG
> >>>> flags in the shutdown path.
> >>>> 2. Add the quirk from Zijun's patch that fixes my hardward configura=
tion.
> >>>>
> >>>> I'm hoping that better clearer descriptions for #1 can help get that
> >>>> landed since the logic current appears to be at odds with how the
> >>>> hardware works.
> >>>>
> >>>> Also, I am happy to split the patches into the two patches, or (mayb=
e
> >>>> more ideally) just modify the commit message to better indicate the
> >>>> reason the change. I just need guidance from maintainers so that
> >>>> whatever work I do leads to something acceptable for y'all.
> >>>>
> >>>> So, please help me get this done. I am just a user with broken hardw=
are
> >>>> and a fondness for Linux. I would love to help do what's needed to g=
et
> >>>> this fix landed.
> >>>
> >>> Ive also objected to that change, in fact the whole shutdown sequence
> >>> is sort of bogus in my opinion and the driver shall really have some
> >>> means to find out what mode it is in when it reboots, regardless if
> >>> cold or warm boot, since otherwise we are in trouble if the user is
> >>> booting from another OS that doesn't do the expected shutdown
> >>> sequence.
> >>
> >> This criticism makes a ton of sense. I'm sorry I missed it before. The=
re
> >> were a lot of threads moving in parallel. However, I am curious. Given
> >> that the patch improves the situation for users (like me). Is there an=
y
> >> way we can separate the redesign of the shutdown sequence and the UX
> >> improvement that comes with this patch?
> >>
> >> Here's my concern. I am happy to do the work to redesign this. However=
,
> >> I don't think I have the information needed to do this since I don't
> >> have access to the technical docs for the qca6390. I am worried that n=
ot
> >> accepting some form of this patch is letting perfect be the enemy of t=
he
> >> good. And I am not sure how I personally can help with that. If you
> >> think it's possible for me to do this without the docs for the hardwar=
e,
> >> I am willing to give it a shot if I can get some guidance. Honestly, I
> >> wish I had the skill to be confident about a change like this, but I d=
on't.
> >>
> >> Any ideas on how to move forward would be greatly appreciated.
> >>
> >> And just to be perfectly clear, I have tested this patch on my laptop.
> >> It greatly enhances my ability to use my hardware since I can reboot t=
he
> >> machine without having to make sure to power cycle the laptop. This is
> >> not a theoretical improvement.
> >
> > I would really love some explanation why can't the driver know under
> > what mode the controller is when it gets probed, because to me we
> > cannot accept a driver that only works under certain condition after
> > the boot and in case it is really impossible, can't even power cycle
> > it to get it back to cold boot stage???
>
> This is a great technical criticism of the driver, and I think you
> deserve that explanation.
>
> However, with the driver already in the kernel, shouldn't the bias be
> toward mitigating the extremely bad UX and not hold users hostage for
> the bad design which has already been approved and landed in the kernel?
>
> > Also the criticism here should be directed to the vendor, how long
> > have we been discussing problems in the QCA driver? And the only thing
> > I see coming our way are work-arounds of the problems, the address not
> > being unique coming from the firmware itself and when provided via DT
> > the address is in the wrong byteorder and now that the driver must
> > communicate the firmware on shutdown in order to get it working
> > properly on the next boot.
>
> I agree that Qualcomm should get flack for this, however, the UX problem
> can be mitigated with a logic fix that doesn't make the init/shutdown
> design problem any worse than it currently seems to be. I mean, wouldn't
> this logic have to exist somewhere even if it weren't the shutdown path?
>
> If you are trying to use this as leverage to get Qualcomm to do a bigger
> thing (redesign the init/shutdown logic), I do think that tactic
> needlessly puts users in the crossfire. I can totally understand why
> you'd do it. I am just suffering the crossfire in the meantime, and it
> doesn't feel great.

So you prefer to risk getting a kernel crash due to UAF over Bluetooth
not working? Really? Because I haven't seen any configuration that
those changes you tested don't reintroduce the UAF, which is why I
haven't applied that change to begin with, so no I'm not holding back
to pressure Qualcomm to redesign the shutdown logic, it just these
things got entangled because I just realized the shutdown thingy is
really out of place, imo, but I'd be fine if there is a temporary fix
until someone finally decide to spend some time to really fix the
shutdown logic.


--=20
Luiz Augusto von Dentz
