Return-Path: <SRS0=25t8=VJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F01C742A5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 08:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F8B21537
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Jul 2019 08:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="vZu7XCZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfGLIjp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:39:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40984 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfGLIjp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Jul 2019 04:39:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id d24so8536660ljg.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2019 01:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=37bn5ZsCuG4Bqp7YWJS32vKo6kA/ECW5S0ipQexmQxs=;
        b=vZu7XCZ82AkGxyiTfimOVIzc7FhCfhyLIkvUW4bLzFF2U4Z61d+GLhC6DLCqDTgq60
         SvyjmA7FscP/pfJmP72yTF/HWD/4HRpiIR1hHNFa6sCfyM2fodyc3glDBbYBJLLhUkVX
         vCWso5y7OUgjl/2oWkHjWI7nxbTrlsLLqAme3P8BbIXlBZWB1lCefPtBBIZjS40k/Mb9
         lTH8S2LTtwbMMCRTfX7V1cHFqkKiihkuZcmwKm0su1zjr68W2Dy8o4m/7qgdEBt3wOiu
         3AmatKBarQUK0c82RBGRu1KchQ3WqUAwJQdOExagLkB3nQoA8/JE1TRsiVw/BjDW6pQq
         4xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=37bn5ZsCuG4Bqp7YWJS32vKo6kA/ECW5S0ipQexmQxs=;
        b=Z3zPBPPdqYYf/BpVC8wwAghRWY5jlnIzlkSWEaz6tXqjYRYjhG+8czEOOeu5X+cT16
         mQkVTtx5diJGWW1+heG0zTlj/PRZRivhdbMMu8gteQ1OQB7zkunvmayOfWWaLjN962/f
         wp0TDSor52h4+FSjQjuSP0qj1ykZgsM864nybsJ4Bl6snnAQ9UgsmlEKQBSFq+URGz3P
         pf7yIsBOuOfz0/GXM1FMIKK80eCq5w2sLHHyjxM3EX8pkJ9SHjVTm6heg8bn9C+EA1Ti
         KYh/AYo2iLG4IOF6gylfLRscSEz6Fx7q6O72p6yUD/HVaksoNGh5AsnuT5TwE/NdOGak
         K8Mw==
X-Gm-Message-State: APjAAAXcDaL4SeG0tcFmoctvmf2JrjcTuujk7VrCSreedUTDdYxO8xEZ
        D5Xbt3cEX7QX8nw337UtB1O2cw==
X-Google-Smtp-Source: APXvYqxjpi7GEOWOxhcq+9MeQWC6zBO9rujF5g2fTV7wng/UkrE7yH5NHd0fiSXvb/MyY8tO+CBGug==
X-Received: by 2002:a2e:995a:: with SMTP id r26mr5226657ljj.107.1562920783692;
        Fri, 12 Jul 2019 01:39:43 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id h3sm1369916lja.93.2019.07.12.01.39.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 01:39:42 -0700 (PDT)
Date:   Fri, 12 Jul 2019 10:39:40 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ v2 0/9] mesh: Provisioner Initiator added
Message-ID: <20190712083940.hwaqbsdf2blvwep5@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20190711225952.1599-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190711225952.1599-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 07/11, Brian Gix wrote:
> v2 additions:
> * Style guide changes noted by Michal
> * Additional patch to use packed structures for Mesh Spec specifid OTA messages
> 
> The added functionality of this patch set allows any node with a keyring
> provision a new node into the network. It does *not* implement a
> user App that can store a Configuration Database, but it does provide
> extensions to the python test script to test the primitives.
> 
> Brian Gix (9):
>   doc: Cleanup API Provisioner1 interface
>   mesh: Fix support for Provisioner Initiator
>   mesh: Add special Beacon handler for Provisioning
>   mesh: Expose mapping function for D-Bus errors
>   mesh: Expose resources needed by Management1 interface
>   mesh: Fix implementation of Provisioner Initiator
>   mesh: Implement DBus Provisioning methods
>   mesh: Convert provisioning pkts to packed structs
>   test: This extends the mesh tool to exercise Provisioning methods
> 
>  doc/mesh-api.txt       |  13 ++-
>  mesh/crypto.c          |   8 +-
>  mesh/crypto.h          |   8 +-
>  mesh/manager.c         | 304 +++++++++++++++++++++++++++++++++++++++++++++++--
>  mesh/mesh-io-generic.c |   2 +-
>  mesh/mesh-io.c         |   6 +-
>  mesh/mesh-io.h         |   7 +-
>  mesh/mesh.c            |  10 +-
>  mesh/mesh.h            |   4 +-
>  mesh/node.c            |  42 +++++--
>  mesh/node.h            |   3 +
>  mesh/pb-adv.c          | 177 +++++++++++++++++-----------
>  mesh/pb-adv.h          |   3 +-
>  mesh/prov-acceptor.c   | 158 +++++++++++++------------
>  mesh/prov-initiator.c  | 283 +++++++++++++++++++++++++++++++++------------
>  mesh/prov.h            |  51 ++++++++-
>  mesh/provision.h       |  10 +-
>  test/test-mesh         | 113 ++++++++++++++++++
>  18 files changed, 946 insertions(+), 256 deletions(-)

Reviewed-by: Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
