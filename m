Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90308C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 18:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A57524656
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 18:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gvjIPVtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgAVSD3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:03:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37156 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVSD2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 13:03:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so304344lfc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 10:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zYMagLR8Ow8wzklC0BM7gY3hNzJuTXm7/8bL9Y1rD9U=;
        b=gvjIPVtfp6YwxmMSaPd92Vz1DRTt+rPGV1Uo0DuM6bNQoglZvO3SBNPLXS1BaJqKP5
         LjpzoY9jXct+jH15SjZ2i145+HL+0CqZVIy+I2R0jq9PQvEUHwUFHKuYB3F+vvuVH5JU
         0r1ezzLusk3cO96mYTmkHNX4SPLCdGGvLjAukwOPAuyFRubUQZFGOm8D2t8JCI7s713T
         UTg+Rf9YgX/hUFMZaH6iD/ylXinvsywKVUe6s5ROThZl1Y+tMM4yjGqvaaUrvvybp33l
         7JpxMNC0ltJwo8/4c2MrtV7FmI9mZNticdw1nMn9TPYQT3RXO1b3Xbzce0o7Mf1667lK
         /znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zYMagLR8Ow8wzklC0BM7gY3hNzJuTXm7/8bL9Y1rD9U=;
        b=qeJ/oi2+aSQPLkgR/VNU+f1B/oqkD6wVnknqsbF4i3TYDbExPe7EOpl3YwxeQgORpa
         24pWHO7XVNEccZv9wxlcyGbw3lBwCewthFiFlyLRf0EAizz3fK6lTZDry7SYULkbnQ4O
         ZNCHlnuuBW9pxQma7xfaCVW61jQH5XmgcvQo8bVK3VrjqIa8lgZr8zRXAeDFS3BKxelT
         oc6lBLx+JmZPDHOMYlQ9jys+73Um/CskUvUiIUgl4mP5/N7nz08LM2V6zUl44VZDYrfu
         1rGOPsBDXX3BiT4UbIE2agAtvN0AZMR9Wn45UYRoD2UbXU9yOfmWwcw7lMJj86ozck4Y
         VpIA==
X-Gm-Message-State: APjAAAURu6e/CeVMeAWJ2ZiFS/7gAAfuk5Ulr3jRqapzZyuspIcBFWqH
        EEQ28UjY/lFjuiwBcPwoqqGqTlQErlYF3g==
X-Google-Smtp-Source: APXvYqze3aho11rviUL89ox49WPQcDQUby3gDxHEPZyY7IEXqzfRQ+4Ccw82f2j4/WHOpjzRrNIy4A==
X-Received: by 2002:ac2:4a91:: with SMTP id l17mr2461045lfp.75.1579716206792;
        Wed, 22 Jan 2020 10:03:26 -0800 (PST)
Received: from kynes (apn-31-2-112-202.dynamic.gprs.plus.pl. [31.2.112.202])
        by smtp.gmail.com with ESMTPSA id w16sm21568147lfc.1.2020.01.22.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:03:25 -0800 (PST)
Date:   Wed, 22 Jan 2020 19:03:24 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH 0/3] Allow to reattach with new composition data
Message-ID: <20200122180324.7anqg6p7rfino43e@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
 <56b3aa902dee18a45e91d826344085cf1fb3ecca.camel@intel.com>
 <20200122180230.h57v3snd6x7uingg@kynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200122180230.h57v3snd6x7uingg@kynes>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 01/22, Michał Lowas-Rzechonek wrote:
> On 01/20, Gix, Brian wrote:
> > This will require some discussion.   Currently we are planning at
> > *least* to make CRPL entirely under the control of
> > bluetooth-mesh.conf, because this has a significant daemon impact.
> 
> Alright, but at the moment the daemon accepts whatever the application
> specifies. The proposed patch doesn't change that, so maybe let's keep
> it that way until a dedicated change in CRPL behaviour lands?

By the way, would you like us to prepare such a change?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
