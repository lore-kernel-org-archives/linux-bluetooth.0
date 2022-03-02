Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70202C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 06:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbiCBG4x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 01:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiCBG4w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 01:56:52 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD08B3E5C
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 22:56:08 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so1529285ybu.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 22:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rPAnekLzbNk36KECkvK8z0i9G5GfS66p/4TMh/dn2w=;
        b=PMLv095RVv3uIatU7yXtNUJUIVhdWimLwnzTZuDbgMQR+gsVYyCzAEjud8LYTHKRND
         7sjYu0nmzwwx7nd9iIy/1TVnz8bM4T9NaQOepevI4yRvysLwalRcGgpM1uaOvhmycnXo
         bUoehgjQtu2XMTS0YogLVasoe4R+5z76/oVnyXkxhdZ9r7oex2ey1rzdHxSvCofOKeYR
         UqsnwgZ/zRt7ddrqFVUyQ1qm0WsqiBbGLxC4piOW2yahV2ZJiG8veOFbb9j22z258NRC
         sBvilGVpPm1GFCqHmC7wBGIrjXmnWe/ZxoU8Jy9m6hikDpluOsGvGiqFoplksf3l4ibP
         g/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rPAnekLzbNk36KECkvK8z0i9G5GfS66p/4TMh/dn2w=;
        b=KeUIxp4LseQ9s+kJvE8V02TOlEVO3W0eJ4E6dibTEdAdoWSx7CKUn83VTv2UBr/Hpv
         7z/IWi6tcVW+0wo7YJg7tZPrVMkpwH1/lJxM++1F6ciQ/3Vm5sSUVPlLNnylUfNvdfNj
         qvPmMqJMxrgeAhUBSuRYgVmssbacEAn574jbpWECJFypJfCZnJGU43GIC5jVCWeInF7s
         WulJuR9KwxVT1D+WwF4dXVwASFIVc6Ka3FLFg0dJKGGdySWqR9XPeaFre/1wrvFR3DlY
         JH0MG2SE2SrYQas58xK+4NxEWy7GyV1j/eaS2mQCsnmrgJt6wp6YnaKW3I8pmCRPwGOA
         fWAQ==
X-Gm-Message-State: AOAM533mFctemaegUGFudktDiCdRVBnUUaOIHXxwdT4gE3Hq7kD/4ibO
        eJTMk/HoxYnp1Df9JtOdZfyF5YsC0hk4u6Xl4yo=
X-Google-Smtp-Source: ABdhPJzB3U4sjBYLQDqUAYIcCkQ9wKWSGZZ5c9AedUoRH1Jz8t6GC7ruhfITx5rmueF8LS93LXwpIvihtmcYxAT7hc8=
X-Received: by 2002:a25:2597:0:b0:628:7f84:3138 with SMTP id
 l145-20020a252597000000b006287f843138mr5573036ybl.41.1646204167727; Tue, 01
 Mar 2022 22:56:07 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <b1a4a920-dbba-58be-72b4-2c95b9b79283@googlemail.com> <82216882-463a-8976-e6bc-4a8919107a31@googlemail.com>
 <CABBYNZ+mO1gQgfwhemY9cqbi8vNLm_60A9c1vPYT2tH4rhgFww@mail.gmail.com>
 <a35b4b75-bb64-89c8-bacd-d58ed8576272@googlemail.com> <2ce6175c-74ec-8469-80a5-374bd1429542@googlemail.com>
 <CABBYNZJNTOT-mEQe2cfZiEX6A2pR7+sacBqtBRPRZY69YmgtvA@mail.gmail.com>
 <17f2bf7e-1d6b-e090-8926-21a408f2b496@googlemail.com> <CABBYNZ+cL4f8xvTJFQGLgqPueE=-UsOtvcPQez0BEsJ5xGppfQ@mail.gmail.com>
 <16cac2c8-c1ca-c8d7-e3d9-5f00be511614@googlemail.com> <CABBYNZJQOSZ1fecTRQOX+w8crdiLdr0_tVstgbnyEVq3NaxscQ@mail.gmail.com>
 <6b17bdb5-dddb-e7c7-86f6-2240c6523a81@googlemail.com> <CABBYNZ+2Dg+AdnJqpR=wS0juektNapwHcPHBWdZyvSGFT1dVLQ@mail.gmail.com>
 <cdfed116-a5ea-0313-ba87-da429a0ac089@googlemail.com> <CABBYNZLnMwod+pgomEfvu83AJ=jM+uqwK9-Eqj6fA9_wXg6HBA@mail.gmail.com>
 <CABBYNZJvQaD4z_pL2YJnu3Ma8MLmxkUqAHMswd8s9XsE5FNMMw@mail.gmail.com>
 <032917a9-0c14-16d3-2751-945b9cd766a3@googlemail.com> <CABBYNZKZZT0Wmzx5YfTWSR7_P--O=8QLOdn7jWKa9x=GjYNgzA@mail.gmail.com>
 <CABBYNZJekcb8wy+Sp7pLPs-usvm8yXPqL+e3RCDv5i9S+cq8dQ@mail.gmail.com> <CABBYNZLSFjVRZf+CTZ0qE+tObaHrDa5rtFvSVuQrwUc1cQWeZA@mail.gmail.com>
