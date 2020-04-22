Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0ACC54FCB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 22:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19ECB216FD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 22:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6juLiGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDVWcm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDVWcm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 18:32:42 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CD6C03C1A9
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 15:32:42 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i27so3680692ota.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2020 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSHNUuBnFaWAwblUgYiqdCllLGGOhNflc6Uq8xgnSh8=;
        b=f6juLiGpAJTaUhLbioe11DgbOcWpa8MIMI0WnOiC/QUhynfOZQrVwGdr6O3JTI70Sf
         guoQabXM/56GarRyO3/tqPqbBM5GLAFB4qJSEWjGc779l0srfCk4BIrynFUKsbxULAzW
         gMyiVnN4p0SCbN0KCCuXFkWX1/IMT6leldvqYX3DLXmK0Sn5T8BUgVyV7/Pp9d9yFaiT
         AZe4YN/uwALavFXeYKBO9ToDX/d1xS5gdM7IWN4/NvpZh7IYZdGoo1FAf9OTVX/1dADM
         DDw1ePq2HhDdbrTRjV3V4xpibxaVAMTweZd3EpcOFX+WVzy/XAf0KEE8nAy2Q5Eh13OI
         HwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSHNUuBnFaWAwblUgYiqdCllLGGOhNflc6Uq8xgnSh8=;
        b=BtLE0SchmXn9L5/kZGtmBJWaQCqvavMeOT0nDUtrJ+52tBmgCEQq6sF8+MX+1ubaDv
         9oM5sRGQRC/fWJSEUsC6FCbwxhpVX9qf2CdMznybzlIBOpcth5mBxxZiiuPQgETeL9P0
         CQOBsvEnyCSEwEsQozOZpSSUOtuLZCVU6CR/Tweta1gOvZl/Bvj5tZ6YO8w98DoYaI82
         So3zxfoPPBT4MvG5diPhzXX9EYNfIlX9pocgh8s0QBPSXrLGIqSgsZ07/R3MU2EOyvWH
         xERfI30TixaQMcl29jC7mCPOg/xROQCbdxK9h3zd2SqxQnkAjws4TSWId28dLy9vWBLQ
         BAuw==
X-Gm-Message-State: AGi0PuY6cuZMFZ6WF+bqBoRQGqfALAQbxWaLVgfK7awbhMqhjsLO4CfH
        JRNJF87fOZ4O79cXdaMYvEWkvWbhHbPayTSwQwk=
X-Google-Smtp-Source: APiQypL01T82svSvrsCILJcxK8sWu4jVZDVeUlXvywO/5mnpm+i25LWF/Ykfgaijz04DLr44qTl9fW0kTsz0LM6EpnY=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr1180324otn.79.1587594761401;
 Wed, 22 Apr 2020 15:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <010201715012e482-bca51111-db3c-4101-9bd4-208b69a0ff03-000000@eu-west-1.amazonses.com>
 <01020171a3203016-7d1d5c39-46ee-4ba9-8ff3-a6928a329d2a-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020171a3203016-7d1d5c39-46ee-4ba9-8ff3-a6928a329d2a-000000@eu-west-1.amazonses.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 22 Apr 2020 15:32:29 -0700
Message-ID: <CABBYNZJ2tn6Riz7uouxD0qa1M-dT7GbtUSkD-dbn1nj1B372iQ@mail.gmail.com>
Subject: Re: Setup Synchronous Connection fails when switching Sony WH-H900N
 headset to HSP
To:     James Belchamber <james@belchamber.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi James,

On Wed, Apr 22, 2020 at 11:27 AM James Belchamber <james@belchamber.com> wrote:
>
> Just bumping this for visibility, still an issue with the latest kernel.
>
> Happy to test anything thrown my way.
>
> On Mon, 6 Apr 2020 at 16:19, James Belchamber <james@belchamber.com> wrote:
> >
> > When using my Sony WH-H900N headphones and switching from A2DP to
> > HSP/HFP the following error appears in journalctl:
> >
> > (  60.063|   0.000) D: [pulseaudio] module-bluez5-device.c: Acquiring
> > transport /org/bluez/hci0/dev_04_5D_4B_E9_C9_90/fd34
> > (  60.063|   0.000) I: [pulseaudio] backend-native.c: doing connect
> > (  60.174|   0.111) E: [pulseaudio] backend-native.c: connect():
> > Function not implemented
> >
> > And using btmon I can see the HCI command comes back with a failure
> > (full log attached):
> >
> > < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
> >         Handle: 67
> >         Transmit bandwidth: 8000
> >         Receive bandwidth: 8000
> >         Max latency: 10
> >         Setting: 0x0060
> >           Input Coding: Linear
> >           Input Data Format: 2's complement
> >           Input Sample Size: 16-bit
> >           # of bits padding at MSB: 0
> >           Air Coding Format: CVSD
> >         Retransmission effort: Optimize for power consumption (0x01)
> >         Packet type: 0x0380
> >           3-EV3 may not be used
> >           2-EV5 may not be used
> >           3-EV5 may not be used
> > > HCI Event: Command Status (0x0f) plen 4
> >       Setup Synchronous Connection (0x01|0x0028) ncmd 1
> >         Status: Success (0x00)
> > > HCI Event: Max Slots Change (0x1b) plen 3
> >         Handle: 67
> >         Max slots: 1
> > > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> >         Status: Unspecified Error (0x1f)
> >         Handle: 67
> >         Address: 04:5D:4B:E9:C9:90 (Sony Corporation)
> >         Link type: eSCO (0x02)
> >         Transmission interval: 0x00
> >         Retransmission window: 0x00
> >         RX packet length: 0
> >         TX packet length: 0
> >         Air mode: u-law log (0x00)
> >
> > This works on ChromeOS, which also uses a (modified) BlueZ stack -
> > though I can't work out why :)

It doesn't look like it is a host problem and Ive never seem this
error before, have you tried with the same controller on Chrome OS? It
may be worth trying to capture the logs in Chrome OS so we can compare
if there is something different in the command parameters, but it
could as well be that Chrome uses HFP instead of HSP as PulseAudio
does and the headset is sensitive to that.

-- 
Luiz Augusto von Dentz
