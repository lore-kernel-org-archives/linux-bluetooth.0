Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB211C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Mar 2022 01:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiCEBLh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 20:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiCEBLg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 20:11:36 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7C1E375B
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 17:10:47 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2dbd97f9bfcso109568617b3.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Mar 2022 17:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhcqeKFbz4lwFb/RNt0No8WQLQ9sWb8V4NSyHeqrmLw=;
        b=Ew2Qk1P8exvbrQbu7pZ7He2+a04vVyjyWYtX3V5cHlVycfMUQYNojpoHv971GHDIGO
         NvkrabDtypb4enHK4GzjqgfIb5gTjhjZEf0YIqrGg99tawIXC8UvoJMuYLlnab4J/gLn
         aDiKh2bTKb9uR0+XriVyROcbfaj8ZAy/pG5uoHPrVn4K1XM87sBIVPDs3ob98euXR81A
         AhAHZVEaaD33GltxPzpu4KGQApitEMywJ2ztNpYMqFoTd7QquQWXlpRlqGcpCHGjnHY2
         hJ0/1//stmzWeeLB13UboHIA5RWXRU1VLUmTp8ecyYZNtIOvNZJ0JDJ7WY1cJNLel4J8
         dzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhcqeKFbz4lwFb/RNt0No8WQLQ9sWb8V4NSyHeqrmLw=;
        b=gcknJZDp/7i1/DnLPbJl5GUyj1JQUL7e7siquEzkyyCZrK99vR9BZG5SrNiKS+1dLx
         SipVeTRwNsyqK8Hhm39X96Y5thmMgT0I7/igBKH+t+junQQtXwQ99/WezhKsFruSJjHd
         AVi9cQzL9v3c8o9YuVPjQ+N6mPUS02JAyHxLyimOZ4ROxXSFrpBtvmxuZ61qTIBYqkpT
         xseqbM7BOTBGbqLSANKfZYlVdGMG9siVdSGIKsYvjshBjvYDMJPlznm5Io65sgTWaVQD
         KAVdKymCegBai5/ON0uMEb9Zb4/EyslDmzd3X4ayq/CUgVxy0iqA7tQ2SNFnINVGmNUW
         1P9A==
X-Gm-Message-State: AOAM533p5kbc3M5Har4koulR0yk47zDqWYonHxmDj4nqVSSW6pLYdVdr
        CMEKQNzlpWCXlEMIU9SuKI8uOz+g/FT9Ub7xXwA=
X-Google-Smtp-Source: ABdhPJwdF4FBmC98qQH8v20EulG8KWqjojw9i6tx5Y+J3feT9RIMnhnvbXfqACxuf0aSEgDqSz4WKmWOuEd8YoUn4XY=
X-Received: by 2002:a05:690c:a:b0:2d8:117f:7323 with SMTP id
 bc10-20020a05690c000a00b002d8117f7323mr1227269ywb.358.1646442646266; Fri, 04
 Mar 2022 17:10:46 -0800 (PST)
MIME-Version: 1.0
References: <4124ccb8-11f-21e9-982e-7fb07f23225@panix.com> <CABBYNZLt3GmBTmAADa+FF2bdEfzMg_9Horxk2pT85BC+LFgrMQ@mail.gmail.com>
 <91c1e9ef-4786-b9f5-8bb8-b93c84c0874b@panix.com> <CABBYNZ+t+L=G-X0qt=Cnn7vUpLu2s1=purmAESnCaRvK7XtmdQ@mail.gmail.com>
 <76f65c9-e031-3870-9dfb-49f8969534ae@panix.com> <6f3b9dbb-6ecf-cfea-2127-cb3360d78431@panix.com>
 <3bc9bbab-b3cd-4c52-cc33-5d723d973deb@panix.com> <28e1099-76a-3b8d-b6d2-84dbde9ab853@panix.com>
In-Reply-To: <28e1099-76a-3b8d-b6d2-84dbde9ab853@panix.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 4 Mar 2022 17:10:35 -0800
Message-ID: <CABBYNZJiDPA=qfkkBHbi5kWFxgM3+RjBtjmryKBY2AEzyfBXFw@mail.gmail.com>
Subject: Re: Commit ad383c2c6 ("Bluetooth: hci_sync: Enable advertising when
 LL privacy is enabled") breaks my MS ArcTouch mouse
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        regressions@lists.linux.dev, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kenneth,

On Fri, Mar 4, 2022 at 4:06 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Sat, 29 Jan 2022, Kenneth R. Crudup wrote:
>
> > So, it turns out that my lack of discoverability is also tied into this last
> > series of BT commits
>
> So, after "for-net-next-2021-11-16" was pushed into Linus' master, my Laptop's
> Bluetooth has been horribly broken; I can't add new devices (says "can't put
> your adaptor into Discoverable mode"), and my MS ArcTouch mouse (and who knows
> what else) doesn't work anymore. I also get stalls/crashes from the BT system
> when trying to shutdown or reboot.
>
> This is a *serious* regression- I had to revert the entirety of that merge.
> I keep checking the BT changes that have made it to Linus' master of late (and
> even monitoring the Bluetooth git), after nearly 6 weeks, BT is still broken-
> certainly I can't be the only person seeing these issues. I did see where
> someone had a regression about not being able to do scans, and that was fixed,
> but trying that commit (since merged to master) doesn't fix anything for me.
>
> My BT adaptor is an Intel AX201 on USB:
>
> ----
> [Fri Mar  4 15:40:52 2022] Bluetooth: hci0: Found device firmware: intel/ibt-19-32-4.sfi
> [Fri Mar  4 15:40:52 2022] Bluetooth: hci0: Boot Address: 0x24800
> [Fri Mar  4 15:40:52 2022] Bluetooth: hci0: Firmware Version: 126-5.22
> ----
>
> ----
> Bus 003 Device 003: ID 8087:0026 Intel Corp.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.01
>   bDeviceClass          224 Wireless
>   bDeviceSubClass         1 Radio Frequency
>   bDeviceProtocol         1 Bluetooth
>   bMaxPacketSize0        64
>   idVendor           0x8087 Intel Corp.
>   idProduct          0x0026
> ----
>
> What can I do to help you fix this?

Have you tried with bluetooth.git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/

This was the latest one that fixes the MGMT commands not working:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/commit/?h=for-net-2022-03-03&id=008ee9eb8a11bcabf12c91771dd4f470b082bd44

It seems some setups are more susceptible to it than others and CI was
one of those when only one MGMT command is ever pending which masked
the problem for us for a while.


-- 
Luiz Augusto von Dentz
