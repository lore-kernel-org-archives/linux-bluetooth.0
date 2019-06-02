Return-Path: <SRS0=VdXi=UB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B028EC282DC
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jun 2019 16:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BB427983
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jun 2019 16:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2B4fnnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfFBQ6z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:58:55 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:50790 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfFBQ6y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jun 2019 12:58:54 -0400
Received: by mail-wm1-f42.google.com with SMTP id f204so4978971wme.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Jun 2019 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QKcuewIVEj06j/cE5HiRPVUPzrXftwmdzc6BWiwg2pQ=;
        b=j2B4fnnrP2pSYmnAhPL9yopFt7q+R24+NwuT2iWMZCEvaOTuQz6e2r4X/a+0NuS3o6
         EAItrTLelpmRpF6IIsJJgWDBhBzWHDrUxt37c9p16DI4nTFVrgzoO7u80uEIGAgj6MLC
         T8qYB2ABuzpvAve4Gwf9GcwK4oSYRW3scsz5n7+ex5ezuaV7oJWYDEyMiE7ELhS7rdns
         pylRUGDWNQB5sIDElwKLb/wKdiARQeFjhrKoi+tRf8mg5x9FYpcJM8C2OJ4KMYccJlAb
         kya7jWsPAq0BgY8aYUm8obZ73r3ywARTgSTd/3SzBE6oMfoSUUtrS2FgsJhMe+Q3j+GL
         d/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QKcuewIVEj06j/cE5HiRPVUPzrXftwmdzc6BWiwg2pQ=;
        b=dkb5cY5gSUkpuJIujbeZxHRF2LxRtA9RDN245c8/UqickX+AM2Hf0tmsXECI9JBmNA
         9EqqXBuGalCP73LrMeXpr6NU15NrYasiBjMvEWn/XYP+Igw1rUHlskK2hyUCXB3r5EXf
         P3Qg8GLeLhiuUGnRzy6EpcWtgzfiBmNymuQqXP9rycxo5Zi503zeublFU6M6195oZpN7
         tRD4zIuOz9h+JFQ/Csrec3/TBI9oZcn1sJtcvrCF2zVmKrbFd8V2jkV25D8DuUZSvVZp
         ghypkNzuvTl92hTd6WNTStpTD1qKBLH9XRQnLeO98C74wrQ69jtSeCQb83Vvgyckpnzq
         9gGg==
X-Gm-Message-State: APjAAAWKzyxYSsXJhonZk3Yb0V2fC1Y6Zf5W+o6xnrxYNcF/hVA4Gx/+
        0wtmyc0WJJwYlmrV5bW9+Po9ecNgL6I=
X-Google-Smtp-Source: APXvYqxqHN0pimZjenahd5+wboM03Xlt34MOT9PaimsXmc14/We33MlGYslnoQMQuwgsJF4Nn1Z5yw==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr1954052wmf.138.1559494732566;
        Sun, 02 Jun 2019 09:58:52 -0700 (PDT)
Received: from N14xZU (host86-156-195-117.range86-156.btcentralplus.com. [86.156.195.117])
        by smtp.gmail.com with ESMTPSA id y133sm7344550wmg.5.2019.06.02.09.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Jun 2019 09:58:51 -0700 (PDT)
Date:   Sun, 2 Jun 2019 17:58:49 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: Re: Different respones to BLE scan from a Peripheral device?
Message-ID: <20190602165844.GA3886@N14xZU>
References: <20190531122557.GA3176@griso>
 <CAO1O6sdSBPXR-h1sfzCF6zsAv-a5Bexd2s8X7wDQwrghrvuCEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO1O6sdSBPXR-h1sfzCF6zsAv-a5Bexd2s8X7wDQwrghrvuCEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, May 31, 2019 at 04:30:38PM +0200, Emil Lenngren wrote:
> Hi John,
> 
> Den fre 31 maj 2019 kl 14:27 skrev John Whitmore <arigead@gmail.com>:
> >
> > Hello all,
> >
> > I'm running on two identical embedded Linux Gateway devices, both on
> > Ubuntu 16.04 and Bluez 5.37. That's certainly an older version, but
> > it's part and parcel of that version of Ubuntu. I'm having an issue
> > where the two identical gateway devices are getting different
> > responses from a BLE scan, and can't figure out what would be the
> > cause. In both cases it's the same peripheral device, a TI CC2650
> > device. On one gateway I get a truncated response with just the MAC
> > address and in the other I get the MAC address plus the description
> > string "CC2650.."
> >
> > [bluepy.btle:37] Got: 'rsp=$scan\x1eaddr=b546C0E530068\x1etype=h1\x1erssi=h43\x1eflag=h0\x1ed=b020105030280AA06FF0D0003000011094343323635302053656E736F72546167051208002003020A00\n'
> >
> > [bluepy.btle:37] Got: 'rsp=$scan\x1eaddr=b546C0E530068\x1etype=h1\x1erssi=h28\x1eflag=h0\x1ed=b020105030280AA06FF0D00030000\n'
> >
> > I'm probably going to have to get a Bluetooth sniffer device to trace
> > this issue, but if anybody had any idea what this would be the case,
> > I'd love to hear.
> >
> > Perhaps even though the Gateways are running the same Hardware and
> > Software there might be a Hardware difference in the chipset used or
> > something. It's all I can think of. Hopefully get something to help
> > diagnose this issue.
> >
> > In those two messages there is a difference in RSS, is that signal
> > strength and could that be the issue? Have to open things up.
> >
> > Thanks in advance for any help, and apologies I'm at the wrong end of
> > a learning curve.
> >
> > John
> 
> You could try running btmon in a terminal to show the HCI traffic.
> There you should see the raw advertising packets in form of LE
> Advertising Report packets. You should see both ADV_IND packets as
> well as SCAN_RSP packets. Maybe the software doesn't always combine
> them and that's why you get different results. And yes RSSI is signal
> strength.
> 
> /Emi

Thank you for that. I'll have a look into that and see if I can't get to the
bottom of this issue.