In-Reply-To: <CABBYNZLSFjVRZf+CTZ0qE+tObaHrDa5rtFvSVuQrwUc1cQWeZA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 1 Mar 2022 22:55:56 -0800
Message-ID: <CABBYNZJ_W-SsfBc2m-8dQkzbJ6KHoP_5YoAiED5JewVd17kUAQ@mail.gmail.com>
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

On Tue, Mar 1, 2022 at 6:31 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Chris,
>
> On Tue, Mar 1, 2022 at 2:47 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Chris,
> >
> > On Tue, Mar 1, 2022 at 2:40 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Chris,
> > >
> > > On Tue, Mar 1, 2022 at 11:40 AM Chris Clayton <chris2553@googlemail.com> wrote:
> > > >
> > > > Hi
> > > >
> > > > On 01/03/2022 18:57, Luiz Augusto von Dentz wrote:
> > > > > Hi Chris,
> > > > >
> > > > > On Tue, Mar 1, 2022 at 10:34 AM Luiz Augusto von Dentz
> > > > > <luiz.dentz@gmail.com> wrote:
> > > > >>
> > > > >> Hi Chris,
> > > > >>
> > > > >> On Tue, Mar 1, 2022 at 1:26 AM Chris Clayton <chris2553@googlemail.com> wrote:
> > > > >>>
> > > > >>> Hi Luiz,
> > > > >>>
> > > > >>> I guess you are hoping for PEBKAC :-)
> > > > >>>
> > > > >>> On 28/02/2022 21:20, Luiz Augusto von Dentz wrote:
> > > > >>>> Hi Chris,
> > > > >>>>
> > > > >>>> On Mon, Feb 28, 2022 at 1:02 PM Chris Clayton <chris2553@googlemail.com> wrote:
> > > > >>>>>
> > > > >>>>> Hi Luiz,
> > > > >>>>>
> > > > >>>>> On 28/02/2022 19:34, Luiz Augusto von Dentz wrote:
> > > > >>>>>> Hi Chris,
> > > > >>>>>>
> > > > >>>>>> On Sat, Feb 26, 2022 at 12:04 AM Chris Clayton <chris2553@googlemail.com> wrote:
> > > > >>>>>>>
> > > > >>>>>>> Hi,
> > > > >>>>>>>
> > > > >>>>>>> On 24/02/2022 15:16, Luiz Augusto von Dentz wrote:
> > > > >>>>>>>>> I'll try another bisection today, but limit its range to changes made in the net/bluetooth directory.
> > > > >>>>>>>
> > > > >>>>>>> That  bisection has proved very difficult because the bluetooth "service" in kernels at some steps of the bisection were
> > > > >>>>>>> completely borked to the extent that blueman's device-manager application wouldn't start and emitted the messages:
> > > > >>>>>>>
> > > > >>>>>>> blueman-manager 12.00.37 ERROR    Manager:137 on_dbus_name_appeared: Default adapter not found, trying first available.
> > > > >>>>>>> blueman-manager 12.00.37 ERROR    Manager:141 on_dbus_name_appeared: No adapter(s) found, exiting
> > > > >>>>>>>
> > > > >>>>>>> Obviously, I don't know whether the problem I am trying to pinpoint is hiding behind this more fundamental problem with
> > > > >>>>>>> the bluetooth "service", so being unable to say whether that kernel was good or bad, I had to skip. There seems to be a
> > > > >>>>>>> batch of commits that mean that, whilst the kernel builds okay, hunting down a bluetooth-related problem is not
> > > > >>>>>>> possible. Eventually and I cursed and gave up. Whatever was causing this breakage has obviously been fixed.
> > > > >>>>>>>
> > > > >>>>>>>> Please record the HCI with btmon, it must be producing something since
> > > > >>>>>>>> it records even the mgmt commands.
> > > > >>>>>>>>
> > > > >>>>>>>
> > > > >>>>>>> Refreshed by a good night's sleep, I started another bisection (between 5.16 and 5.17-rc1) yesterday morning but this
> > > > >>>>>>> time did not limit it to net/bluetooth.  That was going okay until I ran into what I assume is the same batch of borked
> > > > >>>>>>> kernels. I've been more persistent this time but have just had a run of 16 steps in which the bluetooth support in the
> > > > >>>>>>> kernel is broken so badly that testing bluetooth is not possible. I will push on today, but I've suspended that activity
> > > > >>>>>>> to get the hci trace that Luiz has asked for.
> > > > >>>>>>>
> > > > >>>>>>> Using information from the bisect, I built a kernel that had tested as bad (but not borked). The commit is
> > > > >>>>>>> f2b551fad8d8f2ac5e1f810ad595298381e0b0c5. As I've mentioned before, the problem with devices not connecting is
> > > > >>>>>>> intermittent - for a given kernel, sometimes a connection works and other times it doesn't. On the first boot of this
> > > > >>>>>>> kernel, my bluetooth devices could connect, Attached are 4 files related to this - the output from btmon, and the
> > > > >>>>>>> related portions of daemon.log, kern.log and sys.log from /var/log/. Each of the these files is suffixed with ".good".
> > > > >>>>>>>
> > > > >>>>>>> I then powered down the laptop and booted into the same kernel. This time the bluetooth devices could not connect. Four
> > > > >>>>>>> more files are attached for this boot and are suffixed with ".bad". I said in an earlier email that when connection
> > > > >>>>>>> fails, there is no output from btmon, so that log is empty. That's still the case, but I guess that fact itself is a
> > > > >>>>>>> clue to what the problem might be. What I can add, however, is that if, in that same bad kernel, I unload and then
> > > > >>>>>>> reload the btusb module, connections start to work. Maybe that too is a clue. The same unload/load process revives
> > > > >>>>>>> bluetooth on a kernel built after a pull of Linus' latest and greatest this morning.
> > > > >>>>>>>
> > > > >>>>>>> Since I now have a workround, I'm going stop the current bisection that I was doing.  I've done another couple of steps
> > > > >>>>>>> this morning and both produced kernels on which I could not test bluetooth and had to tell git bisect to skip. If
> > > > >>>>>>> however, I can provide any other diagnostics, please let me know.
> > > > >>>>>>>
> > > > >>>>>>> Chris
> > > > >>>>>>
> > > > >>>>>> Can you try with the following patch:
> > > > >>>>>>
> > > > >>>>>> https://patchwork.kernel.org/project/bluetooth/patch/20220228173918.524733-1-brian.gix@intel.com/
> > > > >>>>>>
> > > > >>>>>>
> > > > >>>>> Sorry, that patch has made no difference. After the first boot my headphones connected okay, but after a power-down and
> > > > >>>>> reboot they would not connect without an unload and reload of the btusb module.
> > > > >>>>
> > > > >>>> Can you tell us exactly what steps you are using? Are you applying on
> > > > >>>> top of what, rc6?
> > > > >>>>
> > > > >>>
> > > > >>> Until I got your patch yesterday, I was using a clone of
> > > > >>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git which I update frequently and have been doing so for as
> > > > >>> long as I can remember. Just in case there was a hidden flaw in that tree, I took a new clone yesterday, (so yes, the
> > > > >>> patch was tested on top of rc6) copied over the .config file and applied the patch. Then I built and installed the
> > > > >>> kernel, updated grub, powered off the laptop and booted into the new kernel. Once the laptop had booted and logged in to
> > > > >>> my LXQt desktop, I powered on my headphones and a connection was establisehed almost straight away. I powered the
> > > > >>> headphones off and the disconnection worked fine.
> > > > >>>
> > > > >>> Knowing that the problem crops up intermittently, I then rebooted the laptop. When the boot was complete, I then powered
> > > > >>> on my bluetooth headphones an waited for them to connect to the laptop. After about 20 seconds, a connection had not
> > > > >>> been established. I powered off the headphones, used modprobe to unload and then reload the btusb module. When I powered
> > > > >>> on the headphones, a connectiin was established within 2 or 3 seconds.
> > > > >
> > > > > Ive attempted 5 restart with 5.17.0-0.rc6.109.fc37.x86_64, my headset
> > > > > was able to reconnect every single time without any problem. The only
> > > >
> > > > For your five tests, did it connect on the first boot? As I've said, sometimes it fails to connect on the first boot,
> > > > but if it succeeds, it has always failed after a power-off and restart. Looking back at the notes I took during the
> > > > bisect, I've didn't have a single bisection step where I had to boot more more than twice to ascertain that it was a bad
> > > > kernel. As I said, I didn't mark a kernel as good until I'd had five successful boots.
> > >
> > > It did connect every single time.
> > >
> > > > > normally, once from gdm and then another time when gnome is loading,
> > > > > but I assume it is normal nowadays since it appears when switching
> > > > > session pipewire unregisters its audio endpoints.
> > > > >
> > > >
> > > > I don't use pipewire. Prior to 5.17, bluetooth has worked more or less trouble free for at least 4 years. I've read
> > > > about pipewire in Linux Magazine but don't see what it would bring to my party except complication.
> > > >
> > > > ends on how bluetoothd is being
> > > > > started or something.
> > > > >
> > > >
> > > > Did you see the warnings that read "Bluetooth: hci0: unexpected event 0xff length: 5 > 0"? That seems to indicate that
> > > > something is sending events that are unexpected. What effect will that have?  As I said, according to lshw, my system's
> > > > bluetooth hardware is Intel AX201. Is that what you are testing on?
> > >
> > > I have an AX200 on my system, AX201 is very similar so Id be surprised
> > > if that is the problem, btw Ive also got some unexpected events but
> > > that didn't stop the headset to reconnect.
> > >
> > > > >>> I've booted this laptop countless times over the last few days. Doing the bisect, I didn't mark a commit as good until I
> > > > >>> had done five boots and been able to connect my headphones on each boot. What I can say from that work is that two
> > > > >>> consecutive boots into a working kernel are very rare. I can't remeber an occasion when it took more than two boots to
> > > > >>> establish that a kernel was bad.
> > > > >>
> > > > >> Do commands such as bluetoothctl power on or scan on works? Try
> > > > >> running bluetoothd -dn from a shell (disable bluetooth.service), also
> > > > >> are there any settings changed in main.conf?
> > > > >>
> > > >
> > > > Sorry, I forgot to answer this question earlier. I haven't changed main.conf. Besides, my bluetooth devices connect
> > > > successfully every time with 5.16.11 and 5.15.25 kernels. As I've said before, that strongly suggests that there is a
> > > > code regression in 5.17.
> > >
> > > Not saying there isn't something wrong, we have sent a couple of fixes
> > > that doesn't seem to be merged yet, and we are working on another one
> > > for fixing the scan:
> > >
> > > https://lore.kernel.org/linux-bluetooth/f648f2e11bb3c2974c32e605a85ac3a9fac944f1.camel@redhat.com/T/
> >
> > Btw, are you by any chance doing something like hciconfig hci0 up on
> > your init scripts?
>
> Looks like I was able to reproduce but I still don't know the cause,
> anyway the symptom is the following:
>
> [23412.856410] remove_uuid:2273: hci0: sock 0000000049dcd70a
> [23412.856467] mgmt_class_complete:2174: hci0: err 0
> [23412.856470] mgmt_cmd_complete:176: sock 00000000d63e046a
>
> It looks like the cmd->sk is wrong/corrupted, what is even more
> strange is that the socket pointer does seem to match previously
> connected MGMT clients and after a few attempts with btmgmt> power on
> it does come back to life, very bizarre...
>
> Can you try to enable some kernel debugs before you start bluetoothd:
>
> echo "file net/bluetooth/mgmt.c +pfl" > /sys/kernel/debug/dynamic_debug/control
> echo "file net/bluetooth/mgmt_util.c +pfl" >
> /sys/kernel/debug/dynamic_debug/control
>
> Maybe that should give us a clue what triggers it.

Here is an attempt to fix the problem:

https://patchwork.kernel.org/project/bluetooth/patch/20220302064351.225212-1-luiz.dentz@gmail.com/

Also it probably make more sense to test with the following tree since
we are using it to push regression fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/

> > > > >>
> > > > >> --
> > > > >> Luiz Augusto von Dentz
> > > > >
> > > > >
> > > > >
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
