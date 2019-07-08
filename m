Return-Path: <SRS0=sF93=VF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE7C606C7
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F48121852
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 18:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="EJER6KPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbfGHSWQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jul 2019 14:22:16 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:36772 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732117AbfGHSWQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jul 2019 14:22:16 -0400
Received: by mail-lf1-f43.google.com with SMTP id q26so11596982lfc.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2019 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rCy9lTyFlchYxHM7RHUu+DdDngvtOzKKharJdmOjoSQ=;
        b=EJER6KPO5TqRmtx8cmrGzr+uWdqR/Fakn1AlWksUSMv4ISsvmZo7Sl3IW2Ro9iEekL
         2M8wT3dWD6S004h0JJ3BjByCETVSvdKF+HHDITZN8ZcmsOEj7HbiHYOH3vXwPP9S4m2n
         /zLdKDl5bAzfiocvpAiZbNZAz1YMLVG1RZXcfG2Yi6bKkM/s5IKHSGM+HGNTiGoNW1Yh
         mZUKVtxA3GysVQQsc277FRsNK0hDe6STQpP5sWv4o6dlZyXwXgZZyy+FYRlNTI53dNIb
         tIY+LxlGu25g+b/+KQz8BRDDawmCBS3C6S6eOrUrRU2sYXpKi9RA8nQjGDtfR3N9JUWc
         Ejcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rCy9lTyFlchYxHM7RHUu+DdDngvtOzKKharJdmOjoSQ=;
        b=c5XWLnY1iKwgZnJYNS1IPu6Yi3noIiQ3Ipalvq9Z41KVW1N9a5D90fqcdXJ7JQ7Fgu
         q0wD507zApi5yBnK3IKAyw2udeTpEbBYHmuzI1hiUIbZcXpLD1gR1Qj+Qee0mGidPGKf
         HwR6CI9iLyGvbhqUm7rNiy8hNSh1aMZq19PgkQfQ2NS/GP25OyiYU920eGJUsrpXxwXP
         Yr2OOWt15h4x2Z+4BDfr1sRnL/XwVM5xkF6S6Jta4qTOxtaCEwJCbZ45xJT/cUJqjo6A
         1sixqHgjXiz5jJzbwNZ9RoMY2zrQcwbaAW8p9sHQvvmha/9ldAdr2TnINuiAbMP1I/nJ
         d+aA==
X-Gm-Message-State: APjAAAV2UM1bUOAT49g57JpUFxtWnC+m68pbi2AjgiIVVGepdUNJoHwf
        Sb3NmPlxeGyyePfKXM6r4vbHXA==
X-Google-Smtp-Source: APXvYqwWW0M13zEVcFQvEBInoUUnRYzJJaCBdkhJI48ENBNRuPs5PewtVG4uuMmp4TabL0xsA8P+lw==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr5083374lfl.0.1562610134457;
        Mon, 08 Jul 2019 11:22:14 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id l11sm3182157lfc.18.2019.07.08.11.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 11:22:13 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Mon, 8 Jul 2019 20:22:11 +0200
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [RFC BlueZ 0/1] Validate element indexation
Message-ID: <20190708182211.yxkucondnw5x6ay7@kynes>
Mail-Followup-To: "Stotland, Inga" <inga.stotland@intel.com>,
        "jakub.witowski@silvair.com" <jakub.witowski@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
References: <20190708141314.13950-1-jakub.witowski@silvair.com>
 <65651744c67ae13bd95ffac88fae42f0f6c16c61.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65651744c67ae13bd95ffac88fae42f0f6c16c61.camel@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Inga, Jakub,

On 07/08, Stotland, Inga wrote:
> I agree that the validation for the gaps is needed. Interesting point
> about max number of elements...
> 
> I wonder if a better check woul be to we to add to construct
> composition data as a validation point to make sure it fits in mesh
> message. Plus, an additional strict check can be done when Attach
> method is called: stored composition can be byte compared to the one
> dynamically generated from collected properties...

If I read that correctly, this means we would need a way to build
Composition Data on the fly, during get_manager_object_cb processing.

I think it would be possible to get rid of validate_model_property
function - instead, we could build a temporary mesh_node instance
using information provided by the application as-is, and then:

- in case of existing nodes, generate Composition Data from both
  existing and temporary instances, and byte-compare the two

- in case of new nodes, simply save the temporary instace to 'nodes'
  list

All of that assumes that Composition Data generationchecks that:
 - everything fits into a buffer (this is already done)
 - mandatory models are present
 - indexation is OK

I think this would make things slightly more consistent, and we would
get rid of most "is_new" checks during attach/join/create/import.

regard
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
