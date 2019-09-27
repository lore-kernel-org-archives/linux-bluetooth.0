Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F403C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 08:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E76D217F4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 08:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="zIuBn7Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfI0IwN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:52:13 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36753 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbfI0IwN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Sep 2019 04:52:13 -0400
Received: by mail-wr1-f53.google.com with SMTP id y19so1782221wrd.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2019 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jCS/2uPi1D7uyYN61k/Wdi9pHIZNPSQWwe6XsqOM/TE=;
        b=zIuBn7AhfkjWfzb2FFgbQv8UG7f1m1QEWiLBUkTtui3yPqBSfxznRUy/1mEEQX3jiW
         dTVSOdMLNiUqE3q8E9TUgNLgjEKTkD5fU7nC429aO5YdHTcrR2PMiLbOHrozm8EriwUK
         kOrPu5c6fofGGNwN/5VarUAvvWTqO6JBINkny8GFO2oZ/IFzNenabAmhNXSzmXxmmuu/
         CNicA3UFUxxXyHMNX87mSfnd1CbCAPAv5QKyZc9KM7S5e2a/Azo6jL9YQEnc8oPbaIT8
         FzhOHMJWinhaj6UJ87Jm8U5+oYMlTEjqGuU/zKWMKukQl19sUFTZRg6Ij4kOqiaUzQg9
         vzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jCS/2uPi1D7uyYN61k/Wdi9pHIZNPSQWwe6XsqOM/TE=;
        b=cC+6UJAj3T0C7Xw8ZqK1ZmZCziqKPcTnKwHoBs8GtMtRYmHKci4n7pAyjy5QQdMoRO
         8FQc6Ncyt1Gq4N4zHKsbU5sodEJsHKCmlQefYuSmjiXASXn3cbb7NrSNljMR9EUIAHVy
         lQEgqVLtV5mbLxMQfYkTgwZuiJb0YGBuYl7V6pPlaHPhzsd+Acq6kNoXpy+kVAVlnpEe
         cuCzC3KqTPFgzDlZ9TLKw6sQEl9baOg6xgDbezLKxeDe2RhSs+zW0GSPZ2NArruc/xFi
         AFjdK+lxj9zQRSqE7fq5o9wsYNBMQd8dRzmROiVuU2WOeH9ozuIJUMHaHLhP0qlHQc4g
         0q7w==
X-Gm-Message-State: APjAAAVnt7zbpIM1BZ9WwfsL1f1rRyt4fPm7bP+lweGw1eq/IelIT26s
        ZULNiZcudV8KQDXmXAzoJ+xazg==
X-Google-Smtp-Source: APXvYqxIzrp6GNUXYoMr7wwzlID3PKGQDIxkk+pF6uvWFM59UFl2e13eSaKbnoow4pa2DZ5Q/A9UMA==
X-Received: by 2002:a5d:460b:: with SMTP id t11mr1852520wrq.377.1569574331061;
        Fri, 27 Sep 2019 01:52:11 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y13sm3278765wrg.8.2019.09.27.01.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:52:10 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:52:08 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Message-ID: <20190927085208.sxy2x5656ci3opo6@mlowasrzechonek2133>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
 <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
 <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
 <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
 <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Inga, Brian,

On 09/26, Stotland, Inga wrote:
> While I am still in favor of two distinct methods (given choice, I'd
> always go with self-explanatory API)

So do I.

> I vote against u16 destination field since there is no reason to
> create address space collision even though the chances are small.
> 
> A single method "MessageReceived" method can be modified to include a
> subscription parameter as:
> 1) a dictionary with keys "Group" and "Label" (self explanatory if a
> bit cumbersome).

If we really need to avoid two separate methods, I think it would be a
bit cleaner to pass this parameter as a D-Bus variant of (u16,
array[16]) instead of a dictionary.

Still, even if we add a method, the application is free *not* to
implement it, since we agreed back in the day that calls to
MessageReceived do not require a response, so any errors would be simply
ignored by the daemon.

> 2) a u32 subscription ID that represents a subscription. This 
> requires the daemon to maintain the relationship between "id" and the
> actual address. I believe the daemon does this anyway for virtual
> labels, but from the API design perspective this is not very clean
> IMHO, since it has a whiff of implementation details leaking into user
> interface API. 

I am very much against adding any kind of traslation here. I think that
maintaining subscription IDs would only complicate things, with no
additional benefit. I think it would also confuse users, as there is no
such thing as 'subscription id' in the spec. Mesh is already complex as
it is.

> No matter which approach is chosen, the subscriptions must be included
> in the model configuration dictionary for UpdateModelConfiguration()
> and in the corresponding dictionary for node configuration returned on
> successful execution of Attach().
>
> > > Then it makes sense to add model subscription array as a dictionary
> > > entry in the UpdateModelConfiguration() as well as for the node
> > > configuration returned when calling Attach() method.
> > > Probably will have to have separate keys: "Groups" and "Virtuals".

Indeed, and we also have two options here:
 - if we decide to provide two MessageReceived methods, I would go with separate
   keys
 - if we go with the variant approach proposed above, I would also
   return an array of variants here

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
