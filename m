Return-Path: <SRS0=ag/l=4U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E0C3F2C6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 08:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D497D20842
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 08:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="JiR3Dvx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgCCIz3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:55:29 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:41659 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCCIz2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Mar 2020 03:55:28 -0500
Received: by mail-lj1-f181.google.com with SMTP id u26so2576503ljd.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Mar 2020 00:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eHPZsj/2DEaN2sG67Z8lIY2QLQ0U66OVwxjqVWGTP80=;
        b=JiR3Dvx8nCHJYuKoreVgTG9P+7urgiLHVqCWQsNMB+sQf6rc/QlmN7ydki9oit9Oqb
         V+fserhuTRd8CXr2fFUSV+Ols/eMDcb7E6pziOrmwDdxwaN1vstAJHxOI9cZPpMuq2HS
         MJ6PDndSRHj7UFWWSJQN4lPbYNhmBhD0cKCyWs/wA0+F4NlUdoIci6tmLa+XtS1d7ZCK
         YvL+uLEVnCmi6OCHj+Kx5CMxgR1bkZMV+WiGUdSPuS3Blh6m5oNWGpWE4APfa0qzWZKA
         rqFPEUJvUVKIJLG37+W70Z7XOtYkLksydyI+8ufBF3wf+HBedVZkKpI8OBwrVtr/8N4D
         PZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eHPZsj/2DEaN2sG67Z8lIY2QLQ0U66OVwxjqVWGTP80=;
        b=R5LTz8ztFjqsDvU3OUVD2wFc48Sph0ynTe6JYTL28yhT72vWpIzeDq5oK3ikcAvW9y
         ASVi9qgAUPPGc5hYl897fxhZ8vyXiql4Os9P/DTx4VV9PXPtPG9kh4AicNnkpnuVeF4x
         BJqrcmd1WemtadzmJtO5mrvy1KazKrKuhUmvVYxA87yzlc6zeWrZkdpQhJALZ31Wt2p0
         cx+sl5RodzN1DFowptOdsgrBUlqJxywQ7ETYAFFLks9HV8UDzO0QqoIPGFczFM2Uthwq
         sfhGcN45AAI7RAUH59MSCXV5ftrA+neVz9/Xne71wPX+B1r4gLDe2Jb83WkbULIbtmid
         Xw3Q==
X-Gm-Message-State: ANhLgQ1br+sY/+M2flf4Lv8RQ0aPO6HO+6OLUReuUUywuCvbHZxgn1SW
        tZiYaToq08UirBTg3DXgh0Wb1LTVdWgn+g==
X-Google-Smtp-Source: ADFU+vvMMSk3JY3UZF8s9ibOKlOp8ybUs7d+D1i0hAkgYZwla91Cr4LI2GuHCiyrUxl3hKbs9teuug==
X-Received: by 2002:a2e:9a0e:: with SMTP id o14mr1813123lji.63.1583225726772;
        Tue, 03 Mar 2020 00:55:26 -0800 (PST)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w21sm752955ljj.18.2020.03.03.00.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 00:55:26 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:55:26 +0100
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "anupam.r@samsung.com" <anupam.r@samsung.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Regarding OOB authentication method & action for Mesh provisioner
Message-ID: <20200303085526.g3iqcijh4enapxbh@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "anupam.r@samsung.com" <anupam.r@samsung.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "semun.lee@samsung.com" <semun.lee@samsung.com>,
        "dh79.pyun@samsung.com" <dh79.pyun@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20200302142239.re57glm4ixjot7d3@mlowasrzechonek2133>
 <20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p3>
 <CGME20200302125344epcms5p3e31d97ef6263e0513b94f6306536269b@epcms5p7>
 <20200302145518epcms5p7ec2da0403de9efa6733e12290f3cc80d@epcms5p7>
 <7686b0b5ec818946fef72d8eb438460898d53c40.camel@intel.com>
 <f2ea1cd7ff4a84671a53c518e3bdbabc286343cd.camel@intel.com>
 <17a69d79616ada7b4e64da8c7b3829ec594c755a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17a69d79616ada7b4e64da8c7b3829ec594c755a.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 03/02, Gix, Brian wrote:
> > The daemon indeed is missing the dynamic acquisition of the
> > provisioner's agent capabilities. I think there is no need for a new
> > D- Bus method, the current API is sufficient. What is needed, is to
> > add call for GetProperty() request of "Capabilities" on the Agent
> > interface (in agent.c) prior to sending provisioning invite (in
> > prov-initiator.c, before or in prov_init_open())
> 
> Yes, after talking with Inga, this is absolutely correct:  I think we
> have everything in our existing API to support full control by the
> Provisioner App as to what OOB methodology gets used...  But the
> functionality in the prov-initator.c to use it is currently missing. 

Ack. Thanks for the explanation, we'll do it this way when we get to it.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
