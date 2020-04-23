Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D89C55186
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 11:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2FE20857
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 11:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=belchamber.com header.i=@belchamber.com header.b="AnftHPq9";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="r8Fic0Tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgDWLG1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:06:27 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:40124
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbgDWLG1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 07:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6rp4w2husmdhljsd36xpa6qg7i74gvwa; d=belchamber.com; t=1587639983;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        bh=8S+rr6+VCtO86NiWdAu9R+szMneTBAP+ltocy0LNmv4=;
        b=AnftHPq9hrZItn0sGXyD+mTVHpAwzVgMhFYYhX2C6YnwSQS6iP/DH+sM6Z9PannT
        P7Z7c4RchbyZRYtV0DNzOeL3cBEtRRvYZjSWVXTleAttuICQ18b3BGfJeb5h5csI99i
        hWY/MNKy+YhtKsI7a4fFlBxWcLKuTHIneCyJzxP4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1587639983;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Feedback-ID;
        bh=8S+rr6+VCtO86NiWdAu9R+szMneTBAP+ltocy0LNmv4=;
        b=r8Fic0TxbBV5HyJjYvBKTgWsL+vQUYvrTv0a51LcHdM8v8FTKMBR7qgAnqLhbytm
        s9iV+H8mrr7CP/rD0ibiJz8qai9mKE4Vgx/mDuuo22uFCA8oNxnvsUL4ZQwLfkOg0TF
        x9fQbbaNsNtpHtge/DIdstE0wUkwvZ80fGysjLVI=
X-Gm-Message-State: AGi0PuaBwf4nK+UJMk3vs9zbK2Ri3XNIcQ1VASP1CHWKOYoSTMwY6ztm
        Qcs5I1MaS7J7e9ko4LycKkgxQvNKOeZc7Wf9wyg=
X-Google-Smtp-Source: APiQypK+06aQGBStphr8dnzZq4eAZtMHZ+R1nH4iWSyMTcphvZs6EkoDfB8nq1uT/9jY3Z6zEsLdQUMoi7Z/W1dJYpI=
X-Received: by 2002:a02:c9cb:: with SMTP id c11mr2497041jap.93.1587639981036;
 Thu, 23 Apr 2020 04:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <010201715012e482-bca51111-db3c-4101-9bd4-208b69a0ff03-000000@eu-west-1.amazonses.com>
 <01020171a3203016-7d1d5c39-46ee-4ba9-8ff3-a6928a329d2a-000000@eu-west-1.amazonses.com>
 <CABBYNZJ2tn6Riz7uouxD0qa1M-dT7GbtUSkD-dbn1nj1B372iQ@mail.gmail.com>
In-Reply-To: <CABBYNZJ2tn6Riz7uouxD0qa1M-dT7GbtUSkD-dbn1nj1B372iQ@mail.gmail.com>
From:   James Belchamber <james@belchamber.com>
Date:   Thu, 23 Apr 2020 11:06:22 +0000
X-Gmail-Original-Message-ID: <CADQov_imzyX1E-rDQsLWDuPkgz5G5xazyy_B10cc0nTteHKNEw@mail.gmail.com>
Message-ID: <01020171a6b79a5e-6f98b660-3a61-4542-b956-70276882f469-000000@eu-west-1.amazonses.com>
Subject: Re: Setup Synchronous Connection fails when switching Sony WH-H900N
 headset to HSP
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-SES-Outgoing: 2020.04.23-54.240.7.18
Feedback-ID: 1.eu-west-1.iLkSOx0ll0H29nNg//Fx25T4fmIhOvUmYvVubjmmX6g=:AmazonSES
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Only difference in the btmon output is the handle (256 instead of 67)
- otherwise it all looks the same and it connects first time.

What logs are useful? I have the Chromebook in developer mode and so I
can capture whatever you want (hopefully!)

On Wed, 22 Apr 2020 at 23:32, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi James,
>
> On Wed, Apr 22, 2020 at 11:27 AM James Belchamber <james@belchamber.com> wrote:
> >
> > Just bumping this for visibility, still an issue with the latest kernel.
> >
> > Happy to test anything thrown my way.
> >
> > On Mon, 6 Apr 2020 at 16:19, James Belchamber <james@belchamber.com> wrote:
> > >
> > > When using my Sony WH-H900N headphones and switching from A2DP to
> > > HSP/HFP the following error appears in journalctl:
> > >
> > > (  60.063|   0.000) D: [pulseaudio] module-bluez5-device.c: Acquiring
> > > transport /org/bluez/hci0/dev_04_5D_4B_E9_C9_90/fd34
> > > (  60.063|   0.000) I: [pulseaudio] backend-native.c: doing connect
> > > (  60.174|   0.111) E: [pulseaudio] backend-native.c: connect():
> > > Function not implemented
> > >
> > > And using btmon I can see the HCI command comes back with a failure
> > > (full log attached):
> > >
> > > < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
> > >         Handle: 67
> > >         Transmit bandwidth: 8000
> > >         Receive bandwidth: 8000
> > >         Max latency: 10
> > >         Setting: 0x0060
> > >           Input Coding: Linear
> > >           Input Data Format: 2's complement
> > >           Input Sample Size: 16-bit
> > >           # of bits padding at MSB: 0
> > >           Air Coding Format: CVSD
> > >         Retransmission effort: Optimize for power consumption (0x01)
> > >         Packet type: 0x0380
> > >           3-EV3 may not be used
> > >           2-EV5 may not be used
> > >           3-EV5 may not be used
> > > > HCI Event: Command Status (0x0f) plen 4
> > >       Setup Synchronous Connection (0x01|0x0028) ncmd 1
> > >         Status: Success (0x00)
> > > > HCI Event: Max Slots Change (0x1b) plen 3
> > >         Handle: 67
> > >         Max slots: 1
> > > > HCI Event: Synchronous Connect Complete (0x2c) plen 17
> > >         Status: Unspecified Error (0x1f)
> > >         Handle: 67
> > >         Address: 04:5D:4B:E9:C9:90 (Sony Corporation)
> > >         Link type: eSCO (0x02)
> > >         Transmission interval: 0x00
> > >         Retransmission window: 0x00
> > >         RX packet length: 0
> > >         TX packet length: 0
> > >         Air mode: u-law log (0x00)
> > >
> > > This works on ChromeOS, which also uses a (modified) BlueZ stack -
> > > though I can't work out why :)
>
> It doesn't look like it is a host problem and Ive never seem this
> error before, have you tried with the same controller on Chrome OS? It
> may be worth trying to capture the logs in Chrome OS so we can compare
> if there is something different in the command parameters, but it
> could as well be that Chrome uses HFP instead of HSP as PulseAudio
> does and the headset is sensitive to that.
>
> --
> Luiz Augusto von Dentz
