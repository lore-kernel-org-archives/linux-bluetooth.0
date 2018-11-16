Return-Path: <SRS0=Z/iR=N3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A67AC43441
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B14C2086C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Nov 2018 19:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B14C2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeKQGMN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 01:12:13 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49387 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725753AbeKQGMN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 01:12:13 -0500
Received: from marcel-macbook.fritz.box (p4FEFC1D6.dip0.t-ipconnect.de [79.239.193.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1097FCF167;
        Fri, 16 Nov 2018 21:05:56 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [Letux-kernel] [PATCH RFC] bluetooth: add uart h4 devices via
 serdev/devicetree
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181116204601.4e1aa0de@kemnade.info>
Date:   Fri, 16 Nov 2018 20:58:24 +0100
Cc:     Rob Herring <robh@kernel.org>, sebastian.reichel@collabora.com,
        hns@goldelico.com, devicetree@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, letux-kernel@openphoenux.org
Content-Transfer-Encoding: 8BIT
Message-Id: <09AFE47C-D188-4397-A2CD-C70FFAC3B677@holtmann.org>
References: <20181110232034.17277-1-andreas@kemnade.info>
 <20181111024648.7rt7rlhaqihtqecv@earth.universe>
 <20181112215812.18ebca35@aktux>
 <2C74C837-A6D3-47C9-BE59-CCA594289B94@goldelico.com>
 <20181112222726.73m2oca7hankvcjs@earth.universe>
 <CABGGisxsdv+BTd5-HMzF8asEcWtL5F4CMzmkrBCwK=NibvqjLQ@mail.gmail.com>
 <20181113170128.0f59ef0e@kemnade.info>
 <86A3A2E6-FC89-42FE-8410-9C8273EC9CF7@holtmann.org>
 <20181116204601.4e1aa0de@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andreas,

>> Btw. I see nothing standing in the way of merging btuart.c driver and then go from there. Either I dig this out and submit or someone else does.
>> 
> Do you mean this?
> https://patchwork.kernel.org/patch/10490651/

yes, that one.

Regards

Marcel

