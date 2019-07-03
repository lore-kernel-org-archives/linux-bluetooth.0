Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE7C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 10:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E132A218A0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 10:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXXMa2H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCKjH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 06:39:07 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:55075 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCKjH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 06:39:07 -0400
Received: by mail-wm1-f53.google.com with SMTP id g135so1661735wme.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VXYgiMewesoD0JcFei/mLRq8HiTvUkoPt06L1RjWEso=;
        b=rXXMa2H3j5yLOQ1770jVPJasTZvywkE34s+a8IX8NZTgxSoTdg6dsJiPxu1Y7CyiKz
         ua6bLaAVqFl0XX90Zx0a+3nsk1rHQuNd5mLpJVkXhNlzZYsNuRHwfVALpdHO8jUhcomO
         Mg+4MJL79q15A4lB7pxLQiwyn1sNSGwQtHI/GEM1Dvc/DlzxKpAiYtHfZpzhiWMyODZi
         GC8OWDTrMfFjmjTs5xnK5Xi6DVVx/O2ERhYLmD7HYopXFxi4UDFXQEwR59t2phiyj4Er
         jN3lxPmyZ8eguSbE/y30jc2DC5PvfMy9X/8sDH1Ok2Zxar98WCGdHTRc1/83uZ7nqS65
         Db+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VXYgiMewesoD0JcFei/mLRq8HiTvUkoPt06L1RjWEso=;
        b=AcnoGeL/wxTWtfIegRXh4DAAE1PGiYVlRJd/q8sBT53Ca1KXo8xgciyDrGvgj3Uhn9
         08GUEzApoFZs6la+btK2Ny98UdxQIECQKSmmaCdesMpl8SgkIXwFzuNE6Qh4wZU/C+15
         ZQCOknbkqQdP1d9/O7HAT/nhHtVNuV0ctt1rv6Y08EtSn98qplHPs44XIQOsGuVwm8s/
         mBoBNRrQ0vrU9bhSe0kOs1DpQUqiMG3xpA/Mq8tLvIFPnJzLaDg+8DKyGpK0mc+QhXUk
         N99HcAZBcmFbx49HDXKC7v0Fy93VMaPstnVT+EdvY6WaoGYJUqE0ItJpQYJrAtQeqKXw
         H8OA==
X-Gm-Message-State: APjAAAWU77AoJUqlJk0mxlGW6MV6xm35VIh4T6lvl/w3ClV9P8VY/7uA
        FZaXLgOuKfUxninLc4L5Bq4+kie0
X-Google-Smtp-Source: APXvYqynRLDeBuyiU/pn2mXfLlJU/7SzPLgnaRSG8TWHnG2/PFaJ26by3CNKp7Xlpj3B5JFRdyenww==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr7118387wmj.99.1562150345359;
        Wed, 03 Jul 2019 03:39:05 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id y184sm1407233wmg.14.2019.07.03.03.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 03:39:03 -0700 (PDT)
Date:   Wed, 3 Jul 2019 12:39:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: bluez: avctp_connect_cb(): BT_IO_OPT_IMTU for omtu?
Message-ID: <20190703103902.2llvxp4nrmia2wkc@pali>
References: <20190619160320.kwumolq6sgetfuzf@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619160320.kwumolq6sgetfuzf@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 19 June 2019 18:03:20 Pali Rohár wrote:
> Hello, in bluez source code is function avctp_connect_cb() with
> following code:
> 
> 	bt_io_get(chan, &gerr,
> 			BT_IO_OPT_DEST, &address,
> 			BT_IO_OPT_IMTU, &imtu,
> 			BT_IO_OPT_IMTU, &omtu,
> 			BT_IO_OPT_INVALID);
> 
> Why is BT_IO_OPT_IMTU used for retrieving omtu? Should not be there
> BT_IO_OPT_OMTU for retrieving omtu? Seems like a typo: imtu vs omtu.
> 
> Above code was introduced in commit b5666a3747 (AVCTP: Allocate memory
> to hold incoming/outgoing PDUs).

Hello, I would like to remind this question. It above code bluez correct?

-- 
Pali Rohár
pali.rohar@gmail.com
