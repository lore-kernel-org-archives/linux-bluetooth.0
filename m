Return-Path: <SRS0=dIIZ=R6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A94CC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 17:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D272146F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Mar 2019 17:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nSx8i6Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfC0R3I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:29:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46662 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfC0R3H (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Mar 2019 13:29:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so10004901pfj.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2019 10:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b74V/0OwQbSBs8jcShaZRpUMutCOweQ+Ml+pMHVBMz8=;
        b=nSx8i6LpW0AN7ZaGOLBBI/NDoJwfIDafz5zLjyudBSKQQDZmOFmLn9j7gZPSNaTh8/
         wFZCc9nCRJM98yQaYDEwJBIrZrJ0mJvjhf7b0xmLRjFmoPFPULSH/WUIgR+aVDwuU+9j
         vu8VgbPh2XoY8q8KbaesNDcUEnA4Fdobl9Ccc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b74V/0OwQbSBs8jcShaZRpUMutCOweQ+Ml+pMHVBMz8=;
        b=gFBgGJXD+nEFnS78GTww+Hg6jIhFUKPNSr53EEWF2oemLMQcO3ulAw5Qexif3GEWk1
         LXo3WS1QmH8wfzcV/EzIeI3d7yjMnuU7NWuq0Hv2eKhvNkxBSeLgxS2oSN2WasS8dpfy
         2BxathLlxnWJqDOZAPchK8BVnxNQWmr9fHotbC+UQjJHjGc4QepcjA6SDXJy8rduiPka
         nmX/oF83uPnXjnEFMyehyotcIw/uCPlLb626JpRHWnmkQ6I39Ci1RUb5yUrsLcLiuFdQ
         wKW1dUTWMCSAp8fj8qzKEZTcmhhy044FcQcow8c+C4pDxzsF/Bh1r32e4Vu2rTL4qQY6
         WHxQ==
X-Gm-Message-State: APjAAAUj7AjiGKOuDpC1n9fdPiTbM/cDHFtdsi/siAO4/tjtWUOfdxxG
        52dMT4A6v54qpOIbQ+H2cDkHvA==
X-Google-Smtp-Source: APXvYqw7wH/UoDl65e3uBkVqUW1sb5II2QTNP/njpyxiqhTDgGVw8AavRVdfbqvYZdkpFLutmDBRtA==
X-Received: by 2002:a63:3d49:: with SMTP id k70mr18629273pga.447.1553707747190;
        Wed, 27 Mar 2019 10:29:07 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u62sm59161521pfa.124.2019.03.27.10.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 10:29:06 -0700 (PDT)
Date:   Wed, 27 Mar 2019 10:29:05 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3998
Message-ID: <20190327172905.GE112750@google.com>
References: <1553689723-21017-1-git-send-email-c-hbandi@codeaurora.org>
 <1553689723-21017-3-git-send-email-c-hbandi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553689723-21017-3-git-send-email-c-hbandi@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Mar 27, 2019 at 05:58:43PM +0530, Harish Bandi wrote:
> This patch enables regulators for the Qualcomm Bluetooth WCN3998
> controller.

I commented on this on v3, but you didn't update it:

  No, it doesn't.

  The next version should probably say something like "Add compatible
  string for the Qualcomm WCN3998 Bluetooth controller".

Thanks

Matthias
