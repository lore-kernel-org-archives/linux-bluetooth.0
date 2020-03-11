Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FE3C10F27
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 08:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E08A208E4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 08:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/6H03UV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgCKIIX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:08:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45056 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgCKIIX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Mar 2020 04:08:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id b22so707049pls.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2020 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gBBVFcz129ATYUp3xFoU+B3Q1NnkLaOTSFjTnDqkX0c=;
        b=F/6H03UVyZDuVDLkubEs8bXNusqoG3eexC/p2zhS4y98hUBxaFXE3rr5cFL5vBnvCE
         TCppwO7bbFCPO2mki8k69B/1ONf64X1xjNUBtb99tOudCUn2IdsacSBYAtfl4LTJIVeo
         BLmh32CqgMmhj+iH+REzAaoMbtnn7QUg1BKfNP7u5u4pe+dLPuW2ZEO8gg8bihkS82yf
         b9wBnCXuGBrWRsC25XsfOIBsCuBYeO0ve5zVDsQXJXPJDMctO4Sfkoe6eM0sK4+8jHpO
         jjr+gtwvgkkzFrNFdb8liAPnCR7vzpkCAO9Y8rJsJsVecna7tjKkoSwpd/Mor0hhVmIS
         MIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=gBBVFcz129ATYUp3xFoU+B3Q1NnkLaOTSFjTnDqkX0c=;
        b=do20z85bkX4zQ0WHJsNUTl+l0d4P7SwZZMQ8YL7M3Lbd3e5SxJpTq/whWIpQoGNve+
         fvcuxUwVB+BQywS878sfb0RTzA9Ap7bVnHTYaTF8KRO7YCySWz3lg6QdqI2bkx9qik0j
         Nu7E4C+7C28X74apTUp56gojIyfn2ZpUrJPTvvpna2z1Oye5J5bSBpqZ5ZB7ruqI0o1k
         P3U1Cosw9JN8j9MBH9YLonuckKCTnhueXA03VCWK2kZEejIzMc8e88/i+ODr6SbUO5MP
         XIdoqJOCFLflgBnVXBuBn7NJRgGrj9NnrDwhbDgrdDWS+CVJ5ZalOCyTEPG9TQBENl2Q
         96Bg==
X-Gm-Message-State: ANhLgQ1acwiDFiAwur/0p1Gp0vW+xc6CaTlNSaKfOhLTXh+vPf+HCjAz
        IhbWZ28+UJdAa0sjrSFsmeb8fp2BfWCR9A==
X-Google-Smtp-Source: ADFU+vtsugpC0G+BsjorK/Z1Af6UuMfTf/I3NmbRT5KPX6w+y1p1PIdB/GYYYyRLBNhF/JbPN8ZDiQ==
X-Received: by 2002:a17:90a:34c6:: with SMTP id m6mr2247267pjf.13.1583914102104;
        Wed, 11 Mar 2020 01:08:22 -0700 (PDT)
Received: from localhost ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id w206sm7902894pfc.54.2020.03.11.01.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:08:21 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:08:18 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: bfusb: Switch from BT_ERR to bt_dev_err where
 possible
Message-ID: <20200311080818.GC3293@rboyd-mobl.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200309214456.431153-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309214456.431153-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Mar 09, 2020, Marcel Holtmann wrote:
> All HCI device specific error messages shall use bt_dev_err to indicate
> the device name in the message.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/bfusb.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
