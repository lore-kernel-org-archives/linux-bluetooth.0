Return-Path: <SRS0=wIos=VP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C75C7618F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 18:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB6F2084C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jul 2019 18:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="sx7L4Zh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGRSyP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:54:15 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46517 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRSyP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jul 2019 14:54:15 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so15680529lfh.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2019 11:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/b7ti5XlchOdaQKK/m+f1BmRLsvnJhYgJOFAClHTMfg=;
        b=sx7L4Zh2mIpULRqfkd0shDY1huy9ZC1SXTH/3ConmmKcsuvpbK9lkiNFNasFqeULpx
         65MYj6cOUhthVJieUtdZ/GP9bEk55HuLOhjWL6HmCdHT5eo4mUcSp/SCjzHQ9bDAh+JI
         q1yWf1shz2884XHzfBtXKzP5sAsX6OTEk1R6DorxtD/VGgNYmaPq1A4bEt0UvQ07pdpt
         TOJlKd6DmkdZ+BkU8M+01/T2J212/pFdwNYGPiDeNIoH+pnix5eB9DEV2GSJSLQSGnOz
         F2thFPLm8kPYXVt+WfP3zpq45hUicqokawI1Wk2b3/gkb6pz7WcT554nVeUyG+MBbmOy
         oOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/b7ti5XlchOdaQKK/m+f1BmRLsvnJhYgJOFAClHTMfg=;
        b=F1h4lF21Lr7te2UHvuGYOvd2lztVdVR7ZPEEjaYXPYKNtH0ZeD6IkZ8w+u2vp4W5IT
         7H9gpjB8JbYgZj+BXc3xityszYmrxcnFCIZKk8t0eUUfrCatJIGIA3mF8XUpX2e7/zr8
         6YN33yhUdWPQ+/kHpkpHhNMwejwTu4mLcK35W8KT1GErwtbHVWcerc/WtG+Xa5aIOirD
         nMRAYpkg7Z4CxUGRGXh+mbUUH4LQm0Y6pvA9rXZPCFVa4PflAV2doQr96hnzy70CilYa
         1AhppmgW1rCvtwG2IwXp9221NvP2cGqSueGGWjypUyWmbHdyQZMdVQgSlzPi8y+Wt+2k
         xGPA==
X-Gm-Message-State: APjAAAVzWlP+7TUFa+9ozg/l5PskXjVth4pdjIl5PVe/RYX/7PR7PWNf
        9srjXTHNpLh8EK9vgcEOG29xDw==
X-Google-Smtp-Source: APXvYqwGonB05j1PEyLHWOPMljOBoerX+FBkVZHTZm3L9T7LnLKz1EWu4I5/t8iNBCHELJC5Kg4/UQ==
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr20478318lfm.104.1563476052676;
        Thu, 18 Jul 2019 11:54:12 -0700 (PDT)
Received: from kynes (apn-77-112-37-101.dynamic.gprs.plus.pl. [77.112.37.101])
        by smtp.gmail.com with ESMTPSA id a15sm4091617lfl.44.2019.07.18.11.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jul 2019 11:54:11 -0700 (PDT)
Date:   Thu, 18 Jul 2019 20:54:09 +0200
From:   Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Init keyring storage directory on node
 Attach()
Message-ID: <20190718185409.3pqtjqwnahlus2k5@kynes>
Mail-Followup-To: "Gix, Brian" <brian.gix@intel.com>,
        "Stotland, Inga" <inga.stotland@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20190718040126.5152-1-inga.stotland@intel.com>
 <20190718085923.4ljvk3t3avqdh24d@mlowasrzechonek2133>
 <DEBB0CAA2616974FAE35E4B560B9A4376CBD3EA6@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4376CBD3EA6@ORSMSX103.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Brian,

On 07/18, Gix, Brian wrote:
> There are no use case allowed in the specification that allows any
> Config Client except an authorized Provisioner to communicate with a
> Config Server (even the local Config Server)...   Any changes to a
> nodes configuration states should be tracked by provisioners in a
> master database, and this is not really possible if any node is
> allowed to change it's own CFG Server states.

OTOH, there is nothing in the spec that forbids it.

For example, it's perfectly legal to create a vendor model that extends
Config Server and adds a few additional opcodes that affect Config
Server states.

Another example is multiple Configuration Clients - the spec only says
that synchronizing Provisioners is implementation specific, and it's not
Provisioners who talk to Config Servers - it's a Configuration Client, a
different role. And sychronizing Configuration Clients is not even
mentioned.

Also, for Device Keys, the spec says they are "known by nodes".
Splitting the node into a "daemon" and an "application" is a
bluez-specific architectural decision that has nothing to do with the
standard. While I appreciate there are reasons to implement the stack in
this manner, I am very much against adding arbitrary restrictions on the
things one can do with such a stack.

One of these restrictions is denying access to keys. This is fine, but
the application needs to be able to use these keys *as if it knew them*.

For example, it should be possible to implement an application-side
server model that uses DevKey security. At the moment this is not
doable, because there is no API to send a message encrypted with *local*
device key.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
