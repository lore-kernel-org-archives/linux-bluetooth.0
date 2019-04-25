Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA58C072AB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 13:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18CC206BA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 13:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8z4TA/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDYNVj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:21:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33455 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfDYNVi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 09:21:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id h5so11186205pfo.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2019 06:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f7k68G1+HbbmMJxyXh0sQJ5BZxIF6TKwJnDDYMi2ODc=;
        b=m8z4TA/OMhU9f+xVhirL2x6hKm/Jn/5lI0a7RKlVS2pSO2FNfObm/ERqjMeUeoyzFb
         KUQk5qgugeuFTBCA9TMOmhK+R8JUhWXj5tPP0EXdoX7qslHJo689P3+dSMySIHn1X2A7
         J8xH3rfKwBcC4n8fwRfVPmCGzwfaV8ZBfoIjzO+4DGswkmhrtPg5u0TtO6ZRKYIQVX6K
         7sS9RqJY2aMnSUlmTA6KolffE4vHKL2zHZGp4pVE77rTvmmu3PY6y6M88rYvIc8HgkIk
         np4PBQ1SUumqwGBV9RF64Iznoj15CIhVUqcRdfqkahblOdWP/7VPwr75qCxKGdN8Q4BY
         PxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=f7k68G1+HbbmMJxyXh0sQJ5BZxIF6TKwJnDDYMi2ODc=;
        b=IyQbxHEQqi28+/JL923fY+4EoWdtsBeX4JqWp6jDWWkJtzkN8bHS+ngKaIWIXTSNFa
         3GZ4Ee34aLgxLHx7gRZeli8XZeVUF7X9RwNrbZUQ/9YswSZ0aIl/16j1VeFaJMGWCCWS
         zunLTTIe82Xb9deF9YwOBmNFHVXp+W42czitdHm2YqllARV5bL0E1gGO7XBBuhwmati0
         oQI/qf1YuA0TbnHVbTuu4HIORq+VyWc67QOgmQRdLWD13ZyuFj3CbAiqV6cpe2iciTPO
         tOclCiZ4GuKsV2lFG4B/YTFdSch2JUE82LpsPUde/rwy2vQCU9TDJfnDTeTKtwdVF27V
         JhxQ==
X-Gm-Message-State: APjAAAVs8KFT57ABmE3Re3DVy/5AErlZLe0xSM4qQbAi8qc6n40nMEJb
        ZYmC88YARwiVJrWtz09NF1u2SBcncfVXfA==
X-Google-Smtp-Source: APXvYqzZSbq3ntRjElxJN7eEP7MJlOClOaLxIb6v+B0ZfDZHXsx3l8luG1BYsYl9oMFHLt9ZmL2CUw==
X-Received: by 2002:a63:5d44:: with SMTP id o4mr37107876pgm.15.1556198497562;
        Thu, 25 Apr 2019 06:21:37 -0700 (PDT)
Received: from localhost (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id g67sm33372068pfg.94.2019.04.25.06.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 06:21:35 -0700 (PDT)
Date:   Thu, 25 Apr 2019 06:21:34 -0700
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Align minimum encryption key size for LE and
 BR/EDR connections
Message-ID: <20190425132134.GA67839@jhedberg-mac01.local>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20190424201917.115510-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424201917.115510-1-marcel@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Apr 24, 2019, Marcel Holtmann wrote:
> The minimum encryption key size for LE connections is 56 bits and to
> align LE with BR/EDR, enforce 56 bits of minimum encryption key size for
> BR/EDR connections as well.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci_core.h | 3 +++
>  net/bluetooth/hci_conn.c         | 8 ++++++++
>  2 files changed, 11 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
