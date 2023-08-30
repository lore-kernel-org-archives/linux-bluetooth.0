Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA815C83F25
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 18:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbjH3Sx4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343937AbjH3R2m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 13:28:42 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9030F193
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 10:28:38 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so1111211fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693416517; x=1694021317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7Q6yLBWpq+0cHDNlXkrewgCyTyJH571bDs7gW4UFiI=;
        b=XQ3L3A4jncKeDoosqNpkW6xQq2VqDlziQtYqiDwE781SudLe9zag9mmBsLKGHhLbVh
         ZXxOksFP3wi4ofeFDwikssqB+WDTsfo506P9j/J87mf0NRupcusvrqx6CStn/hdoLhrX
         8EZBmYx9LcAsOm2pLE3ohZsPgWHj19ovlSVVgI0qUuNe27E8LRUFXpu9zWEs1fQqt1Hp
         w3biggwcnoVf5GduTTfLJmf+qq8+Ta3vBJR8BKi2RV48TyVRswT76+BegQzk6meTx+dZ
         VisMaLoZ2E+MXlhYEQNCiWmsZYRXnRg1t/g8jIOgv+rl+O6wb7Be0WZ6omShD5mhiyP9
         hX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693416517; x=1694021317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7Q6yLBWpq+0cHDNlXkrewgCyTyJH571bDs7gW4UFiI=;
        b=cQCv9XUKsBAUS2cLx6zPAkNCesnJpDKoWeC0C9aDGPt5ldL/fNh5ELbLaqAAOhBNVp
         lIpnwBrhYzSbMI5PjSea9IYLZo1KZbSb/rOnNxaJS5qE/gcnV9x36GfEcGjY5cIr8Iyj
         T5A3Ep0fJdYFDXej1srjKzagRxgyJdezKC8BggdDe5RO39zbf5JbdRrFWigEnBVHrbfK
         lXTzx9OK+VBlpZMsSUjmwlqXu35euDej2isNCynMNeEGJHy+woOSVDmklAhjzbSFmHIh
         Ng6998Ju3jIjyRnXuV8FllhGhUsRuQhehnyJEOo4F6Yd5XcIJ/9YMHkMxWZy//UQC8ZR
         ao3Q==
X-Gm-Message-State: AOJu0Yz2bRqdLN6I4CKSA8TYDpPq14P1JoyLIQrC6dOeTfuWAcZQiaYC
        8wT7RBYXSBju27KOlQPTOqnGemSzAeDLsAzmLR8=
X-Google-Smtp-Source: AGHT+IEHENfxnJ7utzrHwU72Eldx3I/wFmAhJBiTlksgsJYsPSGG/SVz2t9KgZl0m9HD7zSrCTdESjAg2qzDi0FWm4g=
X-Received: by 2002:a2e:8619:0:b0:2b7:31a:9d7c with SMTP id
 a25-20020a2e8619000000b002b7031a9d7cmr2262356lji.33.1693416516483; Wed, 30
 Aug 2023 10:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220727135834.294184-1-brian.gix@intel.com> <20220727135834.294184-3-brian.gix@intel.com>
 <578e6d7afd676129decafba846a933f5@agner.ch> <CABBYNZJGKfwTQM8WAdUGXueTPnFyus1a65UO5mg2g4PXVuCnpA@mail.gmail.com>
 <CABBYNZLgG+zTsk-6ceqzLXXyVRnN6p-m8sFq9Ss7mveD0f9BsQ@mail.gmail.com>
 <CABUQxGxBdAFncJ6YVb7a9gnU-_YZDGFDmpHJTtm5K1tDGEGRDQ@mail.gmail.com>
 <0de3f0d0d5eb6d83cfc8d90cbb2b1ba1@agner.ch> <fcdf856db8fd8e77558b4d82b843c51e@agner.ch>
 <24bf25f7-314f-ca73-59e9-df757732f6a9@leemhuis.info> <ac58995a00cb6ad6bb4ce4c74b006a2f@agner.ch>
 <CABBYNZ+5RMqNVMyYKi+gOVaV+K6k8Z-C37KnfGa=qRUORc3dWg@mail.gmail.com>
