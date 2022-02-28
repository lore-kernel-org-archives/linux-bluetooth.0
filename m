Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBBEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 21:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiB1VVN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiB1VVL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 16:21:11 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA737EF788
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 13:20:31 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2d62593ad9bso123462677b3.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 13:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yae00/mcxJBvsU4CK2bMSDPPii+RVXpYqjgg8EO0pCo=;
        b=CZE+Pb6GD2sOaZKOSkchuLQFzGIcs1Mc9RNfck/D6+Pvw1foBqK8ek8SPRwjUPWEyE
         uJgdgvPfbOT/RLy3NAlIThfBYvbgbdFz0azOxekiVvCOHL1tjaXhL3z48lRUUJqaUON+
         jraQJ7xzxAgHuMYzPg3CsPL62zXXu8bA/RtW6ZGKl7LA6WyHwLtQhmQAkohLDwrSsf1p
         nIkiPQf/wll9b5gwnLUcPJmgQqIpyPfBONud9f5OfIEO9g/MEnSUmxq/JvQMR2HYb1n+
         Pwzm+1mDd7ZPRxMTzAn3FSXmnl3dOhcSBBb+PIOtA+T7vpGd4atDMunUSBkXaaXR2afJ
         ScbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yae00/mcxJBvsU4CK2bMSDPPii+RVXpYqjgg8EO0pCo=;
        b=r79MTmG5kySfhc9br1cGvErT5kPkjNexgJssmRH8OL8FSeuGExmuBCERUsdE8tD9Fw
         6g8nb6awe0b5bIKfPoN62CK/y32Otb7q/4finuXZYwPX3Tcut7It2boF4Pl19MPyysXg
         S6h4FmIiU65WZ9b/SM/9bTsTKbgX3YLqWmzoyC/JaLrWGg9vN16S9BVJbJ5LA3hTQoEu
         4NapDZokUR0JnPwlFpcMWbqzLMh7A2g0VMC+TpLq1iESeG3oBjTmFvMq/nR2/PSFXNGm
         h+hShU9ysmPAAZt9OBvpFMjpTB2haYAZK+aIMxZFnsX5YnTGGQ9kkZiP/DDz/MOM9O9/
         Fevg==
X-Gm-Message-State: AOAM533Ye8c6PXnPtQ1XrKeuHfW/MfWMwSgBiNeCv+CpXHdT3aCdAzYs
        5+qU52rwsMX3OYHzUvFb5eGaq8TrG8ASP9REWQU=
X-Google-Smtp-Source: ABdhPJxp7X5tsTPYXoZ3xxVFP27EGOqA6vOESuxJ9bc2YNCqIdkKcThg8Uyo3rhLl7cBootIIze2GbRQu0YOQ5j+yTE=
X-Received: by 2002:a81:638b:0:b0:2d6:ac65:962 with SMTP id
 x133-20020a81638b000000b002d6ac650962mr22101548ywb.37.1646083231056; Mon, 28
 Feb 2022 13:20:31 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
 <9ad505e1-7b59-7ebf-378b-23a6c0e25802@googlemail.com> <CABBYNZ+9tUKgLyUWM5vkMW8vHxYsXv6DEaDWdHt8xTTs6puGQA@mail.gmail.com>
 <aaeb4131-d177-d41e-617b-b0060cd83c92@googlemail.com> <CABBYNZLB+8UzhzttMrKbHW_+-A1EsY9iT5Y55VuOOEPuD4kAHQ@mail.gmail.com>
 <b1a4a920-dbba-58be-72b4-2c95b9b79283@googlemail.com> <82216882-463a-8976-e6bc-4a8919107a31@googlemail.com>
 <CABBYNZ+mO1gQgfwhemY9cqbi8vNLm_60A9c1vPYT2tH4rhgFww@mail.gmail.com>
 <a35b4b75-bb64-89c8-bacd-d58ed8576272@googlemail.com> <2ce6175c-74ec-8469-80a5-374bd1429542@googlemail.com>
 <CABBYNZJNTOT-mEQe2cfZiEX6A2pR7+sacBqtBRPRZY69YmgtvA@mail.gmail.com>
 <17f2bf7e-1d6b-e090-8926-21a408f2b496@googlemail.com> <CABBYNZ+cL4f8xvTJFQGLgqPueE=-UsOtvcPQez0BEsJ5xGppfQ@mail.gmail.com>
 <16cac2c8-c1ca-c8d7-e3d9-5f00be511614@googlemail.com> <CABBYNZJQOSZ1fecTRQOX+w8crdiLdr0_tVstgbnyEVq3NaxscQ@mail.gmail.com>
 <6b17bdb5-dddb-e7c7-86f6-2240c6523a81@googlemail.com>
