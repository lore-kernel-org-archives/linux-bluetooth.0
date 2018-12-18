Return-Path: <SRS0=Q26+=O3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE14BC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B052021841
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Dec 2018 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="KNkGh4YA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeLRT3Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:29:16 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:34410 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeLRT3O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Dec 2018 14:29:14 -0500
Received: by mail-lf1-f41.google.com with SMTP id p6so13186150lfc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Dec 2018 11:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dcbZPmUTjug2h4VpXi0EMFE+baMTG+anA7SdYDqanOQ=;
        b=KNkGh4YAueT2dB7oXGwDtDx6Ml2oAVNdNFSgo0Vsk5rdzlj0c/ceN4cYoK3ELLk5C8
         emEGLv3gdYPeS/hiZBZ5MpTewZimzC64jTetjeYeNhIyZM+XhKc7HGUcDjkrdI0omksy
         TVF5tMiarUgDVvb/RfZFV98v7cnSX0hLCcyenzn0bkM8XQTH41ftZLT32BEUph74YEzQ
         gpmXGtMeQV+8kES6BCzVUx5BdPF6mqTl6ni0MxGUQkwO9aulhJfyFvTXD0OrKhfBHT10
         25+UuEO6TqwAMJopI6jtXHg2hc+j24zgicrlFfcaDGV+3ugDTxf5x3aBAd828eJTYK8t
         W1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dcbZPmUTjug2h4VpXi0EMFE+baMTG+anA7SdYDqanOQ=;
        b=L6VwPbtrmIKRN9PNJ/xJCEy0/KKEUzjoosvcB+W2XU6MTU1ELv1vC7DjCjOBnyJQkC
         ogS4YCrgCbQDPPbRwcgwQgDgHRzMAW8blAdlwpWcWVeZDMDASvrORX30nGJ6725ZVXH5
         QPqllAHTbUksNFGPRhj8yN3369Sy9i84QOnkapNLMenbel2smnZjBbF7LnVIaB+I/GPU
         SDKhLEBxVWsWonmYbpOQKgbGm3bU+ppCv9yc9f7FDaakfTk74OrX84u6FlDxAdNfTsEL
         WDV8cv2lGGRw9mhM2TXLZrkOTBH9xC9gVdBwZGbBOad7dqQhNMG42MRcUTU6bxFTxHoj
         TFTw==
X-Gm-Message-State: AA+aEWZL1Od7J7elV69w+1nwWGV4DNKmMdcP4r0BaJ1+jxGK1fqU+BWa
        OKIBOyLFcxl27rmYKWA/fZK8BtERqaE=
X-Google-Smtp-Source: AFSGD/VFJhaid4UXvT7qwkRcivtF1JgJd/ShgV9WZlYcOiG0zrsnH2Onbb9sRU7uGe+hI50KqMcg6A==
X-Received: by 2002:a19:d857:: with SMTP id p84mr10498178lfg.44.1545161351379;
        Tue, 18 Dec 2018 11:29:11 -0800 (PST)
Received: from kynes (apn-31-2-85-140.dynamic.gprs.plus.pl. [31.2.85.140])
        by smtp.gmail.com with ESMTPSA id m13-v6sm3150538ljg.56.2018.12.18.11.29.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 11:29:10 -0800 (PST)
Date:   Tue, 18 Dec 2018 20:29:09 +0100
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Plans for meshd
Message-ID: <20181218192909.27htxh3glfgjmial@kynes>
Mail-Followup-To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <CACXRGxyMGt1zecvRmgoa5uuSwy4H9UpSECM0tOuC+uXGmQoGNg@mail.gmail.com>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E02FE@ORSMSX101.amr.corp.intel.com>
 <20181218110838.ollsqils5ci7cq4v@scytale>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E0B35@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4375D8E0B35@ORSMSX101.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 12/18, Gix, Brian wrote:
> Maybe we should start with what you actually need.
> * Do you need GATT support only for the Provisioning procedure?
Primarily, but not only this. As Danielle mentioned, there are cases
where we would like to "fall back" to GATT in order to exchange large
amounts of data with a selected node. This is going to happen only
occassionally, so it won't affect the "steady state" performance of a
mesh network. Spec even mentions that particular use case, via Node
Identity procedure.

> * or also as a GATT proxy Server?
No, at the moment we don't need GATT Proxy Server support in Linux,
althouth long-term I think it would be beneficial for bluez to have
this.

> * I do not think we should try to support Proxy Client *at all*.
Agreed.

> The Proxy Client assumes a single Node, which defeats the purpose of
> having a daemon at all.
>
> * Only a single node (or unprovisioned GATT server) can use GATT at a
> time.  The protocol does not allow for the multi-node architecture of
> the daemon.
I do not think this is true. The spec doesn't seem to put any
limitations on the Network PDUs you can exchange with the GATT Proxy
Server, so I think it is entirely possible to have multiple Mesh nodes
share a single GATT connection to a proxy.

Noone does that, though, because performance of such a setup would
probably be abysmal :) In the end, I don't consider this a "real" use
case.

> *  If we do try to put a GATT Proxy Server on a single controller
> implementation, we may need a special node that loops back data
> received from the Mesh to the Gatt Client.
Well, I was wondering if it would be feasible to implement another
flavour of mesh-io layer, that would talk to Bluetooth Daemon (possibly
via API extensions) instead of opening the hci user channel on its own.

For that to work, the main Bluetooth Daemon would need to expose D-Bus
signals to retrieve "raw" advertising indications, and a method to send
a single advertising packet.

Alternatively (and this is just me thinking out loud), maybe it would be
possible to dup() the HCI socket and pass it to the Mesh Daemon,
assuming it gets spawneby by fork()ing Bluetooth Daemon? Not sure if the
kernel interface allows such sheganigans.

> * We may want to make this a build-time option, because ADV handling
> will probably be affected whether an existing GATT connection is
> established or not, if it is possible that a GATT connection could be
> requested.
> 
> * This affects the times when we can use Randomized, ever changing BD
> ADDRs, and requires us to interleave connectable advertisements and
> "be connectable", which is not technically allowed with mesh network
> ADV packets.
In our experience, /just enabling/ Proxy Server on a node (thus making
it advertise with connectables) does not seem affect delivery rate of
mesh packets, at least not meaningfully (0.1%, maybe). The performance
drop is observable only after an actual connection is established, and
is in 10-20% range, if I recall correctly.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
