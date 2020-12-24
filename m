Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Dec 2020 09:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED6322288
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Dec 2020 09:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgLXJYM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Dec 2020 04:24:12 -0500
Received: from jax4mhob03.myregisteredsite.com ([64.69.218.83]:44182 "EHLO
        jax4mhob03.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbgLXJYM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Dec 2020 04:24:12 -0500
X-Greylist: delayed 149189 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Dec 2020 04:24:11 EST
Received: from mailpod.hostingplatform.com ([10.30.71.85])
        by jax4mhob03.registeredsite.com (8.14.4/8.14.4) with ESMTP id 0BO9NTXc010636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Dec 2020 04:23:29 -0500
Received: (qmail 56186 invoked by uid 0); 24 Dec 2020 09:23:29 -0000
X-TCPREMOTEIP: 65.41.18.216
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@65.41.18.216)
  by 0 with ESMTPA; 24 Dec 2020 09:23:29 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 2D0B815403CC;
        Thu, 24 Dec 2020 04:23:28 -0500 (EST)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lbIAtnjdurD6; Thu, 24 Dec 2020 04:23:22 -0500 (EST)
Received: from z230.lan (z230.lan [192.168.1.3])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 032D31540350;
        Thu, 24 Dec 2020 04:23:22 -0500 (EST)
Message-ID: <b4a13800dc869d85c9d5fba9c91483da954f286c.camel@ewol.com>
Subject: Re: mesh: call to Publish triggers apparent output loop in
 mesh/mesh-io-generic.c
From:   Steve Brown <sbrown@ewol.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>
Date:   Thu, 24 Dec 2020 04:23:21 -0500
In-Reply-To: <MW3PR11MB45394DC567668E8D0AD2081CE1DF0@MW3PR11MB4539.namprd11.prod.outlook.com>
References: <cf925daf120458a23798be054865d1e39068f7b5.camel@ewol.com>
         <MW3PR11MB45394DC567668E8D0AD2081CE1DF0@MW3PR11MB4539.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Tue, 2020-12-22 at 18:43 +0000, Gix, Brian wrote:
> Hi Steve, I will investigate on my RPI4
> 
> -----Original Message-----
> From: Steve Brown <sbrown@ewol.com> 
> Sent: Tuesday, December 22, 2020 7:57 AM
> To: linux-bluetooth@vger.kernel.org
> Subject: mesh: call to Publish triggers apparent output loop in
> mesh/mesh-io-generic.c
> 
> Publish functions as expected, but results in continuous, very heavy
> HCI traffic (~every .7ms per btmon log). I don't think it's my
> application as the problem persists after the application disconnects
> from dbus and exits.
> 
> The calls to LE Set Adv Param all fail. Prior to the Publish call, LE
> Set Param calls succeed. The only difference I can see is the failing
> ones have an interval of 50ms and the ones that succeed have 100ms. A
> successful one is appended.
> 
> I'm at current Bluez head (65231892cd). The platform is a rpi4. 
> 
> Below is a pretty normal looking meshd log, a btmon dump and some
> more
> normal looking dbus traffic.
> 
> Steve

I think I found my problem. My retransmit count was set to zero.

If the publish retransmit count is 0, mesh-io-generic.c:tx_to() repeats
the message indefinitely. However, 4.2.2.6 of the mesh profile spec
V1.0 seems to state that 0 means no retransmissions.

Steve


