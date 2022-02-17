Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BED6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 23:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiBQXmd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 18:42:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiBQXmc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 18:42:32 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8EE3CFD0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 15:41:21 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d625082ae2so49227277b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 15:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OH4xdKwbHT+W6V7lIuAFQEx4jlgcFZTl/QovXWm+Qnk=;
        b=VNaGGbiwE6LJcuG9GBl8WJ+o024TKcJ6VfIfuMgT0K8LhKj4Z5XlRbyml48jlejmxd
         GhvWOI1RlpE08mE2TRLLj3wwH9woG9Zq1uxp/HTIBzpu7v/LQdWG2q/RxgkCdyzz5VO4
         kdIuW+K8321R8K6Pq/a5hofVdgu8byXfR/bSJO4kIIBS1Aj3QMZ0ak9GUYD+STMeccta
         DJcH2GR4zcSm/yhh0M2gaHiMvJBghJTwj1fTcUhs+J5EgdzFhcawEXe76GGrsBEPRECs
         Hvt/27p4OAPQDLzk3DmlUxsWkK6LK1iutovNRWERjuYzsiEmdSLkrqUOS4/46Ad88apu
         cexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OH4xdKwbHT+W6V7lIuAFQEx4jlgcFZTl/QovXWm+Qnk=;
        b=ky8mXiyZvCbA1RrrUx7/81BPMOmOHTrd1Qjzr25/22N92SjnNvuqKxE3aOdyGKu4cl
         4wcYhXiXoRxHqDYpPMdfgVRg9lKUxYBs4O+UVJSEamt39SOV2zTzciICCmdQQcou+Ju0
         bInbKwe8sBlRqpIxMehF44akZE+e+J+SBdo9vmcZJMKCoo8lDe1OROoS0l/zgT+IBCr3
         pwxj7Kuhe6sSn6QprveTtdKc6mkmkZu+SSxk2YuoZUxbp6mzuBfbsrK6e0xElVSJyujG
         TUB2bAINqIUiTEQAY8shmzGvaihqQwSUOqsAejYPSTs4Zag9LKk5QXBlFg6FT0zGFnWJ
         D5Lg==
X-Gm-Message-State: AOAM533xlJuL4a3aKLVyx2g8naD8XJMVsxauo3FRyYy5ch/Sw5/dV0VA
        R+MZj05ZvJIcGlDrHMXs580/agY6pDmyW1mrqgAoob1l5lDAlis6
X-Google-Smtp-Source: ABdhPJx39G8VjmklCPpAGAYWtCDsqec/7fknsG9tSgoYkET6uY8iCgcuKghvugx1o4vH8f5+JuSuhjybhmSZAwaXUfQ=
X-Received: by 2002:a81:4b8c:0:b0:2d0:a754:3fe0 with SMTP id
 y134-20020a814b8c000000b002d0a7543fe0mr5131501ywa.369.1645140977247; Thu, 17
 Feb 2022 15:36:17 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com> <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
In-Reply-To: <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 17 Feb 2022 16:36:01 -0700
Message-ID: <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Bluetooth <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

OK I started over, and for now keeping the reporting constrained to
the hardware I personally have on hand.

Hardware:
Lenovo Thinkpad X1 Carbon Gen 7
Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
Jefferson Peak (JfP)
Sony 1000XM3 headset
bluez-5.63-3.fc36.x86_64

kernel 5.17.0-rc4
* remove the paired headset with bluetoothctl
* reset the headset so it's not longer paired either
* put the headset in pairing mode
* GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
* click on Not Setup and nothing happens

The above activity is recorded with 'btmon -w btmon-w-headsetpair.txt'
and i get both termin output and a binary file

terminal output
https://drive.google.com/file/d/1fFbyRm32Lf0yzrHhE1vEE0ztnSeoe7VB/view?usp=sharing

binary output
https://drive.google.com/file/d/1BmnO-utOooMWgcEHTuoz13Ndd5hGuqe_/view?usp=sharing

kernel 5.16.9
* bluetooth panel says it's connected to LE_WH-1000XM3, as if the
previous pairing attempt above worked
* bluetooth panel name for the device flips between LE_WH-1000XM3 and WH-1000XM3
* headset is still in pairing mode from when i was trying to pair with
5.17.0 (flashing blue lights), it eventually powers off so as far as
it's concern pairing didn't succeed
* again remove the headset with bluetoothctl
* put the headset back into pairing mode, click on LE_WH-1000XM3 in
the list, "Not Setup" flips to "Connected" in the GNOME bluetooth
panel, and the headset reports pairing is successful
this is what bluetoothd is reporting during the name flipping
https://drive.google.com/file/d/1qjAlkODkjJzR33WpHD2Sxze8zq4t1UhS/view?usp=sharing

Definitely seems kernel related.


--
Chris Murphy
