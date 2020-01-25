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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B36C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Jan 2020 14:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0FF2070A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Jan 2020 14:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRK6SBFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgAYOfj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 25 Jan 2020 09:35:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38088 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYOfi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 25 Jan 2020 09:35:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so5837323ljh.5
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Jan 2020 06:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zXoIv0kUUbII65E9p4WWXCTV0Fjjou4O4d7c9JC6tyE=;
        b=jRK6SBFOx03Ee+fTb8E4KJ+Si9nziSxmiXRFWLInaluawOp5j8r+9JhHZWfbFvQn1X
         CotPar0JhcabO2jk4vBJ3aZuqJ7j6DedtWxqFfd+GCn1NXfKVA+9srVs46AM50mBrfXx
         9lTwNxj05ia1K9aY0qjGRU7nlcE942kwR+f5wgC97IbnitAUWrysBG+MIkJ/oBAnC4sa
         h+YEtncnRsKWSt0r2lvgBb210mBK9g8SB96whxjLlLUjnYfYs7CZLDPr4fJWlxdrwVET
         D2yvHGU23+XOxsK3mwG7Fu8BdCNsWKDx9WwfKgg+ERPgn2rbGu4e6oQUe2Qj5oVWdIJ2
         MoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zXoIv0kUUbII65E9p4WWXCTV0Fjjou4O4d7c9JC6tyE=;
        b=JBHDxL32f4D8ETVyHA/uEHtKu2aK6KaphpDEuWoETzA1ewgiylbTtuM34mzATFMZEz
         rscNeooNO4LaP4UeNGfvSgVAmfbGUkRUuqUinfFYf8L0gZ9ZiyOKBfgvAmQvKwFf58ai
         jBzOQd1jXSaT02QUa++MdCaZNb7liWG1mCV7O0ewHmsJFxKMcSJ/OmKoeu/TwswQao9U
         0apxNWwjI6FnFc7iSOEXqs7n1McbkeU/bcHUagPQmrNYaF6FHztKo6jNzMUrb6MMVN9r
         /l94+TJFm2RRm9ZANbuUz9iEo2g3yoAsDQJouThsf0H6m5TI6bmvV2UVmsQ0pA17HpC1
         he8g==
X-Gm-Message-State: APjAAAXKJjN0CLqEHZbqE/Eq/R0ARgZY3gdzEnwuvqQAcWqgl9hlMShs
        SPp5W2+w3XofTzpfk/PLqtQ=
X-Google-Smtp-Source: APXvYqyPCQFj97idU3ocTi8/M/KWqCzUKciQJZAq49rNk0ngHypT+l2n5PRqdGpPvW3FRx0s2RCsNw==
X-Received: by 2002:a2e:7c08:: with SMTP id x8mr5180664ljc.185.1579962936675;
        Sat, 25 Jan 2020 06:35:36 -0800 (PST)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id y66sm4739321lfa.53.2020.01.25.06.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 06:35:35 -0800 (PST)
Date:   Sat, 25 Jan 2020 16:35:35 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add missing checks for HCI_ISODATA_PKT packet
 type
Message-ID: <20200125143534.GB27634@jhedberg-mac01.home>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200125082347.96440-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125082347.96440-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sat, Jan 25, 2020, Marcel Holtmann wrote:
> The checks for HCI_ISODATA_PKT packet type are required in a few
> additional locations to allow sending/receiving of this new packet type.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c |  4 +++-
>  net/bluetooth/hci_sock.c | 12 ++++++++----
>  2 files changed, 11 insertions(+), 5 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
