Return-Path: <SRS0=EsMn=TA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26498C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 10:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27E221734
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Apr 2019 10:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlrY/Cdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfD3K1A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:27:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38301 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfD3K1A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Apr 2019 06:27:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id k16so20383297wrn.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2019 03:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mUWyVObWu+Z8SB6h1iZyBU31qHTWfOI9jy2T9pt47fE=;
        b=AlrY/CdiLxP2iY49KVdEYs1PystkPKBEm3dkghHL7YjVgDDYpmkXxRkYiD9oiePaTt
         vBWerT3vMr9a+7MWhcDpMobGr9GHUt0NBC4jQKiSptF85I3CGo4xkucjgcv5l/M5MV0x
         6+p+JDRX7iMCwfcZgJzGB42UR1+yqri1bulOvZoT9E/uQillNDkMkhHtEuUP5FZSwiYs
         1yn0yZs5yk9+XIrpGpfLEdQykpym7GjzjPoNAtif3QFZSZQXgXT6S1rfO+1JCDAuQMOc
         YTiCjduWJEpJqbhfYKX++e3O9nr3C+0MKz/EYVpIERPsalCXZRs+em9jSBmtCvrP4Pxh
         TtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mUWyVObWu+Z8SB6h1iZyBU31qHTWfOI9jy2T9pt47fE=;
        b=p9wwlD32VwGBZp1TqzofwkQYKnXUDBqlNZ+mhBsmIWW5NJpNSe8YHGE/BxDO3zATS+
         lgR9ste+YLIMO4S2nQtetuKo1tOxpS+Mrh7vwGadTyP9hdLrUPxGFhm1hpcB4HW98Vhz
         ahJM1YpXPf6GvDQNJRTcEvAtj6km6rACb8xq4xipXKNoc4TD7VmDLdbH1S9A7jVt7fUu
         zDjkno0dKLidGPaNFeXnL2FaN0W41ST7OYlrNw8cw5sORxs9dJyZ3C6SZz9a3/ps0G0i
         QaAeqmXJ+MK5CccHy2GZv1/gBDTUx5f+E+Ip/aXBJuaHfCAMSZElUsWn3Qvrknb5/D3B
         vaOg==
X-Gm-Message-State: APjAAAWPKVjBMJezckh7f6rfFdrXFmZLPWF5sJ8azAZ/XIGfBwyEV7XR
        e/GvakfaEF/o8AFBjQFRmfwhGP8g
X-Google-Smtp-Source: APXvYqwe0KJtOBTETWAySJ5ukA3AH9emeV58OpeYJTakLeeQFraMTEYSQWZZ7fJc3fJQG51CKqPsig==
X-Received: by 2002:a5d:4308:: with SMTP id h8mr33434805wrq.22.1556620018825;
        Tue, 30 Apr 2019 03:26:58 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q3sm4672498wrc.45.2019.04.30.03.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 03:26:58 -0700 (PDT)
Date:   Tue, 30 Apr 2019 12:26:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 3/3] a2dp: Fix not calling SelectConfiguration on
 other available endpoints
Message-ID: <20190430102657.biqv6icyqww7jf5y@pali>
References: <20190429120259.17880-1-luiz.dentz@gmail.com>
 <20190429120259.17880-3-luiz.dentz@gmail.com>
 <CABBYNZK1LRANfR6cwu+xbLsvy4EnB+ZPS78JNK04mJ=pwTGSDw@mail.gmail.com>
 <20190429163916.ngdqk437xbuahl4k@pali>
 <20190430102432.qo6pflsj75ktr34x@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190430102432.qo6pflsj75ktr34x@earth.universe>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 30 April 2019 12:24:32 Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Apr 29, 2019 at 06:39:16PM +0200, Pali Rohár wrote:
> > Btw, for future patches please directly CC them to me as I'm not
> > subscribed to list and either extracting them from '> ' quotes or
> > finding them in web archive is quite impractical.
> 
> FYI (not against your point, just making your life a bit easier):
> linux-bluetooth is on lore.kernel.org, which provides an mbox
> download:
> 
> https://lore.kernel.org/linux-bluetooth/20190429120259.17880-1-luiz.dentz@gmail.com/T/#t

I have not know about it. I used marc.info, there is "Download RAW":
https://marc.info/?l=linux-bluetooth&m=155653938929963&w=2

-- 
Pali Rohár
pali.rohar@gmail.com
