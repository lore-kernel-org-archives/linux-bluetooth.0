Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F71C4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 16:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEFB20700
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 16:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CZrKgYnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDCQdG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:33:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45507 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCQdE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 12:33:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so8285112plb.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2019 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XB1Sdaf9/n2443fVFh0UcdLCA6K/ncc+pyUwOmdH/eI=;
        b=CZrKgYnVjYzOJ4nbAVNc00En+Zx+3ZEIn+qkicW7/91Y/UJt39LzGWMPaPPNAsuRX6
         qVRaHW8jYZkPJ/7pkWWMdijCMdYg7NBMMNOE+ednvxqzkGxT4yj+tsKXT90qFg59C9cK
         JMJEAKjGcx7j0MryHT3za4k8f5B/LYWgi5a7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XB1Sdaf9/n2443fVFh0UcdLCA6K/ncc+pyUwOmdH/eI=;
        b=dCHOAnV7EQNTwgCJgBbHFWgtGUyXYb/cSgFAgF4DWUFxOF3Lq4hvB0YL4pX3aJ0L9O
         27RotX+DpB5WfM2EtEvNYwFSf4msHAIqP76qirf6ABpS9mPJt240pb1Y3NbANX5UKVHL
         bSje/lsibRm/qiqN6NJaoYxIU7bU+n3dAebBDMJW8D01u4otldaGBilWWRdGsxb6lQ2k
         MuKQVogx4Su+aB2LPGI90ai4AKWBJn1tRpeXsIeheFgbOsCDnUcmgATpEzryyRB1UxLy
         KXhiczb93IhbvzUCk9v1IYyyTEZQlM0UhQ2KfVOZD+cPu1USgVzdCn/ssAOukujXzmOJ
         Mcvg==
X-Gm-Message-State: APjAAAVJxS+BO1rU/ojGgS4cjUHpTilQod67S3qwSZd+OeWPJpR/QryR
        L3SYxxERnHzbrWHJOuGlWVBozg==
X-Google-Smtp-Source: APXvYqym1a29P2MbfqotGnh/SpbmeIH18rjK6eyL41yp5z2M7ikpmrYutLaqkgLJ1Axza/PfmQNV1A==
X-Received: by 2002:a17:902:b407:: with SMTP id x7mr934082plr.288.1554309183748;
        Wed, 03 Apr 2019 09:33:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id i129sm12986077pfc.163.2019.04.03.09.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:33:03 -0700 (PDT)
Date:   Wed, 3 Apr 2019 09:33:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
Message-ID: <20190403163302.GO112750@google.com>
References: <20190307004041.38059-1-mka@chromium.org>
 <20190307004041.38059-3-mka@chromium.org>
 <ff905fac1e57bcca78c74f1bc3349645@codeaurora.org>
 <20190307182009.GB138592@google.com>
 <20190307233039.GA69116@google.com>
 <c985a6712f91930d7c710ca4abb42e80@codeaurora.org>
 <a03acbdc6bfad172fdd65f428ffbe4cf@codeaurora.org>
 <20190401171202.GH112750@google.com>
 <1bebaf0766988a9f27cbbcb9bb35e26f@codeaurora.org>
 <20190402180501.GK112750@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190402180501.GK112750@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Apr 02, 2019 at 11:05:01AM -0700, Matthias Kaehlcke wrote:
