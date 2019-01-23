Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96400C282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5072221855
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy3V4YQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfAWRE6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:04:58 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45320 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfAWRE5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 12:04:57 -0500
Received: by mail-ot1-f53.google.com with SMTP id 32so2511923ota.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 09:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtpStc2HzOSFNrYGh3xy1nosDA6e21PX2L+JGCF5xcg=;
        b=Iy3V4YQqIKxpksnA+rtxy3qBNP0xt7Fr7jUsdj19JNys7Hply82ngtgTZ/9OQiekHR
         5ALWUu1/JwSB/n5FeB0BdVsazDXZfPbBikv7B/NMvEBRp7YF8mfrnXOsgxPQQwOO5G1S
         HiYI+vzcOr+kRFkm7QE1LmMqiKclV62ZJoTjCXIukLgB51MTivu6MKk+mcEG/AF26/CP
         Uk7HtpEv73C/q2Eu9Pn5bfpN4dt6dxb6aCwkxK3Mv3TTul34ErFvJCs0z0Nako6OakLZ
         v+xbpvJYDpLhccVJu1edHbdU/XAwG22TxQYSrQtJ8wQuRavMCn1sF4P8kgg8Lv45Zp76
         pI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtpStc2HzOSFNrYGh3xy1nosDA6e21PX2L+JGCF5xcg=;
        b=hdwrnO/eyeuVlnBjQ+Qs2ysvUdpMts/hn50JZlUTmmgNYMRogtGl9B/S4ReaeOoryQ
         7TGVMnj9i5kFocaNhAPBUdvEiqPeWcUjL326KIv+digIrgB+qtBb0jU/DSDEzsD1fiCz
         WFAIRUCL/EfCI9h5qRP+wCm4Ek0g0qa/Cc131e0C3BhKQmZTg0knX8oWoJi2+0g0xXa1
         Zcsxj/QlJ7gCOvMjCc1MZls6X6X8sEIe658CqG6whProB2Ikr/oQvre5877jmyFAxb4J
         73Mnbg0fWSrLGYWd5ueCTqYn0D5Ipp+l+eFSuYf7IsSp33WpHwVsUqQmQ2/LKKWcMnnn
         xLYQ==
X-Gm-Message-State: AJcUukeYjV71ogM5udcRXCB/GmyN9xSeSUmAvbxS4vTgaYmh2MVf04lA
        cdEJZR/mQKCQ/J8wfs79+bnWPgDyFnW8IHM9ZVQ=
X-Google-Smtp-Source: ALg8bN587SpXbjXJgp79QuBmi0F96b2RolB0iSd2o0z/x9iE/Nreps5vPRgP38DlaDYc/LQEn7NB6+lsYNvNZiRmgrc=
X-Received: by 2002:a9d:3426:: with SMTP id v35mr2112386otb.71.1548263096790;
 Wed, 23 Jan 2019 09:04:56 -0800 (PST)
MIME-Version: 1.0
References: <CAAOqupyyrt4_3=1-8rHVoWFAKLX=adE3PopwTfczUCga=4k7gg@mail.gmail.com>
In-Reply-To: <CAAOqupyyrt4_3=1-8rHVoWFAKLX=adE3PopwTfczUCga=4k7gg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Jan 2019 19:04:44 +0200
Message-ID: <CABBYNZ+8Lkf5_f+CwXorUQhtON1hJ-Vyj0cd0QHPHGvUgq3m_A@mail.gmail.com>
Subject: Re: Battery level of energy
To:     Grigory Fateyev <gfborn@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Grigory,
On Wed, Jan 23, 2019 at 6:22 PM Grigory Fateyev <gfborn@gmail.com> wrote:
>
> Hello!
>
> I have a bluetooth headset Sony MDR-XB650BT.
>
> # hcitool info 00:18:09:C5:44:1E
> Requesting information ...
> BD Address:  00:18:09:C5:44:1E
> OUI Company: CRESYN (00-18-09)
> Device Name: MDR-XB650BT
> LMP Version: 4.0 (0x6) LMP Subversion: 0x2576
> Manufacturer: Cambridge Silicon Radio (10)
> Features page 0: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
> <3-slot packets> <5-slot packets> <encryption> <slot offset>
> <timing accuracy> <role switch> <hold mode> <sniff mode>
> <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
> <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
> <power control> <transparent SCO> <broadcast encrypt>
> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
> <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
> <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
> <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
> <sniff subrating> <pause encryption> <AFH cap. master>
> <AFH class. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps>
> <3-slot EDR eSCO> <extended inquiry> <simple pairing>
> <encapsulated PDU> <non-flush flag> <LSTO> <inquiry TX power>
> <EPC> <extended features>
> Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>
> I'd like to get the energy level at least in shell. In which direction
> I should look for? How to know if my device has GATT support? If it
> connected with Android smartphone, where Android version is < 6.0, it
> has an icon with level in percents. I want to get the same on my linux
> machine.

bluetoothd should be able to detect if there is a battery service,
well at least if you are connect over LE, note that in past there
exists ways to fetch the battery level of AVRCP and HFP via AT
commands, so perhaps Android is using one of those, btw you should be
able to see what bluetoothd has discover with:

bluetoothctl> info <bdaddr>

> Thank you!
>
> --
> Grigory



-- 
Luiz Augusto von Dentz