In-Reply-To: <6b17bdb5-dddb-e7c7-86f6-2240c6523a81@googlemail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 28 Feb 2022 13:20:20 -0800
Message-ID: <CABBYNZ+2Dg+AdnJqpR=wS0juektNapwHcPHBWdZyvSGFT1dVLQ@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Chris Clayton <chris2553@googlemail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Mon, Feb 28, 2022 at 1:02 PM Chris Clayton <chris2553@googlemail.com> wrote:
>
> Hi Luiz,
>
> On 28/02/2022 19:34, Luiz Augusto von Dentz wrote:
> > Hi Chris,
> >
> > On Sat, Feb 26, 2022 at 12:04 AM Chris Clayton <chris2553@googlemail.com> wrote:
> >>
> >> Hi,
> >>
> >> On 24/02/2022 15:16, Luiz Augusto von Dentz wrote:
> >>>> I'll try another bisection today, but limit its range to changes made in the net/bluetooth directory.
> >>
> >> That  bisection has proved very difficult because the bluetooth "service" in kernels at some steps of the bisection were
> >> completely borked to the extent that blueman's device-manager application wouldn't start and emitted the messages:
> >>
> >> blueman-manager 12.00.37 ERROR    Manager:137 on_dbus_name_appeared: Default adapter not found, trying first available.
> >> blueman-manager 12.00.37 ERROR    Manager:141 on_dbus_name_appeared: No adapter(s) found, exiting
> >>
> >> Obviously, I don't know whether the problem I am trying to pinpoint is hiding behind this more fundamental problem with
> >> the bluetooth "service", so being unable to say whether that kernel was good or bad, I had to skip. There seems to be a
> >> batch of commits that mean that, whilst the kernel builds okay, hunting down a bluetooth-related problem is not
> >> possible. Eventually and I cursed and gave up. Whatever was causing this breakage has obviously been fixed.
> >>
> >>> Please record the HCI with btmon, it must be producing something since
> >>> it records even the mgmt commands.
> >>>
> >>
> >> Refreshed by a good night's sleep, I started another bisection (between 5.16 and 5.17-rc1) yesterday morning but this
> >> time did not limit it to net/bluetooth.  That was going okay until I ran into what I assume is the same batch of borked
> >> kernels. I've been more persistent this time but have just had a run of 16 steps in which the bluetooth support in the
> >> kernel is broken so badly that testing bluetooth is not possible. I will push on today, but I've suspended that activity
> >> to get the hci trace that Luiz has asked for.
> >>
> >> Using information from the bisect, I built a kernel that had tested as bad (but not borked). The commit is
> >> f2b551fad8d8f2ac5e1f810ad595298381e0b0c5. As I've mentioned before, the problem with devices not connecting is
> >> intermittent - for a given kernel, sometimes a connection works and other times it doesn't. On the first boot of this
> >> kernel, my bluetooth devices could connect, Attached are 4 files related to this - the output from btmon, and the
> >> related portions of daemon.log, kern.log and sys.log from /var/log/. Each of the these files is suffixed with ".good".
> >>
> >> I then powered down the laptop and booted into the same kernel. This time the bluetooth devices could not connect. Four
> >> more files are attached for this boot and are suffixed with ".bad". I said in an earlier email that when connection
> >> fails, there is no output from btmon, so that log is empty. That's still the case, but I guess that fact itself is a
> >> clue to what the problem might be. What I can add, however, is that if, in that same bad kernel, I unload and then
> >> reload the btusb module, connections start to work. Maybe that too is a clue. The same unload/load process revives
> >> bluetooth on a kernel built after a pull of Linus' latest and greatest this morning.
> >>
> >> Since I now have a workround, I'm going stop the current bisection that I was doing.  I've done another couple of steps
> >> this morning and both produced kernels on which I could not test bluetooth and had to tell git bisect to skip. If
> >> however, I can provide any other diagnostics, please let me know.
> >>
> >> Chris
> >
> > Can you try with the following patch:
> >
> > https://patchwork.kernel.org/project/bluetooth/patch/20220228173918.524733-1-brian.gix@intel.com/
> >
> >
> Sorry, that patch has made no difference. After the first boot my headphones connected okay, but after a power-down and
> reboot they would not connect without an unload and reload of the btusb module.

Can you tell us exactly what steps you are using? Are you applying on
top of what, rc6?


-- 
Luiz Augusto von Dentz
