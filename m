Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09EC83F12
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Aug 2023 20:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbjH2Umt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Aug 2023 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbjH2Umm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Aug 2023 16:42:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E996FD
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 13:42:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcc4347d2dso72758981fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693341758; x=1693946558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OTEAVjWZManNNhW8B7XS+y7CCMSFbnafvp7IyfPI7E=;
        b=gn5wcYBJzffvyIc5InH/JbF2Gqbww7712ixTQKAjtn0rVxPHognSv5zcxqWHW8f0nH
         IoBkRISBZw2lW9dpJB7UcDJps8a2PwjZTd+jaRRDovTLJrk8+Fzha18JnfG0WN2wBjVq
         dktfvDifCwkASNdeYj8rr6kRB8fyTC1cHGrJJ9uSKOebcLAkpHOzfnOS76M5+7Mv9KKg
         EpvulrOlTS2mTve1pmR2rQnGhpl9clXDaDDi6A/L43ZW5hHPsQTmpxbv/O32yucqzu1Q
         xzzGUanblRKfZ1Srw5+HL4KcNTqC8Qr/sdEXWLXEl/nGyf6T6FxoROCss89VIbxjydtL
         n8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341758; x=1693946558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OTEAVjWZManNNhW8B7XS+y7CCMSFbnafvp7IyfPI7E=;
        b=gFTNcDGXgYsxxKXayy9yD7MjQPGI3XCTdgI4m1gaRo62KLY+2YDiez75ItMdo+bs27
         x7LXogRIvmBGsVfDkdMyW1PrirZR2iwxEuVJ3IsHh5BeTaX7JHf626stc0d4qmjzJ4JZ
         crD15FYlhXEABXr4CwunNy0p90yvuhyDImx9TunxI4RIItqERxjm8BV52+7OlqRGXMlQ
         VIn4kNaNeBjsUgDuTGr3VPHdClrNlMC8n4q3iGddOwuXFZdgNIqr4roaDO8gANjaaNev
         Ynj4a+Mpwm7NPTj4Z2dvEd2n59GX//hIKmJIZyrHZP/pdepoLW8Lqg09M9Ec+/A4aoff
         m6Ag==
X-Gm-Message-State: AOJu0Yy93FT3wwgIYfbE6Ic4/tZpY9bIykLAP53DOYq42xW3Yt9p4nDo
        AH39bKylPp3jmvfI9TZijp53q+3mXob7tiqiGvw=
X-Google-Smtp-Source: AGHT+IHb43rPzhP3p0pse1Ty20zQ9rN3uYAqxtCcf9g4P/GkDhxLRjMO7wTtWo7wboL70vBGLY1yK8FTK53kElQ6cUc=
X-Received: by 2002:a2e:7d0e:0:b0:2bb:997a:493e with SMTP id
 y14-20020a2e7d0e000000b002bb997a493emr276700ljc.35.1693341757409; Tue, 29 Aug
 2023 13:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220727135834.294184-1-brian.gix@intel.com> <20220727135834.294184-3-brian.gix@intel.com>
 <578e6d7afd676129decafba846a933f5@agner.ch> <CABBYNZJGKfwTQM8WAdUGXueTPnFyus1a65UO5mg2g4PXVuCnpA@mail.gmail.com>
 <CABBYNZLgG+zTsk-6ceqzLXXyVRnN6p-m8sFq9Ss7mveD0f9BsQ@mail.gmail.com>
 <CABUQxGxBdAFncJ6YVb7a9gnU-_YZDGFDmpHJTtm5K1tDGEGRDQ@mail.gmail.com>
 <0de3f0d0d5eb6d83cfc8d90cbb2b1ba1@agner.ch> <fcdf856db8fd8e77558b4d82b843c51e@agner.ch>
 <24bf25f7-314f-ca73-59e9-df757732f6a9@leemhuis.info> <ac58995a00cb6ad6bb4ce4c74b006a2f@agner.ch>
In-Reply-To: <ac58995a00cb6ad6bb4ce4c74b006a2f@agner.ch>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Aug 2023 13:42:25 -0700
Message-ID: <CABBYNZ+5RMqNVMyYKi+gOVaV+K6k8Z-C37KnfGa=qRUORc3dWg@mail.gmail.com>
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

Hi Stefan, Brian,

On Tue, Aug 29, 2023 at 6:27=E2=80=AFAM Stefan Agner <stefan@agner.ch> wrot=
e:
>
> Hi Thorsten,
>
> No, this hasn't been addressed so far. I am also not sure how we can
> help solving that particular issue.
>
> Besides this, we have other Bluetooth issues which seem to be Kernel
> regressions (where downgrading to Linux 5.15 also helps), folks see
> "hci0: unexpected event for opcode" on Intel but also other systems. We
> haven't bisected that issue yet. But it seems that the Bluetooth stack
> is really somewhat unstable in recent releases.


I suspect the following change shall make it behave as before, the use
of hci_cmd_sync_queue is not equivalent to hci_req_sync:

https://gist.github.com/Vudentz/b78f34e3775c8cd2db55b868e5c8ef42

That said, I'm considering removing the whole custom handling for
HCI_QUIRK_STRICT_DUPLICATE_FILTER and just disable duplicate filtering
when this flag is set.

