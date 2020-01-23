Return-Path: <SRS0=lRrI=3M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FD4C33CAA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 23:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A83F20684
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jan 2020 23:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaVwgSuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgAWXOE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:14:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38901 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgAWXOD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jan 2020 18:14:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so4513124oth.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2020 15:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jfZ6PqzdY3UJ50IFdqGJ0SYi6XBLrvXzq1DVeJ23b24=;
        b=SaVwgSuAuPTqztpD/q/4goKm5RR45Be96i5EH1LJr+SJe5JgOejN3gye/oR0lT3dna
         k8WE99Tgy7Ln4SDTUV6j2B1pfCR2Zd4+Ot9s1pnr9cBk+MXX9LtaqZc+a3gkpDKmvZiy
         vCUkMjYvf1CgT49Z6YBFp50H3y2qVmGSGi/F4Yw3I7QFch8+VcTwJ5ngRYrqK+HOzK04
         qMYnW4a8gR5/vJezO8SpV6+9TNmCPLJUaCGz58xdln8CzxfWNUT9PlgqKNtCHZvRL0tq
         oNqgKH48N8JEjss7G1Rz2B+fcqD57N4wH1eF0Mt3+//uJ0oNPojTgbEPeD8soavJFMHU
         ZZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jfZ6PqzdY3UJ50IFdqGJ0SYi6XBLrvXzq1DVeJ23b24=;
        b=hVdc1hkrQDKNikgcG8I8T7B1fZyRsGXPOVcX0tKADODen/h//kRarODWrSmEMzYEzS
         T9fIU0+i+ZSwUgydxRuqkRsdrBJDl3MHDGwO5qRoKhF8ANrnu+4+sSkEYivBBWM2yvG1
         6CcvPW0feK6Dp1tqqcrQJ5pQ1GFfM/9b/H6L6UNp65+5pTTXvJ55Eqsii2K4L+pYR4GU
         90jegUrZzkhbOyVWXHfssl92GIy+vZovaO3fwb1G3r2ZAzQzHsuJ1vI0Wqoc6BYlHE1S
         4iO/J4A7DTWKOm6whTMjv5a4m5kykid+2oNP+urjtafkMHFWTKjSLmhr6yW6jU6orccU
         UTvQ==
X-Gm-Message-State: APjAAAXTfAxgqax8bOldi+m5xt8JnO3Hnm96vmhKVp+TToWu5WDmMGf2
        mKXx1V3NNC0sgslj/CZd3jtbZKkuO75lOShyuMk=
X-Google-Smtp-Source: APXvYqwA1zkkDvHOFdJ3wqqevzwjgQVd621bM534sBoitVQXxGMsdHdY+PjZRYKhToYTrnLSLLvVzo3pKKSNv5ulRFI=
X-Received: by 2002:a05:6830:1515:: with SMTP id k21mr561871otp.177.1579821242664;
 Thu, 23 Jan 2020 15:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20200120202708.111383-1-alainm@chromium.org> <6E55772A-01D5-4616-B3DB-CC22B935C855@holtmann.org>
 <CALWDO_WyZUvkOgXVSd12q7Trg_=LqSb9KQsXH9_C_k8_kD0ddQ@mail.gmail.com>
 <D0C01568-E48B-46ED-A2CC-D19FB2895756@gmail.com> <CALWDO_Wf3c5Vgt1a_p+pt_SpdkGJnLvneiZZ_1spRVuOr+9n0g@mail.gmail.com>
 <CALWDO_VC2z8ZxCQM0EBWvkEWJRQKaVy0butAeRc+uUqhpGcyMw@mail.gmail.com>
 <DFE9B731-5CB8-4FDA-8E89-1D5A51EAFB67@holtmann.org> <CALWDO_V=Q0725MhnA3hMnvL+hDbGVCa-RCT4d4NCysMo0Fvh7g@mail.gmail.com>
 <F6319DB4-FE70-45C8-A61D-D965CB659C9E@holtmann.org> <CALWDO_Vqboxt4JfV9yGVd5Jv5jZ-vwtOghh4tffpQpQzHuq6NQ@mail.gmail.com>
 <D61B5AA9-A509-4253-95D7-F6401C832081@holtmann.org> <CALWDO_Ub-orioZmPkCC4BoVfxHv9onP9QXz_M_T9nmh7_78LLQ@mail.gmail.com>
