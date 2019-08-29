Return-Path: <SRS0=q5Cw=WZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B57EC3A59F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 19:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECDA2080F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Aug 2019 19:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="IUXNiDfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfH2T4Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:56:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46643 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfH2T4Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Aug 2019 15:56:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id f9so4182782ljc.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2019 12:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J7ZJJb2kwxX0pte3jJfiDvoZeKJTFKNMsdzm7vZT5WM=;
        b=IUXNiDfOhs1BhhrgHwCLXsLYkk9pOKfngvn2MFK/7GML9ZGCbh+2j8j7AZC+siEdlx
         kwwlGL+Fy5psqqMcfXsEqtfMzRCW9O23HkSfNS5pxKi1o7sISK83zTc6ZgtJzAcXdL3q
         xDcoXhdcQHa6HQBt2q4uQyN0XPtFl7ySe7AY47NCzOICHkNzHs7zWvUhD7jKtNwqzqhu
         hazE1ABRhiQyk5HgCKc2xRA6cOqLdCBtcpx8ZEyttpzQzc27PEPk0EyrJD+nXlZ+vSi4
         aS8XLij4cBOPXUUtUqPunKlkTtozj2RDGSVRdJGRZB+H9wpzAf/XgkJV6luwXbrOUL0k
         6Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=J7ZJJb2kwxX0pte3jJfiDvoZeKJTFKNMsdzm7vZT5WM=;
        b=BuDf3PZUIw5dUNQK1q+9Rccpw+GsUCrFyI+Mtn8fzlfYid8MzIAwmU0aaTRKELvEWy
         RCB5nOfhXGElmdKJoV81R5cZIb0BS81hjrqv/jAUq1mmKt9Mx3E3KtGUXgPGXFA0TdmH
         upB7iWtRDyPn67Hy/d0tdq6tfpQ4V+tAxg6uG1H6dmND3mf7XH/iQLC0kXlZoBZ+y4Qs
         rro8ilG8u/a36RmXSkun40lo72B/ooCtBu2kY3bCDiFZzBbj1HCqdntGwhVK99BoL+TT
         sTzUjdaJ82ZMQRnnmAN2SLzkefC/uR/IfcuQZJJsQdBVkrMgAhvvqBvp1rXO4SdAPSUf
         54vQ==
X-Gm-Message-State: APjAAAWqttkjYU0amLKccQ8uNQEl/KQF5v7VUwsZKrDWjcdztR+Kxenc
        VmPeUIW/gsGn1jgYFLYqbVS9jw==
X-Google-Smtp-Source: APXvYqwHg7x/H0bJ82BjcQ+TpQCozxD31ZcVNsz28A57paAiIo9jbjSBJCo03Yzk4qv0Hvuemc36bQ==
X-Received: by 2002:a2e:8705:: with SMTP id m5mr6567829lji.9.1567108582217;
        Thu, 29 Aug 2019 12:56:22 -0700 (PDT)
Received: from kynes (apn-95-41-66-58.dynamic.gprs.plus.pl. [95.41.66.58])
        by smtp.gmail.com with ESMTPSA id c197sm536330lfg.46.2019.08.29.12.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Aug 2019 12:56:21 -0700 (PDT)
Date:   Thu, 29 Aug 2019 21:56:10 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Log D-Bus method call errors
Message-ID: <20190829195610.a6dwgxabq3d2g3bp@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190820075654.2195-1-michal.lowas-rzechonek@silvair.com>
 <685bc703108f5329b861f5c5f87301b44bddd8e0.camel@intel.com>
 <20190829095951.nzzqqhgvblhogf4e@mlowasrzechonek2133>
 <145b9b726c45fd37592b5a7a3504c911cd848409.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <145b9b726c45fd37592b5a7a3504c911cd848409.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 08/29, Gix, Brian wrote:
> That is true, and we *expect* applications that are attached to handle
> the socket-signals (that drive d-bus) in a timely manner...  But I am
> not sure we have a way to enforce it.
> 
> Certainly, we can simulate a disconnection if an App ignores it's DBus
> socket signal, but again, we won't know about that for 30 seconds
> which seems like forever...  And an App could potentially have a large
> enough backlog of messages negatively affecting the daemon before it
> and corrects it.

This seems like a limitation of ELL:
1. There doesn't seem to be an explicit API to set timeouts on method
   calls, so if the application takes too long to handle method calls,
   message_list hashmap in l_dbus struct would indeed grow quite large.
2. There doesn't seem to be a way to set an upper limit of pending
   messages (or maybe even message rate?) in l_dbus connection.

Still, looking at ell/dbus.c, it seems it should be possible to manually
call l_dbus_cancel after obtaining serial number of the method call
message, using _dbus_message_get_serial from dbus-private.h (yeah, I
know).

Anyway, I think a better approach would be to submit patches to ELL
implementing these two features, and then use these additions in meshd.
Does that sound acceptable from your POV?

By the way, it seems that bluetoothd suffers from the same problem with
regards to external GATT services/characteristics/descriptors.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
