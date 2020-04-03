Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0EEC43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D285C207FF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 17:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="lEnnCs0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404048AbgDCRzB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:55:01 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:43071 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgDCRzB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 13:55:01 -0400
Received: by mail-lj1-f171.google.com with SMTP id g27so7795901ljn.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2020 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6Y3JmRrd9MRUQqES6MNU+fEjUp4DvXrw8BTG4ou0rQQ=;
        b=lEnnCs0xYcyNcPHPp/UKrQ1XoCask9TB9Z/wQK75vKphRvQu74GYprmSjDgi23xHCA
         8LnEB6GA5+DFPHSsDZWMX1H5o5m0Z/WNNgV07Rvo9MEu/KoJobt4QNu+rRwp0XSzPQzD
         k4vFXejCw9a5ka0k+1A32hZI61L7rk7dJC8LYx33V6wtT0hdGnHa5zpbmpqSsBvqsFef
         sV0LJ9vpzi9rfz8ohkkZsddIFyk1zdykhtesqsRmIsgYrskOqn/KwPX2nHYaEe1rv/uW
         Ip+tagAYteoU84wVHB3lFWCZEKV0KRUqG4hA23EhYstPbFTNFcE5eHh//PIBz7JS1siO
         Vjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6Y3JmRrd9MRUQqES6MNU+fEjUp4DvXrw8BTG4ou0rQQ=;
        b=j09sNTkjRVVz/poK+XqO5ImzqecVKX0XYpB8aXku6ilT3yCNL/6B+sU2lfea6/DrbN
         wajCr1P6J3cjY+HpKHEr/6dBY1JwHctO5im2z+VnKZU/XudHi4rK6WWdeCSptRlZ+Fd8
         cZYHk73sWRpFwzEoqY7gj6R1NJWm3Ete4y+9BPmXC/mxXTWZ+YU0lfOIBTIz4B0z3rfx
         HD6AThmZHulZwg/+VqHmCzIOVJBS8beNINWSN4xRxeZPQKWdGScpK56NpLgZ71dl8C5d
         Oo4+iKzw7ovpNCMAEhz5yqGe8NB6Wjc6xmtB7yZctkfGk7Q02H3yulzzAJyGuqXJp3Qs
         buvw==
X-Gm-Message-State: AGi0PubyZfeyBVu/PtfiL8Q3z0jZ9yP3tThT8Bq+kNMUTorp18MZNnwp
        mhEV5kk0NQrltyRrFsf1qvuy7yMlcfY=
X-Google-Smtp-Source: APiQypJKO7vll0LBsOdpybigQwd3iC86dwWsVmO2ByvMGrBa//4onJxDaiOhKnpUGS/FspnHYj9Jrg==
X-Received: by 2002:a2e:9886:: with SMTP id b6mr5617139ljj.237.1585936498367;
        Fri, 03 Apr 2020 10:54:58 -0700 (PDT)
Received: from kynes (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id b25sm1242628lff.0.2020.04.03.10.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 10:54:57 -0700 (PDT)
Date:   Fri, 3 Apr 2020 19:54:56 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com
Subject: Re: [PATCH BlueZ v2] mesh: Fix FPE in overcommit logic.
Message-ID: <20200403175456.cnw6dz4gywwq6xte@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20200331090400.18379-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200331090400.18379-1-michal.lowas-rzechonek@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 03/31, Michał Lowas-Rzechonek wrote:
> During overcommit, mesh_config_save is called in asynchronous mode to
> avoid blocking Send() calls. This means that update of cfg->write_time
> is scheduled via l_idle_oneshot, so if the next Send() gets scheduled
> first, the code may see elapsed time of zero.
> 
> If this happens, then the overcommit logic was already executed and the
> overcommit is pending, so we can just return.

Ping?

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
