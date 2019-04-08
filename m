Return-Path: <SRS0=Ssic=SK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFBBC282CE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 09:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B47920870
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Apr 2019 09:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRe8dRf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfDHJxO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:53:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35048 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHJxO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Apr 2019 05:53:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so15598701wrp.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2019 02:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tMjLW4oSTp2MLtALOpTKEZf+KJlluVDSjj8s3U8Mxxg=;
        b=uRe8dRf9CC9nsGsZRCoPn7uSsh8bWoZzEY4PmneLEc+ECC04krVvaSQsSi8ZJfA0Wt
         0fh0sJmfHC2QqzYQWpvJpBSipfEtCAM3X/0h7cJsobqy1xx4NOPrq3tb29o1xA5JQZy1
         p9L/anCOy5joPyO4C2NfdFdpP8bPxWqyWCx1XtYcj/FOgB2CLYlGKsqkpegliXXml+u6
         VIUWSUZQ9a0o5grNUuorCNGOmpahAPO2hpXg9f5OuS7tUJib9hrmiwq5YElC/ho4Q7E6
         Gz/OeBkuFYsAGouainxqkBESRGDwM9kS65Y9otvcMRorzyQzQcaDFDd1ywbhUHt2pk6L
         YIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tMjLW4oSTp2MLtALOpTKEZf+KJlluVDSjj8s3U8Mxxg=;
        b=uhCfdkmdjNPFoih567n23Onfp/751cO/Ld1wTchTN13bebDAc8TeFpOyGigNbZ6Mmw
         Af1D0XwPl55ArdOmMRha/wyIzJ7jxXF+czGE6thwdUu0hAcZBMAAdfb8u/2SjGT9raGe
         yOSDPGbk8aysGXlYCdjDab+XITM/gQw/Ikwxqbg1jeXGoGD4CygZu8yLrdEUXhY+uKyX
         VucYzPhA/35iY8Bz9pQNmDOq2CFKwK+TCMWtv1n8jsgH/neQu86JhKdhbxopfoHtgy7M
         ZRq+0rYaTBVCVATd0/hFKANRRTKuRHGw8pQwILSoRpBsQDujI8ffo+8YHvKgidz1zKmB
         rv2A==
X-Gm-Message-State: APjAAAWp8nJ1lCfY1uCPqw61DjwiPewiutwNJZoeU4YDFP+5bLBktnFw
        SMtJ9qRaacNnzlMLT1N5WWM=
X-Google-Smtp-Source: APXvYqx2rlD+Z+MLBrICxcm9i00m1GT2r1SqVbidEIM+MJu2lVFzw4ndTGGfmJ+05IxFL2XsRsyd4w==
X-Received: by 2002:adf:b458:: with SMTP id v24mr17886044wrd.46.1554717192846;
        Mon, 08 Apr 2019 02:53:12 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e1sm52176620wrw.66.2019.04.08.02.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 02:53:12 -0700 (PDT)
Date:   Mon, 8 Apr 2019 11:53:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 1/9] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190408095311.5pbc4gk62uu4fmmv@pali>
References: <20190122134524.20509-1-luiz.dentz@gmail.com>
 <CABBYNZLCFpXhbAnVYaA-nVNOY8QRvpR1UZhMHfy-awZxtpSocQ@mail.gmail.com>
 <20190122175622.dj6riiim6zukpetw@pali>
 <CABBYNZJGLGnNzXC_Q+Visk1XPwP9FX+BvJ65UQMj4tMJfL92+Q@mail.gmail.com>
 <20190405164713.cvfciulxnby25o3g@pali>
 <CABBYNZJQvOODiwVcNrDPH7A+5qTM0ZmSHaZ8=+=32CeH1t482A@mail.gmail.com>
 <CABBYNZJCOnudwGi6Km=m2SWSvV8v_zz3_Pd-+-ek9H785J4BkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJCOnudwGi6Km=m2SWSvV8v_zz3_Pd-+-ek9H785J4BkQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 08 April 2019 12:47:40 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Mon, Apr 8, 2019 at 12:41 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > > $ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep1 org.bluez.MediaEndpoint1.UUID
> > > 0000110a-0000-1000-8000-00805f9b34fb
> > >
> > > $ qdbus --system org.bluez /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep2 org.bluez.MediaEndpoint1.UUID
> > > 0000110a-0000-1000-8000-00805f9b34fb
> 
> Btw, 110a is a remote source I wonder if why you were saying they were
> sinks? Or you were referring to the local role?

Main problem is that these two UUIDs are same. There should be one for
remote source and one remote sink. Remote source is local sink role.

> > > So this is a clear bug.
> >
> > I will send a fix shortly.
> >
> > --
> > Luiz Augusto von Dentz

-- 
Pali Rohár
pali.rohar@gmail.com
