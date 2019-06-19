Return-Path: <SRS0=h9/h=US=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C0FC31E49
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 06:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2C220679
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jun 2019 06:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="aABDI3YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfFSG5E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:57:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40408 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfFSG5E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jun 2019 02:57:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id a9so11216923lff.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2019 23:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XH2ByBGMWuV0a5BfcG9F5ydd6NKDEv/mvisyPY5vGmY=;
        b=aABDI3YQWN0DaruXI/PSLJRMtVylpJ4EUeoCJbq8GlS4eCx4mIseQh8CQHAUoHeyyY
         NAGkWnHKFDVr5ClEguZT6MkK1oOnmly6JLGmueLoK+ryxp5HYm9LsGIDYJqu++QiXYEP
         A8Z4h3px8E1jgJdR0ZWkcSWKlGb3MC/t73+g3Q/yD8tNCrNHRp6aKHmhw51oWXZ4ecNa
         4uhKBTqm3RXJX/j8HyXiCr7Y9fQs7YiBaj/yhTYz1ca4lXEPBOjrsRVFRlHGGJtjlYF1
         XRaFSs5jnKDlNzJdMYa+JyAXL8HpNRKbrDriAeNsltpXH94CB6BiItrgAuMpqM398X9c
         inqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XH2ByBGMWuV0a5BfcG9F5ydd6NKDEv/mvisyPY5vGmY=;
        b=izBWLdDeQ7H7OX2bs6j1cy7gdE4LJqvrtB6rVGcutRRaShm3ExYebxYKRBu71H96bv
         vLBBwNcaDXakATQwT5ZOuEovvVBUsea7kq7DHIsa3Pmw03+5b7wKAxqB1lUN6U7zuleB
         di11ii1YXVDL7VDlQV1Ivyv52EOSsR+H3dwVn9X/0zesbV20DBv7OBYL/xrtZ66poJUa
         DbEhOX1an2cQU0qCoeO8JsncOzAHd/oeJe2qRncDElmC3qDgSi/TFFCXsb86++R5hUwZ
         F0IDZurgz3hWbeVQxe5WtiWCgmQlKee6MPc7ymZjzyetdsPJJ3NRtCiXytmaq8KJwgaU
         zonA==
X-Gm-Message-State: APjAAAUXd2XE/3bOR7wpaZI2IvREmx2OmUwa1JgT7Auu8xPKopEEfBxU
        51sxKUa3m/fxVe5fe7oWDBj76Q==
X-Google-Smtp-Source: APXvYqxQ9UnmC8P3MRqq5j7TruhuhgZMla/aAffxt8Q2KbvIJZveRMEzuCq2DNpXVG0v5licMYLXCQ==
X-Received: by 2002:a19:6602:: with SMTP id a2mr3488274lfc.25.1560927422006;
        Tue, 18 Jun 2019 23:57:02 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id b25sm2548907lfq.11.2019.06.18.23.57.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 23:57:01 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:56:58 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/1] mesh: Move HCI handling to mesh-io-generic
Message-ID: <20190619065658.y5cjqjz764i6wkab@mlowasrzechonek2133>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190618112655.19963-1-michal.lowas-rzechonek@silvair.com>
 <34B4A752-E039-4CAD-A8A7-E8CC137DC8A4@intel.com>
 <F5913AD6-9050-422D-8BED-AB6CD2B434D3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F5913AD6-9050-422D-8BED-AB6CD2B434D3@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On 06/18, Gix, Brian wrote:
> > The intent if the architecture was to allow for finer control with
> > future controllers, and thus a mesh-io.c which doesn’t assume
> > anything about underlying controllers, and then an *initial*
> > mesh-io-generic.c which is what gets used by 4.x controllers... as
> > more controllers are supported with finer tuning available, then
> > mesh-io-<bt5+>.c can be added to the abstracted list.
> 
> We are also talking about how to share controllers between bluetoothd
> and meshd...   one idea is using the MGMT interface to send and
> receive specific advertisements...   that would necessitate a
> mesh-io-mgmt.c. However, it will also require support in the kernel.

Yes, I remember that discussion, and fully agree.

I think the proposed patch moves us in this direction, so that mesh-io.c
indeed does not assume *anything* about underlying controllers, up to
the point where mesh-io doesn't need to be aware of interface index -
the mesh-io-api implementation might use whatever transport it wants.

About MGMT calls (MGMT_OP_READ_INDEX_LIST and MGMT_OP_READ_INFO): I
guess the idea was to allow mesh-io-<something> to reuse this part of
the code. If you prefer, I could extract this into mesh-mgmt.c and have
mesh-io-generic call it. This would allow us to implement mesh-io-<bt5+>
in the future, and have it reuse the implementation, using its own
callbacks, while other I/O flavours might skip MGMT calls altogether.

I'd still like to keep mesh.c oblivious to HCI/MGMT/whatever.

Does that sound OK to you?

cheers
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
