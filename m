Return-Path: <SRS0=G1Nt=XZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07586C32792
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 10:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDE621855
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Sep 2019 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6EFCJd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfI3Kyi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:54:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39557 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbfI3Kyi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Sep 2019 06:54:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so5389032pff.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2019 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YP7LM/RmWQL82An/EdW4oyV4KLY+KNCzsOSBjn3AnAQ=;
        b=j6EFCJd5c3KTmERJ0y6boOJxdGPvXLMunQe3Imx4V0PfswVmHhBgWoG0VfF83WKWMQ
         2sURmJa8xW03MeIJYNQ3zMC9XF0IuGil/azBD/F1X4h+QjYK3Q2V16XsMBM2AMmWUZQg
         QvysLLWaUIpn8d4GlhTUF3jLyzLzR91KC4Pu5vN6nnivs8SgGw7cVMofXxex5AcTEZsG
         2rStfahfH4mFmKR9JaxCJEbsBeRtaxhU4h7mIZSdP2EQmM7/zI1RLPJUqvYQeb1GWyI/
         2CiWytMjZ+Pl4z4OWY4YmcsM9lkov40L12C/a2yuKi+tXiNDcEr8YyjMfFjC3R4VmN6s
         uihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YP7LM/RmWQL82An/EdW4oyV4KLY+KNCzsOSBjn3AnAQ=;
        b=J1/msb0QzkRLyVKAfKl2oBJYkGPqon7OJsR15cUceOCU/zNzlFHv7wDnNedNWuJXJW
         dRJksPBFdL4mBGT+l3VdcCJ5fqJBzMi/hkk2xtxWPvOgxsaaiJWHLQMZtK12q8oZg81G
         Gw7NeGCwGHLsDeDC7C0mhD2JAkwoDmzj2+4f4fbRjzxsKXqlodaLZE9+3y3+AZpMLKbR
         4mNmu3Ky2/OAFAJ1g2K7lcTbfX2itKnC77V2Ur5mpgQfDCbZg9cL5fbYonwdBIwZ8wvW
         CjExMuP7Iyfe9ccJIr4JAbD3YIaFAZnCZSq9sFXnpjEJ0ryOKYFShg5GZpnj+WSxu5tD
         wH8Q==
X-Gm-Message-State: APjAAAUlif/y6jtho/lt8AFgyd7PBBJshnA6ngi0kVE6D1BnEta9114o
        jUvS+cBaVwS7HZcg/48QVoVXyVMST0UImQ==
X-Google-Smtp-Source: APXvYqyTN6WZkAcMHOm1evCYjcn+6LxZPlGImAKJMHfVAPxoVMZ/gxO1iGQJVcqD2aLPXdzC5i04Rg==
X-Received: by 2002:a17:90a:a78d:: with SMTP id f13mr25830498pjq.18.1569840877403;
        Mon, 30 Sep 2019 03:54:37 -0700 (PDT)
Received: from localhost ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id r21sm15699887pgm.78.2019.09.30.03.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 03:54:36 -0700 (PDT)
Date:   Mon, 30 Sep 2019 13:54:33 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Use IS_ENABLED instead of #ifdef
Message-ID: <20190930105433.GA52240@jhedberg-mac01.fi.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20190927064858.121461-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927064858.121461-1-marcel@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Sep 27, 2019, Marcel Holtmann wrote:
> For the different hardware support options, it is better to use
> IS_ENABLED check. Let the compiler do the needed optimizations.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/btusb.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
