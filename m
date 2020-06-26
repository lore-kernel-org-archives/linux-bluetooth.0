Return-Path: <SRS0=vuCz=AH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ACCC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 17:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89206206DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 17:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFZRd4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:33:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:61151 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbgFZRdz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jun 2020 13:33:55 -0400
IronPort-SDR: bBDyGK6TzE3RUJZq0VzzO8sGkqTlzLdmwSuF0WRQlgSJB6o2f1J81UnDKKV+RUfyMTwt/xKiSp
 TBBZIELIjgRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="132827650"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="132827650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 10:33:54 -0700
IronPort-SDR: DIRoWrO4YMjg2CWLSXiCTe+BZJiLpQdwwHrEHYHOdpGerbyhii+oTPkuzUOeun6w9zV2Un3nDe
 79Y4xDqQZWzg==
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="480070565"
Received: from han1-mobl3.jf.intel.com ([10.254.109.237])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 10:33:54 -0700
Message-ID: <01396c1298c1d34127aa6a164f59adc15aa3b7af.camel@linux.intel.com>
Subject: Re: [BlueZ PATCH V2] btp: Update connect event structure
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Linux Bluetooth Mailing List <linux-bluetooth@vger.kernel.org>
Date:   Fri, 26 Jun 2020 10:33:53 -0700
In-Reply-To: <CABBYNZJ34-f3_2vZStRaghc8jn9YPPc+Av93bBOuU1Jek7Fprg@mail.gmail.com>
References: <37bbc9912da0efcf5e7afd252eba90309f53c79a.camel@linux.intel.com>
         <CABBYNZJ34-f3_2vZStRaghc8jn9YPPc+Av93bBOuU1Jek7Fprg@mail.gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

On Fri, 2020-06-26 at 09:58 -0700, Luiz Augusto von Dentz wrote:
> Hi Tedd,
> 
> On Thu, Jun 25, 2020 at 5:10 PM Tedd Ho-Jeong An
> <tedd.an@linux.intel.com> wrote:
> > From: Tedd Ho-Jeong An <tedd.an@intel.com>
> > 
> > This patch updates the connect event struct to align withe the btp spec.
> > 
> >  Opcode 0x82 - Device Connected event
> >     Controller Index:   <controller id>
> >     Event parameters:   Address_Type (1 octet)
> >                         Address (6 octets)
> >                         Connection Interval (2 octets)
> >                         Connection Latency (2 octets)
> >                         Supervision Timeout (2 octets)
> > ---
> >  src/shared/btp.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/src/shared/btp.h b/src/shared/btp.h
> > index f0ac3a1ee..cc71a71df 100644
> > --- a/src/shared/btp.h
> > +++ b/src/shared/btp.h
> > @@ -259,6 +259,9 @@ struct btp_device_found_ev {
> >  struct btp_gap_device_connected_ev {
> >         uint8_t address_type;
> >         bdaddr_t address;
> > +       uint16_t connection_interval;
> > +       uint16_t connection_latency;
> > +       uint16_t supervision_timeout;
> >  } __packed;
> 
> This appears to be an API break, or we don't for BTP to be stable?

It was old change and this patch was to align the change for BlueZ.
All other projects using BTP such as Zephyr and Mynewt are already using new
change.

> 
> >  #define BTP_EV_GAP_DEVICE_DISCONNECTED         0x83
> > --
> > 2.17.1
> > 
> > 
> 
> 

