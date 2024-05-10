Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EE4DA09
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715383264; cv=none; b=gtHIKpcS0wlBTWa4bc7+R610rjole/W4JFYHOkEr6zsyiFfQ+8tttZclh+6S6KR5sLz/dwQZL9oUbNXU4ICC1BHEQzVL9hpLsvdk27l91cemi1zc9fBQ+Us5Rf+04fQ0Af7ODkAUl0IgUNfgQTx62+ozFxKcVp6i9VOFMch48Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715383264; c=relaxed/simple;
	bh=Ihx6jHvQBcYBhmKKX0wSUpNH/MHOgk90oKHDPNCexLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9sWQl0+1/E3w2hETSFR5N/cPFlbG12JcFgCQytPRsYjwZsoUyVaOBkr9/+pXwcLDjGCDQUbBO4RL0P/I7t+aP4JrCgAE+i/NqhhQkblynbFLUVhzMqu6qEZ4+eAgxwOhkD+K/xue2ERU8lNsbDoG6fsNU2KTVfWcCJMW3jwZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQOsQBNd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQOsQBNd"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e538a264e0so19909811fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715383260; x=1715988060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihx6jHvQBcYBhmKKX0wSUpNH/MHOgk90oKHDPNCexLw=;
        b=DQOsQBNd5PYsvRJSYlwFfC0SDTRopIgZI1OWcdsv2FoGw+YRdur9AtCKxOVDBeOPe2
         R4xyO1h0b8CAc+Dj7UT4r1guo00AgzL+wfNy1msvfU+fgwGhLfVGtH5K3bfNxviZRsFx
         SOxxHg7dKTC+GLjeEKckX8p+zv6j0BzTDya0Ge4JGbErA3pLPjRSPfOjC9JEy0LQrzqW
         veAe3zUIys9c/AaPJAAB23OqJLjXjYHYz6z/5j3jtXz7b9ZFdJ7E0Mj0jQp75JmHjp6a
         ov+m8Dxl7YYLRkTuXdAxz7YFFZR7FCWUp332mvYBw/RGOY7z8mBjEr3fY4kRwtmUv1J+
         QG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715383260; x=1715988060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihx6jHvQBcYBhmKKX0wSUpNH/MHOgk90oKHDPNCexLw=;
        b=nTiwF9yeVXAxrGskF6TJxljuIr/LJN4lsezYeqiV5y9niFKtB9+d+3gzfN4u/nJFKM
         IlIHpEu9L0fe+iw8fH5SA7M9YaMcRpeGFAezvPoW8+FDpmdoz05DAn+xduKtv4foZufz
         aCIfJw4ZsD15H+THFjSUeaZ0m9+wk2D93vh6MoDZ1X/fHcB3XCNYFw2FgKHO6sqiKj0a
         GiQ1RQg5p2vX9iXZt7TTt0LeIx2Wy2OUwgFWfVmBQgtxfmoc3bUiYFNcqLqji1wgm1qB
         W+x9gLZ5al46mP4+bGvjtVq1LDhBXrmKx3txgOpPhmWKUB7wBO+GuOEDxpzormrfnrB4
         rEjg==
X-Gm-Message-State: AOJu0Yw6R2PDmne8rnpa6sJpXX1o/VVyP6W/jMx9vOZsjspU/o+M5fL/
	/uDgEui1x+BCbmJl9bmLKWx4+gZYXwgxV6N99xiibvkWZUmqjl8omSD0NuCILy2UPuB0tl57nbJ
	iEwpZvK/5E5LDxTemKTreyLgOils=
X-Google-Smtp-Source: AGHT+IGRpiVjL2UKxPz4lP5+QO5AC7Gq2l509pq09EggUsEZ8VcVSUl+DJQ9XFoOMLQKJEsgXZtbPNntrtsyyVRxZkI=
X-Received: by 2002:a2e:8898:0:b0:2e0:3367:81fc with SMTP id
 38308e7fff4ca-2e5205c80f3mr29792381fa.49.1715383260132; Fri, 10 May 2024
 16:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
 <CABBYNZ+FBwFtrqg1Hj72Q7_6f8hDSwVTNtkofP0XgEd98DRf9A@mail.gmail.com>
 <560c5c03-563a-4f1c-abc1-1372ca73c421@penguintechs.org> <CABBYNZK+FGe75VJ4YqsxxyGj-Ac+voeMb3CR9qRD+yz7d=d7oQ@mail.gmail.com>
 <44b75302-1349-445d-90ac-8df8a1fb91e2@penguintechs.org> <CABBYNZ+KTV7y-UxWE_6jaHT0wDiMN-xReHW8zLT0WEPHCsyXQQ@mail.gmail.com>
 <089e57db-e2c5-4e42-b52e-c9e052c69efa@molgen.mpg.de>
