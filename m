Return-Path: <SRS0=Ti+w=XA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A9DC3A5A5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 06:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC982173B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Sep 2019 06:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW3orVLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbfIEGEw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:04:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37022 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfIEGEw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Sep 2019 02:04:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id y9so1009268pfl.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Sep 2019 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CAa72BCQwDoIZ0Jk2Bk+th4bdDXZHFU3XLOk43o5i3U=;
        b=DW3orVLaIX7s9yCgvQGrsfX9Gvqo7CJxoXfJ/SHffeC9XDqcks7sNAf4S0CD+mwXpu
         wX/3ijoXhq3MSomYIZk/086ApB/OxZ7Oh21j1r97uiml81DYrL53F4owaXkLLDgYfVXn
         hQbcJ2JXMkUQyfod5LsnGjfgCHcNFd8LNgQMjtownbRneYvNLxz4U+ktH9FjuvE4PIJn
         fICI0jq/N/mRySigPxvXK9UwXa/yQGuXf6m4nZQOj/MBH9aGRUIkatTacIbThk+oHld1
         WVZb7A0fBGVvcNbkz9q+Jlz0YVTzUZdG7BuhqwPKfvR1mZqPbnYAgAx28rIKnliUq4e3
         ou+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=CAa72BCQwDoIZ0Jk2Bk+th4bdDXZHFU3XLOk43o5i3U=;
        b=Q0x7PJQyDw3g7qhgT7xcWaAqdbydNGDtg1jHLJLtL3tjY7NQfwcuCkxzONWkz3QLp0
         VG4Y+eOrWW9/48Im6KITJALPDU9Ckj5ooo1uwEuPHWiDV/LYmx5GdkvCjjb9uIE0ZaND
         YDOi8Xw5nFY6MRWgtdJ3q5LWbydDOkr9AXRQdCy4KfMVH80JRkr9VovqnZLlCylG+v40
         G5l0EeT3jcgVtM2sxu1GN9Rit6dd+uFfRZptD4ukoS75Zv3C7YiHU1VY2ipvFLDEkLt6
         A8bCrlKruJ5x2UpiZ3MXbsUFOd0RogM8/yS2A7xI+NRJ3SSI9ZDZV6cu1BNOR7E++VHO
         jMnw==
X-Gm-Message-State: APjAAAUg5D8GjWc4CpIrdBvaYVNen/qKc+bDaI/p4vF5DNDdtwEPy5t8
        dr4ARdM8HzW9omI0zx2Id2xEwfMFUWEfAg==
X-Google-Smtp-Source: APXvYqyicQIBAxZESX647QAmvZo3Wk7gfeXZuXpioCsoVhar2sf3M05Oy41h8sf6azgxx9CA0SXTPA==
X-Received: by 2002:a62:583:: with SMTP id 125mr1807583pff.69.1567663490742;
        Wed, 04 Sep 2019 23:04:50 -0700 (PDT)
Received: from localhost (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id z4sm920020pgp.80.2019.09.04.23.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 23:04:50 -0700 (PDT)
Date:   Thu, 5 Sep 2019 09:04:46 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Revert "Bluetooth: validate BLE connection interval
 updates"
Message-ID: <20190905060446.GA47246@blobacz-mobl.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20190904181308.14948-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904181308.14948-1-marcel@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Sep 04, 2019, Marcel Holtmann wrote:
> This reverts commit c49a8682fc5d298d44e8d911f4fa14690ea9485e.
> 
> There are devices which require low connection intervals for usable operation
> including keyboards and mice. Forcing a static connection interval for
> these types of devices has an impact in latency and causes a regression.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_event.c  | 5 -----
>  net/bluetooth/l2cap_core.c | 9 +--------
>  2 files changed, 1 insertion(+), 13 deletions(-)

Applied to the bluetooth stable tree. Thanks.

Johan
