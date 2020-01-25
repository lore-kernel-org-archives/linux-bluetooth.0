Return-Path: <SRS0=CluT=3O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F0FC35243
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Jan 2020 14:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75EC2071E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Jan 2020 14:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhvrKZmg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAYOfT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Jan 2020 09:35:19 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39942 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYOfT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Jan 2020 09:35:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so5813223ljo.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jan 2020 06:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hnOOth4cfOTsK3blqbf64rvHbKbZo2t8cNMCr1uCkdc=;
        b=rhvrKZmgpI0UG7tHnghsfQfMZ/CDAtqFvaE9K6f1jUh2V61vXu4/tmdS6UBvsyti1k
         8pK1CUyFZaomWH7BLkA4VLfLAbMGQSEzxmjChEO0/PJn/2e2YTagPF6osIbOsdQrg76K
         H6pgx7ZQ1f1xXrvABwVVkVC8poqapR8yAmDdJTPWBbn+cB7z9DIbFciBc6pi2wGNyso6
         d2UJomV6K6+PhoACAbV/d7WSaiFXliWMw/K/G3V6bKfThULcXaB5aVJBS1b0c8urs1q2
         hZ8yKLyMWFtSN15+w7Lh2asRmjoeOtqT4fznbs0ZgUsPtxq5E9ZPq8w+F4QC5vmkgFaf
         DwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hnOOth4cfOTsK3blqbf64rvHbKbZo2t8cNMCr1uCkdc=;
        b=q7aXky30lIyTqoxqqyWWOPocpeo1kYVWGwMwcMthDQWy50RjeoWtc8xcCYMFcL2dds
         hcE0pG+u+CZatv6zKtXBKKuv0myrEDLaUcb8TG6vZyYKh+t2p+4vByzrR0KI1bfusEDY
         jKjIIvyxrm1QjdnKuSUyF38W6oBaXUplUaNno+J7RtyfG8kuRAPF9YTxaUqnwsAtTEFO
         kypA/dCsXCbjXShRNLFthCY9QOu9S7zaCkdsYqIN+PhfshG15MjufCP13jq+00G7XNwA
         nmM1CZ1SKYoDGECwoERY3p9RjKcQkizrfi16uKrtj7Gg33U/W4lL4xWX6XTa52X0lYHC
         91Bg==
X-Gm-Message-State: APjAAAUi2KDV6tSCuR+ruC2r/Z850LvnM7Rh//yccgbDD92xsWx3HUg7
        cP1VKJiA+O0/+mQr39Khbq9xEVGU8HB1ng==
X-Google-Smtp-Source: APXvYqyhw/cqzHvKhJLEriywFfFhlaELsF2x8ivaN8+6ErAHaZsOx2F2pJ5QMAi2SDgVdJj9FalUjg==
X-Received: by 2002:a2e:580c:: with SMTP id m12mr5350324ljb.150.1579962916795;
        Sat, 25 Jan 2020 06:35:16 -0800 (PST)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id j7sm1069912ljg.25.2020.01.25.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 06:35:15 -0800 (PST)
Date:   Sat, 25 Jan 2020 16:35:14 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Move {min,max}_key_size debugfs into
 hci_debugfs_create_le
Message-ID: <20200125143514.GA27634@jhedberg-mac01.home>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200125081951.96271-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125081951.96271-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sat, Jan 25, 2020, Marcel Holtmann wrote:
> The debugfs entries for {min,max}_key_size are created during SMP
> registration and thus it might lead to multiple attempts to create the
> same entries. Avoid this by moving them to the LE controller init
> section.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_debugfs.c | 61 ++++++++++++++++++++++++
>  net/bluetooth/smp.c         | 93 -------------------------------------
>  2 files changed, 61 insertions(+), 93 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
