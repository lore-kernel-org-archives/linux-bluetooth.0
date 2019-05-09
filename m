Return-Path: <SRS0=Q31N=TJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2615C04AB1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 19:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C920656
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 19:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="oBDwJ0sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfEITLk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 May 2019 15:11:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37037 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfEITLk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 May 2019 15:11:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id h126so2356684lfh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2019 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=U0P9XFjYm3AUa4GTdhBQBlitfwmftJFA3SrNmoWTmro=;
        b=oBDwJ0sDKMpuwIyIuuKzGk8OlVd6Z79UwSIM+Ajvy82IXByT1nItaxwiESEVE0xuTh
         0UQUAor9THQgmZnnjFWchNF+pUOiyahISijiAYA7MFlLyi3IqKjYAp+0Iov1VgujOMVw
         s2I1hMhvCARUFM4/vWY6INScwat3geH3BlZkRJrXlK/XzL6cHS+SUsR7fsM36JgwJybS
         PMnb164W8em3lQBOflFvh2K7JQIF/rT0o5Le+d3wY7fcsnZaiPUyffLxCPTtYz1As3Ws
         6Nn6/Ff0rrDCuOGDOdl1yqRbaGW9ID/ydNFFp5fPefsLi4+JNGLkN3TYP8seU8TQMwid
         pvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=U0P9XFjYm3AUa4GTdhBQBlitfwmftJFA3SrNmoWTmro=;
        b=ZPTsm9Bsstwdk2WNMleled5AeZRo3UZV49haiCma8iwep5ISrnvOnlwD+BLnHLaDsc
         ee719RElw36Fw/HkdDaBF7w4GBosi6VCzU60pNP0RpQKd7zgOrxW7/PvSj5/8F7jqFmj
         rvtY0IQdNFFTDF0+MuPW7hOa9a9tgAWs7OptK5lDQhS4dr0q/1Wp/rpnaIHP9yUACs4X
         szpAU5X52qvzG+AgTPY249Bung2J/Nbchpe/AiAkrXqrOww8FmspuknPltdndNS0R2V0
         GRWpbtjNiN5yAYFzE64UIcMpeb9SZgPNs8eR9mt5OHDaEQN45iaSzLrOURHn5W3GzwE5
         ElCw==
X-Gm-Message-State: APjAAAVfWRI/AEsHpY6AB+h36HyZ87H1XjMLGqDX6rjy9vMtZxMVz+Gk
        XGjFyKPv32O0c7lylpk+j6vnHw==
X-Google-Smtp-Source: APXvYqzQrPLk67SKdDDkmJ2NRZ7qQcudKcvo75p1ESfo9JoelMSIQQ98aJGWHnTALE9/4Iauzs+rZA==
X-Received: by 2002:ac2:523a:: with SMTP id i26mr3397658lfl.118.1557429098521;
        Thu, 09 May 2019 12:11:38 -0700 (PDT)
Received: from kynes (apn-31-2-19-253.dynamic.gprs.plus.pl. [31.2.19.253])
        by smtp.gmail.com with ESMTPSA id e19sm679693lfd.36.2019.05.09.12.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 12:11:37 -0700 (PDT)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@kynes>
Date:   Thu, 9 May 2019 21:11:35 +0200
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ v5 2/2] mesh: Add key storage
Message-ID: <20190509191135.y6rbo5ziv6hrxxah@kynes>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
References: <20190509175739.16891-1-brian.gix@intel.com>
 <20190509175739.16891-3-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190509175739.16891-3-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi again,

On 05/09, Brian Gix wrote:
> +	fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC);
> +	if (fd > 0) {
Hm. I might be mistaken, since I'm not that much familiar with systemd
internals, but 'back in the day' daemons were expected to close their
stdin, leaving descriptor #0 free for reuse.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
