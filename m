Return-Path: <SRS0=vsJv=6G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44929C55185
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A11D21473
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Apr 2020 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=belchamber.com header.i=@belchamber.com header.b="cOWMb9uG";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="bDi3B1/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDVSWK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:22:10 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:35922
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726412AbgDVSWK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Apr 2020 14:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6rp4w2husmdhljsd36xpa6qg7i74gvwa; d=belchamber.com; t=1587579728;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type;
        bh=YWkQSnhh26aKnsSU32ykFoK16FB6iB6/L6EMP3JxaM4=;
        b=cOWMb9uGkS8eguRF1Nf6l2hcafXjIp2D3I2M437RgwQ3mrYapTN/oxAVIuZpx2C1
        fjA+t/Y4TQ9bpiR0ZQvNzCJFEHPiiCoaBxfCWezwQGXFqpIMXHmUf91kUpRaFSM7G8D
        v/QfAUOLFPzThWoppe4ZfApf0CeJtAafOyt59X8w=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1587579728;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:Feedback-ID;
        bh=YWkQSnhh26aKnsSU32ykFoK16FB6iB6/L6EMP3JxaM4=;
        b=bDi3B1/HjN+9BRFg9wqfIFTGU2f/9+yr3pqbYsPwOrRXDOr5pCwm1NMw4DDie/uv
        Vl/RI2tPbAeYDHoF1Z1T4Gp2RSqnsSpOpH/0Y8zaGAyDnISaXKP4hB3jrh23Ywuzf9Q
        HJqf0XhYXLlP0FFdbrNQjan9TReusvZd41DPVm+k=
X-Gm-Message-State: AGi0PuZTzJvF+0ReUIXYb89QCA6HI/PCccyf564BO47BsUt6ztaRLy+m
        qRq1HfrtTB0xSLBIRZhTVAaN9rWYU/5pDuNVjMc=
X-Google-Smtp-Source: APiQypLPCP/x7Q9jwNdVGYWBv4/92y3we0+D7WIg6WArZg4L+oeQmjU1ysN7VPFWbNPh10k9ywLUdnSGL/W1Mku+Qco=
X-Received: by 2002:a5e:d516:: with SMTP id e22mr26088037iom.183.1587579726464;
 Wed, 22 Apr 2020 11:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <010201715012e482-bca51111-db3c-4101-9bd4-208b69a0ff03-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201715012e482-bca51111-db3c-4101-9bd4-208b69a0ff03-000000@eu-west-1.amazonses.com>
From:   James Belchamber <james@belchamber.com>
Date:   Wed, 22 Apr 2020 18:22:08 +0000
X-Gmail-Original-Message-ID: <CADQov_gh0qax9zH8Yf7giztNcq0ArVoDVjcYod5DapYcKxgbKA@mail.gmail.com>
Message-ID: <01020171a3203016-7d1d5c39-46ee-4ba9-8ff3-a6928a329d2a-000000@eu-west-1.amazonses.com>
Subject: Re: Setup Synchronous Connection fails when switching Sony WH-H900N
 headset to HSP
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-SES-Outgoing: 2020.04.22-54.240.7.18
Feedback-ID: 1.eu-west-1.iLkSOx0ll0H29nNg//Fx25T4fmIhOvUmYvVubjmmX6g=:AmazonSES
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Just bumping this for visibility, still an issue with the latest kernel.

Happy to test anything thrown my way.

On Mon, 6 Apr 2020 at 16:19, James Belchamber <james@belchamber.com> wrote:
>
> When using my Sony WH-H900N headphones and switching from A2DP to
> HSP/HFP the following error appears in journalctl:
>
> (  60.063|   0.000) D: [pulseaudio] module-bluez5-device.c: Acquiring
> transport /org/bluez/hci0/dev_04_5D_4B_E9_C9_90/fd34
> (  60.063|   0.000) I: [pulseaudio] backend-native.c: doing connect
> (  60.174|   0.111) E: [pulseaudio] backend-native.c: connect():
> Function not implemented
>
> And using btmon I can see the HCI command comes back with a failure
> (full log attached):
>
> < HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
>         Handle: 67
>         Transmit bandwidth: 8000
>         Receive bandwidth: 8000
>         Max latency: 10
>         Setting: 0x0060
>           Input Coding: Linear
>           Input Data Format: 2's complement
>           Input Sample Size: 16-bit
>           # of bits padding at MSB: 0
>           Air Coding Format: CVSD
>         Retransmission effort: Optimize for power consumption (0x01)
>         Packet type: 0x0380
>           3-EV3 may not be used
>           2-EV5 may not be used
>           3-EV5 may not be used
> > HCI Event: Command Status (0x0f) plen 4
>       Setup Synchronous Connection (0x01|0x0028) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Max Slots Change (0x1b) plen 3
>         Handle: 67
>         Max slots: 1
> > HCI Event: Synchronous Connect Complete (0x2c) plen 17
>         Status: Unspecified Error (0x1f)
>         Handle: 67
>         Address: 04:5D:4B:E9:C9:90 (Sony Corporation)
>         Link type: eSCO (0x02)
>         Transmission interval: 0x00
>         Retransmission window: 0x00
>         RX packet length: 0
>         TX packet length: 0
>         Air mode: u-law log (0x00)
>
> This works on ChromeOS, which also uses a (modified) BlueZ stack -
> though I can't work out why :)
