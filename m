Return-Path: <SRS0=cdju=QJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D73C282D7
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Feb 2019 15:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6625D2085A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Feb 2019 15:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OszjMU6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfBBPxF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Feb 2019 10:53:05 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:38489 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbfBBPxF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Feb 2019 10:53:05 -0500
Received: by mail-pg1-f171.google.com with SMTP id g189so4389632pgc.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 02 Feb 2019 07:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Gx5tFqBthrHwSClu+iJ63olPNyER0KO/dNoU5nE+cg=;
        b=OszjMU6BFpfJBrl5u+BYJmR+qtxyZUCu0xmJVM7WYNOOp/eO0XwY+oA4QfG9KXW2y4
         1GNlXvbWHxkxgOwsGu97kt1HR19zkuq/paeSumSWI8ndBkXRE3UmTVRj2Ml0YsEeYuU0
         Nz7aGepXIfNLxb01yzRwJUQvfBlob0ubLu3/SIslW/AIjPrKxSamuVa4Dv6WgYvDmG5G
         /60rzKc3eJOLgPlu3/0mbHncuxVbmSF6j3pI3P79od9ruS0o8laGbYUrJx05/uxyVChu
         Hw1nIzPtgCGvX8MJdYvmcAKNTbPKf52KPUGuEn3RMiRd/NFlDGVzISW5Y8WN+AVTt0V7
         Vn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=0Gx5tFqBthrHwSClu+iJ63olPNyER0KO/dNoU5nE+cg=;
        b=cLKuE4lG87ecd4LrXPlUmOOaP4zpgpRbj51a1y/ey0ly0MAvhxdqkUBqAUxdE7MWKt
         vsJyHooPoMyCUr+K+v1aSYfVB257gYXuWTJ8zyP+xFT8XCKf+6S0pah+7bwPhgsEGMrl
         tbIug1qxVpLSOARUZfvHCC5iNPsKZpLl6Dqltedzw4t41Ll1tvH9Fu9WgU7TYej5dNbj
         VrdFIqzPw2HJNUcjhlXeoTtYihyk7+B6ToZNnvTgtcsiGHmQJZL6Zzz12Yz7WsiGSMNF
         sGF+OG1di8mkIFHcISsaIEjAm1Rrds8sArdYU3NETDAZ463gV2pRtPe1+9ghk3pDGEPj
         nR2A==
X-Gm-Message-State: AHQUAuaBcTyVDbk2umZymHrlJNK1EfLyz+px6eHNso6urky0Lahdzp/+
        vugMZLKmc/xBYuPTf+78YNs2dXcBgZE=
X-Google-Smtp-Source: AHgI3Ib/ppCaZjHyJ9irSVfEdI0fANm5dN4KtwnmkrVcHp2mzXcRWiV44bZBIuaWRTF1aK5PxMhT2Q==
X-Received: by 2002:a63:cf48:: with SMTP id b8mr6651943pgj.17.1549122784803;
        Sat, 02 Feb 2019 07:53:04 -0800 (PST)
Received: from localhost ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id w6sm31593375pga.72.2019.02.02.07.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 07:53:03 -0800 (PST)
Date:   Sat, 2 Feb 2019 17:53:00 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Youssif Saeed <youssif.am.saeed@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Directed advertisements from the command line
Message-ID: <20190202155300.GA66082@ahuge-mobl.ger.corp.intel.com>
Mail-Followup-To: Youssif Saeed <youssif.am.saeed@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
References: <CA+T8qpb8n8oVRfiFsxX7y27LDDpc2CfdPdQLgsdmQH5FBeBQcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+T8qpb8n8oVRfiFsxX7y27LDDpc2CfdPdQLgsdmQH5FBeBQcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Yussif,

On Sat, Feb 02, 2019, Youssif Saeed wrote:
> Is there a tool/utility/option for enabling directed advertising?
> Currently, it seems that the only options available through
> bluetoothctl is undirected advertising. I can see that there is a
> "type" field in the advertising section, but from browsing through the
> source, it looks like the only supported options are "peripheral" and
> "broadcast" (This can be seen in bluez/client/main.c). Is there an
> option or another utility that enables this feature?

If I remember right, you can force the kernel to do directed advertising
by enabling the "advertising" mgmt setting (e.g. "btmgmt advertising on"),
and then issuing a connect on an L2CAP socket to your wanted destination
address. This was originally designed for testing purposes, so I'm not
sure how practical it's for anything else.

Johan
