Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C261C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 16:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5070D60FF2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Aug 2021 16:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhHTQnU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Aug 2021 12:43:20 -0400
Received: from mail.sma-inc.us ([192.88.109.73]:31726 "EHLO sma-inc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhHTQnU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Aug 2021 12:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=sma-inc.us; s=mail;
        bh=m8cw7UV7De/CQ2Xt9ie8RBmo/i0xkZdtyPLRD1/o1W8=;
        h=Content-Transfer-Encoding:Content-Language:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:To:References:Subject; b=JqLiUtNdI7ugo/zLgC
        8rKDVO8icT7p2/NJ1GLA1dn/riigf9aGcyOEUhXsirZvq52ALpZL+ubRq36Gm264rpoFV6uhagIsL
        bZB3jt4Ktr+NSRVNGbAyoRtKEyd1CFNRJ8oODcqocbT5EygvmZeTekuCbkVGwbDztzG5R8Nu80gk=
Received: from [127.0.0.1] (account moe.james@sma-inc.us HELO [IPv6:fd2f:4760:521f:3f3c::c0a8:45ec])
  by sma-inc.us (CommuniGate Pro SMTP 6.2.15)
  with ESMTPSA id 7815783 for linux-bluetooth@vger.kernel.org; Fri, 20 Aug 2021 09:42:41 -0700
X-Assp-Version: 2.6.5(21218) on assp.sma-server3.sma.com
X-Assp-ID: assp.sma-server3.sma.com 77761-07640
X-Assp-Session: 7F4AFBA483D0 (mail 1)
X-Assp-Envelope-From: jimoe@sohnen-moe.com
X-Assp-Intended-For: linux-bluetooth@vger.kernel.org
X-Assp-Server-TLS: yes
Received: from unknown ([fd2f:4760:521f:3f3c::c0a8:45ec] helo=[IPv6:fd2f:4760:521f:3f3c::c0a8:45ec])
         by assp.sma-server3.sma.com with SMTPA (2.6.5); 20 Aug 2021 09:42:41
         -0700
Subject: Re: The UNIFY bluetooth unit is not recognized by Gnome/bluetooth
References: <sig.0865cb2f28.54aee928-a4e2-9368-f417-58d87999b4e1@sohnen-moe.com>
To:     linux-bluetooth@vger.kernel.org
From:   James Moe <jimoe@sohnen-moe.com>
Message-ID: <sig.0866c380ef.dd1e6212-858f-d73c-9762-56ead54e8cbd@sohnen-moe.com>
Date:   Fri, 20 Aug 2021 09:42:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <sig.0865cb2f28.54aee928-a4e2-9368-f417-58d87999b4e1@sohnen-moe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 8/18/21 6:36 PM, James Moe wrote:

> The Roverbeats UNIFY by Etekcity is a bluetooth-to-analog-audio device to allow
> bluetooth capable devices to send audio to analog equipment. Gnome fails to
> properly connect to the device. The Bluetooth Settings page shows the device as
> connected. However, there is no listing of Unify as an Output option, nor does
> the Unify unit show a proper connection.
>
  Is this the wrong list for this question?

-- 
James Moe
moe dot james at sohnen-moe dot com
520.743.3936
Think.
