Return-Path: <SRS0=cftP=V3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65304C433FF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jul 2019 07:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DC1206E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jul 2019 07:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="iKDjONb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfG3HAR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:00:17 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:46378 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfG3HAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jul 2019 03:00:17 -0400
Received: by mail-lj1-f174.google.com with SMTP id v24so61121340ljg.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2019 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8zvHdhZ/J133rm7t0JzGkPm4QqqBcC6NWbXjWCro1RM=;
        b=iKDjONb5JuS9UU0L2WEK0h1dfd5KznQEnJjoXY+lcIn3NxA5dBxlDfPvzpp4yprVec
         2Z67PSgnh3mq43rCJtk+QbM+TfAx2UkErjbpceX7Uv49fyWCndSBbxYTIWp3f0aUqgS4
         7QDimVwAY+EF/SCrp0oeWjJs6KrYA4D/fFy8aKTV2/wyjersnffzbWyXR9HpuWpuLAxv
         JqfymhQX8bxLI70/OOCHKCpuXxPcoLo4obtoihyp6dfBjzbnxDMu1pGjZoKqPgKMpDXB
         EEwaitrIKuFxDF5U88miauWnk0skaYsMusYXvL0PT2DCZQR7hoIyV6BehqjVDNNgGGzT
         xd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8zvHdhZ/J133rm7t0JzGkPm4QqqBcC6NWbXjWCro1RM=;
        b=Hc0QAKajnzfND3e5QmNc///13GDs7Ul6AOQ2ZX+k7s5t6TSQX6BXp9rjgFTHlwX5oC
         SuyHlVa8xQjSHsaGGgR94HLXzqa9PHWfyPB28CVEBY0SJgFTVy54uEdc5jfc32HsJAZE
         kevNHAfyPqj6osTifztRT8HW1hWjsvSoOu+Pj06VZgtCXmRd4n2l76F/LQ8Ooq4Tyfrf
         hwNXS7oTr6KOnUtkH70UUxYRbEFMrZHrdqd/diqBUoyYPXE7vk6ZknT1+WSlZfJF9WBN
         Xo6O2CSwrnlsPGXCjFyg1evttvlyAxZEeGZ625jH/HaNjbroexhiJj4P3bvn08UP/FMw
         +ZJw==
X-Gm-Message-State: APjAAAUC0bZGWHsb2ksRrBjoRN6yI3x3IES8ojkBUH82+RwqjrBmN54I
        GH7BoQNeT2PVukEWlXsmcp/iFw2ySl8=
X-Google-Smtp-Source: APXvYqzJigdbB2xiWTHIygTuvgodgwQjqWHBsjwQXlvM4NMDV/ZO3gpKQMp2deLONFWfuSUHoMHRDA==
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr61805459ljj.160.1564470014768;
        Tue, 30 Jul 2019 00:00:14 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id z17sm13277574ljc.37.2019.07.30.00.00.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 00:00:13 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Tue, 30 Jul 2019 09:00:12 +0200
To:     Mahaboob Nazeer SK <nazeer.m@phytec.in>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: No default controller available error
Message-ID: <20190730070012.aq27j73ugslt3wv6@mlowasrzechonek2133>
Mail-Followup-To: Mahaboob Nazeer SK <nazeer.m@phytec.in>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <OF16744CA5.5F3760DC-ONC1258446.004C8E8D-C1258446.004C8E8E@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OF16744CA5.5F3760DC-ONC1258446.004C8E8D-C1258446.004C8E8E@phytec.de>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nazeer,

On 07/29, Mahaboob Nazeer SK wrote:
> I just cloned the latest Bluez and tried to install it with mesh
> enabled. The installation was successful. But when i run the mesh
> control and try to do discover-unprovisioned,i am facing below error.I
> also get same error when i tried with bluetoothctl.
>
> $ meshctl
> Waiting to connect to bluetoothd...
> Reading prov_db.json and local_node.json from /home/nazeer/.config/meshctl directory
> [meshctl]# discover-unprovisioned on
> No default controller available

FYI, most of the development effort is now focused on bluetooth-meshd,
which supports ADV bearer. Meshctl is a GATT proxy client and is going
to be phased out.

Please take a look at doc/mesh-api.txt instead.

Also note that at the moment it's not possible to run 'regulard'
bluetoothd and bluetooth-meshd on a single HCI interface.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
