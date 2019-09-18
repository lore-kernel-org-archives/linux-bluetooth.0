Return-Path: <SRS0=h2kO=XN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087FCC4CEC4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Sep 2019 08:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA5A21897
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Sep 2019 08:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="IExSR8le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfIRIwp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:52:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37464 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfIRIwp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Sep 2019 04:52:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id r195so1551748wme.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2019 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uSqnHJlpyn3xUcaX0KRfG3ajKAV7jjvBrEfZ1jZSDvM=;
        b=IExSR8leupREi4oBKnBErWctxINqgJmgzO4C7hFcHo82hFsscDQbnJv0z/7sGhWjbr
         DGFgESxKCUQH8MTparSfLhsu4JNpvSRFR/GR1zDINjf+yLq3uazdnoG2WYg/RLQfBDnP
         +DyRuWq4SaLjPLz6dnoaH+6cFS7PLzbGn/zURnj7gdabfTXEbK3YD2bbXs1256G0TwbC
         1Q1pe5FoodXu8aHuG9FJ/hE6kRnZGrJzBLidkFImJ8bkgaJ4vSy4DuEOYVwxTQ2+g2Oj
         3WRqx9l/5TxYruWhGb9purggznmbXjEFPaphixsRaPC/pAXZiV8PiPNyBjbrMOZuF1Sg
         MRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uSqnHJlpyn3xUcaX0KRfG3ajKAV7jjvBrEfZ1jZSDvM=;
        b=XrqJvv/vL/H018HWRmSxrlhWOG2pTLRPV04KUcZFcgTSJpmBVsXqSV42ZeKKmJCZed
         qKtitmCCre0I/hqqqnkCDt1tQH2KzD8brZkFlBH3sS/8QpH0kLkyaGdRRdhusoqCqUz4
         f2EdqZFvN8ylrjiVo4GfeESiByE7v6eMA65X6Y/iQjiT5u30CcQVOc0GjRWa84hLjCsY
         rKJ2Y8wNGfIFz/B61I4nfa1pv0tkWQyTYWyvT1/z9nZsZ7ONC6ikATXIFmAw8f+6XoBg
         MR0SgIxkRXCxS6SOQjU19oXajkceEmGBGzCdWpTZygkdZeFQKO3czKKmHVb8MxG062oN
         jnIw==
X-Gm-Message-State: APjAAAX/n+i2yb9hNl62E+ncFXhgElRoi/Xt6X4h2fPl7dLapJtS4k9e
        rfNn28p9THNXg/7EjtoM8nE/Kg==
X-Google-Smtp-Source: APXvYqzjjMr9JXFDgwqVuLjjiwdHcMpmTxOdRHYgqpXllEaW6QM+5Jaw6np2EMqsBkh6i5nmmPBSOw==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr1942059wml.40.1568796762578;
        Wed, 18 Sep 2019 01:52:42 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v64sm2024300wmf.12.2019.09.18.01.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 01:52:41 -0700 (PDT)
Date:   Wed, 18 Sep 2019 10:52:39 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org,
        Piotr Winiarczyk <piotr.winiarczyk@silvair.com>,
        Szymon =?utf-8?Q?S=C5=82upik?= <simon@silvair.com>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Message-ID: <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
Mail-Followup-To: Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org,
        Piotr Winiarczyk <piotr.winiarczyk@silvair.com>,
        Szymon =?utf-8?Q?S=C5=82upik?= <simon@silvair.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190830184301.zd3zaqrw7mv6r252@kynes>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

> Imagine a dot-matrix, where each pixel is a mesh node.
> 
> Each of these pixels implements two models:
>     on element 0, a GenericOnOffServer controlling the light output
>     on element 1, a Blinkenlights Server model
> 
> Blinkenlights Server extends GenericOnOff Server and GenericOnOff
> Client, and on top of that contains a translation table mapping group
> address to either 'ON' or 'OFF'.
> 
> Now, when Blinkenlights Server receives a GenericOnOff Set message, it
> looks up the destination address at the translation table, and sends a
> *different* GenericOnOff Set to *its own* element 0, with target value
> determined by the translation entry.
> 
> This allows users to configure each node in such a way, that sending a
> *single* message to a group address causes all pixels to switch to a
> preconfigured pattern *at the same time*.

Per conversation with Piotr, I'd like to revisit the discussion and
provide more details about our use case for models knowing the
destination address.

Please see a diagram at http://ujeb.se/BmTIW.

The main reason we map scenes using destination addresses is that such a
setup consumes much less unicast addresses.

Assuming that:
 S - number of switches
 B - number of buttons (elements) on a switch
 N - nunber of lamps

With a 'regular' case, number of consumed unicast addresses is
    S*B + N*(B+1)

With the destination mapping, it becomes
    S*B + N*2

Since we typically use 4 button switches (B=4), without translation we
consume unicast address space at a *much* faster rate.

reagrds
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
