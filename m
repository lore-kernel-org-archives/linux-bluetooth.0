Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7C4C43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 11:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746B8217D9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 11:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="aCaJPqUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeLRLIp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:08:45 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:33005 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeLRLIo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 06:08:44 -0500
Received: by mail-lj1-f179.google.com with SMTP id v1-v6so13858316ljd.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Dec 2018 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tnhhXf9GPq/tx57yGVX6X8eoF6wHMtfGFBNbVNZeTLo=;
        b=aCaJPqUqFfWgM+S56tCzcAcnT+dUtBlk7lFPPlXS3YJ9zH1xbYUM/xXzdzuusOcATj
         ZPqZHSPCeeHP+aHBS/B2L7CJ3YLbK/4ZTCxBizRgZVmjh3T3OkFmuUhk3BoJsnnIHcy/
         bBe2GdiXECaCllCpfvQzioiw/trCJdR/RAxuh0+/1vjGFnawSFOMc4Os+1NAu+2Tm9jA
         PiMTIURGW0Zg4eK1kgoXorKHbOKvKlWMbWS6ryVG/xeX/a0+vVBKgfnuvmRL19XUfEmu
         EiYxc/+YrgMEzaM2rsIpDIndqEGux57h6p3ZwbnU6AKFOqt1VekyW4kLBCprfcGvACN3
         xfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tnhhXf9GPq/tx57yGVX6X8eoF6wHMtfGFBNbVNZeTLo=;
        b=FL7tSoildhhJw884zdijFZlFZOcaLvIKSTrNwm/rjxFXzh3N3/UC/DOXLAKHqiiJ4N
         AYkuUlI09PAVK9tJUnAaf0n9eLG4ebkvJ3yOL2sr+iDlJr2Nq2ocru1YdgCsGpzT6i3V
         sRRFlkt4K8tseEV4zkAoSmaDmb1apmTDy7cgwL1qUCEnNA2K54mSlM8TZ5hvrOBIvn38
         sv2iq+ucYfTXtBzCMTvqAA9ckMFMsUZTYchn5Zmx16XWmCVP7QJbIezXIowvWIWxhP62
         I/Mp+JXEVjIiLIIFeb4wv1M+YeUdyc7Wp7IgCcDmeWYDU2ZbCJ4r3gf1esGLgLlaeFA5
         ssSA==
X-Gm-Message-State: AA+aEWYHGRvAM3s9mC1ZEVHXFGfPrgx2wvnwqmKqdRZhyn+VZd28+Qu9
        rUkPERojes9S3QHm45PxrDzo74+cu6s=
X-Google-Smtp-Source: AFSGD/UJcwGhwdkKjcxJ9VrTkhu6BJVCOPb88ypbrYJGf5/KP6dk4LKvsJOl4QPglorgCV5685C65w==
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr2389482ljg.50.1545131322271;
        Tue, 18 Dec 2018 03:08:42 -0800 (PST)
Received: from scytale ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v17-v6sm2924015ljg.32.2018.12.18.03.08.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 03:08:40 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@scytale>
Date:   Tue, 18 Dec 2018 12:08:38 +0100
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Plans for meshd
Message-ID: <20181218110838.ollsqils5ci7cq4v@scytale>
Mail-Followup-To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <CACXRGxyMGt1zecvRmgoa5uuSwy4H9UpSECM0tOuC+uXGmQoGNg@mail.gmail.com>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E02FE@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4375D8E02FE@ORSMSX101.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

Thanks for clarifying.

On Mon, Dec 17, 2018 at 09:48:34PM +0000, Gix, Brian wrote:
> I consider this to be a practical approach, because the overhead
> consumed by ACL connections negatively affects Advertising based
> communications, and linux in particular handles a practically
> unlimited number of controllers.  Support for devices with controllers
> that have active ACL connections requires other mesh devices to send
> more redundant packets to ensure delivery.
Ok, fair enough. We are well aware of performance considerations.

What I'm thinking about is having both modes of communication available,
even if the embedded device has just one Controller, as is the case with
the majority of off-the-shelf platforms.

The reason we want/need both BLE/GATT and Mesh on the same node has a
lot to do with provisioning - at the moment we configure our networks
using a mobile app, meaning we need devices to support PB-GATT. This is
because Controllers present in mobile devices do not support Mesh
natively, and we can't assume there is a GATT Proxy nearby, especially
when configuring a new network.

> And I am not opposed to someone starting a project that will allow the
> bluetoothd and meshd share a single controller and taking
> responsibility the reduced performance of each, but that is not work
> we have planned.
Ack.

FYI, it seems we might be interested in making that happen.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