In-Reply-To: <089e57db-e2c5-4e42-b52e-c9e052c69efa@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 May 2024 19:20:47 -0400
Message-ID: <CABBYNZL6RPPN62TY95w4o7CGsRH=Zy_mgJMstXjZ3pYegk1hpQ@mail.gmail.com>
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org, Wren Turkal <wt@penguintechs.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Fri, May 10, 2024 at 6:57=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Luiz,
>
>
> Am 10.05.24 um 23:25 schrieb Luiz Augusto von Dentz:
>
> > On Fri, May 10, 2024 at 4:54=E2=80=AFPM Wren Turkal <wt@penguintechs.or=
g> wrote:
> >>
> >> On 5/10/24 12:48 PM, Luiz Augusto von Dentz wrote:
>
> >>> On Fri, May 10, 2024 at 3:14=E2=80=AFPM Wren Turkal <wt@penguintechs.=
org> wrote:
> >>>>
> >>>> On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:
>
> >>>>> On Mon, May 6, 2024 at 3:24=E2=80=AFPM Wren Turkal <wt@penguintechs=
.org> wrote:
> >>>>>>
> >>>>>> Krzysztof,
> >>>>>>
> >>>>>> I am reaching out to you as you had the most important objections =
to the
> >>>>>> change to fix qca6390 for the warm boot/module reload bug that I a=
m
> >>>>>> experiencing.
> >>>>>>
> >>>>>> For context, the problem is that the hci_uart module will send spe=
cific
> >>>>>> vendor specfic commands during shutdown of the hardware under most
> >>>>>> situations. These VSCs put the bluetooth device into a non-working=
 state
> >>>>>> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
> >>>>>>
> >>>>>> Zijun's proposed fix is to not send these commands when it's not
> >>>>>> appropriate for the hardware. The vendor commands should be avoide=
d when
> >>>>>> the hardware does not have persistent configuration or when the de=
vice
> >>>>>> is in setup state (indicating that is has never been setup and sho=
uld
> >>>>>> not be sent the VSCs on the shutdown path). This is what Zijun's p=
atch
> >>>>>> implements.
> >>>>>>
> >>>>>> In addition, Zijun's change removes the influence of both
> >>>>>> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asser=
ts
> >>>>>> that those flags should not influence the sending of the VSCs in t=
he
> >>>>>> shutdown path. If I understand KK's objections properly, this is w=
here
> >>>>>> his objection is stemming from. KK, is this correct?
> >>>>>>
> >>>>>> Zijun's proposed fix can be seen here:
> >>>>>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19=
619-3-git-send-email-quic_zijuhu@quicinc.com/
> >>>>>>
> >>>>>> I'm wondering if we can resolve this impasse by splitting the chan=
ge
> >>>>>> into two changes, as follows:
> >>>>>>
> >>>>>> 1. Change that removes the influence of the QCA_BT_OFF and HCI_RUN=
NING
> >>>>>> flags in the shutdown path.
> >>>>>> 2. Add the quirk from Zijun's patch that fixes my hardward configu=
ration.
> >>>>>>
> >>>>>> I'm hoping that better clearer descriptions for #1 can help get th=
at
> >>>>>> landed since the logic current appears to be at odds with how the
> >>>>>> hardware works.
> >>>>>>
> >>>>>> Also, I am happy to split the patches into the two patches, or (ma=
ybe
> >>>>>> more ideally) just modify the commit message to better indicate th=
e
> >>>>>> reason the change. I just need guidance from maintainers so that
> >>>>>> whatever work I do leads to something acceptable for y'all.
> >>>>>>
> >>>>>> So, please help me get this done. I am just a user with broken har=
dware
> >>>>>> and a fondness for Linux. I would love to help do what's needed to=
 get