In-Reply-To: <CABBYNZ+5RMqNVMyYKi+gOVaV+K6k8Z-C37KnfGa=qRUORc3dWg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 30 Aug 2023 10:28:23 -0700
Message-ID: <CABBYNZKoXd0+kLdD-FMz3UisrE03fzrt13Zk9-6+tWwuTsKF1g@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] Bluetooth: Rework le_scan_restart for hci_sync
To:     Stefan Agner <stefan@agner.ch>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Brian Gix <brian.gix@gmail.com>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Stefan,

On Tue, Aug 29, 2023 at 1:42=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Stefan, Brian,
>
> On Tue, Aug 29, 2023 at 6:27=E2=80=AFAM Stefan Agner <stefan@agner.ch> wr=
ote:
> >
> > Hi Thorsten,
> >
> > No, this hasn't been addressed so far. I am also not sure how we can
> > help solving that particular issue.
> >
> > Besides this, we have other Bluetooth issues which seem to be Kernel
> > regressions (where downgrading to Linux 5.15 also helps), folks see
> > "hci0: unexpected event for opcode" on Intel but also other systems. We
> > haven't bisected that issue yet. But it seems that the Bluetooth stack
> > is really somewhat unstable in recent releases.
>
>
> I suspect the following change shall make it behave as before, the use
> of hci_cmd_sync_queue is not equivalent to hci_req_sync:
>
> https://gist.github.com/Vudentz/b78f34e3775c8cd2db55b868e5c8ef42
>
> That said, I'm considering removing the whole custom handling for
> HCI_QUIRK_STRICT_DUPLICATE_FILTER and just disable duplicate filtering
> when this flag is set.

Any chance to tests the following changes:

https://patchwork.kernel.org/project/bluetooth/patch/20230829205936.766544-=
1-luiz.dentz@gmail.com/

> > --
> > Stefan
> >
> >
> > On 2023-08-29 13:22, Linux regression tracking (Thorsten Leemhuis)
> > wrote:
> > > Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> > > for once, to make this easily accessible to everyone.
> > >
> > > Stefan, was this regression ever addressed? Doesn't look like it from
> > > here, but maybe I'm missing something.
> > >
> > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' h=
at)
> > > --
> > > Everything you wanna know about Linux kernel regression tracking:
> > > https://linux-regtracking.leemhuis.info/about/#tldr
> > > If I did something stupid, please tell me, as explained on that page.
> > >
> > > #regzbot poke
> > >
> > > On 30.06.23 12:59, Stefan Agner wrote:
> > >> Hi Brian,
> > >>
> > >> Gentle ping on the issue below.
> > >>
> > >> On 2023-06-20 16:41, Stefan Agner wrote:
> > >>> On 2023-06-16 03:22, Brian Gix wrote:
> > >>>
> > >>>> On Thu, Jun 15, 2023 at 11:28=E2=80=AFAM Luiz Augusto von Dentz <l=
uiz.dentz@gmail.com> wrote:
> > >>>>
> > >>>>> +Brian Gix
> > >>>>>
> > >>>>> On Thu, Jun 15, 2023 at 10:27=E2=80=AFAM Luiz Augusto von Dentz
> > >>>>> <luiz.dentz@gmail.com> wrote:
> > >>>>>>
> > >>>>>> Hi Stefan,
> > >>>>>>
> > >>>>>> On Thu, Jun 15, 2023 at 5:06=E2=80=AFAM Stefan Agner <stefan@agn=
er.ch> wrote:
> > >>>>>>>
> > >>>>>>> Hi Brian, hi all,
> > >>>>>>>
> > >>>>>>> We experienced quite some Bluetooth issues after moving from Li=
nux 5.15
> > >>>>>>> to 6.1 on Home Assistant OS, especially on Intel NUC type syste=
ms (which
> > >>>>>>> is a popular choice in our community, so it might just be that)=
. When
> > >>>>>>> continuously scanning/listening for BLE packets, the packet flo=
w
> > >>>>>>> suddenly ends. Depending on which and how many devices (possibl=
y also
> > >>>>>>> other factors) within minutes or hours.
> > >>>>>>>
> > >>>>>>> Jan (in cc) was able to bisect the issue, and was able to pinpo=
int the
> > >>>>>>> problem to this change.
> > >>>>>>>
> > >>>>>>> Meanwhile I was able to confirm, that reverting this single com=
mit on
> > >>>>>>> the latest 6.1.34 seems to resolve the issue.
> > >>>>>>>
> > >>>>>>> I've reviewed the change and surrounding code, and one thing I'=
ve
> > >>>>>>> noticed is that the if statement to set cp.filter_dup in
> > >>>>>>> hci_le_set_ext_scan_enable_sync and hci_le_set_scan_enable_sync=
 are
