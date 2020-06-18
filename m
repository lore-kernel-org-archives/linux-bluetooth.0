Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875DDC433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659592075E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 15:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gi5PeLgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgFRPyS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgFRPyS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 11:54:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF72BC06174E
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 08:54:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t74so3786665lff.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E7+l03fsBHCYz8VsMiL0F/uUy+gdwbJV4YORJA1NV58=;
        b=gi5PeLgbguTHZLL+aZpArO2k+fWJXPZrYxYlVQbEt12jJzFYMbKTlKbgzo0/6Iwurj
         bqeJn0IUs/gqI297WBAnZ5SgIPB/5jq224SyVPXgLr+H8d5AyEC2w+cEzDtuA5CfTn4G
         dkM3vojgPx/ItFjnQ7WOpTPNBk7jug+vy3KP3NG1EuXsvb5T3Uhrpb8xRbhC/uz6T8h7
         4VwmR+LFiahv//buqfFy97oyNnqE1RbTxwWve73bDSvAU1KFuoTj7mzMFeil63yq1rMe
         0w9HmSURnGWRYuNOHG3eQ50Cu/+bDkEsWU6TLP1CS2E6t9xpv3kDgey+2KP+4PaOsRNS
         hU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=E7+l03fsBHCYz8VsMiL0F/uUy+gdwbJV4YORJA1NV58=;
        b=K2UrH83a5mr3BwOShnpIzMS3lnAhSaH6F1nQrX1YoU3eqSoOzzVaLQ0ZgGbHvv7GUS
         PC28jbNVXD0f8Tz3aGvwrYvhKJFm2f63hsYLsUE0CsRocIdJBhxUI/18iRNobU/6xEdd
         Ri+5Foxi4cKgBwNgoAL2nUJR6TwaR7p4uyhmQ7VPr+3f2fE5CNgHXf1BsnmOOomIR6I+
         LKZ6Xk/AwXhgbubXqcLHI+DPfcjXDV7TarGvawlEqqKrgzoTb3on5BFLqrpxrknNPO9n
         eKCc6Mys2om3FAbky24MlTQt2y1q23y/oTpWhFguhPK9vsZLanNDZT7rnG8qp2YcMI/+
         AGRw==
X-Gm-Message-State: AOAM531KcUcQKPYPun6ygfE8w4R+f4xWvFiBSY/1qiID+i2jxrFoyni8
        Cwr3eEUNCEyt9xUV6dTFaTgy5g==
X-Google-Smtp-Source: ABdhPJzABfuvMtrhjo9Z4UUxv48pxRxeoBF6ItLLIjpRDbcZZENxxcgLe1uRRy4qEZlaKdcBRUELDQ==
X-Received: by 2002:a19:4945:: with SMTP id l5mr2751845lfj.12.1592495654592;
        Thu, 18 Jun 2020 08:54:14 -0700 (PDT)
Received: from kynes ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id r17sm804544ljd.0.2020.06.18.08.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 08:54:13 -0700 (PDT)
Date:   Thu, 18 Jun 2020 17:54:11 +0200
From:   "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Add deferral of Attach() and Leave() if
 busy
Message-ID: <20200618155411.coomela7gawizxxl@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
References: <20200616181436.50319-1-brian.gix@intel.com>
 <f4c0a48f8d7c30b7c12bdcce84cf8ee172709daa.camel@intel.com>
 <20200618154325.eaudqfy4inbjl7oy@kynes>
 <12a59828baabec5621917d283e03338d796715f3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12a59828baabec5621917d283e03338d796715f3.camel@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 06/18, Gix, Brian wrote:
> I am using the user_data for the Attach and Leave call (which the dbus
> system always passes as NULL) as the indication that the timed
> deferral call is just that...   Otherwise if we *never* get the
> JoinComplete response, we will forever loop repeatedly re-deferring
> the Attach/Leave.

Ah, right. I missed that part. Thanks.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
