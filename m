Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E372C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 20:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6082071A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 20:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="m2TBWz0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgFOUcx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOUcw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 16:32:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9F0C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 13:32:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e12so12513480eds.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tCEg9O2/ce8O96LEDDUmWPxoAr0o/NKXaVFsJT9HBpM=;
        b=m2TBWz0esCeV8C/uI5hUO2B6iJHGfKv8LjtcuDlJJQJWCp6JrhQ9wjft+z5DjZDP98
         TC/1CnKEs25YejN44653mzF5ucxvw/gq91JHfLEUXqP82/iWbNG4eSXUNWbhBQ+f2gxr
         CUJnzpzmnxboKkgvFF2HoYim9tBi+HzeOsITFTvN3FTzJ3whK+PQiLy0ax0RXeFWgT8n
         fsMyH5MrqJFiJJTtH/jjRAwlF+FUg/LqDlxolhAHtMFpZ6uPg0hKy5AtQd0Mf/nwx7y/
         h92+ldRs7G64+HAh3ONL0UbYa9ma6jVfu95QQWLKxrBFHy5bI1sQ3a5Vc+8Nn4ZeSmyH
         r3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=tCEg9O2/ce8O96LEDDUmWPxoAr0o/NKXaVFsJT9HBpM=;
        b=OOLi7Ef0w8gAUeYNGnDPssNf3kkHAtZ9jp8kB5mZENszeJuiWKl4TrO7kjbcWc3DST
         7u09hAyXkK7C1r3siEtV9PbkbhptOXNlizOzi09eEwRK7KFDUKU2+3rKdLH2HhFyfbZ2
         MwLbGPQq/OMkoYxJYYjryPMjCFLjFaAAGAr7g19nbAJaFNDRVPdJDgWHIDaKpe77v1oa
         jXo6jZ1sE5Wjj/BwcsjgGoLvoasiEfiVmVjEc+tbBfjHNmuXLwoVCMw1Dvem87CFjWag
         y0EP4cbv2EZeF8RDrqh0Z/WClAsj4CDUZgwB42LXVQzrSWumNPMmKotiA7gBvuO90CXU
         T2Vw==
X-Gm-Message-State: AOAM5303t8cf6upY7vEjJWwSXIbIkr7uJ1XnAFYUNhWyi3N3Va9gJN7k
        +NhdgWqb4kG/TFoLRdB/HNsPy5i1K6Q=
X-Google-Smtp-Source: ABdhPJxypO6QApgisDdgmf7WyVpj+63BID//p2dE95JKncPn9n/fCXWHbPsPHsuzr02HiG6+yDXVpA==
X-Received: by 2002:aa7:cb53:: with SMTP id w19mr24448032edt.328.1592253169895;
        Mon, 15 Jun 2020 13:32:49 -0700 (PDT)
Received: from kynes (apn-46-215-210-131.dynamic.gprs.plus.pl. [46.215.210.131])
        by smtp.gmail.com with ESMTPSA id o7sm9009617edj.52.2020.06.15.13.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 13:32:49 -0700 (PDT)
Date:   Mon, 15 Jun 2020 22:32:47 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v3 5/5] mesh: Add "node is busy" check for Leave()
 & Attach()
Message-ID: <20200615203247.4zw2vhauuducewws@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200610171121.46910-1-inga.stotland@intel.com>
 <20200610171121.46910-6-inga.stotland@intel.com>
 <20200615082259.bpstucduyunyqvmt@mlowasrzechonek2133>
 <72efc0bd23669143a0c1b9749a6c523f1ea49f5f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72efc0bd23669143a0c1b9749a6c523f1ea49f5f.camel@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Inga, Brian,

On 06/15, Gix, Brian wrote:
> > With this patch, this call sequence fails, because now we're supposed to
> > send a *reply* to JoinComplete first, and only then call Attach()?
> 
> A couple months ago, we made the decision (with your input, I believe)
> that we needed to use JoinComplete on every node creation (Join,
> Import, Create), to ensure that the App has the token (...)

Yes, I remember that discussion. The rationale was ability to catch
bugs in the application, and get rid of created, but effectively
unusable nodes.

> This creates (...) the unfortunate situation revealed in one of your
> test-suite cases where if Leave() was called before returning the
> JoinComplete() call, we Seg-Faulted.

Indeed, although I don't think it's necessary to introduce a "busy"
state...

In case of Leave(), this call removes the node anyway, so what I think
would suffice is to check whether the node still exists when
JoinComplete reply arrives, to avoid freeing the node twice (causing
SEGV).

void node_finalize_new_node(struct mesh_node *node, struct mesh_io *io)
{
	if (!node)
		return;

	if (!l_queue_find(nodes, match_simple, L_UINT_TO_PTR(node)))
		return;

    // ...
}

This would allow the application to call Leave *before* sending a reply
to JoinComplete.

As for Attach(), I also think it should be legal to call it before
replying to JoinComplete. The worst thing that can happen is that
application successfully attaches, then replies to JoinComplete with an
error. This would simply remove the node, and the application would be
promptly detached.


> > I'm using a high-level API for D-Bus, so I don't really control when the
> > reply is sent, so at the moment the only way to implement this would be
> > by delaying Attach() by a fixed timeout - and I'm not comfortable with
> > that.
> 
> 
> Yeah, I can see how this is now required...  
> 
> In the mesh-cfgclient tool (which is also built on ELL) we accomplish
> this by scheduling an idle_oneshot for the Attach.  

Unfortunately, not all main loops have API to schedule "idle" calls,
i.e. calls executed when the loop doesn't have anything better to do.

I know that both ELL and Glib do, but AFAIR Qt does not (it uses timers
with timeout set to 0, if I'm not mistaken), and Python's asyncio
doesn't either.

I don't think requiring a specific sequence of dbus messages is a good
idea :(

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
