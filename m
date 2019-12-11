Return-Path: <SRS0=dcS5=2B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A1C43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 15:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9BE2073D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Dec 2019 15:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="JjnZAH5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbfLKPs3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:48:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46659 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732172AbfLKPs2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Dec 2019 10:48:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id z17so24555034ljk.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2019 07:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sTBB2t6rKSXBONEhd/znnnhumhrJUK9npg8h8UNSDc8=;
        b=JjnZAH5O8aHDzEgg9j5GVnPpAPmLgw46304TfjEUFDSC0/gB7iGvxnKQefnlNMrhO+
         7Z4aMZAZha4IyS7mNhcN15BC74zooXPMD4TrsVLiWWosKIv9HhtitZF0ntub94enCeKp
         ILtoOwWwZHuTZ4EyX1RyfTrOMN+TsLEwZZnGXFFCX8I/YYHbZzlAAqsxYlJQADt3JnCr
         MfF541gRrHT78Qyfmc9bO5MU6xgV+xJJHC2Y4nassMT6Yl8Z43jGfvx+06rsg7BEpTZF
         j7MCZN3+YVSQwU3reFQY4AN0slggrrvyo5TWZNwJdh3UoldW/k4RGEKQjz+dj8TKUrin
         LcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sTBB2t6rKSXBONEhd/znnnhumhrJUK9npg8h8UNSDc8=;
        b=Qohc8KII84Sw2TCro2ByJckDdPP+UZ5Iey5n+pLlOcJApgqJaPgrcbOuzNNtmXGb0l
         uRFVkPsKxUbFd9/4SyahFCyqeKSeC7I5PeRZXegeG9tC86ga+izYZvaEqjADyxTC6g9C
         fsUYjNrUK83NWaSoYYaldGi0NIxxFeUIRX+r1sPJo/N2tYLfVETDCPk3+/L6x212exJb
         AezDf5nFnv6IqGrQuvraYwYQ8aGjl/V2n5T7ju2+iI+7Nzwzo2lFC2vXY37hPb7Jy7sO
         bSljyAqyrXPIj8+lLwOoWQNMCqTciwd+Qm2o8AtaPU4cOm2Okm/bF6ruZQ2FfVkmQs7Q
         Eg4w==
X-Gm-Message-State: APjAAAV5ojPNjD3egtZMt8Zu7rTAHaOSMZNy4eNyFRTD4AWLnPfVKjTn
        TXMW5W6z0Smt7v91G+DazrDGtNUsO9QZuQ==
X-Google-Smtp-Source: APXvYqzanjrYqI/sDK0qdNADiQCI/Mz4cwkx7jF03QZlsTfgHk8Rgpr7kQ1qWerP6cw4XgPepdOTGA==
X-Received: by 2002:a2e:9987:: with SMTP id w7mr2569122lji.107.1576079305615;
        Wed, 11 Dec 2019 07:48:25 -0800 (PST)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id a9sm1395663lfk.23.2019.12.11.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:48:25 -0800 (PST)
From:   "=?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek" 
        <michal.lowas-rzechonek@silvair.com>
X-Google-Original-From: =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek <khorne@mlowasrzechonek2133>
Date:   Wed, 11 Dec 2019 16:48:23 +0100
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: Re: [PATCH BlueZ 2/3] mesh: Clean up node.c
Message-ID: <20191211154823.b4hwkqor5awnxpat@mlowasrzechonek2133>
Mail-Followup-To: Inga Stotland <inga.stotland@intel.com>,
        linux-bluetooth@vger.kernel.org, brian.gix@intel.com
References: <20191206205749.12918-1-inga.stotland@intel.com>
 <20191206205749.12918-3-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191206205749.12918-3-inga.stotland@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On 12/06, Inga Stotland wrote:
> @@ -876,8 +902,6 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
>  {
>  	uint16_t n, features;
>  	uint16_t num_ele = 0;
> -	uint8_t *cfgmod_idx = NULL;
> -
>  	const struct l_queue_entry *ele_entry;
>  
>  	if (!node || !node->comp || sz < MIN_COMP_SIZE)
> @@ -940,9 +964,6 @@ uint16_t node_generate_comp(struct mesh_node *node, uint8_t *buf, uint16_t sz)
>  			mod_id = mesh_model_get_model_id(
>  					(const struct mesh_model *) mod);
>  
> -			if (mod_id == CONFIG_SRV_MODEL)
> -				cfgmod_idx = &ele->idx;
> -
>  			if ((mod_id & VENDOR_ID_MASK) == VENDOR_ID_MASK) {
>  				if (n + 2 > sz)
>  					goto element_done;
> @@ -988,9 +1009,6 @@ element_done:
>  	if (!num_ele)
>  		return 0;
>  
> -	if (!cfgmod_idx || *cfgmod_idx != PRIMARY_ELE_IDX)
> -		return 0;
> -
>  	return n;
>  }

Note that this cause the daemon to no longer reject applications that
declare presence of Config Server Model on non-primary element.

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
