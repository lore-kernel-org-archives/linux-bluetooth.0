Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB3C4320A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AEA76108F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhHJQDk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhHJQDj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Aug 2021 12:03:39 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DB4C061799
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 09:03:17 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id v24-20020a0568300918b02904f3d10c9742so19208210ott.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Aug 2021 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UOeBJb5cGy5paFAALWsFuASdLzBG7EqmkQ93lI0oDjg=;
        b=xVCYLKEs/uDoz2qqKcRtH/cYFoZnbZtY9Tsrn8R8CS1Hqbg7ZL9bDIuxarRrVYwQdM
         +ngMyxnNwBX5TVXYeeqDFzZw5ddBYJoMQOIXjyVTSxf736jyFNzE1HxEiGx7gNTLMIw6
         p0om15jxaQbX7AdNnXcnl3wi1PpJK1xddiRfvez+TUVQLaNFawI5L/tHPNRHD731k4fm
         mw2fTJ2IlQGWmQqoEXwoaB3FD5jDfiQZy7itDo4NBJskHHgnEx4FFQ2r4owqxYvXRMNr
         pBRBpexnI1Uy68f9xSDEcijNmcw+Q1k1/GekGnKXWB+/aVSHzXzKiSi7za8l+9W4sba5
         VVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UOeBJb5cGy5paFAALWsFuASdLzBG7EqmkQ93lI0oDjg=;
        b=rHTOelqCgW0fSlte+LOi2HFRdP7A6dPBRenY9TShxd5wWyEqZ9vps2eJwQOKprI5e1
         JlaOnapx4/UAUHTN4RJoeiLMGmLjcYNyhDSKTbtTZ42UTOFRnlOGtUXiUHYih8YJ0kls
         gFYsxCy8wukPUqqVcfhKkjierOpyspDedhKG58yNDNUM60lo0qXnWBGY2ht3QZW87e3E
         cf0DMcN2AsZDFfbCsSY4WWpwtkkpTGumR+Wwg4hH//S/KVOeqbp5CNNtZBoR06i5oxfA
         bYGUPlVNXHYQ40Kbq3Fe23AJ05b/kynD/se6wF5f2VYrEDwoUq6rfaNW5vxz0THt4IMJ
         h5SQ==
X-Gm-Message-State: AOAM531LeGvhTK8JKxVP4LI95oEnc1EMGN8VuRUiQPyRG6U/sWPNR/QM
        0ZRtOO+qvJeSp+Y8MdoYDIp5BA==
X-Google-Smtp-Source: ABdhPJyb5luJDRgsrhvyVHotm5kjI3gsgDl7FNLBXBEL8BAgkYs1tlNbNSeNVUWUOeezbAkELGsIFg==
X-Received: by 2002:a05:6830:b84:: with SMTP id a4mr20805679otv.357.1628611396393;
        Tue, 10 Aug 2021 09:03:16 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e22sm3072636otq.5.2021.08.10.09.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 09:03:15 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:03:12 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/7] regulator: qca6390: add support for QCA639x
 powerup sequence
Message-ID: <YRKjQJc0yiQXFqCD@builder.lan>
References: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
 <20210621223141.1638189-3-dmitry.baryshkov@linaro.org>
 <CAPDyKFo6dmjw0TnaK7=35dq5Si_6YYpeeSa=gU++1od7WkQZ7A@mail.gmail.com>
 <20210706115517.GB4529@sirena.org.uk>
 <CAPDyKFr=8spZBD+bTe3SjS=nATL-ByFu_epnT2Z4chSuQNke2w@mail.gmail.com>
 <CAA8EJppSV--TBjnGxGhaTHeKWdpM6uz70bg7diU3_K7OHoka4g@mail.gmail.com>
 <20210714164710.GC2719790@robh.at.kernel.org>
 <CAPDyKFokvTFSpbnhhKeCmZzAjqvSpUiwz7QjjQNdcd3Sd3T0rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFokvTFSpbnhhKeCmZzAjqvSpUiwz7QjjQNdcd3Sd3T0rQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue 10 Aug 06:55 CDT 2021, Ulf Hansson wrote:

