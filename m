Return-Path: <SRS0=sa2S=XB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D3BC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 07:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC12121D7C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Sep 2019 07:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Q8Y3BVP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfIFHHK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:07:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42009 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731717AbfIFHHK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Sep 2019 03:07:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id u13so4103016lfm.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Sep 2019 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=05auKXgEciMXleN23OmuPSv2R1TkfhSvfUeH4QQefEI=;
        b=Q8Y3BVP4QBMLzbiPbD7FMjOVqAs2sX4mJpmnvrpp2X76ZVcR91LpZcuJj+hwDYk7ab
         P+MPLt+DPHPBYSNXCmyEo715BOzA8V1pMmID6nKY69j0KWV/N3eeMLArj/GUvKVawa5y
         SvuoIdcOSWwE30GocsE74ZU2pKnMYE8egKnNrZXrerrpAQHP7v3tC9j6atcamBS1oznz
         j38UgF+eoBlLzlgpJbCxdEZRip2t8P6zdWNWGx+84jmkDFD7Tm2tIJCYaffbjOPnS75n
         BeTMgs62hp7OJ3LiC+ZPH3x5p7JVK50jq40PeFpygbN/fsPsrDaZs5VGjmyy9Y3PriGK
         hUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=05auKXgEciMXleN23OmuPSv2R1TkfhSvfUeH4QQefEI=;
        b=f0mtZqscnJq0Uk/hcAX05K33usL20+qevRcd2ET5iGo0KR6BDkBH/QaNu8iWtNULrh
         rkMZzEZZ41Z/fQNaJwBlEZLNtyIJlTpn/YNJmarY+uIivDkryFfZCix95YieCqaEFNfg
         tCiRKKlH52P6u4Qu7bDvigWVMWiXtjKd1nEJaTzrFbS4x56yGQ1AVCaMhz5oi6XHH9/W
         S6xjeNC0G2IHjEvySAq51YnibUuIjQRHhgWuVJkbbr+ju9ePRnBVwpXnj/Ne15844zlk
         xWwIvQJ/6a9gG6HhN55lIiCjuHXxFC8KSBmKAFLnegNFymXI7Dh96hbPqXveS9sfz/Rx
         Wmhw==
X-Gm-Message-State: APjAAAVg2tOeWMLGa8wKsRd3Nu27gRlMVpSbEDPLv08+d76o4e4rNhxG
        DYs17a+stxcnLR+AmRCeOPYncA==
X-Google-Smtp-Source: APXvYqykA4BSRIIGctHP/JFbWxKE4YRUcKrY+AmF5rZd68Z2WvGLJ8qBpxMxZCfoqsrB08j0f/XPhQ==
X-Received: by 2002:a19:c396:: with SMTP id t144mr5332770lff.14.1567753628103;
        Fri, 06 Sep 2019 00:07:08 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id z21sm767764ljn.100.2019.09.06.00.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 00:07:07 -0700 (PDT)
Date:   Fri, 6 Sep 2019 09:07:06 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix IV Recovery procedure when IV Update is
 in progress
Message-ID: <20190906070706.xtfu7ihivlsyqvn2@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190905131240.24969-1-michal.lowas-rzechonek@silvair.com>
 <3980d0c20d416de8ca17bd406cc830b03a4d9498.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3980d0c20d416de8ca17bd406cc830b03a4d9498.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 09/05, Gix, Brian wrote:
> >  	if (net->iv_upd_state == IV_UPD_INIT) {
> > -		if (iv_index > net->iv_index)
> > +		if (iv_index > net->iv_index + 1)
> >  			mesh_net_set_seq_num(net, 0);
> 
> I think you have found something, but I think we are missing something here...
> 
> If iv_index > net->iv_index, and iv_update == false, then we still
> want to reset to Seq Zero, I think...Even if the increase is just 1.

Indeed. Let me re-test both scenarios and I'll get back to you with v2.

> So perhaps:
> 	if (iv_index > net->iv_index && !iv_update)
> 		mesh_net_set_seq_num(net, 0);
> 	else if (iv_index > net->iv_index + 2)
> 		mesh_net_set_seq_num(net, 0);
> 
> Or more esoterically (and maybe harder to follow):
> 	if (iv_index > net->iv_index + iv_update)
> 		mesh_net_set_seq_num(net, 0);
> 
> Or something like that.

Yeah, that looks reasonable.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
