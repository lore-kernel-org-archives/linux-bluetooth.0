Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D10C282C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 10:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BD92183F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 10:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="G0Eu3hJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfAWKsA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:48:00 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:44118 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfAWKsA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 05:48:00 -0500
Received: by mail-lj1-f176.google.com with SMTP id k19-v6so1466569lji.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 02:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X883s8YXVZU+v7t+zQF0PoJLYpxBC3xKotUZaJCQDaA=;
        b=G0Eu3hJbl8fJNdW3WFyrpL7FRxVJ9CIpJT3as3x2cX+bQBDb7gTudvBuxcPKFzn+CC
         gPxwTyc9C+TpHuln4IyWmTAbdh30jqhGZnfAkESAjoycEsIwoygdxiowUR/cr6o24p35
         20lCwEmF6YdK5WOAEHr6W2ALHZCLkJxCMxxAXb4S6qXiX1QtyNUeYCPWRmPbY4CHt1Vx
         RnBFvJH8FMfGyGQuzQzw/J+kravgl9aTELy7+sy88tvbsC4kuGyVjwfeKPPAmJN1yYWj
         SQbWvg1EuEVlnMzCbHnLKug0+wr3N/0Oy7TTJprqOGE/qQdSEi9c7HOkIUHH1vAjuJ1s
         hpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=X883s8YXVZU+v7t+zQF0PoJLYpxBC3xKotUZaJCQDaA=;
        b=J8P/VYW1wKcgCwsGxwtRVvStbFyt9vOC6606JiTngSuSlkNMxBEs4i7HKAPq6XAmRr
         6kl+4xs5lD8iqQAYG30XDw89SdMrq9if/sy4+SlHfmXSVl+MAH4youJqxSgKH2lV6a+W
         sYdt3Zs0G2hOT8/toRgL7cD4c7z35jJb4kY0wo/EcOpFLLgy9GlGWCh9rrg1hyYZxbyP
         YUqq6xCDNG1jYGXH/lEKI41tdRLVXjzQgpICJpUC4GP+mAvjw5ucJ2LcE57YRcRdjPWd
         rcZULaWeRcEHdz2Ol6yvi6c3uY22JrZHR/MWPfUQZ34d5rs8djnLy6prr5K1+RlpBnpB
         7riw==
X-Gm-Message-State: AJcUukeHxUv+puaS+1cqkMXsOV4sCrXkcv8hyv3iFlOcW5XZq9MKW2Qa
        bZRcxgsd6PxK9eLybOOoql5mNQ==
X-Google-Smtp-Source: ALg8bN5BqUHw/vMozy7RikY3x4DNWofBiNTEUPxCSBD0z3hwzBFH0R+KwwEjFzH4apJTJVJbJghSKw==
X-Received: by 2002:a2e:3a04:: with SMTP id h4-v6mr1604809lja.81.1548240478201;
        Wed, 23 Jan 2019 02:47:58 -0800 (PST)
Received: from scytale ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 6sm459769lfa.27.2019.01.23.02.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 02:47:57 -0800 (PST)
Date:   Wed, 23 Jan 2019 11:47:55 +0100
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: Format of HCI LE Advertising Report Event
Message-ID: <20190123104755.vfripl2xo46hjums@scytale>
Mail-Followup-To: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
References: <20190123102452.o5xvunjcsx57pdwl@scytale>
 <282271E8-D3D1-4AEC-8B57-BA03F3FF7D36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <282271E8-D3D1-4AEC-8B57-BA03F3FF7D36@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Johan,

On 01/23, Johan Hedberg wrote:
> > event_type[0]
> > event_type[1]
> > address_type[0]
> > address_type[1]
> > address[0]
> > address[1]
> > length[0]
> > length[1]
> > data[0]
> > data[1]
> > rssi[0]
> > rssi[1]
> 
> See Vol 2, Part E, section 5.2 (page 728 in the pdf):
> “
> • Arrayed parameters are specified using the following notation:
> ParameterA[i]. If more than one set of arrayed parameters are
> specified (e.g. ParameterA[i], ParameterB[i]), then, unless noted
> otherwise, the order of the parameters are as follows: ParameterA[0],
> ParameterB[0], ParameterA[1], ParameterB[1], ParameterA[2],
> ParameterB[2], ... ParameterA[n], ParameterB[n]
> “

Oh boy. Thanks a lot, I missed this.

Not the clearest wording in the world :|

-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
