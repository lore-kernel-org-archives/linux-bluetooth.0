Return-Path: <SRS0=E8Rw=U6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFC7C0650E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E2D20B7C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Jul 2019 19:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="d23M8wBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfGATkD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:40:03 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:40122 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGATkD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Jul 2019 15:40:03 -0400
Received: by mail-lj1-f170.google.com with SMTP id a21so14429913ljh.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2019 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Av5ASeYPcZEafE3mJChu1s+BPROAWgoAYr0NjyqtGx4=;
        b=d23M8wBQIfYkxyJMJzIuWNEFckjqWF4wRuHT89SOAYzG5u2POvnEV586ZxrCMFTrua
         S/vGkIeLZYcg+qKU2sFCtkGnkZsgyjDuEYr3FudzZWXyp+zEuowVu/xXGfj66XRZ7UQj
         sCT1Mt83vztJuBnbAaXmCdNRRJAMH+ZlPeVxipE9XFxct2lO7p01g0c5KTB12LsiC/eS
         anYoS1APH6cJA/CuIHjK4xaiwNzilpaHctkCjIYW34OY9mjOpndihI4q0PEf8nWp/gwB
         rsw37jrfPTZ0ug+bta0+rxEmILp/1JS5oinz3YR7RLFxyl+LcfKmMxkObkLjGvEi/PV5
         QfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Av5ASeYPcZEafE3mJChu1s+BPROAWgoAYr0NjyqtGx4=;
        b=S3TNn3xuB1m0qaIAFqUmXc+oPlU0TmxKImr+vsnoCtXt4/X+M07Ayo0cgH8ad30PQ/
         dj1+Ok/cLBbtp5mdeRh0I6azbG/1LP+A/YF2tB6jqIrvFHla9RGks3z0jg1CbjInmXRI
         8oK+51dJcQq/7XwdmSCpLt1Dx69v2P5bAF5XusCilBCHFmfMBUhoLk1MlFDenTkFPD8t
         I1NzIUEik5Q4Tz7Q7sRD4kaImWbEZUJjZsJ1dbzQTrWCfy/mhVaLJdJESkOLl1DI7d2m
         Zp2jdhiV1AdajF6DHtVUozcyKADmhE7fNEH3t/dUW0FIGOfpvEkJucmJBESb6JTFZBH+
         YSpw==
X-Gm-Message-State: APjAAAXQheCqDHBzOC6SxTiQx7+j/0SKMVt7VT3GWL39bLo0JfFCg0pt
        32PnfI+EX/BppdnUF4l+6A2DfV8k8VI=
X-Google-Smtp-Source: APXvYqw7D2gO9whLi++saCj99QUtg89gOvVACABhNRR399PavfqrA8CcAa94879PGVWw/fWEuwwADQ==
X-Received: by 2002:a2e:9b84:: with SMTP id z4mr15306361lji.75.1562010001175;
        Mon, 01 Jul 2019 12:40:01 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id l15sm275152lji.11.2019.07.01.12.39.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jul 2019 12:40:00 -0700 (PDT)
Date:   Mon, 1 Jul 2019 21:39:58 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ 2/2] mesh: Register D-Bus management interface
Message-ID: <20190701193958.hkyb3x6nm7ecn7uv@kynes>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Inga Stotland <inga.stotland@intel.com>,
        Brian Gix <brian.gix@intel.com>
References: <20190628082734.18809-1-michal.lowas-rzechonek@silvair.com>
 <20190628082734.18809-2-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628082734.18809-2-michal.lowas-rzechonek@silvair.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga, Brian,

On 06/28, Michał Lowas-Rzechonek wrote:
> When application Attach()es itself, start exposing both Node1 and
> Management1 D-Bus interfaces.

How about this one? It's needed if the application wants to use remote
device keys imported via ImportRemoteNode API.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
