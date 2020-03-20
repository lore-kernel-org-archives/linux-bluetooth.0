Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C41C4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 13:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCDC20754
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 13:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itCQwaGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCTNCE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:02:04 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36192 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCTNCE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 09:02:04 -0400
Received: by mail-wm1-f44.google.com with SMTP id g62so6231065wme.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q0ftB85Jx6aGt+1mPXwJgjIaSB2cWkfI0dQ+W6Udl4U=;
        b=itCQwaGI2b+KWkmaJQBEgn25VzjZyzKe2y0v7YXEo4h5qnD9eWr0bgg4ein0ITVAgx
         /UFnlPoiBMORzFtY7P+MmDJ4//hLE3CmTRFTwV17td8S5nlC/iqyMccE5A2tqoV9blyF
         2AzXJroAOQfCtKSMJYKVYuEQYqG1DTOG1es0OjoBO0yqNOmD0zbtwWJDUj4GVDVV0lyr
         kUYqe2M/xo1ZD3nxRpZteaNWqcHLNV6PNttinAtJRxpAbnDT1s2/D6xS/83r/6IQyGu0
         Let/Sh8J8QdbMVyQvIZkvabgqCVB5lMuCem3aggVuLzW7yPRaTJZF98Ogtaw4Me/3g5e
         H78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q0ftB85Jx6aGt+1mPXwJgjIaSB2cWkfI0dQ+W6Udl4U=;
        b=SsfyKa/1VD0O8RqJEl5JwIBnGL+0VK7f0DkCEu9Jnr1/ZsTgNvbFG8n5KddhN0asgM
         TaEFzspNCZyvqdUtCocIdiDf4qd77XtLqqcV7wsM8T7Q814nKKaI/XD5uKKq4BNJB3ug
         S4grhI1h1UbPh5h0lKyJqnKgWJyLh5BSx9rxdxPvHjlnt5w6dnm6ERPxRzSf5MsCBnoM
         vsR1f3JZWr3Vxsjrqw/aqb7s0kbDUHoh6RYoBiG9UXkoVxaaVBZucnz9nX9HGnEr8TGy
         j+iivDJHKafO8EiYEDa9THhaZol0Gmb+nN1rT4Rw4Chb21FGwtmSeFgig8XD0zGHzS9D
         dT2w==
X-Gm-Message-State: ANhLgQ1SzbzfBgb8heTp0KkvTwUp06FD/f969ANmf5/F1WcA7f3qWPwN
        NEu4sW4CcEcJhIF2ymY5ORI=
X-Google-Smtp-Source: ADFU+vsyveOie/hJBObHpBOJ8oPGVsgj2tF41udAZZ3g76idGYIuU3tuscAVv7qlNd0vw19gJ+cgeg==
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr10034013wmd.101.1584709321395;
        Fri, 20 Mar 2020 06:02:01 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z12sm8737064wrt.27.2020.03.20.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:02:00 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:01:59 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: Re: bluez: Export SDP "Remote audio volume control" item for HSP
 profile
Message-ID: <20200320130159.cm2shncjg5qo6xgh@pali>
References: <20191212172944.hgt6se2qz2hpsbo2@pali>
 <CABBYNZKCovNDcAaMMeYZgKAAq-8oz+pcs6xmS3A_Qt-28aoEbQ@mail.gmail.com>
 <20191212230314.g5gt6rxkphzpwucd@pali>
 <20200209130243.u4kpbj3cwhbdqa56@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200209130243.u4kpbj3cwhbdqa56@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 09 February 2020 14:02:43 Pali Rohár wrote:
> On Friday 13 December 2019 00:03:14 Pali Rohár wrote:
> > On Thursday 12 December 2019 21:42:27 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > > 
> > > On Thu, Dec 12, 2019 at 7:31 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > >
> > > > Hello!
> > > >
> > > > According to HSP 1.2 specification, section 4.7 Remote Audio Volume
> > > > Control, Support for remote audio volume control is optional, so an
> > > > implementation may support none, either, or both of the controls for
> > > > microphone volume and speaker volume.
> > > >
> > > > According to HSP 1.2 specification, section 5.3 SDP Interoperability
> > > > Requirements, bluetooth device with HSP profile announce via SDP "Remote
> > > > audio volume control" field information if device itself supports volume
> > > > control.
> > > >
> > > > But currently I did not found any way how to access "Remote audio volume
> > > > control" SDP field in (pulseaudio) application as bluez does not export
> > > > it.
> > > >
> > > > Can you please export this field? E.g. for HFP profile all optional
> > > > features from SDP are passed to NewConnection() DBus method via
> > > > fd_properties dictionary under Features key. Could you export that
> > > > "Remote audio volume control" bit for HSP profile in Features key?
> > > >
> > > > And in same way, this needs to be handled also in RegisterProfile() DBus
> > > > method.
> > > 
> > > Do you have a use case in mind?
> > 
> > Yes, checking in pulseaudio if remote side announce that supports remote
> > volume control or not. And based on this switch to software volume
> > level.
> 
> Hello Luiz! Is it is possible to export this field?

Hello, I have not got any answer to my question.

So may I ask again how to retrieve SDP attribute 0x0302 "Remote audio
volume control" for a remote bluetooth headset with HSP profile?

It is really important as this attribute says if remote bluetooth
headset supports volume control or not. In case it does not support, we
need to switch to software volume control on host side.

There is open pulseaudio bug that on some headsets it is not possible to
control volume level and therefore pulseaudio needs to switch to
software volume control.

But without checking this SDP attribute 0x0302 this is not possible.

-- 
Pali Rohár
pali.rohar@gmail.com
