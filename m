Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB78BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 03:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiBRDtn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 22:49:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBRDtn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 22:49:43 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24760CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 19:49:27 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id v73so4707602ybe.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 19:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKpWIr0TcA77XBBCX3gs+GMKHM6n8k9HS5ec9QazhkQ=;
        b=mgc6k/yKJ2jkPFJ+gHPqa1kQyFVAe8Z3lU5OwgnPpS/JSPRXQg2cIAdTPRhI5zMi9/
         6EVQ35Agac8HU9SCrH6fSE9YlqsC4YszwLaDaU+mZesYzem3vFFcnf86D82+PNjTOwDv
         hHMogfQ0189NJAjcDBFtXWRB/9Mk3CDRfTnXylcDhqDczo5wilbxPWDfW7Kxx41IwbRK
         YlJ9fuahjWbq95+gaOOCnDdoni74Z2NbVKS/vYhyf+INWWGuAbrTuLrmqn8i6lirSvRU
         Ex0ViVtpuVcUY9hDpfJfGRr2Sy0I7qLClkhdIQM1OR1VWsAX3M1Z447ldQW+IpRXiz+e
         fNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKpWIr0TcA77XBBCX3gs+GMKHM6n8k9HS5ec9QazhkQ=;
        b=vgMI/bVcyfo4QN5r9DUXt+3YO4ke2S3e1YM+fYZlKRCJD5OqSGRN9Ka4f9U3ki5JzI
         unCYW3IJxDypNTV9z6ZF0lDrTknqK+td1nypw5dJtV6fj13bjIce7ROE7dYsJ9sodui7
         nPnTfn6PvR9Kp3CaDg0tQZpN7lcwL6zrkQAa9Lp+wR0L006SkGN1trnG+P8Fzy2DJtp/
         Whpcl47740H5ewbI7U6d3mXviguWXUJB6YTlhgnnmS3YMOhAct1AH4bpg7IjYABusEpq
         yAh8uSzRpdju8nxTgbxTZXAWgxgJ9WZht5h87Yf3yjaX96+l1//MR2S9kzZ+FL9VNcjX
         PYAQ==
X-Gm-Message-State: AOAM533CHncofBQB/D5bNSEv5XbVoOQXBWXz5G/O5CmyTVPg7c25wubF
        CzPulHeYHVXnuKIDTyqSZ96mp8LOi7kCfLr4WWoKi7ImUAAtzjup
X-Google-Smtp-Source: ABdhPJxpdw5CCv/loHvG7s1pzxNcodNXBpHnXhebUNIOryrEMQvDBjJDpMmfo1A9d6+DmZAhblqOGqH+s+Bk8259Bzo=
X-Received: by 2002:a05:6902:91e:b0:621:b123:de46 with SMTP id
 bu30-20020a056902091e00b00621b123de46mr5674977ybb.76.1645156166864; Thu, 17
 Feb 2022 19:49:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTdiPNkV1_b478_LkG11TMOPEdDGHTjf5LfZJpwWrK+bg@mail.gmail.com>
 <CAJCQCtTNk25u6sm_Xqt8qzf7mM5kmOrnXyD6pT1GKJ5z5-Kqbw@mail.gmail.com>
 <CAJCQCtRYKbTQ16eUq2qODZ=dE=HB6pZpLNswdqMbiWw+DBE9KQ@mail.gmail.com>
 <CABBYNZKfy-ntFhbx0TStNwFiwxCF4sPVaHS4wDbef0shb=pawg@mail.gmail.com>
 <CAJCQCtRiTQ1BTEHugxhS-zmXFG4qi4WLxsRyZsG9-_Q0isM+7Q@mail.gmail.com>
 <CAJCQCtS35JeABLDBaNpfgxjq+ZJ9rZgwtRnSYLNm8tMwtdYGMw@mail.gmail.com> <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
In-Reply-To: <CABBYNZKTSe83iP4tm36we4cpAbeGUbEw9frZD1wCM9yo1zry5w@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 17 Feb 2022 20:49:11 -0700
Message-ID: <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Feb 17, 2022 at 5:15 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Chris,
>
> On Thu, Feb 17, 2022 at 3:36 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > OK I started over, and for now keeping the reporting constrained to
> > the hardware I personally have on hand.
> >
> > Hardware:
> > Lenovo Thinkpad X1 Carbon Gen 7
> > Bus 001 Device 004: ID 8087:0aaa Intel Corp. Bluetooth 9460/9560
> > Jefferson Peak (JfP)
> > Sony 1000XM3 headset
> > bluez-5.63-3.fc36.x86_64
> >
> > kernel 5.17.0-rc4
> > * remove the paired headset with bluetoothctl
> > * reset the headset so it's not longer paired either
> > * put the headset in pairing mode
> > * GNOME Settings Bluetooth panel sees -> LE_WH-1000XM3, Not Setup
> > * click on Not Setup and nothing happens
>
> Well from the logs it doesn't seem the GNOME Setting is trying to do
> anything, have you tried bluetoothctl> connect <address>

`bluetoothctl scan on`  does see the device
$ bluetoothctl pair 38:18:4C:24:2D:1D
Device 38:18:4C:24:2D:1D not available
$ bluetoothctl connect 38:18:4C:24:2D:1D
Device 38:18:4C:24:2D:1D not available

$ journalctl -b -o short-monotonic --no-hostname | grep -i blue
https://drive.google.com/file/d/1x9EDvDx6XUowyRy2056n6uW-4PLx5KRb/view?usp=sharing



--
Chris Murphy
