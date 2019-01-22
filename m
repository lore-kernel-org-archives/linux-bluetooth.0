Return-Path: <SRS0=wtFT=P6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B2FC282C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D7F20870
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jan 2019 12:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeKdHCew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfAVMiV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:38:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43831 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbfAVMiQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Jan 2019 07:38:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so27112121wrs.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jan 2019 04:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2S+F8YqukpyXra3fRENWvO6adRdnqlscaZOu2SHC10I=;
        b=AeKdHCewZOBIt3/9y9eRjTPpvAngRPBWmEjUuOXlvOUgbwqwxlDS9FwNopfeKqdA1n
         NQ+m4snhFtPLIEjZCJ8auxPoIYavmeehGyOiankPUgjwlUI9FWhWF1UiHzbLJx1d9DaB
         38QAaVaBQgT92Dx83ZSF2GSJ1uWX6CkAWG7c7yvbWuemE37ELZHi5kQwTvEu1Tf6/e9m
         EG86Q5r50jrIuODyaQPEtcnzW28i1QSJSl1b8giblNV0sLbkhkwaTgNBQMyxNzhn7zcO
         NZJFiFvapFqV97euY+e+DmkoV5NPJdCiQTnmmuacZT8+dvc+jwJFxzJeaQOQLWHuEoLl
         cqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2S+F8YqukpyXra3fRENWvO6adRdnqlscaZOu2SHC10I=;
        b=ZiQdnjjDeixgxw9sOLjCP0v9h43hf6zwcalDJhiwUVL2Ci/KuyYD7IWJmSCVgAtFxs
         16YvJtqmzpJ87oD/3awURxzFh/yisk7+84UNqh2UtYFlhVPVyLeMmGt3za2UM/HoAgZq
         LhG40gPOF0uvDWuQRQ+denTZWMc9oFIXAx5U6OUc/MtHmQUf8R6mRIWhAncpP3NFQ6Bg
         2xALiZtoOLbbcKTc76yY6Bahr5nrznMa/rdngq6KlWRPA9A/s8E8hwdMrHdSuYNrv/Es
         DesAvLmY0xp+8FJMjSx7XTctlVpmpzCFLhUj1LaDQBPCt12x3W9jxdAdor49ldK0ZVMX
         srrg==
X-Gm-Message-State: AJcUukcHg2QAqqj39DBTJhC4esqlYXcXGPJWCy8E6nESgpC7AekJzFcC
        QEqvveVQCGnKjRoRnbW6rM8=
X-Google-Smtp-Source: ALg8bN6HK09wdrosyyqc/fiSAfgJjvZmfR9a3LGxFYFXl2mmt7pqIl7s+bP119TWg8ZFlz6IEWYg+A==
X-Received: by 2002:adf:b307:: with SMTP id j7mr34432665wrd.46.1548160694551;
        Tue, 22 Jan 2019 04:38:14 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q3sm105214018wrn.84.2019.01.22.04.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 04:38:13 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:38:12 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Subject: Re: [PATCH v2 1/8] doc/media-api: Enable MediaEndpoint to expose
 remote SEP
Message-ID: <20190122123812.hypezv5oypabeb27@pali>
References: <20190115141023.353-1-luiz.dentz@gmail.com>
 <CABBYNZLL7Usr=bS2rcJCCV6STVwi9ywq3Om6jkF8cfB8GC6mcA@mail.gmail.com>
 <20190121183016.jiqrtw3csllmqhif@pali>
 <CABBYNZKMPfkSvHqryeR7P8QitQVAv+-WVudSV=hpVaPjTOUu3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZKMPfkSvHqryeR7P8QitQVAv+-WVudSV=hpVaPjTOUu3A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 22 January 2019 14:35:42 Luiz Augusto von Dentz wrote:
> I will send a v3 which does the reverse discovery, that should make it
> work with existing paired devices that reconnect and configure since
> otherwise there would not be any endpoints to associate with.

Ok.

> Note
> though that in case of PA the endpoint object should be considered
> optional no matter what since otherwise it won't be backward
> compatible.

Yes, patches are already backward compatible. When endpoints do not
exist, pulseaudio just refuse to switch codec.

-- 
Pali Rohár
pali.rohar@gmail.com