> >>>>>> this fix landed.
> >>>>>
> >>>>> Ive also objected to that change, in fact the whole shutdown sequen=
ce
> >>>>> is sort of bogus in my opinion and the driver shall really have som=
e
> >>>>> means to find out what mode it is in when it reboots, regardless if
> >>>>> cold or warm boot, since otherwise we are in trouble if the user is
> >>>>> booting from another OS that doesn't do the expected shutdown
> >>>>> sequence.
> >>>>
> >>>> This criticism makes a ton of sense. I'm sorry I missed it before. T=
here
> >>>> were a lot of threads moving in parallel. However, I am curious. Giv=
en
> >>>> that the patch improves the situation for users (like me). Is there =
any
> >>>> way we can separate the redesign of the shutdown sequence and the UX
> >>>> improvement that comes with this patch?
> >>>>
> >>>> Here's my concern. I am happy to do the work to redesign this. Howev=
er,
> >>>> I don't think I have the information needed to do this since I don't
> >>>> have access to the technical docs for the qca6390. I am worried that=
 not
> >>>> accepting some form of this patch is letting perfect be the enemy of=
 the
> >>>> good. And I am not sure how I personally can help with that. If you
> >>>> think it's possible for me to do this without the docs for the hardw=
are,
> >>>> I am willing to give it a shot if I can get some guidance. Honestly,=
 I
> >>>> wish I had the skill to be confident about a change like this, but I=
 don't.
> >>>>
> >>>> Any ideas on how to move forward would be greatly appreciated.
> >>>>
> >>>> And just to be perfectly clear, I have tested this patch on my lapto=
p.
> >>>> It greatly enhances my ability to use my hardware since I can reboot=
 the
> >>>> machine without having to make sure to power cycle the laptop. This =
is
> >>>> not a theoretical improvement.
> >>>
> >>> I would really love some explanation why can't the driver know under
> >>> what mode the controller is when it gets probed, because to me we
> >>> cannot accept a driver that only works under certain condition after
> >>> the boot and in case it is really impossible, can't even power cycle
> >>> it to get it back to cold boot stage???
> >>
> >> This is a great technical criticism of the driver, and I think you
> >> deserve that explanation.
> >>
> >> However, with the driver already in the kernel, shouldn't the bias be
> >> toward mitigating the extremely bad UX and not hold users hostage for
> >> the bad design which has already been approved and landed in the kerne=
l?
> >>
> >>> Also the criticism here should be directed to the vendor, how long
> >>> have we been discussing problems in the QCA driver? And the only thin=
g
> >>> I see coming our way are work-arounds of the problems, the address no=
t
> >>> being unique coming from the firmware itself and when provided via DT
> >>> the address is in the wrong byteorder and now that the driver must
> >>> communicate the firmware on shutdown in order to get it working
> >>> properly on the next boot.
> >>
> >> I agree that Qualcomm should get flack for this, however, the UX probl=
em
> >> can be mitigated with a logic fix that doesn't make the init/shutdown
> >> design problem any worse than it currently seems to be. I mean, wouldn=
't
> >> this logic have to exist somewhere even if it weren't the shutdown pat=
h?
> >>
> >> If you are trying to use this as leverage to get Qualcomm to do a bigg=
er
> >> thing (redesign the init/shutdown logic), I do think that tactic
> >> needlessly puts users in the crossfire. I can totally understand why
> >> you'd do it. I am just suffering the crossfire in the meantime, and it
> >> doesn't feel great.
> >
> > So you prefer to risk getting a kernel crash due to UAF over Bluetooth
> > not working? Really? Because I haven't seen any configuration that
> > those changes you tested don't reintroduce the UAF, which is why I
> > haven't applied that change to begin with, so no I'm not holding back
> > to pressure Qualcomm to redesign the shutdown logic, it just these
> > things got entangled because I just realized the shutdown thingy is
> > really out of place, imo, but I'd be fine if there is a temporary fix
> > until someone finally decide to spend some time to really fix the
> > shutdown logic.
>
> The no-regression policy is clear to not cause regressions for users.
> Even if we had crash reports from before, fixing one bug and causing
> another is unwanted to my understanding.

So you are also suggesting that a system crash is less of a problem
then a regression? I'm not opposed to having a fix to the regression,
but it needs to come without the reintroduction of a system crash,
period. The no-regression policy only applies as long as it doesn't
cause even bigger problems like a system crash or a security problem
for example, otherwise we need to find a better option, which in my
opinion is to rework the driver shutdown logic, if I had the hardware
and could experiment with I would just attempt to detect the hardware
mode at probe and if that fails force a reset and start over since the
setup stage exists exactly for the driver to have exclusive access to
the controller it can in theory power cycle the controller.

>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
