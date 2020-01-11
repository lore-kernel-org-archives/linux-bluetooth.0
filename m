Return-Path: <SRS0=d6qz=3A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BDAC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 07:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4499206DA
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Jan 2020 07:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Vf6/1Lgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgAKHTV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Jan 2020 02:19:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33245 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgAKHTU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Jan 2020 02:19:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id n25so3209793lfl.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jan 2020 23:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fa2M5eeaQafc5g38hJFJUuo5DPxJiu2kaUWeTZWQbCc=;
        b=Vf6/1Lgoswl7L000nIBeKoQhAqTiYuKWIK7I2SUAUpaTaWq8ZNtOOxt9q6Y8mpcGHx
         N6bgmseB/mpnKwx1yGGVPgogYAN8iEIz97pMhCyjyio6hQaX3PobKPX2YBuq08UqDV7K
         2IkMRqAg9XDjKqtwr8QPPgK2+u9rY5XLbAIu3DHXATRvbplD8ORm+wQJhRMfdN1rdyDJ
         34aO23v0HznBjz7eaZClOhzmCSHesEa8E4gspa3RbpMoKUp26Um3uDMq2bPEC2XMnmVi
         X5X07LYfhMtJzz/lhc9FkyMa9d/3tqV9TFn0UAC835Hz+2xJiscH8d+k+8UCBg+E0qU/
         8Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fa2M5eeaQafc5g38hJFJUuo5DPxJiu2kaUWeTZWQbCc=;
        b=nC0wpZaMYs+xKBehioUhaLlJLg+JvdkU958YaXZYH/r16UgSzmaDERockhyFJodQxw
         1vLytBFBrQl8qiEJzVOxRFixPaAg6RiUnnXrlmkoOWEcWK9wRFaL/PTvzKRb0JpCaMPm
         oxoSOEK7sFnsyp0ZdgusQg3Ooo7EZRK6DgqVS0nWDZ2LWhrmU7GlgwdZ0Bcple6MFwTB
         +bK57OVQkbBJkI9ncLeGQ4eOgq/S8OJXuJJNx+2sM+1ZdSOmlPOH+9TwRZeUqoMTzPEc
         gpHg87kytlKhhHMi7b32jKNyCn7POE0NLeY6eLDfo4ftVO+JYVUGQhoQJVqqQYS48GX/
         EkCg==
X-Gm-Message-State: APjAAAVo1byymr1SrAwLu7Opqomgk7bw8RxIovKDZgIA7i2HLmIga/Z9
        w7hFM/gRBa4NI+4+Vzf+MHd2RQ==
X-Google-Smtp-Source: APXvYqy0Ikm4w0qaMVKECzat7OKPLAvA3G3bSiGW8iTl58jgEe4tHuNGTlPPPajac0tURCQYga/IrA==
X-Received: by 2002:ac2:5147:: with SMTP id q7mr4772040lfd.87.1578727158850;
        Fri, 10 Jan 2020 23:19:18 -0800 (PST)
Received: from kynes (apn-37-7-124-67.dynamic.gprs.plus.pl. [37.7.124.67])
        by smtp.gmail.com with ESMTPSA id l28sm2175139lfk.21.2020.01.10.23.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 23:19:18 -0800 (PST)
Date:   Sat, 11 Jan 2020 08:19:16 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>, linux-bluetooth@vger.kernel.org,
        inga.stotland@intel.com
Subject: Re: [PATCH BlueZ v3 1/1] mesh: Implement provisioning loop-back
Message-ID: <20200111071916.7skwicdkdwpngfja@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20200111013856.32675-1-brian.gix@intel.com>
 <20200111013856.32675-2-brian.gix@intel.com>
 <20200111063425.5sn6mvrlu3rkx3ka@kynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200111063425.5sn6mvrlu3rkx3ka@kynes>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 01/11, Michał Lowas-Rzechonek wrote:
> > @@ -93,10 +94,43 @@ struct pb_close_ind {
> >  	uint8_t reason;
> >  } __packed;
> 
> By the way, why is this struct packed?

... because it's a packet.

Seems like lately I need to think before hitting "send"...

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
