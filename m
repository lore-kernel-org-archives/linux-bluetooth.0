Return-Path: <SRS0=q/Kg=T6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A9EC072B1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 May 2019 06:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D449247CD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 May 2019 06:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="fiRoFiXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfE3G6i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 May 2019 02:58:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38861 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfE3G6i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 May 2019 02:58:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id o13so4983448lji.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2019 23:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8Ybm2xNSDPNpQcDRe0OBHmOkNGFxQ7oqQWs+ADD/knc=;
        b=fiRoFiXCUv4xlbK23DsbJj3OxBp6mXY56YuVljbzNQy6yVLZeIUZf2oWGymD8PAtbH
         wkqzIdVDXYk+uylViviQjClb49XmAuYByByGTolmYPfAPEc1GgUFJWPW5xDnn/Xh27qT
         0z8MSHDqTZ0fxEdKlRZyxkze0nu9MIT/yilNIh0cOG0X2NLSMAXng3TNonfSR1vGWURs
         TmjbkRWW+qaYzDkZlHxw4zlpBKj+zTDNM2ouq3KBibMiR6DqNqV+0vkG1H64OC+TxMN2
         j4J1KBgRx/5Kh58gwaXNiTNJDilifVASFuez0B+sDCxM0yMcIhLzUobqCQ+aK7D9ArX7
         v+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8Ybm2xNSDPNpQcDRe0OBHmOkNGFxQ7oqQWs+ADD/knc=;
        b=lh3+mWqDBU6YPrzgEwQhqIIUB7uKncSi6zJgwIty+wBBhk12PtAZUla8TWIv12+UG4
         ppPR8yghPv+0evF3VT+oFZq9W1FL0jIio/ml9TFy0DOcuWgEY+uJtq5w2hHZ8+0LzW4G
         LPcmSoW5ZS1marrVbTuwYk8saCsEQAr3jkUM3pfOpHCGSxyRkskmk5+LVwlDiR9TjyyZ
         nYZhBC2p3ZXjHqHMKn21pre0v68zCMzXazA7VOfoZL24LIVLzgchPSwRt1Sw6ah4+tJp
         AOni1i1hDBXMSOPlYaMxeqlp7phPAuLTIYcqaQYl8j6G7IN7RLxQs3XakcIlT6uiK9ka
         e9zQ==
X-Gm-Message-State: APjAAAUPFbuoDTseHSu+AC39YQbl8/gYZIYWpmV8kJMMMI3A4ch6vrp3
        Fq8S7HIdtUqJbi65rGAJH/lxUw==
X-Google-Smtp-Source: APXvYqzhfYeLy5zcs3i6xHH7zaN25HKb/ZHSxlZ0BYanZHF8IXo/bIC+gZzs3Wf7tdD8EGXC3hjTPA==
X-Received: by 2002:a2e:7808:: with SMTP id t8mr1090479ljc.78.1559199516430;
        Wed, 29 May 2019 23:58:36 -0700 (PDT)
Received: from scytale ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id y19sm320684lfl.40.2019.05.29.23.58.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 23:58:35 -0700 (PDT)
Date:   Thu, 30 May 2019 08:58:33 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        marcel@holtmann.org, johan.hedberg@gmail.com, denkenz@gmail.com
Subject: Re: [PATCH BlueZ 0/1] mesh: Convert all crypto to ELL
Message-ID: <20190530065833.acnzga3knthhh3nk@scytale>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, inga.stotland@intel.com,
        marcel@holtmann.org, johan.hedberg@gmail.com, denkenz@gmail.com
References: <20190529172818.8844-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529172818.8844-1-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 05/29, Brian Gix wrote:
> This will have one major side effect in that it will no longer support
> kernels older than v4.9 (I am personally using v5.0.17).  I am told
> that (some?) Freescale platforms also will have problems regardless of
> kernel version.

Alright, so I agree that it would be up to the vendor (i.e. me ;) to
provide a patch for older kernels.

I think the most sensible option would be to patch ELL to use userspace
fallback, instead of patching bluez. So if you could just make sure that
an appropriate unit test exists within ELL, I have no objections.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