> On Tue, Apr 02, 2019 at 05:32:54PM +0530, Balakrishna Godavarthi wrote:
> > Hi Matthias,
> > 
> > On 2019-04-01 22:42, Matthias Kaehlcke wrote:
> > > On Mon, Apr 01, 2019 at 01:48:23PM +0530, Balakrishna Godavarthi wrote:
> > > > Hi Matthias,
> > > > 
> > > > On 2019-04-01 13:29, Balakrishna Godavarthi wrote:
> > > > > Hi Matthias,
> > > > >
> > > > > Sorry for the late reply i was on vacation.
> > > > >
> > > > > On 2019-03-08 05:00, Matthias Kaehlcke wrote:
> > > > > > On Thu, Mar 07, 2019 at 10:20:09AM -0800, Matthias Kaehlcke wrote:
> > > > > > > Hi Balakrishna,
> > > > > > >
> > > > > > > On Thu, Mar 07, 2019 at 10:35:08AM +0530, Balakrishna Godavarthi
> > > > > > > wrote:
> > > > > > > > hi Matthias,
> > > > > > > >
> > > > > > > > On 2019-03-07 06:10, Matthias Kaehlcke wrote:
> > > > > > > > > Firmware download to the WCN3990 often fails with a 'TLV response size
> > > > > > > > > mismatch' error:
> > > > > > > > >
> > > > > > > > > [  133.064659] Bluetooth: hci0: setting up wcn3990
> > > > > > > > > [  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
> > > > > > > > > [  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> > > > > > > > > [  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
> > > > > > > > > [  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)
> > > > > > > > >
> > > > > > > > > This is caused by a vendor event that corresponds to an earlier command
> > > > > > > > > to change the baudrate. The event is not processed in the context of the
> > > > > > > > > baudrate change and later interpreted as response to the firmware
> > > > > > > > > download command (which is also a vendor command), but the driver
> > > > > > > > > detects
> > > > > > > > > that the event doesn't have the expected amount of associated data.
> > > > > > > > >
> > > > > > > > > More details:
> > > > > > > > >
> > > > > > > > > For the WCN3990 the vendor command for a baudrate change isn't sent as
> > > > > > > > > synchronous HCI command, because the controller sends the corresponding
> > > > > > > > > vendor event with the new baudrate. The event is received and decoded
> > > > > > > > > after the baudrate change of the host port.
> > > > > > > > >
> > > > > > > > > Identify the 'unused' event when it is received and don't add it to
> > > > > > > > > the queue of RX frames.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > > > > > ---
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > Can you test by reverting this change "94d6671473924".
> > > > > > >
> > > > > > > The issue is still reproducible.
> > > > > > >
> > > > > > > > We need at least 15ms minimum delay for the soc to change its baud rate and
> > > > > > > > respond to the with command complete event.
> > > > > > >
> > > > > > > The baudrate change has clearly been successful when the problem is
> > > > > > > observed, since the host receives the vendor event with the new
> > > > > > > baudrate.
> > > > > >
> > > > > > I forgot to mention this earlier: the controller doesn't send a
> > > > > > command complete event for the command, or at least not a correct
> > > > > > one.
> > > > > >
> > > > > > That's the data that is received:
> > > > > >
> > > > > > 04 0e 04 01 00 00 00
> > > > > >             ~~ ~~
> > > > > >
> > > > > [Bala]: can you share me the command sent and event recevied.
> > > > >  I see that we receive a command complete event for the baud rate
> > > > > change command.
> > > > >
> > > > > command sent: 01 48 fc 01 11
> > > > > vendor specific event: 04 ff 02 92 01
> > > > > command complete event: 04 0e 04 01 00 00 00.
> > > > >
> > > > >
> > > > >
> > > > > > This is *a* command complete event, but the opcode is 0x0000 instead
> > > > > > of the earlier command. The same happens for the firmware
> > > > > > download/read version command, which is the reason why the command
> > > > > > complete injection mess
> > > > > > (https://lore.kernel.org/patchwork/patch/1027955/) is needed in one
> > > > > > way or another.
> > > > > >
> > > > > [Bala]: fw download approach is different where we use
> > > > > __hci_cmd_sync() where as here we use hci_uart_tx_wakeup()
> > > > >         which directly calls the hci_uart_write_work(). so even we
> > > > > send an valid opcode or not for baudrate change will bot matter.
> > > > >
> > > > [Bala]: i miss understood the comment. Yes your true. in the all
> > > > vendor
> > > > commands SoC responds with an 0x0000 opcode.
> > > 
> > > And IIUC this is not compliant with the spec, or at least the BT core
> > > expects the actual opcode to consider the command to be completed.
> > 
> > [Bala]: Did you try increasing the the baud rate change timeout to 50ms
> > instead of 10ms.
> 
> It is even reproducible with the ROME timeout of 300ms.
> 
> The timeout doesn't help here. With 78e8fa2972e5 ("Bluetooth: hci_qca:
> Deassert RTS while baudrate change command") RTS is deasserted during
> the baudrate change, hence the controller only sends the response when
> RTS is asserted again. Before the event resulted in a frame reassembly
> error and the data was discarded.
> 
> >         i suspect it is an timing issue.
> 
> Timing is certainly also a factor here (the problem isn't seen
> always), but I don't think 'timing issue' is a proper description of
> this issue. The problem is an event that the Bluetooth core doesn't
> expect due to the hack of sending a raw command behind the core's back
> to work around the firmware 'feature' of sending the command response
> with the new baudrate.
> 
> Maybe a delay after re-asserting RTS can address is reliably, I don't
> remember if I already experimented with that in the past. If a delay
> can 'fix' the issue reliably I'm open to consider it for the sake of
> simplicity, but only with a detailed comment that describes the
> problem.

A short delay after re-asserting RTS indeed seems to 'fix' this, the
problem didn't reproduce in 5000+ iterations of binding/unbinding the
HCI.

I'm fine with either solution, the delay is slightly less code, then
again this patch (or v2:
https://lore.kernel.org/patchwork/patch/1050247/) also isn't overly
complex. Just noticed though that my post of v2 is messed up and I
would have to re-send it with proper format.

Marcel, please let me know if you prefer an msleep + comment or
actively dropping the event.

Thanks

Matthias
