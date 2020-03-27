Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BE8C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385F020575
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 18:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="RUrqIzkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0Sz4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:55:56 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:36502 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Sz4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 14:55:56 -0400
Received: by mail-lf1-f43.google.com with SMTP id s1so8737976lfd.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bh75V5R+4LYHLZUzkTvqSLcwmo9mX/SiaZH+8Kt3xAo=;
        b=RUrqIzkTIrE3DwU6/qQXHS3KYwZKBQesCeOOW8mt2rWe3NWii4NWFwofA/TKaM7jFB
         AEcqVHcK0l2yLhC8U4vFRbNcmeJ0CEGAgbUsW2P2TXqPPatb8HXX+gu0w4EyfaveBuMW
         WmInkDGevK0IRHnik81lnPyscAhxfjJEtRLZr8Q+M2T2rMhx2q2ZK+v8SPPxU+cZT+hO
         wfEOqj2MOyILosE97rPZ7fvmkr9Nk5biyON8az7lOpwi3O2lXG8wPMXWl8kDAUcuNFWJ
         /Vc7U12v+yipDHUhXbNnPrEego5mGPncs4Rduw6KHmvAjLYLKexbiQJ+daM/JI/xMGXp
         h/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bh75V5R+4LYHLZUzkTvqSLcwmo9mX/SiaZH+8Kt3xAo=;
        b=Hqkt/35bY7KGeohG0mxt7dQpTV3tTQiYZoNXTuHDJsKwEn5PktuPbwV0pkP8HTWk7f
         9tNrUqbDWeocntRM7XKNxfFzRQdYCtBDZhbHahPselBbzCy0CfmGe/GkzcInG9HD9JPt
         fQPjmBIaGL8uPWh4l2PPDxFdJDwEfMpVYfcNaxy2qjpXDrZS7WCcaE97IJuCpKBdobJp
         Q7KZPIFKZVQ54yjWqvA2jBDjEEct+MaUMQbN1NVqbSRHE/puBWIl4QAG3XHxpk1QmGsO
         CUV9AkIZ54tiZuoVqsQXcpdDKUf67352bX0VldrCXkaK0NdidzcVI9Fw+T52GSomGIbx
         egzA==
X-Gm-Message-State: AGi0PuaVybLq+96KbMmS1v+pLVImGYOrTK4beOnBrnKrstMQSYUws7oO
        XKgnRZTbYhbaR/RBNzFqPPRSZA==
X-Google-Smtp-Source: APiQypKHNMBfp2dk1ne93FQGtIfLBxCGKvUG1i1cuQIXC6i9gKecfGAqzCPTf9/e5QsBaaNeU4vq0Q==
X-Received: by 2002:ac2:42c5:: with SMTP id n5mr469037lfl.20.1585335352190;
        Fri, 27 Mar 2020 11:55:52 -0700 (PDT)
Received: from kynes (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id g5sm3218318lfd.66.2020.03.27.11.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 11:55:51 -0700 (PDT)
Date:   Fri, 27 Mar 2020 19:55:49 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add net key index to send_seg()
Message-ID: <20200327185549.wwuwqwzudw7yeewo@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200327131800.7637-1-michal.lowas-rzechonek@silvair.com>
 <4ef38cfb7149f3b52f8ee4e76d718ef25d64fd71.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ef38cfb7149f3b52f8ee4e76d718ef25d64fd71.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 03/27, Gix, Brian wrote:
> There is one use case which is being missed here: Resends of segments
> of a segmented Device Key message, which do not have a bound net_key,
> and can use *any* net_idx.
> 
> When the initial Outgoing message is composed in mesh_net_app_send(),
> the net_idx is known, and should be fixed for the life of the
> segmented send procedure. I think we should just add net_idx to the
> mesh_sar structure, and use that each time a segment needs to be
> resent.
> 
> And then next, we will probably need to make sure our outgoing ACKs to
> incoming SAR messages are sent on the correct net_key.

Thanks. This sounds good. We'll get back to you with v2 next week.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
