Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC69FC0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 20:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AFC21721
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 20:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="G9H3Ri65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGAUA3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:00:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38744 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUA3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 16:00:29 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so14496195ljg.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2019 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9UU94f82JSzX3YHKOwlgRBln+7Hg6rn7BOoVRDULvnk=;
        b=G9H3Ri65HkNRr09Mnj0ZISNCtr87Xy/IcIM+0H0aTQTPQJKj9aBsaOVdPG1CkjtPBM
         SeED3ckerUd3VYxgvdGzJUdFzI6B8muZqF6V3H1Pl+DVisehhuIo2zshm/YGei+ipWoh
         7CVtQP56/LCEzganaDUnI6cFHMAABfqoOgySsCSMfGmdF6wGUNa+rW64uGWiBreUvFzm
         Elq3YJUvajnVNcCEdi99Dhj8NnbvOihWX1QqWs1U5YMqM1Ztfa+LdU2WU490pWAF3nNB
         2dHCW4FDBhuwkpJXby5EVDJN0rFTzaeA6aglX7FCwFvyBvxKhNCLRDJmfobQ/OLPSC3Y
         KLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9UU94f82JSzX3YHKOwlgRBln+7Hg6rn7BOoVRDULvnk=;
        b=CcLM8/i/HgO1w4w7o1FHYdCvjMrFqSpaw2vVSqQQ9MwndawkGAP5N1xRwN8JPogMIx
         q3wxr2H6fdns+PCY83+vXfY0FkjfjijdZHZt5ZjnIBohCmR3/+v9OazfkdjT/ftqpYkt
         awyOIupLarzKxt2NXMgBxYSyhA5AevB24BFduRaOWBdVU2kWjLwMI5PEunJ5CRbBHezb
         0VUEnzsTjqlDpp4plVmqOaJ7zdl9weS2bi40fp55/jTcPLQczH2jsfWb3xQ/w/xigV5L
         GLtKPtg5JJJKpFH/QtiGykp/5+B/k22gjtrIhN1YjMkmGkz0U5X90IdQ26G3jyY/d+rC
         su7A==
X-Gm-Message-State: APjAAAXuhvmx2J1KNBvfktdBLBWb0UcHSEK7rylLbcKUMg3Lwg0RtyGL
        qkhB1Cv0DlQAXhDP9vLVOGfnyPnhshg=
X-Google-Smtp-Source: APXvYqwmEr3slAW6OCXX8g2loZEGk5c4m/mzn2+cGnD4wsyQrO2lRkn9Lm59T5lNZHpVNaMXuiyriw==
X-Received: by 2002:a2e:9a96:: with SMTP id p22mr14916458lji.57.1562011227367;
        Mon, 01 Jul 2019 13:00:27 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id x19sm3389284ljb.6.2019.07.01.13.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 13:00:26 -0700 (PDT)
Date:   Mon, 1 Jul 2019 22:00:24 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 2/3] mesh: Add DevKeySend call
Message-ID: <20190701200024.btxrfm2ndanzx7tm@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
 <20190628125205.21411-3-michal.lowas-rzechonek@silvair.com>
 <20190628132932.bhcvcx4tzlfkertu@mlowasrzechonek2133>
 <1561732393.7802.50.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561732393.7802.50.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 06/28, Gix, Brian wrote:
> Unlike App Keys, Device keys do not have a bound Net Key...  They can
> be sent on *any* network key.  So while sending a message on a
> specific App index implies the Net Key to use, the Dev Key send does
> not, and so needs it to be explicit.

After digging through the code, I've noticed that at the moment
bluetooth-meshd doesn't really support sending messages using
non-primary network key - this is because of internal API limitations
(see the TODO next to send_seg function in net.c).

Would it be OK for me to start implementing SendDevKey API in a way that
always uses the primary subnet, like it's currently done with
application keys? The same applies to calling DevKeyMessageReceived() on
the application side.

I am aware that a node is supposed to respond using the same subnet that
a request was sent through, but it's not that simple to implement in one
shot...

I'd very much like to add subnet support as well, but such a patch would
be much, much larger - I think I would need to modify internal APIs to
use mesh_subnet struct instead of mesh_net, and do it in many, many
places.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
