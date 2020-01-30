Return-Path: <SRS0=xtvM=3T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A903C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 08:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AE12082E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 08:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="i5u7lKKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA3Iza (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:55:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35816 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgA3Iz3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 03:55:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so3052061wro.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 00:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ltqih8r/YXGD2kJxXajbixBSaqU0NAsgMPa1WlgZDaQ=;
        b=i5u7lKKk7hA7OeFIOvJ/dBUA3pnmEymApSJEkQ9UeoXpJ7UaxW79bcxlpmorJ9dLNV
         wHKbtNMp71WOkQwSrauTqjr9WQZR6KLjuLx3OpDH3GMjbrWpexDIyiq9b/Fs4Uu8SD6+
         a/KmnJZCtpvWOz4ac2Z2Y3DXSNu4qgYlhM5IhqbhWgn+/IYFaU1YVuex/yJc1NYevv9l
         AwYbf9HVuB4tt5MDVXGrAmkBe/UCi+kiBYjBNxiEsHLA9rhoS1RvV3HyZWGYS91VCTEk
         3ZFWdEERjmV4IDM5474AIIC3ZZsEslwvPxaMPuYiFxnsF4sFwyNtRI1WL4pOqOyF1D0X
         GM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ltqih8r/YXGD2kJxXajbixBSaqU0NAsgMPa1WlgZDaQ=;
        b=DW7CDGQg9q4ZZo129I/4IWLa3iZ8OFfCSunA2fbWR7cKTZOVZiEUVkAzISqdbxJuU7
         CgHFQGleOW0SvW9gdr+Ye67Q/tSBehUVfAtyDiiNBy3OhPsKUN6W4gAi6Q3eTZW+Fqoc
         JXHgSazNfSE1EzWoRFOrjMhl6LrpWjE9WhoZLKf8ZjOIpp3aAb8CVjgEItQc9QOJJuyT
         LnoPQOejaaoEDFEN8DdWFDQmog+4b3D1p0oekWxq6fk5Cw+f+J80vQrib+Qr+2p/3uAV
         wTsdSj0JQKdMEs+keH5+9G2ZM7Vl/pLvO1+SUIUT8YbQflECj3ErDlz7fLW1Xnz4cUUY
         rgPA==
X-Gm-Message-State: APjAAAVHQJkUjoC74HU0WPbXTiY1ooPz5tnFigvh0AYuKmtCFEc65lxJ
        q+W6nYqFeIVK//CWBqpDY2xlg5yNwjs=
X-Google-Smtp-Source: APXvYqyRWY+hIQ2FZwKDKWBEu1ZS0YZGAYQIkt55PvvarOhSlpL957zIlNHoO8Uutq4Mnap+L2g1Eg==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr4151219wrx.109.1580374527486;
        Thu, 30 Jan 2020 00:55:27 -0800 (PST)
Received: from rgajda2364 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id q130sm5550413wme.19.2020.01.30.00.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 00:55:26 -0800 (PST)
Date:   Thu, 30 Jan 2020 09:55:25 +0100
From:   Rafal Gajda <rafal.gajda@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v4 5/5] mesh: Add NVM storage of Replay Protection
Message-ID: <20200130085525.hmlrfexnwm5dehbb@rgajda2364>
References: <20200129023258.10004-1-brian.gix@intel.com>
 <20200129023258.10004-6-brian.gix@intel.com>
 <20200129121744.zv3jnf6uejjpetud@rgajda2364>
 <a49f5f0c9633bacfcbe6f2125aece235ac34e90f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a49f5f0c9633bacfcbe6f2125aece235ac34e90f.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Jan 29, 2020 at 03:06:10PM +0000, Gix, Brian wrote:
> Hi Rafał,
> 
> On Wed, 2020-01-29 at 13:17 +0100, Rafal Gajda wrote:
> > Hi Brian,
> > 
> > I have a question about the way RPL is stored.
> > 
> > On Tue, Jan 28, 2020 at 06:32:58PM -0800, Brian Gix wrote:                                          
> > > Mesh specification requires that Replay Protection be preserved
> > > across node restarts.  This adds that storage in
> > > <node_uuid>/rpl/<iv_index>/<src>
> > 
> > Wouldn't it be more convinient to keep both iv_index and sequence in a file like this:
> >   <node_uuid>/rpl/<src>
> > ?
> > 
> > You could store them in bytes instead of hex string 
> > and it would eliminate the need for cleaning entries from old IV_index.
> 
> 
> We considered this and decided against it for ease of processing, as this method requires fewer file
> operations.  Cleaning old entries is something that will happen regardless of how the RPL tree looks in the
> file system, as we delete entries that are older than (net->iv_index - 1) since we don't receive messages on
> that iv_index, there is no possiblility of a Replay attack. And deleting a file system tree is pretty simple. 
> A SRC address does not get to keep it's spot in the RPL indefinitely...  only over the current or prior
> iv_index.
> 
> Our other considerations included maintaining the integrity of the RPL across power-loss or abort reboots.
> 
> However, we do recognize that some platforms may different NVM storage available that can be optimized in
> different ways, so we tried to keep the NVM RPL apis as simple as possible to allow others to optimize the
> storage as they see fit.  For instance, if someone was to port this to an embedded system without a standard
> linux file system.

Ok, I understand. Thank you for the explanation.

Rafał Gajda
Silvair

