Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E201C69E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633192; cv=none; b=FaksHby7arRwK8gDFtIO0hH2Qjfw8shWxxm/2IgjoKOGJwK3DulA2VRfP0qEKRpXrG3Z6GKn+CJNmbRMxLuzRFe5r0DmswlqCKVWrQiMq7N46wOX3F094TbJ7Fjq6RtnF2ei5I0CRCHgzL07gPlnZQlVJEz3y5SHWIuAPVYzW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633192; c=relaxed/simple;
	bh=Vp9r1ukTmn6hnXEb/gTUnMmKwYnXIN4vNJUdbnYzTLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VS5GXgztPAHyZaRM+UzCdVR67m9cCP9wCQbSuVLqWXg8qn1uJTeYSgwjlioSMBk54v2Goo8IB60uTc/+YlifAo7VP9VImiQ+4+CyiiF9PmhcD8TgJv0ljl4QZV+vRwXg1k+riin+vmF6rFsinBO+VhNjNp820Y96XpHkAkHC4Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1D4A/l5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1D4A/l5"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso72200471fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715633189; x=1716237989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5VG8LfpXEIyquzfZG+KogIqKaNLmz1hPuPuNUynYSk=;
        b=D1D4A/l5dfMra/dsHsULOz4Q5Vo89TFt3l1g2B2nNo1gR1lJVBq4G6DdRhT0fDTnfJ
         bXlICSOH6KUrHAh00pK4ig8pKS5AfKMUQe1sl4xScrs6bJjbgF04WWF0zvcS2z1+qgNo
         B/uCJDeYhJz2gpqecIy6neaehNAc8CNoLzthv4EHr7bkeoegVzSi/MDpp2+D3WigeWT0
         KImQc6MX7ZfiIKfb9cDmpbu1pQqPVelHsmx22UHmXZBPgpczmxOIGHbH7DQ35JmybJbi
         tQavGrm1wQvzLFbRlQbEmCo98TMEnCPTyANb3e7b1McTO0QKkwA05ocDPKTkc9lbkpO4
         x/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715633189; x=1716237989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5VG8LfpXEIyquzfZG+KogIqKaNLmz1hPuPuNUynYSk=;
        b=dS8z6r67QkGr0dEwY9cphe1dgCadhb8aUCEE6h+sQ5hiM6AcRNFpIM1TBH6ZG+z9L5
         hBoBy04A/58CGi6moQ1iKwjpCTCbtrO1xgajbfi5sD49vrxT8mDRPZeF53vuMOxiaKty
         utIA6G+PwLc9afjEXZ5mKzAz1NUmdVDM8glfTjEIOm7BTdUk+M7gvKoorqm5QtthFKPV
         Uum55YGesFGChnLEsXfGSL2wfzPPvgCJj1Gg/b9lmNGQzmRzMCZvSong9pVEkBzIaZfa
         F4d5q19tskpVkQsaT48HoUjByOuTdtU/y9wc1BtDREsgp33YsFEt8ljdsOEWUrtY3+Jz
         Zn4g==
X-Forwarded-Encrypted: i=1; AJvYcCUV0fE6PagFmXEKm2HhfJtF7wU2fUh/nORCKXZed6JmfyUYcvqnGDIzuGdsm5UeYD58mvj3+6X4Ri/1AUi31yMZbrOGzcsUEBM/rthaGOqs
X-Gm-Message-State: AOJu0Yz6FMB15u8mvzPtl8NTPZ5+bq+oOfiVH+bgN4u0CC/iTOuVT6Nu
	qHSKWsC6pYfHaTAwKeIgWdymZDchsf3xJXIuryT6ZPoIiP0il+gtk4OWFtuq6tWe6pn4TwnPNk7
	Kyni/AmmBzQMi0usTG2YjJl4m5wQ=
X-Google-Smtp-Source: AGHT+IGu4PxGcI19lXM4dd+ex3SxXgG+UTFMMr5sWMz+byA7zZPKQStPjM0cjyRPD0gfZnQURxzlN6n4E6V9KtXzzsA=
X-Received: by 2002:a2e:a591:0:b0:2e2:9416:a649 with SMTP id
 38308e7fff4ca-2e5205c3760mr74549301fa.53.1715633188642; Mon, 13 May 2024
 13:46:28 -0700 (PDT)
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
 <9cf1f313-c236-43d0-bd98-299478630869@penguintechs.org> <8de52d0c-ed3f-47b3-a318-b1942c193978@163.com>
 <4104e918-7e8f-4494-93c5-8f606c13d61b@penguintechs.org>
