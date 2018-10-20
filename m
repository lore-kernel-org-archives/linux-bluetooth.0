Return-Path: <SRS0=5noO=NA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF1C67863
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Oct 2018 19:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8378F215E6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Oct 2018 19:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8378F215E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJUDpl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:45:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34282 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeJUDpl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Oct 2018 23:45:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 361EC13ADDDFC;
        Sat, 20 Oct 2018 12:34:12 -0700 (PDT)
Date:   Sat, 20 Oct 2018 12:34:11 -0700 (PDT)
Message-Id: <20181020.123411.1116183885730251618.davem@davemloft.net>
To:     johan.hedberg@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: pull request: bluetooth-next 2018-10-20
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181020090342.GA14926@x1c.home>
References: <20181020090342.GA14926@x1c.home>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 20 Oct 2018 12:34:12 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Johan Hedberg <johan.hedberg@gmail.com>
Date: Sat, 20 Oct 2018 12:03:42 +0300

> Here's one more bluetooth-next pull request for the 4.20 kernel.
> 
>  - Added new USB ID for QCA_ROME controller
>  - Added debug trace support from QCA wcn3990 controllers
>  - Updated L2CAP to conform to latest Errata Service Release
>  - Fix binding to non-removable BCM43430 devices
> 
> Please let me know if there are any issues pulling. Thanks.

Pulled, thanks Johan.