In-Reply-To: <CALWDO_Ub-orioZmPkCC4BoVfxHv9onP9QXz_M_T9nmh7_78LLQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Jan 2020 15:13:50 -0800
Message-ID: <CABBYNZKESdA4V7N8sVc6g31gsfN6G8=NH=-EU3q0phvfg5HGuA@mail.gmail.com>
Subject: Re: [Bluez PATCH] doc: Add definition for Set Kernel Debug Level
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Archie Pusaka <apusaka@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain, Marcel,

On Thu, Jan 23, 2020 at 10:20 AM Alain Michaud <alainmichaud@google.com> wr=
ote:
>
> Hi Marcel,
>
> That makes sense.  Adding +Archie Pusaka as well who may have input into =
this.
>
> Thanks,
> Alain
>
> On Thu, Jan 23, 2020 at 1:16 PM Marcel Holtmann <marcel@holtmann.org> wro=
te:
> >
> > Hi Alain,
> >
> > > From a high level, this looks good for me although I agree, this is a=
n
> > > order of magnitude bigger in terms of scope.  Can you suggest perhaps
> > > an interactive way to deliver this over a period of time, perhaps
> > > prioritizing the BT_DEBUG kernel messages first? :)
> >
> > I am always in favor of increasing the ability to debug things, but we =
need to do this in a clean fashion and not some short term hacks (since the=
y will come back and haunt us). I like to get some review on my idea first.
> >
> > What we could do is work on the BT_DBG etc infrastructure to allow swit=
ching when dynamic_debug is not available. Then you would use some debugfs =
toggle in /sys/kernel/debug/bluetooth since that is no stable API for us (a=
nd of course the clear understanding that this toggle is temporary).
> >

Not sure if I fully understood the problem, so I guess we are looking
to a solution to replace dynamic_debug since that is not normally
enabled on production? Not sure if this should be discussed with
kernel community as whole because it does lead to each subsystem
reinventing their own mechanism of logging.

Now logging the kernel message into btmon I thing would be very
useful, regardless on what the mechanism would be used to enable them,
so perhaps we should start with that. I fill that enabling the exact
same granularity as the dynamic_debug has would be a bit overkill so
Id would suggest sticking with the current categories that we have for
the monitor which are:

#define BTSNOOP_PRIORITY_EMERG        0
#define BTSNOOP_PRIORITY_ALERT        1
#define BTSNOOP_PRIORITY_CRIT        2
#define BTSNOOP_PRIORITY_ERR        3
#define BTSNOOP_PRIORITY_WARNING    4
#define BTSNOOP_PRIORITY_NOTICE        5
#define BTSNOOP_PRIORITY_INFO        6
#define BTSNOOP_PRIORITY_DEBUG        7

Though I see Marcel's point that if we go this way enabling DEBUG
level would simple flood the trace, but I believe the problem can be
solved with a minimal change which is to split data (above
L2CAP/RFCOMM) and signalling logs, obviously this would require a spit
on the way BT_DBG works so we can actually say dump the data path or
just the signalling (this should probably be the default), which I
think would benefit us even in case of using dynamic_debug because
depending what files are enabled (hci_core.c, l2cap_core.c, etc) that
logs way too much and it is not uncommon to lose the logs because the
terminal buffer is not big enough just because the data is intermixed
with some signalling, that said I think we would have to prefix data
and signalling with some string and then use format option to match
them.

--=20
Luiz Augusto von Dentz
