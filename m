Return-Path: <SRS0=JpWv=7C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA61C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E3A206F1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 May 2020 16:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="GIXCq6Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETQSU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 12:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETQST (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 12:18:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8429BC061A0E
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:18:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f13so3050479wmc.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding;
        bh=MdgLXCn92RRNd2uRAvpTDztdPl6p1VSJN6eMi1qi5+w=;
        b=GIXCq6Ne7AjdXKkak75YpZ8NeddmswvVnKO5q0kk7wtxC5m4KTfC5IHnSoe9yTH1OC
         P9SrAV1Ke3T9hKmDZqfJTJeJeJjaOs+BPnrw0+wQSSLrm3ShFARpks26qZIyke9r8kwH
         SBI6xApZT+epZOfBvlx6z4+aD7gmIdGOmqegucYR1BaJXu9R8ul6tjwgm4GHaNd8u6Zg
         Ql1l68pSnK0kaO5zsNSjusJZ9AJJIML4AruMUiX7jbNBS9HwUXSgAs4NOLw1hN5Nm85b
         r2CwOHK4ApvFxgMK4fKaNbwUMmGiJA972bgf+d4uP5kaooHDQDd5qYVhE6HrNUvVLKSt
         tREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding;
        bh=MdgLXCn92RRNd2uRAvpTDztdPl6p1VSJN6eMi1qi5+w=;
        b=E3gt6JsDzUXsar6es5CL715XgEbHoctvuNfpDt1FCd3AAr9LeJbFGd91IiE0iRxhnu
         Ogv6FsRqL+xF+HlejUaghQz9EMoIRrSBlV3lo9cR0CqcwgZhtERfWqMmpO5wC+6x0qnj
         QM5PJFJMsVBlacxKSgGfyUvFu3KicQVzm9wE7r8xB5IV8O+CKkJ3ZaQXSGS8KTVuqxBn
         M3nbO3bFz94D+rvMlffqgAQqUQo1hseNeYZVp5UPWGp4/HRhdnsDKprxdZHSkCj47jdQ
         eMzF4LhIt9EocZrxGtU+0nPw5gbx0Ame1kVOX5Wiqpsl3Y/BVFUPHWPj1to1e0KOnTWN
         UYtw==
X-Gm-Message-State: AOAM532tSIB6YJQukem2iRZX15DwOBdamIHpnzODjFk+kiz1Sk3CmqQ9
        pd7Xwoc0J/3gjD8cbOQUrkYvhg==
X-Google-Smtp-Source: ABdhPJwat6yFgiuDdu5/KsI/mGabF4uCiiPrjo+/QjA0OZXvALYvID+FsVf4qCCiesmnOzsW0p9p5g==
X-Received: by 2002:a1c:bad6:: with SMTP id k205mr5113292wmf.53.1589991496637;
        Wed, 20 May 2020 09:18:16 -0700 (PDT)
Received: from kynes (apn-37-248-42-218.dynamic.gprs.plus.pl. [37.248.42.218])
        by smtp.gmail.com with ESMTPSA id t82sm3750447wmf.10.2020.05.20.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:18:15 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Wed, 20 May 2020 18:18:14 +0200
To:     Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] mesh: Alternative delivery method of mesh packets
Message-ID: <20200520161814.5kknqmst5apc3poz@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga, Brian,

When playing with bluetooth-meshd on an embedded platform (i.MX6 UL),
I've noticed an unusually high CPU load, both on user and system levels.

Granted, our application is implemented in Python, so it's not the most
performant language for ARM (to be gentle), but I still think it should
be able to handle the message load... For the record, the traffic we're
subscribing to is about 100 messages per second, published by 200+
nodes.

I don't have hard data to back this up, but I've profiled the
application and it seems that most of the CPU time is spent on D-Bus
marshalling. I also suspect that most of the 'system' time is spent
passing message buffers between bluetooth-meshd, dbus-daemon and the
application.

To make things worse, the platform we're using imposes tight security
constraints, to the point where it inspects each and every D-Bus call
using AppArmor.

All of that makes  me wonder if we shouldn't optimise message transport,
by e.g. passing a datagram socket descriptor that applications can
recvmsg() from, avoiding method calls over D-Bus, like
org.bluez.GattCharacteristic1.AcquireNotify.

Thoughts?
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
