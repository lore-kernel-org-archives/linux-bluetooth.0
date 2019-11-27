Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865C8C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 04:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556E920835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 04:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=socoptimum-com.20150623.gappssmtp.com header.i=@socoptimum-com.20150623.gappssmtp.com header.b="BU3L5PN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfK0EQX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:16:23 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:37447 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfK0EQX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 23:16:23 -0500
Received: by mail-pg1-f181.google.com with SMTP id b10so10126336pgd.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 20:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=socoptimum-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=7LE/KmhgWQbDKZiPASD3RWI3bhICe2/ZKa9LlQcl5T4=;
        b=BU3L5PN0qj0SWkxUKfFd1f0JYJsNtka/dZPmoLXvsSzbfisM+TccMuinD5XBygPe3a
         Fnb5coB5rkJKbe8vq2ck7KT6Mzb8NOOOHepP9qjSwVC0RVT9ug6hp6LK/o068pmV1t9M
         ElSZ9M67eepShzNJjlwljJ8c4R1VJVGTo6ekBMZsLpxCrq16BHQL5wLmDv4uPZjC7XES
         +Mradg0Q9oUxzH5evZ506aTaWLCcgNzJO3OehCiJlqt0qxuGpAvzWKCJpdV+QHTMkFIT
         8qug/+62WRnN45YaHnp8TXqZr+hiZejtLkwnXQfj1jhsg43gl03CQvFFz6SpabV84ymw
         G7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=7LE/KmhgWQbDKZiPASD3RWI3bhICe2/ZKa9LlQcl5T4=;
        b=awj8hammCCkB5L5pJZfuKSE718nsGmrREAWyu/wkYMMBfZG5PfWkRBea3SahBzekk/
         DYIy55AyIXBXH3aSvZj3j8NFXBcAkX5HW52m5b3WjLZk53IKjLTprIPIUZLuW8IHltYH
         51XkZukIbTBaP2J2R/G7MJWzXAFyzRN6uThHI+kZlHyuuPC5lKkB+TvG/T/xyDaheg2X
         WkcjnPNjzoEXw1GorpqcJze/Q6JDSqtAfVWk3MXddb86AVNT269Bv5ldqBqy5lgTU5va
         MxCN66jUy4m16Y57edyMgWTRk7vsLP64IIcKe7kEWGEV+wB3n4m00WU9MMdFE5mjJepe
         Bx0A==
X-Gm-Message-State: APjAAAVcWNRj+FuWsLAcGQhRO+mcZaL7PReTGG9/RoFMVAhSbDrQ+UAl
        VuiUDY5EDcYS1/9UED5Y+2lGjBwsCeU=
X-Google-Smtp-Source: APXvYqzkpe2hCNXYi9q8KVl/4MEUHvtdOWX/Ymih41ogAYLwYn7dvUjCIkC3P/vtlUtISQwxgzDZhQ==
X-Received: by 2002:a63:f64:: with SMTP id 36mr2469477pgp.16.1574828181193;
        Tue, 26 Nov 2019 20:16:21 -0800 (PST)
Received: from [192.168.1.9] ([122.179.42.13])
        by smtp.gmail.com with ESMTPSA id 136sm14516406pfb.49.2019.11.26.20.16.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 20:16:20 -0800 (PST)
To:     linux-bluetooth@vger.kernel.org
From:   Venkat Vallapaneni <vallapaneni@socoptimum.com>
Subject: bluez meshctl error: socket operation on non-socket
Message-ID: <b260550e-0884-662d-e395-90e7678cb1a7@socoptimum.com>
Date:   Wed, 27 Nov 2019 09:46:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I am trying to use bluez 5.52 for provisioning a bluetooth mesh capable 
device. When I gave provision <uuid>, I get this below error. Please let 
me know what I am missing.

I am using ell 0.26 on ubuntu 18.04. I am able to provision successfully 
with bluez 5.50.

AcquireWrite success: fd 8 MTU 69
GATT-TX:     03 00 10
*sendmsg: Socket operation on non-socket*[Zephyr]#

Rgds,
Venkat.


