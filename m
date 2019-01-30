Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49943C282D5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F072087F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 08:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfA3IPU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:15:20 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:50798 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfA3IPU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 03:15:20 -0500
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id EE0DD2014D;
        Wed, 30 Jan 2019 10:15:17 +0200 (EET)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id E813D36C0F6; Wed, 30 Jan 2019 10:15:17 +0200 (EET)
Date:   Wed, 30 Jan 2019 10:15:17 +0200
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20190130081517.GI32745@reaktio.net>
References: <20190123174504.12350-1-pali.rohar@gmail.com>
 <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
 <20190123175448.cdkdpnk6i5r4rzjs@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190123175448.cdkdpnk6i5r4rzjs@pali>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Rohár wrote:
> On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > Hi Pali,
> > 
> > > ---
> > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > index 18569c895..a21410f5a 100644
> > > --- a/tools/parser/avdtp.c
> > > +++ b/tools/parser/avdtp.c
> > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> > > {
> > > 	if (vendor == 0x0000004f && vndcodec == 0x0001)
> > > 		return "aptX";
> > > +	else if (vendor == 0x0000000a && vndcodec == 0x0001)
> > > +		return "FastStream";
> > > +	else if (vendor == 0x0000000a && vndcodec == 0x0002)
> > > +		return "aptX Low Latency";
> > > +	else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> > > +		return "aptX HD";
> > > 	else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> > > 		return "LDAC";
> > > 	return "Unknown???;
> > 
> > lets keep the focus on btmon support since nobody should be using hcidump anymore.
> 
> In btmon I already implemented it and patches are now merged. I just
> found another place where this capability parsing is implemented and
> based on fact that users still use hcidump I quickly looked at it and
> implemented this parsing.
> 

I agree, hcidump still comes up on many places (guides, blogs, mailinglist posts, etc),
so it makes sense to add these patches to hcidump aswell. Especially when the patch is quite small.


> > Regards
> > 
> > Marcel
> > 
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com


-- Pasi

