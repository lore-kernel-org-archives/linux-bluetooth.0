Return-Path: <SRS0=5zPD=O5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A442BC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77103218D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 18:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="GjAEgRWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbeLTSTL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:19:11 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:34347 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLTSTL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Dec 2018 13:19:11 -0500
Received: by mail-lf1-f47.google.com with SMTP id p6so2098505lfc.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Dec 2018 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nUmJS9/u1ILqwLnopTBKuABuh3L5YYDObJRHyQXbVLQ=;
        b=GjAEgRWsFbo1sKvajyfXLof5Yjh30Wn1uC6lwI+5XsnCVxtFwPNVxSsLASU48OsDfe
         DXmMsLcitZbbHMHb5TCUTinGuZA3YBEMag9RPggL/rU5yqlzqmLtxmHlUXYfp0IMcrJE
         haIzNkVgNwAYiHob57VsaFfQDZRM8TzlNkGTdKNj9WUPgbMt60bvaDcyrLMPbxuSL6U1
         /M8/I2/4enPHYZJ+FiSd3yyU+1JvjtuWUlMlpv32u6ipxRG7unrwRYZgE/vitTqsueyV
         Q3sQXnyuNTFXg9WBfZziPvPt69fL19Fi9kpshMf8WUwu2EXYkk7Mo5c8yfXTMSUA+xtb
         aZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nUmJS9/u1ILqwLnopTBKuABuh3L5YYDObJRHyQXbVLQ=;
        b=NrOiibbbnPpNm0ehf3eip0NSUI1YWaTqi1xc9yAw3bY318dwAOZeWFwvyrj4K4QTnh
         WizuGPvagnLLdj4arxohRaX9/Xhc/jBaIIeCoRDG3vRxr8ksVOcpDbtkfXbQsFuRJzV0
         uhuhLA1f0MQYkpL/tYpOTLf/C99ndZzsBCbxQqHXVJYRrwnMG2pH+FHVVHKFCpc1BmSs
         IpgCKDomvoMnBEpuG9dACJUktQZ6GeoGMXx7ZuZ6GRt/jqRKc4kVVLerMP31lFnOC1Pv
         mxaVry0YfJCrrmCOLCgekBU7klYEyEaqKs4PGNbIMXzrpHFJGHtYxXnjMzE4wWB5VXp8
         kUgQ==
X-Gm-Message-State: AA+aEWZuXuOWdrpXfU5Ljcne2UwTyXS+aVUmenpK278CDrose/pIqWP4
        st9AsOjZLlb17aU5PH3AOYIrH+j7BOM=
X-Google-Smtp-Source: AFSGD/V5p3EpNQ9lVtazrxnPzNN/aUsW9C9fSTUyI4gjWE2ruHeNGq/51QpM9N4qrn4/gGOBU0w/vQ==
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr15158342lfc.27.1545329949024;
        Thu, 20 Dec 2018 10:19:09 -0800 (PST)
Received: from kynes (apn-31-2-85-140.dynamic.gprs.plus.pl. [31.2.85.140])
        by smtp.gmail.com with ESMTPSA id d5sm4378073lfi.65.2018.12.20.10.19.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 10:19:08 -0800 (PST)
Date:   Thu, 20 Dec 2018 19:19:05 +0100
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Advertising report address types in mesh-io-generic
Message-ID: <20181220181905.3r4fv45qe3y6sq75@kynes>
Mail-Followup-To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20181220161707.lxrzzvknqa64pmyc@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E337C@ORSMSX101.amr.corp.intel.com>
 <20181220180318.gwsj6aflihlppbgu@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4375D8E351D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4375D8E351D@ORSMSX101.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 12/20, Gix, Brian wrote:
> > says that "address type" in that event is one of:
> > 
> > 0x00 Public Device Address
> > 0x01 Random Device Address
> > 0x02 Public Identity Address (Corresponds to Resolved Private Address)
> > 0x03 Random (static) Identity Address (Corresponds to Resolved Private
> >      Address)
> > 
> > and nowhere does it mention BR/EDR.
> > 
> > I don't think we're supposed to even receive BR/EDR addresses via HCI LE
> > Meta Event.
> 
> I think you are probably correct.  This may be a remnant that we picked up from code that was
> intended to serve both BR/EDR and LE advertisements.  I will remove that check first thing after 
> the existing patchset is applied.
Thanks! \o/

Thanks for the work by the way, we're still digging into the codebase
and getting our heads around it, but I'll make sure to give you folks a
hand when we finally manage to add something substantial.

cheers
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
