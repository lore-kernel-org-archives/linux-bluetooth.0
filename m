Return-Path: <SRS0=8Xmo=2A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02376C43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 17:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03BE2077B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Dec 2019 17:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cuzz+jUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfLJRYW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:24:22 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45367 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfLJRYW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Dec 2019 12:24:22 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so19586155ioi.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2019 09:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUEoNLC6Akny1bikIOVy5vqtKPV3GBIyGaF/rhZOP44=;
        b=Cuzz+jUmPzIpSevP2xHPa2zmBbTuiIfrYmEzuDKcr8Oc0j05tlRgwsOmeD+Pf01hci
         NAtNx8Jy7TCw/GStZb0E0krxW6+LTW6qSFmaZ5QpFUPgumYoKlgRVmxQt9FLmAVozLHe
         0CTceF8pcEyFlud7HofSogxqrqduoZeNjrGTrpdZlo/ijsxUluSLVS2pRsjqGuSbrppx
         Nh/GYJWqzDBtkz0o+RvXr6DVY1wRBO35vi4QZpXI92iaxVL04EOpFbm5OxlnB0LPIhgz
         OIEU8uPRZ/2fWbVaK/j37z4bMTAzRLyW4GB5git6egzsVFre++EPJ6XojH13Z5neDZtd
         qg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CUEoNLC6Akny1bikIOVy5vqtKPV3GBIyGaF/rhZOP44=;
        b=d2Y/kXWwhjWFfPhh+0NNHuUUqJgfmOk52iFwGbwrHA+gM/FQ2//1fm6iCfyHQvIqcs
         vL+KM9bdsrrpa6I9typRj4AXDWGrOpcGRiHyBmosm81di2F6eCWjwvAU9S2l/HE1oJnS
         Ld5JHSmIlJYAR7o2isoSUkVApDzEhAVMbUdlUhSH+1pn8KbI2hLa5sOkXVFuAC/DpErI
         Ibj0U8mBtAkTCdznPY/wAADVBB0K24iPP11xgVrvGsTxEfEJoO+hGkdKpbgUlONlQpZ+
         T5NZ4aRV/fkDRQaCg8Bk0l9sKxOUXDwC9zC9tDFu9Djc5fhUxHVJaHDSd2dFuRnVXlfh
         CTXQ==
X-Gm-Message-State: APjAAAUinkOG7QTcsnIcFj4HMlrcL6QEY7S2lbXt+sfUcKAGHqnbHCk0
        r+t2QbLkouidj5r22za9tBfWrS43+FnXxA==
X-Google-Smtp-Source: APXvYqzFIHheIT3nvdU2WmAUuGyknkPxLAu0UH3eCZeBNYLM/y+SkXG9Hn2+6Z6ocWHeB0vNHOHBnw==
X-Received: by 2002:a63:f202:: with SMTP id v2mr8889644pgh.420.1575998412698;
        Tue, 10 Dec 2019 09:20:12 -0800 (PST)
Received: from localhost ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id z4sm4090311pfn.42.2019.12.10.09.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 09:20:11 -0800 (PST)
Date:   Tue, 10 Dec 2019 19:20:07 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Ajay Kishore <ajay.kishore@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] obexd: Add initial support for MAP conversations
Message-ID: <20191210172007.GA50352@meiermar-mobl.ger.corp.intel.com>
Mail-Followup-To: Ajay Kishore <ajay.kishore@intel.com>,
        linux-bluetooth@vger.kernel.org
References: <1575976621-11019-1-git-send-email-ajay.kishore@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575976621-11019-1-git-send-email-ajay.kishore@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ajay,

On Tue, Dec 10, 2019, Ajay Kishore wrote:
> Changes made to add a new method for MAP conversation listing i.e
> "ListConversations" to handle conversation listing object
> "x-bt/MAP-convo-listing".
> 
> Co-authored-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
> Signed-off-by: Ajay Kishore <ajay.kishore@intel.com>
> ---
>  obexd/client/map.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)

Maybe I missed it, but I didn't see a patch to update doc/obex-api.txt.
That's one of the most important changes and what needs to be agreed on
first.

Johan