In-Reply-To: <4104e918-7e8f-4494-93c5-8f606c13d61b@penguintechs.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 May 2024 16:46:16 -0400
Message-ID: <CABBYNZJ6-Ht=6p9wkmOqQopv7n769tBhjpxbzDhp=R5ovSDBog@mail.gmail.com>
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Wren Turkal <wt@penguintechs.org>
Cc: Lk Sii <lk_sii@163.com>, linux-bluetooth@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Zijun Hu <quic_zijuhu@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wren,

On Mon, May 13, 2024 at 4:13=E2=80=AFPM Wren Turkal <wt@penguintechs.org> w=
rote:
>
> On 5/10/24 11:25 PM, Lk Sii wrote:
> > On 2024/5/11 07:33, Wren Turkal wrote:
> >> On 5/10/24 2:25 PM, Luiz Augusto von Dentz wrote:
> >>> Hi Wren,
> >>>
> >>> On Fri, May 10, 2024 at 4:54=E2=80=AFPM Wren Turkal <wt@penguintechs.=
org> wrote:
> >>>>
> >>>> On 5/10/24 12:48 PM, Luiz Augusto von Dentz wrote:
> >>>>> Hi Wren,
> >>>>>
> >>>>> On Fri, May 10, 2024 at 3:14=E2=80=AFPM Wren Turkal <wt@penguintech=
s.org>
> >>>>> wrote:
> >>>>>>
> >>>>>> On 5/6/24 12:49 PM, Luiz Augusto von Dentz wrote:
> >>>>>>> Hi Wren,
> >>>>>>>
> >>>>>>> On Mon, May 6, 2024 at 3:24=E2=80=AFPM Wren Turkal <wt@penguintec=
hs.org>
> >>>>>>> wrote:
> >>>>>>>>
> >>>>>>>> Krzysztof,
> >>>>>>>>
> >>>>>>>> I am reaching out to you as you had the most important objection=
s
> >>>>>>>> to the
> >>>>>>>> change to fix qca6390 for the warm boot/module reload bug that I=
 am
> >>>>>>>> experiencing.
> >>>>>>>>
> >>>>>>>> For context, the problem is that the hci_uart module will send
> >>>>>>>> specific
> >>>>>>>> vendor specfic commands during shutdown of the hardware under mo=
st
> >>>>>>>> situations. These VSCs put the bluetooth device into a
> >>>>>>>> non-working state
> >>>>>>>> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
> >>>>>>>>
> >>>>>>>> Zijun's proposed fix is to not send these commands when it's not
> >>>>>>>> appropriate for the hardware. The vendor commands should be
> >>>>>>>> avoided when
> >>>>>>>> the hardware does not have persistent configuration or when the
> >>>>>>>> device
> >>>>>>>> is in setup state (indicating that is has never been setup and
> >>>>>>>> should
> >>>>>>>> not be sent the VSCs on the shutdown path). This is what Zijun's
> >>>>>>>> patch
> >>>>>>>> implements.
> >>>>>>>>
> >>>>>>>> In addition, Zijun's change removes the influence of both
> >>>>>>>> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun ass=
erts
> >>>>>>>> that those flags should not influence the sending of the VSCs in=
 the
