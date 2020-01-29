Return-Path: <SRS0=JIrD=3S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D97C33CB2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CD22071E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="q8upA4G3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgA2MRt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:17:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45344 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgA2MRt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jan 2020 07:17:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id a6so5323901wrx.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2020 04:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SZXM8L5hThf/lTMyWpJQskJEMAQbEdTrVu9lqisbSCc=;
        b=q8upA4G3t947aBupxQjnGeyADpdlcAYyMmYCbXk8sJDxWfPfD39nGUJHMSyTwD2DeU
         PvVoQBJJWbwVCA6mL2USfzOazu20Nrbscz8w8+HDGU4hSMkNAlMGxcyZgL6EjTW3NawT
         yKNWzkTecgQUBA6zrYTj9abr0fF1gN+bBw0P0aq84azCH5Yph7RklIKK7tg2SUW4waz1
         UTp8mNXXj4n1pZLmfEYLWDcCmaZeWZPaXK1PtkkgIDhN5xHm4LC8t4YPFtDkzIca4IJ8
         AZnP5s/OTANovJzlx+0CO4aWEjUen3TSsnP16YtLQqSmpmrziiosNxmHQj1v7KsXmzFI
         9RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SZXM8L5hThf/lTMyWpJQskJEMAQbEdTrVu9lqisbSCc=;
        b=eGEOG8TdI7ysbSxux5O+v8xbicHR5p9VV9ZClInK5HA6LR4gCWJqqHSpc1N7zq1/OL
         PsZudyi9rLTpUQXeLZFVYee4h8OzAdM+mK23zD6YnF+E7qCwTOMWSodMRlptlkG6CqOU
         BdwMh2u8U+CTRcJlm4kQdE52XCznOb/8iTNdIbZlT030uAGlG9/Y9OrnebaR2y0WxjPF
         8w3syuF7U0nl4noubR+9D9m69EECrLxE0e+yJ2Uw/N7aZAgEKTzknkBrQcCC9Y41noII
         UDbhnaFd8wLcrME3+AbGEG7emzYVYl5HWHeFCCnTAEoRNe2FP6FS2PABWPrZYCoKCKZ1
         BEog==
X-Gm-Message-State: APjAAAVWhUxSFbldsSrzhakzAFZeMLBhZ9mZ5HnzD8Sjl9UOdN8zFlQ4
        xd83vE3OjYOiao5FN6uNSwVrxA==
X-Google-Smtp-Source: APXvYqyFRG8ardQRTCZlvD+rC2a1ncbR/aJ7PutqKkCetyUQxl+IkwOuWK3wo5H0sxloZcLZEr0uDw==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr35415935wrt.208.1580300267243;
        Wed, 29 Jan 2020 04:17:47 -0800 (PST)
Received: from rgajda2364 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t81sm2100272wmg.6.2020.01.29.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 04:17:46 -0800 (PST)
Date:   Wed, 29 Jan 2020 13:17:44 +0100
From:   Rafal Gajda <rafal.gajda@silvair.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: Re: [PATCH BlueZ v4 5/5] mesh: Add NVM storage of Replay Protection
Message-ID: <20200129121744.zv3jnf6uejjpetud@rgajda2364>
References: <20200129023258.10004-1-brian.gix@intel.com>
 <20200129023258.10004-6-brian.gix@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200129023258.10004-6-brian.gix@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

I have a question about the way RPL is stored.

On Tue, Jan 28, 2020 at 06:32:58PM -0800, Brian Gix wrote:                                          
> Mesh specification requires that Replay Protection be preserved
> across node restarts.  This adds that storage in
> <node_uuid>/rpl/<iv_index>/<src>

Wouldn't it be more convinient to keep both iv_index and sequence in a file like this:
  <node_uuid>/rpl/<src>
?

You could store them in bytes instead of hex string 
and it would eliminate the need for cleaning entries from old IV_index.


Regards,
Rafał Gajda

Silvair