> --
> Stefan
>
>
> On 2023-08-29 13:22, Linux regression tracking (Thorsten Leemhuis)
> wrote:
> > Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> > for once, to make this easily accessible to everyone.
> >
> > Stefan, was this regression ever addressed? Doesn't look like it from
> > here, but maybe I'm missing something.
> >
> > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat=
)
> > --
> > Everything you wanna know about Linux kernel regression tracking:
> > https://linux-regtracking.leemhuis.info/about/#tldr
> > If I did something stupid, please tell me, as explained on that page.
> >
> > #regzbot poke
> >
> > On 30.06.23 12:59, Stefan Agner wrote:
> >> Hi Brian,
> >>
> >> Gentle ping on the issue below.
> >>
> >> On 2023-06-20 16:41, Stefan Agner wrote:
> >>> On 2023-06-16 03:22, Brian Gix wrote:
> >>>
> >>>> On Thu, Jun 15, 2023 at 11:28=E2=80=AFAM Luiz Augusto von Dentz <lui=
z.dentz@gmail.com> wrote:
> >>>>
> >>>>> +Brian Gix
> >>>>>
> >>>>> On Thu, Jun 15, 2023 at 10:27=E2=80=AFAM Luiz Augusto von Dentz
> >>>>> <luiz.dentz@gmail.com> wrote:
> >>>>>>
> >>>>>> Hi Stefan,
> >>>>>>
> >>>>>> On Thu, Jun 15, 2023 at 5:06=E2=80=AFAM Stefan Agner <stefan@agner=
.ch> wrote:
> >>>>>>>
> >>>>>>> Hi Brian, hi all,
> >>>>>>>
> >>>>>>> We experienced quite some Bluetooth issues after moving from Linu=
x 5.15
> >>>>>>> to 6.1 on Home Assistant OS, especially on Intel NUC type systems=
 (which
> >>>>>>> is a popular choice in our community, so it might just be that). =
When
> >>>>>>> continuously scanning/listening for BLE packets, the packet flow
> >>>>>>> suddenly ends. Depending on which and how many devices (possibly =
also
> >>>>>>> other factors) within minutes or hours.
> >>>>>>>
> >>>>>>> Jan (in cc) was able to bisect the issue, and was able to pinpoin=
t the
> >>>>>>> problem to this change.
> >>>>>>>
> >>>>>>> Meanwhile I was able to confirm, that reverting this single commi=
t on
> >>>>>>> the latest 6.1.34 seems to resolve the issue.
> >>>>>>>
> >>>>>>> I've reviewed the change and surrounding code, and one thing I've
> >>>>>>> noticed is that the if statement to set cp.filter_dup in
> >>>>>>> hci_le_set_ext_scan_enable_sync and hci_le_set_scan_enable_sync a=
re
> >>>>>>> different. Not sure if that needs to be the way it is, but my out=
side
> >>>>>>> gut feeling says hci_le_set_ext_scan_enable_sync should use "if (=
val &&
> >>>>>>> hci_dev_test_flag(hdev, HCI_MESH))" as well.
> >>>>>>>
> >>>>>>> However, that did not fix the problem (but maybe it is wrong
> >>>>>>> nonetheless?).
> >>>>>>>
> >>>>>>> Anyone has an idea what could be the problem here?
> >>>>>>
> >>>>>> Are there any logs of the problem? Does any HCI command fails or
> >>>>>> anything so that we can track down what could be wrong?
> >>>
> >>> No HCI command fails, there is also no issue reported in the kernel l=
og.
> >>> BlueZ just stops receiving BLE packets, at least from certain devices=
.
> >>>
> >>>>>
> >>>>> @Brian Gix perhaps you have a better idea what is going wrong here?
> >>>>
> >>>> It seems unlikely that this is Mesh related. Mesh does need for filt=
ering to
> >>>> be FALSE, and Mesh does not use extended scanning in any case.
> >>>>
> >>>> But this was part of the final rewrite to retire the hci_req mechani=
sm in
> >>>> favor of the hci_sync mechanism. So my best guess off the top of my =
head is
> >>>> that there was an unintended race condition that worked better than =
the
> >>>> synchronous single-threading mechanism?  Filtering (or not) should n=
ot
> >>>
> >>> After review the code I concluded the same. What is a bit surprising =
to
> >>> me is that it is so well reproducible. I guess it is nicer to have a
> >>> reproducible one than a hard to reproduce one :)
> >>>
> >>>> prevent advertising packets from permanently wedging.  Does anyone h=
ave an
> >>>> HCI flow log with and without the offending patch?  Ideally they sho=
uld be
> >>>> identical...  If they are not then I obviously did something wrong. =
As this
> >>>> was not specifically Mesh related, I may have missed some non-mesh c=
orner
> >>>> cases.
> >>>
> >>>
> >>> I've taken two btmon captures, I created them using:
> >>> btmon -i hci0 -w /config/hcidump-hci-req-working.log
> >>>
> >>> You can find them at:
> >>> https://os-builds.home-assistant.io/hcidump-hci-req-working.log
> >>> https://os-builds.home-assistant.io/hcidump-hci-sync-non-working.log
> >>
> >> Could you gain any insights from these logs?
> >>
> >> --
> >> Stefan
> >>
> >>
> >>>
> >>> This is while running our user space software (Home Assistant with
> >>> Bluetooth integration). Besides some BLE devices (e.g. Xioami Mi
> >>> Temperature & Humidity sensor) I have a ESP32 running which sends SPA=
M
> >>> advertisements every 100ms (this accelerates the issue). In the
> >>> non-working case you'll see that the system doesn't receive any SPAM
> >>> advertisements after around 27 seconds. The working log shows that it
> >>> continuously receives the same packets (capture 120s).
> >>>
> >>> Hope this helps.
> >>>
> >>> --
> >>> Stefan
> >>>
> >>>
> >>
> >>



--=20
Luiz Augusto von Dentz
