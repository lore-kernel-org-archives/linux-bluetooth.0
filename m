Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CDBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 18:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiCASfm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCASfl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 13:35:41 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEDF57168
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 10:35:00 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id j2so29086468ybu.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 10:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=biRlXb0s7CfZNwFCvFFaKremMZs5H/IsJHOKTQl6rtk=;
        b=UbqXvwfsvxrpRwd1/hkGKhTI84+ErptN4WMQcWMImuTFiUVCHIJ+Ld6WcSJsrPxW2E
         XgNuy2UgXTHmx4eujnIS3wHxOscDtflnOZ39VNNQ1oh3w2k7DGitoiK0nENoJyMEsa6l
         E17Lp1hoeKKr4kdbRQcuZ7jagVKBEI42oxFmgLveGNCnfkhgpG01Yn6NzdEkDCIqiqjo
         X8MzvYN1xlC3iw+B1odWf5qjCgk+C4OacWPlrn1wT5hykef7VHf5hOCnsgAlVzsNI/6h
         BzORLE7PXvmSA5nWjevIJGfl5LyXUx6KIHTVcu8hitMNsJ21ZgZhENEn5bdpWaqcPlZx
         HYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=biRlXb0s7CfZNwFCvFFaKremMZs5H/IsJHOKTQl6rtk=;
        b=kUCA8sHo4HNIt88u7cj6s3S7MWO0ahv0/Qakzqs/6vuCZbWobv3MKFYdsLVaeAChS6
         /QTVttGK4rWrQbxlmAtaixJQg67RFaYTcLjJcINRN8DmZ2Gu1/DuUIWYMcH5UU3J7fNc
         VXEr3R6LHpoyYLJt8n1eRr2ZAlJ+9zFcbj/zfACLMc/W18QiEbtGHJt/BMsGDIvPM4OY
         OCfEUqGwnp5aVWZ9irSDlPHHqVrHapvx4C8Y7F9OfrEDYfXU43ccWdmUOnx/Ol0aY/TH
         q34LdGBGScC2sszcWw2dXqAuY94p8ISZcLsgesBjCaaFXsXYLJmi2zZ5ExqGZOfxZ4g/
         Pp3Q==
X-Gm-Message-State: AOAM531KzC4rCZ6DYu+tKG4+QBnhZmdk0AyOJMeKcl7WeyEsn9kDP98v
        zDYj6nTWoBrvDbxXXTK06FIf2n+VIjJhLoorY2Nq6se2
X-Google-Smtp-Source: ABdhPJxyK4IEzZ6uFVEy6vV07wq01h0jdO0WUbBj3JCAx4OedLZ49EKckPQBAn5Kf+SMOmYVfawyOfwGqrLMT+zGtz8=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr24373337ybn.259.1646159699152; Tue, 01
 Mar 2022 10:34:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CABBYNZ+9tUKgLyUWM5vkMW8vHxYsXv6DEaDWdHt8xTTs6puGQA@mail.gmail.com>
 <aaeb4131-d177-d41e-617b-b0060cd83c92@googlemail.com> <CABBYNZLB+8UzhzttMrKbHW_+-A1EsY9iT5Y55VuOOEPuD4kAHQ@mail.gmail.com>
 <b1a4a920-dbba-58be-72b4-2c95b9b79283@googlemail.com> <82216882-463a-8976-e6bc-4a8919107a31@googlemail.com>
 <CABBYNZ+mO1gQgfwhemY9cqbi8vNLm_60A9c1vPYT2tH4rhgFww@mail.gmail.com>
 <a35b4b75-bb64-89c8-bacd-d58ed8576272@googlemail.com> <2ce6175c-74ec-8469-80a5-374bd1429542@googlemail.com>
 <CABBYNZJNTOT-mEQe2cfZiEX6A2pR7+sacBqtBRPRZY69YmgtvA@mail.gmail.com>
 <17f2bf7e-1d6b-e090-8926-21a408f2b496@googlemail.com> <CABBYNZ+cL4f8xvTJFQGLgqPueE=-UsOtvcPQez0BEsJ5xGppfQ@mail.gmail.com>
 <16cac2c8-c1ca-c8d7-e3d9-5f00be511614@googlemail.com> <CABBYNZJQOSZ1fecTRQOX+w8crdiLdr0_tVstgbnyEVq3NaxscQ@mail.gmail.com>
 <6b17bdb5-dddb-e7c7-86f6-2240c6523a81@googlemail.com> <CABBYNZ+2Dg+AdnJqpR=wS0juektNapwHcPHBWdZyvSGFT1dVLQ@mail.gmail.com>
 <cdfed116-a5ea-0313-ba87-da429a0ac089@googlemail.com>
In-Reply-To: <cdfed116-a5ea-0313-ba87-da429a0ac089@googlemail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Mar 2022 10:34:48 -0800
Message-ID: <CABBYNZLnMwod+pgomEfvu83AJ=jM+uqwK9-Eqj6fA9_wXg6HBA@mail.gmail.com>
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