> >>>>>>>> shutdown path. If I understand KK's objections properly, this is
> >>>>>>>> where
> >>>>>>>> his objection is stemming from. KK, is this correct?
> >>>>>>>>
> >>>>>>>> Zijun's proposed fix can be seen here:
> >>>>>>>> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-=
19619-3-git-send-email-quic_zijuhu@quicinc.com/
> >>>>>>>>
> >>>>>>>> I'm wondering if we can resolve this impasse by splitting the ch=
ange
> >>>>>>>> into two changes, as follows:
> >>>>>>>>
> >>>>>>>> 1. Change that removes the influence of the QCA_BT_OFF and
> >>>>>>>> HCI_RUNNING
> >>>>>>>> flags in the shutdown path.
> >>>>>>>> 2. Add the quirk from Zijun's patch that fixes my hardward
> >>>>>>>> configuration.
> >>>>>>>>
> >>>>>>>> I'm hoping that better clearer descriptions for #1 can help get =
that
> >>>>>>>> landed since the logic current appears to be at odds with how th=
e
> >>>>>>>> hardware works.
> >>>>>>>>
> >>>>>>>> Also, I am happy to split the patches into the two patches, or
> >>>>>>>> (maybe
> >>>>>>>> more ideally) just modify the commit message to better indicate =
the
> >>>>>>>> reason the change. I just need guidance from maintainers so that
> >>>>>>>> whatever work I do leads to something acceptable for y'all.
> >>>>>>>>
> >>>>>>>> So, please help me get this done. I am just a user with broken
> >>>>>>>> hardware
> >>>>>>>> and a fondness for Linux. I would love to help do what's needed
> >>>>>>>> to get
> >>>>>>>> this fix landed.
> >>>>>>>
> >>>>>>> Ive also objected to that change, in fact the whole shutdown sequ=
ence
> >>>>>>> is sort of bogus in my opinion and the driver shall really have s=
ome
> >>>>>>> means to find out what mode it is in when it reboots, regardless =
if
> >>>>>>> cold or warm boot, since otherwise we are in trouble if the user =
is
> >>>>>>> booting from another OS that doesn't do the expected shutdown
> >>>>>>> sequence.
> >>>>>>
> >>>>>> This criticism makes a ton of sense. I'm sorry I missed it before.
> >>>>>> There
> >>>>>> were a lot of threads moving in parallel. However, I am curious. G=
iven
> >>>>>> that the patch improves the situation for users (like me). Is ther=
e
> >>>>>> any
> >>>>>> way we can separate the redesign of the shutdown sequence and the =
UX
> >>>>>> improvement that comes with this patch?
> >>>>>>
> >>>>>> Here's my concern. I am happy to do the work to redesign this.
> >>>>>> However,
> >>>>>> I don't think I have the information needed to do this since I don=
't
> >>>>>> have access to the technical docs for the qca6390. I am worried
> >>>>>> that not
> >>>>>> accepting some form of this patch is letting perfect be the enemy
> >>>>>> of the
> >>>>>> good. And I am not sure how I personally can help with that. If yo=
u
> >>>>>> think it's possible for me to do this without the docs for the
> >>>>>> hardware,
> >>>>>> I am willing to give it a shot if I can get some guidance. Honestl=
y, I
> >>>>>> wish I had the skill to be confident about a change like this, but
> >>>>>> I don't.
> >>>>>>
> >>>>>> Any ideas on how to move forward would be greatly appreciated.
> >>>>>>
> >>>>>> And just to be perfectly clear, I have tested this patch on my lap=
top.
> >>>>>> It greatly enhances my ability to use my hardware since I can
> >>>>>> reboot the
> >>>>>> machine without having to make sure to power cycle the laptop. Thi=
s is
> >>>>>> not a theoretical improvement.
> >>>>>
> >>>>> I would really love some explanation why can't the driver know unde=
r
> >>>>> what mode the controller is when it gets probed, because to me we
> >>>>> cannot accept a driver that only works under certain condition afte=
r
> >>>>> the boot and in case it is really impossible, can't even power cycl=
e
> >>>>> it to get it back to cold boot stage???
> >>>>
> >>>> This is a great technical criticism of the driver, and I think you
> >>>> deserve that explanation.
> >>>>
> >>>> However, with the driver already in the kernel, shouldn't the bias b=
e
> >>>> toward mitigating the extremely bad UX and not hold users hostage fo=
r
> >>>> the bad design which has already been approved and landed in the ker=
nel?
> >>>>
> >>>>> Also the criticism here should be directed to the vendor, how long
> >>>>> have we been discussing problems in the QCA driver? And the only th=
ing
> >>>>> I see coming our way are work-arounds of the problems, the address =
not
> >>>>> being unique coming from the firmware itself and when provided via =
DT
> >>>>> the address is in the wrong byteorder and now that the driver must
> >>>>> communicate the firmware on shutdown in order to get it working
> >>>>> properly on the next boot.
> >>>>
> >>>> I agree that Qualcomm should get flack for this, however, the UX pro=
blem
> >>>> can be mitigated with a logic fix that doesn't make the init/shutdow=
n
> >>>> design problem any worse than it currently seems to be. I mean, woul=
dn't
> >>>> this logic have to exist somewhere even if it weren't the shutdown p=
ath?
> >>>>
> >>>> If you are trying to use this as leverage to get Qualcomm to do a bi=
gger
> >>>> thing (redesign the init/shutdown logic), I do think that tactic
> >>>> needlessly puts users in the crossfire. I can totally understand why
> >>>> you'd do it. I am just suffering the crossfire in the meantime, and =
it
> >>>> doesn't feel great.
> >>>
> >>> So you prefer to risk getting a kernel crash due to UAF over Bluetoot=
h
> >>> not working? Really? Because I haven't seen any configuration that
> >>> those changes you tested don't reintroduce the UAF, which is why I
> >>> haven't applied that change to begin with, so no I'm not holding back
> >>> to pressure Qualcomm to redesign the shutdown logic, it just these
> >>> things got entangled because I just realized the shutdown thingy is
> >>> really out of place, imo, but I'd be fine if there is a temporary fix
> >>> until someone finally decide to spend some time to really fix the
> >>> shutdown logic.
> >>
> >> Luiz, I'm sorry. I do not want a crash instead. I didn't understand th=
at
> >> the solution I proposed (i.e. adding Zijun's logic without removing KK=
's
> >> logic) would introduce a new crash opportunity. I previously thought y=
ou
> >> were saying one of the following things:
> >> 1. The crash opportunity already existed due the init/shudown sequence=
s.
> >> 2. The crash opportunity already existed due the init/shudown sequence=
s
> >> when removing KK's logic.
> >>
> >> If it was #1, I was hoping that adding the logic would make the risk n=
o
> >> worse.
> >>
> >> If it was #2, I was hoping that my suggestion of adding Zijun's logic
> >> without removing KK's logic might represent an acceptable middleground
> >> for a temporary fix that would "correct" the logic without introducing=
 a