> > >>>>>>> different. Not sure if that needs to be the way it is, but my o=
utside
> > >>>>>>> gut feeling says hci_le_set_ext_scan_enable_sync should use "if=
 (val &&
> > >>>>>>> hci_dev_test_flag(hdev, HCI_MESH))" as well.
> > >>>>>>>
> > >>>>>>> However, that did not fix the problem (but maybe it is wrong
> > >>>>>>> nonetheless?).
> > >>>>>>>
> > >>>>>>> Anyone has an idea what could be the problem here?
> > >>>>>>
> > >>>>>> Are there any logs of the problem? Does any HCI command fails or
> > >>>>>> anything so that we can track down what could be wrong?
> > >>>
> > >>> No HCI command fails, there is also no issue reported in the kernel=
 log.
> > >>> BlueZ just stops receiving BLE packets, at least from certain devic=
es.
> > >>>
> > >>>>>
> > >>>>> @Brian Gix perhaps you have a better idea what is going wrong her=
e?
> > >>>>
> > >>>> It seems unlikely that this is Mesh related. Mesh does need for fi=
ltering to
> > >>>> be FALSE, and Mesh does not use extended scanning in any case.
> > >>>>
> > >>>> But this was part of the final rewrite to retire the hci_req mecha=
nism in
> > >>>> favor of the hci_sync mechanism. So my best guess off the top of m=
y head is
> > >>>> that there was an unintended race condition that worked better tha=
n the
> > >>>> synchronous single-threading mechanism?  Filtering (or not) should=
 not
> > >>>
> > >>> After review the code I concluded the same. What is a bit surprisin=
g to
> > >>> me is that it is so well reproducible. I guess it is nicer to have =
a
> > >>> reproducible one than a hard to reproduce one :)
> > >>>
> > >>>> prevent advertising packets from permanently wedging.  Does anyone=
 have an
> > >>>> HCI flow log with and without the offending patch?  Ideally they s=
hould be
> > >>>> identical...  If they are not then I obviously did something wrong=
. As this
> > >>>> was not specifically Mesh related, I may have missed some non-mesh=
 corner
> > >>>> cases.
> > >>>
> > >>>
> > >>> I've taken two btmon captures, I created them using:
> > >>> btmon -i hci0 -w /config/hcidump-hci-req-working.log
> > >>>
> > >>> You can find them at:
> > >>> https://os-builds.home-assistant.io/hcidump-hci-req-working.log
> > >>> https://os-builds.home-assistant.io/hcidump-hci-sync-non-working.lo=
g
> > >>
> > >> Could you gain any insights from these logs?
> > >>
> > >> --
> > >> Stefan
> > >>
> > >>
> > >>>
> > >>> This is while running our user space software (Home Assistant with
> > >>> Bluetooth integration). Besides some BLE devices (e.g. Xioami Mi
> > >>> Temperature & Humidity sensor) I have a ESP32 running which sends S=
PAM
> > >>> advertisements every 100ms (this accelerates the issue). In the
> > >>> non-working case you'll see that the system doesn't receive any SPA=
M
> > >>> advertisements after around 27 seconds. The working log shows that =
it
> > >>> continuously receives the same packets (capture 120s).
> > >>>
> > >>> Hope this helps.
> > >>>
> > >>> --
> > >>> Stefan
> > >>>
> > >>>
> > >>
> > >>
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