On Tue, Mar 1, 2022 at 1:26 AM Chris Clayton <chris2553@googlemail.com> wrote:
>
> Hi Luiz,
>
> I guess you are hoping for PEBKAC :-)
>
> On 28/02/2022 21:20, Luiz Augusto von Dentz wrote:
> > Hi Chris,
> >
> > On Mon, Feb 28, 2022 at 1:02 PM Chris Clayton <chris2553@googlemail.com> wrote:
> >>
> >> Hi Luiz,
> >>
> >> On 28/02/2022 19:34, Luiz Augusto von Dentz wrote:
> >>> Hi Chris,
> >>>
> >>> On Sat, Feb 26, 2022 at 12:04 AM Chris Clayton <chris2553@googlemail.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 24/02/2022 15:16, Luiz Augusto von Dentz wrote:
> >>>>>> I'll try another bisection today, but limit its range to changes made in the net/bluetooth directory.
> >>>>
> >>>> That  bisection has proved very difficult because the bluetooth "service" in kernels at some steps of the bisection were
> >>>> completely borked to the extent that blueman's device-manager application wouldn't start and emitted the messages:
> >>>>
> >>>> blueman-manager 12.00.37 ERROR    Manager:137 on_dbus_name_appeared: Default adapter not found, trying first available.
> >>>> blueman-manager 12.00.37 ERROR    Manager:141 on_dbus_name_appeared: No adapter(s) found, exiting
> >>>>
> >>>> Obviously, I don't know whether the problem I am trying to pinpoint is hiding behind this more fundamental problem with
> >>>> the bluetooth "service", so being unable to say whether that kernel was good or bad, I had to skip. There seems to be a
> >>>> batch of commits that mean that, whilst the kernel builds okay, hunting down a bluetooth-related problem is not
> >>>> possible. Eventually and I cursed and gave up. Whatever was causing this breakage has obviously been fixed.
> >>>>
> >>>>> Please record the HCI with btmon, it must be producing something since
> >>>>> it records even the mgmt commands.
> >>>>>
> >>>>
> >>>> Refreshed by a good night's sleep, I started another bisection (between 5.16 and 5.17-rc1) yesterday morning but this
> >>>> time did not limit it to net/bluetooth.  That was going okay until I ran into what I assume is the same batch of borked
> >>>> kernels. I've been more persistent this time but have just had a run of 16 steps in which the bluetooth support in the
> >>>> kernel is broken so badly that testing bluetooth is not possible. I will push on today, but I've suspended that activity
> >>>> to get the hci trace that Luiz has asked for.
> >>>>
> >>>> Using information from the bisect, I built a kernel that had tested as bad (but not borked). The commit is
> >>>> f2b551fad8d8f2ac5e1f810ad595298381e0b0c5. As I've mentioned before, the problem with devices not connecting is
> >>>> intermittent - for a given kernel, sometimes a connection works and other times it doesn't. On the first boot of this
> >>>> kernel, my bluetooth devices could connect, Attached are 4 files related to this - the output from btmon, and the
> >>>> related portions of daemon.log, kern.log and sys.log from /var/log/. Each of the these files is suffixed with ".good".
> >>>>
> >>>> I then powered down the laptop and booted into the same kernel. This time the bluetooth devices could not connect. Four
> >>>> more files are attached for this boot and are suffixed with ".bad". I said in an earlier email that when connection
> >>>> fails, there is no output from btmon, so that log is empty. That's still the case, but I guess that fact itself is a
> >>>> clue to what the problem might be. What I can add, however, is that if, in that same bad kernel, I unload and then
> >>>> reload the btusb module, connections start to work. Maybe that too is a clue. The same unload/load process revives
> >>>> bluetooth on a kernel built after a pull of Linus' latest and greatest this morning.
> >>>>
> >>>> Since I now have a workround, I'm going stop the current bisection that I was doing.  I've done another couple of steps
> >>>> this morning and both produced kernels on which I could not test bluetooth and had to tell git bisect to skip. If
> >>>> however, I can provide any other diagnostics, please let me know.
> >>>>
> >>>> Chris
> >>>
> >>> Can you try with the following patch:
> >>>
> >>> https://patchwork.kernel.org/project/bluetooth/patch/20220228173918.524733-1-brian.gix@intel.com/
> >>>
> >>>
> >> Sorry, that patch has made no difference. After the first boot my headphones connected okay, but after a power-down and
> >> reboot they would not connect without an unload and reload of the btusb module.
> >
> > Can you tell us exactly what steps you are using? Are you applying on
> > top of what, rc6?
> >
>
> Until I got your patch yesterday, I was using a clone of
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git which I update frequently and have been doing so for as
> long as I can remember. Just in case there was a hidden flaw in that tree, I took a new clone yesterday, (so yes, the
> patch was tested on top of rc6) copied over the .config file and applied the patch. Then I built and installed the
> kernel, updated grub, powered off the laptop and booted into the new kernel. Once the laptop had booted and logged in to
> my LXQt desktop, I powered on my headphones and a connection was establisehed almost straight away. I powered the
> headphones off and the disconnection worked fine.
>
> Knowing that the problem crops up intermittently, I then rebooted the laptop. When the boot was complete, I then powered
> on my bluetooth headphones an waited for them to connect to the laptop. After about 20 seconds, a connection had not
> been established. I powered off the headphones, used modprobe to unload and then reload the btusb module. When I powered
> on the headphones, a connectiin was established within 2 or 3 seconds.
>
> I've booted this laptop countless times over the last few days. Doing the bisect, I didn't mark a commit as good until I
> had done five boots and been able to connect my headphones on each boot. What I can say from that work is that two
> consecutive boots into a working kernel are very rare. I can't remeber an occasion when it took more than two boots to
> establish that a kernel was bad.

Do commands such as bluetoothctl power on or scan on works? Try
running bluetoothd -dn from a shell (disable bluetooth.service), also
are there any settings changed in main.conf?


-- 
Luiz Augusto von Dentz
