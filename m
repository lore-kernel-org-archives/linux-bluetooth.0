Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AACC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 18:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357BB20733
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 18:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="zBZOTYXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfLQSnf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:43:35 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38255 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfLQSnf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 13:43:35 -0500
Received: by mail-lf1-f49.google.com with SMTP id r14so7713329lfm.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 10:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=i1M6RVGzXE7k/FxZosSpaaIp5Kd2A7wuUGfvA0OEmPw=;
        b=zBZOTYXYNdszaasWQ5X9XIjiOK/MXm7ZXW7+MdCYOvBcQEsx94xAirfc+Cm6KOYa5f
         sSgwa3hziEeFkzflmvQpWCx7GurPDAAm+m7VhK3leyCFyzdzKg80zvKoD6Z8qTj/FYNd
         TUdqsW/Agbl4LKk4RcEzrbgtv54o23hNsPkzMO3GKAgWCAhjW4y54l2EgGGCqXtyR7/6
         hdGhMu9U1Fhej5lxHzrg0UaxzpHWiDs9DfnryEcAv44btwXQpp5PX/1jHTtSueqmN2f2
         hJ+UqkPnEaDhuo98c1Ack1kDsZRkAJX/OY1fRPbGkR6Bi5KPCDoL1p6WvNz5xdxwD/34
         e7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=i1M6RVGzXE7k/FxZosSpaaIp5Kd2A7wuUGfvA0OEmPw=;
        b=LRm18ZWEB5gFWh16gDSg+KF+IHO+pUdoD6ewJnAVGlK1yJwCv8F9tVfHDGm1F+PvwW
         5KTli/vVtey1l35IYtSitu69E7Lst9vQwbfWXqZJ2/cXKdpOLb1yFCZ+6zxN47mFFOQj
         c00UcYyY9st2CzxdsL8sLYnwqtnGnercTL+7J5eXTcms2QC6n8DBDwtBegmHW4DEYWI8
         nKMeVdl9/HuJL0qNV/q8vJ4Il9XHu8crk9kNcMhmpjIwXA1X4TbHCMDH+l96Yxefy6tG
         Y4mxyywl8EGeU3K9T96I8RS9c9JdAcoVmUF8Yq+VM5H3bDqhoonfQCXqOwU4Kd/Uu/dq
         lEkw==
X-Gm-Message-State: APjAAAUS+EknwTFN+ugKYpdM/cWe6pkCNzBzEpOkE0ziX0LYdbk4TxVz
        gAEXOxEOf92vyMS0jyb2FousuXZRdIipow==
X-Google-Smtp-Source: APXvYqzvzgfX7yJokDmjMzzv4U4LYKNAKPOUedbyxf5S/sRHCvhfzzU2k8M3Cf9o0QVEZ1oC/cwxiA==
X-Received: by 2002:ac2:4c98:: with SMTP id d24mr3605510lfl.138.1576608213345;
        Tue, 17 Dec 2019 10:43:33 -0800 (PST)
Received: from kynes (apn-46-215-206-57.dynamic.gprs.plus.pl. [46.215.206.57])
        by smtp.gmail.com with ESMTPSA id e8sm16000920ljb.45.2019.12.17.10.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 10:43:32 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Tue, 17 Dec 2019 19:43:30 +0100
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: mesh: Handling application failures on Create/Join/Import
Message-ID: <20191217184330.coc6c7b7hw4to6vx@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        inga.stotland@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I've noticed an issue with Create/Join/Import calls: when application
performs one of these calls and fails to save the resulting token (for
whatever reason), the node created on the daemon side is pretty much
unusable. It's also rather hard to get rid of, as the daemon won't even
expose them over D-Bus when application is not Attach()ed.

I would like to discuss possible solutions to this. 

One of the ideas is to give the application some time to successfully
Attach() itself to the new node, otherwise it gets removed.

Another possibility would be to remove "created but never attached" nodes on
daemon restart.

Thoughts?

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
