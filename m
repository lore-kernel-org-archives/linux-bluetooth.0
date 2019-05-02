Return-Path: <SRS0=qzIG=TC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC53AC43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3520B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 20:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="cL8W+660"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEBUYg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 May 2019 16:24:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42413 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBUYf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 May 2019 16:24:35 -0400
Received: by mail-lf1-f68.google.com with SMTP id w23so2851892lfc.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2019 13:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AOvc8yBd7CsZCYlYNNvyyBnJyBGmUO2JugZULUOVcOc=;
        b=cL8W+660CyotKO5X4JASaIHgS1cMBq2RG18LjTsRFnilS9TmDMWc5baZxnH+ny3pbc
         iVqKUBXLkC2iLv5OPhiH+VPIPSNoyV7CfC1RKawenQeUcvKS6NDFLYhpiDQ/eH+Br08a
         aDMlTv1E+tVgABJYjQtXB7F4j1mXoPauhJnDvbjvNoCc25GX3uyCKnP9jHiBRIz6lctv
         WnyFoF6WYDcUrZlYeptPRrdR0ERzshbbhaO5Nvuci2wY3qlKqdX5mJzNJCujc6Gbf8pe
         VH3LUG4GwlFIqL5Z661oB0Ptld5Bak9oyOfIgV8AQ37VhhSDf8lsQ1vr3QUghtXgba3/
         eD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=AOvc8yBd7CsZCYlYNNvyyBnJyBGmUO2JugZULUOVcOc=;
        b=BY2Gwqiy+45GMLyYrrtKKymhVAEhe7iJLgLmutAj0MVpMRtPeJNd3WXsbB5BI14o6m
         qEWmRoyl8dC+JSCnAiWK9iEGtHQaerEVEzFbcSPLjeaLGg5adgCPg5qU7wD9tD8IJwzC
         kz2FveXg2dUsQMOlg5O55NU2eV7rvg/fNJUi6adfl2VOHzwHU5pqznahpKfx3BKE1EyN
         g1gzzEtMBBV7zSP54W3nMSkw86yQvstRr4DujEi0vwaTleJPU3GjZl7XQTTKih6ko2hR
         nfFc1sb3R+ujNFfZ7+inK3dtEaeJJtVK+o1+5NUWZrr5oPvLn97StJoyAdG8PfLzW2N/
         wxJA==
X-Gm-Message-State: APjAAAXP89E2scJUtZQvN9WzUV4P4XoLTfhLaLwHzoGJVjxsJCllzqQO
        WHYtIAyLQnQc6CCbFw4AbhyaaA==
X-Google-Smtp-Source: APXvYqyC08s52vczOAL1OGg3JAoiq04mIxwY1nD70jXI6WXZvPCBFUmTpWrrA+QIF/0rG8Vv4mlnAA==
X-Received: by 2002:ac2:43ac:: with SMTP id t12mr2971047lfl.120.1556828673647;
        Thu, 02 May 2019 13:24:33 -0700 (PDT)
Received: from kynes (apn-31-2-19-253.dynamic.gprs.plus.pl. [31.2.19.253])
        by smtp.gmail.com with ESMTPSA id l13sm20258lfc.61.2019.05.02.13.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:24:32 -0700 (PDT)
Date:   Thu, 2 May 2019 22:24:29 +0200
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Add remote dev key support and cleanup
Message-ID: <20190502202429.kxyyql4prcllzpcj@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20190423231624.19302-1-brian.gix@intel.com>
 <20190424085945.zmniib4vpy2uiyql@kynes>
 <DEBB0CAA2616974FAE35E4B560B9A4376CB05944@ORSMSX103.amr.corp.intel.com>
 <20190430073809.wdbhglfaiqsvscmc@scytale>
 <DEBB0CAA2616974FAE35E4B560B9A4376CB0C1B5@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CB0C1B5@ORSMSX103.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 05/02, Gix, Brian wrote:
> > Right, but I think this is covered by the server/client model behaviour, so I don't
> > think we need to care if the message was encrypted using a known remote
> > device key, or our local device key.
> 
> There is the SHALL paragraph in the specification, under section
> 3.7.4.3:
> 
> "A response message shall always use the same DevKey or AppKey used by
> the corresponding request message."
Indeed, but on the other hand 4.4.1.1 says that:

"The application-layer security on the Configuration Server model shall use the
device key established during provisioning."

So it doesn't make any sense for a server model to accept messages encrypted
with remote device key. I think the only situation where a message using remote
device key should be accepted is processing responses directed to a local
client.

In the end, I agree we need to track the 'kind' of a device key... But, I think we
actually need to expose the local/remote distinction to the application, as an
(boolean?) argument of DevKeyMessageReceived. This is because foundation models
aren't the only models that are allowed to use device-level security.  Also,
you mentioned earlier that the daemon will not expose APIs for all
configuration client operations.

> > I think this means that the API needs to allow using either local or remote
> > device key when *sending* a message (i.e. use remote key for requests and
> > local key for responses), but API for receiving messages needs only to
> > differentiate between device and application keys.
And what about this then?

Because of the above, I don't think it's correct to always (automatically) use
remote device key if one is known.

If the previous comment about an additional argument makes sense, it would also
make sense to add it to DevKeySend.

> > I was more concerned about the CRPL size. At the moment the limit means that
> > a node cannot simultaneously talk to more than 10 remote nodes because of
> > this (mesh/appkey.c:227):
> 
> This will definitely be fixed, and should be following the value
> indicated by the Composition data of each node.
Note that the Composition Data Page 0 indicates a *minimum* CRPL size. A
node is free to use a longer list.

So if I read this right, the plan is to allow the application to declare CRPL
size during CreateNetwork/Join procedure?

> > What are your thoughts on replacing the JSON storage with something more
> > granular?
> >
> We would like to keep Node Storage, at least for the full Linux
> implementation, in JSON format
Got it. Thanks for the additional details.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