> On Wed, 14 Jul 2021 at 18:47, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Jul 08, 2021 at 02:37:44PM +0300, Dmitry Baryshkov wrote:
> > > Hi,
> > >
> > > On Thu, 8 Jul 2021 at 13:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > - Peter (the email was bouncing)
> > >
> > > + Peter's kernel.org address
> > >
> > > >
> > > > On Tue, 6 Jul 2021 at 13:55, Mark Brown <broonie@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jul 06, 2021 at 09:54:03AM +0200, Ulf Hansson wrote:
> > > > > > On Tue, 22 Jun 2021 at 00:32, Dmitry Baryshkov
> > > > >
> > > > > > > Qualcomm QCA6390/1 is a family of WiFi + Bluetooth SoCs, with BT part
> > > > > > > being controlled through the UART and WiFi being present on PCIe
> > > > > > > bus. Both blocks share common power sources. Add device driver handling
> > > > > > > power sequencing of QCA6390/1.
> > > > >
> > > > > > Power sequencing of discoverable buses have been discussed several
> > > > > > times before at LKML. The last attempt [1] I am aware of, was in 2017
> > > > > > from Peter Chen. I don't think there is a common solution, yet.
> > > > >
> > > > > This feels a bit different to the power sequencing problem - it's not
> > > > > exposing the individual inputs to the device but rather is a block that
> > > > > manages everything but needs a bit of a kick to get things going (I'd
> > > > > guess that with ACPI it'd be triggered via AML).  It's in the same space
> > > > > but it's not quite the same issue I think, something that can handle
> > > > > control of the individual resources might still struggle with this.
> > > >
> > > > Well, to me it looks very similar to those resouses we could manage
> > > > with the mmc pwrseq, for SDIO. It's also typically the same kind of
> > > > combo-chips that moved from supporting SDIO to PCIe, for improved
> > > > performance I guess. More importantly, the same constraint to
> > > > pre-power on the device is needed to allow it to be discovered/probed.
> > >
> > > In our case we'd definitely use pwrseq for PCIe bus and we can also
> > > benefit from using pwrseq for serdev and for platform busses also (for
> > > the same story of WiFi+BT chips).
> > >
> > > I can take a look at rewriting pwrseq code to also handle the PCIe
> > > bus. Rewriting it to be a generic lib seems like an easy task,
> > > plugging it into PCIe code would be more fun.
> > >
> > > Platform and serdev... Definitely even more fun.
> >
> > I don't want to see pwrseq (the binding) expanded to other buses. If
> > that was the answer, we wouldn't be having this discussion. It was a
> > mistake for MMC IMO.
> 
> Let's make sure we get your point correctly. I think we have discussed
> this in the past, but let's refresh our memories.
> 
> If I recall correctly, you are against the mmc pwrseq DT bindings
> because we are using a separate pwrseq OF node, that we point to via a
> "mmc-pwrseq" property that contains a phandle from the mmc controller
> device node. Is that correct?
> 
> If we would have encoded the power sequence specific properties, from
> within a child node for the mmc controller node, that would have been
> okay for you, right?
> 

In Dmitry's case, we have an external chip with that needs to be powered
on per a specific sequence, at which point the WiFi driver on PCIe and
BT driver on serdev will be able to communicate with the device.

The extended case of this is where we have an SDX55 modem soldered onto
the pcb next to the SoC, in which case the power sequencing is even more
complex and additionally there are incoming gpios used to detect things
such as the firmware of the modem has crashed and Linux needs to toggle
power and rescan the PCIe bus.

In both of these cases it seems quite reasonable to represent that
external chip (and it's power needs) as a separate DT node. But we need
a way to link the functional devices to that thing.

Regards,
Bjorn

> >
> > If pwrseq works as a kernel library/api, then I have no issue with that.
> 
> That's what Peter Chen was trying to do. A generic interface, flexible
> enough so it can be used for many similar configurations (but not
> exactly the same).
> 
> Perhaps it was too generic though.
> 
> >
> > >
> > > > Therefore, I think it would be worth having a common solution for
> > > > this, rather than a solution per subsystem or even worse, per device.
> >
> > Power sequencing requirements are inheritently per device unless we're
> > talking about standard connectors.
> 
> The requirements are certainly per device, but the way to manage them
> doesn't have to be.
> 
> As you said above, a generic library that subsystems/drivers can call
> to power on/off a discoverable device, before trying to probe it would
> be a good start.
> 
> >
> > This is a solved problem on MDIO. It's quite simple. If there's a DT
> > node for a device you haven't discovered, then probe it anyways.
> 
> A child OF node?
> 
> Then what do you think about some common power sequence properties
> that we can use in such node?
> 
> >
> > Rob
> 
> Kind regards
> Uffe
