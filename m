Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7EDC47420
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 21:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 293EA206A4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601415632;
	bh=DlscN2yqRbyyGeJN7YrFc+q4f8UfVNS6D0CjSgVFjBk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=E1chgAE7q3M+wZLeER1fdBlzHYOlmj5AU/PGQb1AOzS7paYK+KexTHFSXqtHw7Yk6
	 dOIRF4KDPGPxytBMm+2du3USb9pjocnyA3XLxuqmmiznJwfkHlobLIIhOK0uLR7kbn
	 KNhouDZsG8scM+r4rvOayA0r2oFuUGOLnB53taEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgI2Vkb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 17:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2Vkb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 17:40:31 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A32420774
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 21:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601415293;
        bh=DlscN2yqRbyyGeJN7YrFc+q4f8UfVNS6D0CjSgVFjBk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=iA1slaAqd8Q1yLAH3bqsoA/dIEZGeYNWiT1NqHsgauHwFW3SVhinehPe9DFRxudCS
         iM3ZB1vsNAksAOFgdE31u0yR/UmZVAtnZh/w5m4Xyw9GGK4XhfO1h7fvi8AQMepXOR
         58SlcGVEJC2y5Z53HvTGGqGPX/brniRYY8yIxEtg=
Received: by pali.im (Postfix)
        id F31AEAA6; Tue, 29 Sep 2020 23:34:50 +0200 (CEST)
Date:   Tue, 29 Sep 2020 23:34:50 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] avinfo: Print more A/V capabilities
Message-ID: <20200929213450.evljeiutlvnczpaq@pali>
References: <20200512165112.24006-1-pali@kernel.org>
 <20200808132336.opzyojwsyj2txgbp@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200808132336.opzyojwsyj2txgbp@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Saturday 08 August 2020 15:23:36 Pali Rohár wrote:
> Hello! I would like to remind also this patch:

PING

> On Tuesday 12 May 2020 18:51:12 Pali Rohár wrote:
> > ---
> >  tools/avinfo.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/avinfo.c b/tools/avinfo.c
> > index e45b50918..576981a5e 100644
> > --- a/tools/avinfo.c
> > +++ b/tools/avinfo.c
> > @@ -65,6 +65,7 @@
> >  #define AVDTP_HEADER_COMPRESSION	0x05
> >  #define AVDTP_MULTIPLEXING		0x06
> >  #define AVDTP_MEDIA_CODEC		0x07
> > +#define AVDTP_DELAY_REPORTING		0x08
> >  
> >  /* SEP types definitions */
> >  #define AVDTP_SEP_TYPE_SOURCE		0x00
> > @@ -696,13 +697,33 @@ static void print_caps(void *data, int size)
> >  
> >  		switch (cap->category) {
> >  		case AVDTP_MEDIA_TRANSPORT:
> > +			printf("\tMedia Transport: Supported\n");
> > +			break;
> >  		case AVDTP_REPORTING:
> > +			printf("\tReporting: Supported\n");
> > +			break;
> > +		case AVDTP_DELAY_REPORTING:
> > +			printf("\tDelay Reporting: Supported\n");
> > +			break;
> >  		case AVDTP_RECOVERY:
> > +		case AVDTP_HEADER_COMPRESSION:
> >  		case AVDTP_MULTIPLEXING:
> > -			/* FIXME: Add proper functions */
> > -			break;
> >  		default:
> > -			printf("\tUnknown category: %d\n", cap->category);
> > +			switch (cap->category) {
> > +			case AVDTP_RECOVERY:
> > +				printf("\tRecovery:\n");
> > +				break;
> > +			case AVDTP_HEADER_COMPRESSION:
> > +				printf("\tHeader compression:\n");
> > +				break;
> > +			case AVDTP_MULTIPLEXING:
> > +				printf("\tMultiplexing:\n");
> > +				break;
> > +			default:
> > +				printf("\tUnknown category: %d\n", cap->category);
> > +				break;
> > +			}
> > +			/* FIXME: Add proper functions */
> >  			printf("\t\tData:");
> >  			for (i = 0; i < cap->length; ++i)
> >  				printf(" 0x%.02x",
> > -- 
> > 2.20.1
> > 
