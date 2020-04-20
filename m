Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E59C54FCB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467B9206B9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 12:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="Miik+hCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgDTMIf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgDTMId (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 08:08:33 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE51C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:08:33 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u6so9630770ljl.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2020 05:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VjGv8kHQf0vHIcXlYD+5u67o2s1F3lXqWFmAULV7fM4=;
        b=Miik+hCGPQlhPr+U7E+ZNRzOcZ33MgcsR6mmI39D+2Us7GKb6YT1ZJniRPXLNwhJRF
         z0vMMOQoCx3BiRpOX5AkYWyASXhZ4AAQAvHrHl4fAZB1XRraH7BYKVfFzuPSGDQg3zyl
         7/68ANZD+HA3xtQ/vMP5v61beOsj/irN7TN7+OK3GJtQTOdV75L2LyOF9h1yxrMY8BFd
         DiD388kPMQZjBZQTnyUwjCEZxqbT+/+QJCdCtGpX6BgquG6E/Owd3kIa62grpKyb/lOs
         rWOpZP5z0ArUIddw0fPyAfZ5pq0sXukcDj0MqCmlRRIAtlUE5MWiUI88Ta2Ah25gS0Cm
         wYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VjGv8kHQf0vHIcXlYD+5u67o2s1F3lXqWFmAULV7fM4=;
        b=q772ZfOIUalHSuB6McRE9uoEotA0U36lvSP5hfc+3zX8ZHyx8bEm2Oaw4P+LRkWOM3
         EkLJVeGK2vtAQgnm/rvLBjeLmxHzDg6KVWHVyrx98ir29sHZgaBkr60q9Q2jvd0ADqDC
         G4M1fSH19rVVLZ8G5gYhlCaj+5KZLZwG6SDFMY2zZRACpfkXU3C5jd1ENjuSQHYMgCSg
         yFQouv3MpY7zUni9RBIfhO79NXM2dCDU2nqWn5tIcxxG3/WzSfS5IcvYVZvjtYhTIu+R
         yDSN4ZfLF3HpyGHF1Lepz3kDcGOBvOxceFQq/AQ0jmLky+6PlolVtf6CvSc11VZi10Ar
         WYqQ==
X-Gm-Message-State: AGi0PuZs+j5BnYtc30NfgVKwezxomFQJ41ZkGSHJQZxtzdRPaP9HPr5f
        c0vtRbFevcvKxXKebFDvjKsVLmwcsno=
X-Google-Smtp-Source: APiQypLCFFuSxveARtS0L9OteONyEe00QuN0C3o1/TK5UK1we+V8gNXScb3m8rwCn/geXNdewuAyfg==
X-Received: by 2002:a2e:a549:: with SMTP id e9mr10076607ljn.28.1587384511566;
        Mon, 20 Apr 2020 05:08:31 -0700 (PDT)
Received: from ix.localnet (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id w24sm678506lfe.58.2020.04.20.05.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 05:08:31 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Cc:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: Build errors under Fedora 32 beta distro / GCC 10.0.1
Date:   Mon, 20 Apr 2020 14:08:30 +0200
Message-ID: <2525599.mvXUDI8C0e@ix>
Organization: CODECOUP
In-Reply-To: <5f5cc8a0b25cb7a2a289f83cfbf42b2f86e36f28.camel@intel.com>
References: <5f5cc8a0b25cb7a2a289f83cfbf42b2f86e36f28.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Friday, 17 April 2020 20:44:30 CEST Gix, Brian wrote:
> Compiling BlueZ using GCC 10.0.1, which is the standard version for Fedora
> 32 distro:
 
> $ gcc --version
> gcc (GCC) 10.0.1 20200328 (Red Hat 10.0.1-0.11)
> Copyright (C) 2020 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> This is just a snippet of the top of the error log:


I've just sent patches for this and few other errors reported by GCC 10.

-- 
pozdrawiam
Szymon Janc


