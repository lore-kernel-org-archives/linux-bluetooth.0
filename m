Return-Path: <SRS0=NPxI=77=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2658C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 10:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0E120B1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Jun 2020 10:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY4QbUCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgFRKRp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgFRKRc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Jun 2020 06:17:32 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C82DC06174E
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 03:17:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d7so3120942lfi.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2020 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y2RIAJV8ZsSpSlmsN0Mtm8ddYweIRQvNFQDpS74Mfhk=;
        b=iY4QbUCmdiZJda231G5kcdXutq150SsmwFqY0XLt/gdmLeJx5QUxkZrr3uuCAdsHQ+
         9ysiifgProcqc/KmKlxPQ4wg/S9P5GeiCvxm/jyit8oiz9H5JCnXEFWiUbPrP2UrJLqc
         M8RK0qK9uBMyQ7DFeGsRYnmekMPsqIexpeNgA1DcB3xben8BK9py3SHyeMngjIyCWiLl
         NK2FKSuT7vZm9FpebViWZL+R7AY+gC4K/MjBpXK03VlZY5Fqjl6bQUNeLfE9Goe7QSC7
         se6FejAyTUBBfs6I+B4AaGva/Ha6w3oOdgEvlYqLom9jqrxobKCkiLtG5SirYQLTY5Cg
         xDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Y2RIAJV8ZsSpSlmsN0Mtm8ddYweIRQvNFQDpS74Mfhk=;
        b=IGLy9nDQ09+KRxKbI0x07qpxo0Fq70TpuZs1O7+NCqyfcJcU55c0TjlUru0y5DiBns
         zximoYGv/jP5kLCc9Qhp5MohzyLjRC6TRlL85BntsTCmPwrYSAIJ9VdwcesfsY8JcEL6
         C4hkkt3OzM5aCJurxou4d5qYOwzgOWyOvNjl8gIJ9tSL2lsbPp5ivLzXsOEXF9S+cIxa
         y4KcLgTS8xToFbWkNbJw3NfNBy8+s6OZej9BDxYYfb+dohJ+xSruxCE8KlMeakpS6Ymn
         k5hlTjEgTXJEpghxuSSWsqTd6YQ6YsQ4gTgjR6ttcGpROCG2x7ET0MuROEMSSzjbhhu9
         s1iw==
X-Gm-Message-State: AOAM531Hk1IvwcdX8RqPAuLskCOrhYUKEZUW7AnO2eDJEwSLZ9IFto/o
        R+u5LMU5vYuuPZFmaysVlWBJMTepoAs=
X-Google-Smtp-Source: ABdhPJynfDk7z6/2pF5MWjTWyAMO7tkGf6jDydsZKjKB7y3SyRR/HLVGms8EGH1wl5Myv9hua5AG4Q==
X-Received: by 2002:ac2:5443:: with SMTP id d3mr1973508lfn.121.1592475447508;
        Thu, 18 Jun 2020 03:17:27 -0700 (PDT)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id o16sm615276ljg.90.2020.06.18.03.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 03:17:26 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:17:24 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Combination of pending patches
Message-ID: <20200618101724.GA76432@jhedberg-mac01.home>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <cover.1592404644.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1592404644.git.marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Jun 17, 2020, Marcel Holtmann wrote:
> This is the list of pending patches and fixes merged together. Please
> review that the set and functionality is correct and working as
> expected.
> 
> In v2 the Reviewed-by tags have been added.
> 
> Abhishek Pandit-Subedi (4):
>   Bluetooth: Add bdaddr_list_with_flags for classic whitelist
>   Bluetooth: Replace wakeable list with flag
>   Bluetooth: Replace wakeable in hci_conn_params
>   Bluetooth: Add get/set device flags mgmt op
> 
> Manish Mandlik (1):
>   Bluetooth: Terminate the link if pairing is cancelled
> 
> Marcel Holtmann (2):
>   Bluetooth: mgmt: Add commands for runtime configuration
>   Bluetooth: mgmt: Use command complete on success for set system config
> 
> Miao-chen Chou (7):
>   Bluetooth: Add definitions for advertisement monitor features
>   Bluetooth: Add handler of MGMT_OP_READ_ADV_MONITOR_FEATURES
>   Bluetooth: Add handler of MGMT_OP_ADD_ADV_PATTERNS_MONITOR
>   Bluetooth: Add handler of MGMT_OP_REMOVE_ADV_MONITOR
>   Bluetooth: Notify adv monitor added event
>   Bluetooth: Notify adv monitor removed event
>   Bluetooth: Update background scan and report device based on
>     advertisement monitors
> 
>  include/net/bluetooth/hci_core.h |  73 +++++-
>  include/net/bluetooth/mgmt.h     |  77 +++++++
>  net/bluetooth/hci_conn.c         |  11 +-
>  net/bluetooth/hci_core.c         | 153 ++++++++++++-
>  net/bluetooth/hci_event.c        |  13 +-
>  net/bluetooth/hci_request.c      |  32 ++-
>  net/bluetooth/l2cap_core.c       |   6 +-
>  net/bluetooth/mgmt.c             | 382 ++++++++++++++++++++++++++++++-
>  net/bluetooth/mgmt_config.c      |  23 +-
>  net/bluetooth/mgmt_config.h      |   6 +
>  net/bluetooth/msft.c             |   7 +
>  net/bluetooth/msft.h             |   9 +
>  12 files changed, 755 insertions(+), 37 deletions(-)

All patches in this set have been applied to bluetooth-next. Thanks.

Johan
