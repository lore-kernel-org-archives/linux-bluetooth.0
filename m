Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E631C282D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 12:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4F420869
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 12:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0tfyljK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfA3MGp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:06:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39550 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfA3MGp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 07:06:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id y8so21270815wmi.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 04:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9vkdzCQ269b/E3q0G0dD2elkVVJVrXir6Y62H4jdSEc=;
        b=Q0tfyljKMBha5uvOHdCTvqE7lg6ky0pLeCrDJK/gZpc64npB+vj1ndXyGCKs5dRYG0
         Hy9qaCIDAW+BrRLe6ChO+L+3Xv3Vd/sTxTPgYYPUqWw2A9N0/lm5EFTpbE795fP+G2ub
         9NGk2o+fcGS6UlxFPzgiJNnOMBAEJqTnlUTKjjtAjL/e7rTkNS3x6g8V/OQkXJG5rEPa
         tgcfbvG6LHu9AcIJ/Gs600HYvroDAFR9gnYzJaKuvI2oZKDN1hi3IVEL5A47uPH0FxDx
         KdK3pUdJyW1T9hprOjHISQ4IYY+6F/kc9Jrcrfuu/YX/FX0boin+a+z6RgYDXSnta0yv
         +MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9vkdzCQ269b/E3q0G0dD2elkVVJVrXir6Y62H4jdSEc=;
        b=S55+KGcqF8lpXhnOIXooI1KfKzFSFpc0U1h8aln0c+LchNWI1LNvBVgqblgTPCpROr
         vZz9HeUEzHLQwjWE6HqmwthTNuV1wUMQnK6QuobIHolWTsSDBQsG8cvkxTy30rNDuwNR
         UX4RS2rxLjobpIBf1vhwVZm/KA9OqHVeqf2y7wrgo75V+4Roj6z66sfjt3plHJiHiuhK
         vM8yjLwHJOUTwOfUpGiVYKF5srtnbpMEaPYhm/JDlD+8SmwG+WnMk5G1ysXETc+E99zZ
         9mJDzbTN341bHIODbC3OSd1L3HI93Rm/8z27xQAgw3+yVCqw70LIl0YdImS435ZvNNd1
         nkQA==
X-Gm-Message-State: AJcUukeyJPF6XndiH8fN/lUYB+nYD6YDHLASMk3RksTUkMqSGhEFuaL3
        cILgLAY3j6jDZ8E6/bzfMmQ=
X-Google-Smtp-Source: ALg8bN7P/hiR93kuL1X6xAbBWww8SVulzr2Guo47SPByGLRH9pax/4gYkOB5/nyjefk5ZFDIE3Avjg==
X-Received: by 2002:a7b:c142:: with SMTP id z2mr26412263wmi.102.1548850003469;
        Wed, 30 Jan 2019 04:06:43 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n9sm1014408wrx.80.2019.01.30.04.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 04:06:42 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:06:31 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20190130120631.usx67zjk4kmbhcla@pali>
References: <20190123174504.12350-1-pali.rohar@gmail.com>
 <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
 <20190123175448.cdkdpnk6i5r4rzjs@pali>
 <20190130081517.GI32745@reaktio.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130081517.GI32745@reaktio.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 30 January 2019 10:15:17 Pasi Kärkkäinen wrote:
> On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Rohár wrote:
> > On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > > Hi Pali,
> > > 
> > > > ---
> > > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > > index 18569c895..a21410f5a 100644
> > > > --- a/tools/parser/avdtp.c
> > > > +++ b/tools/parser/avdtp.c
> > > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> > > > {
> > > > 	if (vendor == 0x0000004f && vndcodec == 0x0001)
> > > > 		return "aptX";
> > > > +	else if (vendor == 0x0000000a && vndcodec == 0x0001)
> > > > +		return "FastStream";
> > > > +	else if (vendor == 0x0000000a && vndcodec == 0x0002)
> > > > +		return "aptX Low Latency";
> > > > +	else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> > > > +		return "aptX HD";
> > > > 	else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> > > > 		return "LDAC";
> > > > 	return "Unknown???;
> > > 
> > > lets keep the focus on btmon support since nobody should be using hcidump anymore.
> > 
> > In btmon I already implemented it and patches are now merged. I just
> > found another place where this capability parsing is implemented and
> > based on fact that users still use hcidump I quickly looked at it and
> > implemented this parsing.
> > 
> 
> I agree, hcidump still comes up on many places (guides, blogs, mailinglist posts, etc),
> so it makes sense to add these patches to hcidump aswell. Especially when the patch is quite small.

Exactly, people still use hcidump...

> 
> > > Regards
> > > 
> > > Marcel
> > > 
> > 
> > -- 
> > Pali Rohár
> > pali.rohar@gmail.com
> 
> 
> -- Pasi
> 

-- 
Pali Rohár
pali.rohar@gmail.com