> >> new crash opportunity.
> >>
> >> I feel like I may not be clear about what I mean by adding Zijun's log=
ic
> >> and not removing KK's logic. Maybe something like this diff:
> >>
> >> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> >> index 2f7ae38d85eb..fcac44ae7898 100644
> >> --- a/drivers/bluetooth/hci_qca.c
> >> +++ b/drivers/bluetooth/hci_qca.c
> >> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device *=
dev)
> >>                       !test_bit(HCI_RUNNING, &hdev->flags))
> >>                           return;
> >>
> >> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
> >> &hdev->quirks) ||
> >> +                   hci_dev_test_flag(hdev, HCI_SETUP))
> >> +                       return;
> >> +
> >>                   serdev_device_write_flush(serdev);
> >>                   ret =3D serdev_device_write_buf(serdev, ibs_wake_cmd=
,
> >>                                                 sizeof(ibs_wake_cmd));
> >>
> >> I think this diff is mangled due to using Thunderbird, but I hope this
> >> helps convey what I was asking about.
> >>
> >> If I am understanding you correctly now, you are saying that simply
> >> introducing Zijun's logic (without removing KK's logic) will introduce=
 a
> >> new crash opportunity. Is that correct?
> >>
> >
> > as Zijun declared. i believe Zijun's change will solve both this
> > reported regression issue and the use-after-free(crash) issue.
>
> I did see Zijun's claim of that. However, I think that both KK and Luiz
> are not convinced by the explanation. Also, if that explanation does
> convince KK and Luiz, I think that the explanation needs to be added to
> the commit message.
>
> I'm hoping that Luiz will at least respond to the middleground I
> proposed as a workaround.

I recall suggesting using HCI_UART_PROTO_READY instead since that
tells when serdev_device_close has been run:

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0c9c9ee56592..bbbc86d4932a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2455,8 +2455,8 @@ static void qca_serdev_shutdown(struct device *dev)
        const u8 edl_reset_soc_cmd[] =3D { 0x01, 0x00, 0xFC, 0x01, 0x05 };

        if (qcadev->btsoc_type =3D=3D QCA_QCA6390) {
-               if (test_bit(QCA_BT_OFF, &qca->flags) ||
-                   !test_bit(HCI_RUNNING, &hdev->flags))
+               /* Check if serdev_device_close() has already been called. =
*/
+               if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
                        return;

                serdev_device_write_flush(serdev);


--=20
Luiz Augusto von Dentz
