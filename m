Return-Path: <SRS0=fj53=SU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423BFC10F0E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 09:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F092083D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Apr 2019 09:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="g2s5Ufop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbfDRJ1p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:27:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45400 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbfDRJ1p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Apr 2019 05:27:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id y6so1292701ljd.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2019 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+tuwLp97/GP0eIPAIM4DCvDskyAZBE44W/jVU7ovMF0=;
        b=g2s5Ufop6HEDXXV5/eh7h4b9dXeSDtMUTpm1Fr2Lnh/WB8iVNRaBBIB0zRlLycfplc
         AWL1lz8n1AROU+o6vACZGaOwwdjQO+gLHZcIC5BYzE/oJf5ttSwJUVqSih4Bb13n7TD8
         4e9gHM7JNQS2iALvq2r7efyT4MCqHmnGB+xFB6zhTwtctWedCgdU1VL3KsmDiWvlcxmz
         7MfMmWBOFmHKoT1njKCAfNwq0TugC2ec0J8n+bAjPRNsud+at1mKNL8n5ZzhwFn6u1dL
         z1XoZbE/ST3/+IPfF3+d6IOM/8oRw/UgascwkP5h/tV+G8iTdmAyIaJtbZb9uEsQ3voL
         8RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+tuwLp97/GP0eIPAIM4DCvDskyAZBE44W/jVU7ovMF0=;
        b=rveyfteJc46wfyMYuns3K/2sF8ih0nnPzwk2RiQK3i4UREDUsZOUM41UT9uBvTgLvJ
         h5v11kC0qFoB8KAGzVVFbPcFJdxdWbV58p82T1CYWEhqKol8EvQL1lU4LPJksUYCC2LT
         zFLoMnCyH7gMP9wUv1NFJhX69h4OodCWzh71EiOmIW6WlCgTxgIg2GTGtXCGYgvIlb1+
         f4CJTAp9m00Y5nA13enPfAm6rygHl8zGndCqjhgNS10OqrTx3unhlUWcoHwvgG6yeoR+
         H0QbFJVkHbuogHAOds/DojLhutkL+tn3CSZCFT2b07tHaOpvu0kZ4IOhdVM0sOlY0Za/
         yuog==
X-Gm-Message-State: APjAAAWqh8XErE3f5mXmM5HuvQgGbiVQEfIKUZAR8fbKbsa5P8vN0tPP
        3bj09SsU5WaBz7yvW8CYqro0FA==
X-Google-Smtp-Source: APXvYqwC7tmqJ9i6hkIrQT6lC+Pk2YIGwOD8vxe5/EKaiQ9LdbT31dUSEzmrP0R/fNRlvo489STRhw==
X-Received: by 2002:a2e:500d:: with SMTP id e13mr53331338ljb.169.1555579662136;
        Thu, 18 Apr 2019 02:27:42 -0700 (PDT)
Received: from scytale ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t29sm292903ljd.82.2019.04.18.02.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 02:27:41 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:27:38 +0200
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ v5 1/1] mesh: Add APIs for Provisioner and Config
 Client
Message-ID: <20190418092738.wdohlkvcej5ffw5x@scytale>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
References: <20190415194946.13121-1-brian.gix@intel.com>
 <20190415194946.13121-2-brian.gix@intel.com>
 <20190417055132.scxvzhusx2suasdv@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4376CAFE9DF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CAFE9DF@ORSMSX103.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 04/17, Gix, Brian wrote:
> > Not sure what are the size constraints (if any), but I think it might be better
> > to pass the JSON as a string.
> Indeed, this has been discussed internally as well, and is still
> subject to the change you mention. We are still wait8ing for input
> from all stakeholders, and your preference is noted.
Ok, thanks.

> > > +	void AddNetKey
> > > +	void AddAppKey
> >
> > If I understand correctly, these are convenience functions for
> > SendWithDeviceKey, so that the application wouldn't need to construct
> > access payloads for configuration messages?
> > 
> > If so, I guess we will need more functions like that, ideally to cover all
> > messages mentioned in section 4.3.4 of the mesh profile?
> 
> These two functions are explicitly separated out from the rest of the
> section 4.3.4 messages in order to keep the security of the keys in
> the hands of the daemon.
Ok, understood.

> The messages where keys are explicitly sent over-the-air are the only
> messages we anticipate providing specific D-Bus methods for to
> minimize D-Bus API bloat.
> (...)
> The external Config Client App is responsible for:
> * deciding *when* to send App and Net key adds and updates
> * sending all pub/sub/binding/feature settings
>
> so in this case, the controlling Config Client App will be composing
> all Config Client messages (except for OTA key messages)
So if I understand correctly, to add a new application key one would
need to either:
 - call CreateAppKey to have the daemon generate a new application key
   internally.
 - manually create access layer payload for Config Client App Key Add
   message, then send it to the local node via loopack

After one of these operations, the key can be sent to remote nodes using
AddAppKey API.

This seems a bit assymetric: the application that would like to act as a
Config Client would need to use a mixture of manually constructed
access payloads (e.g. to configure binds and subscriptions) and a
higher-level APIs used to add keys.

I think it would be cleaner to have the application use just the API,
and relieve it of requirement to implement Config Client messages,
especially given the fact the daemon implements Config Server internally.

This would indeed make the API surface larger, which certainly is a
drawback, but I think it would make it easier to implement actual
applications, because foundation (and *only* foundation) models (both
servers and clients) would be provided by the daemon.


Another point would be adding explicit ImportNetKey and ImportAppKey
operations, so that an application using external provisioning database
would be able to inject keys into the daemon's database without sending
raw Config Client messages. This is similar to Import*Node operations we
discussed before.

> >  - SendApplicationMessage + ApplicationMessageReceived
> >  - SendDeviceMessage + DeviceMessageReceived
> 
> That seems reasonable. We will rework for naming consistency.
Thank you.

> >  - SendControlMessage + ControlMessageReceived (but I don't see a need
> >    to expose this to application, at least not at the moment)
> I am not sure there are *any* control messages that I would expose to
> any of the Apps.  Certainly none of the existing set of control
> messages, and I worry that exposing the Control interface would be
> seen as an invitation for "Vendor Usage" which could be difficult to
> back out later.
Fully agreed. I mentioned these only for completeness.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
