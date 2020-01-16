Return-Path: <SRS0=0CDr=3F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF2C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 07:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E48E2075B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jan 2020 07:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV0dkxz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgAPHle (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jan 2020 02:41:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41496 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgAPHle (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jan 2020 02:41:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so9466543pgk.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2020 23:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UU24XtQJM7Lsz+2wyte3r2CcjDdGFIfX+8DQsgDKdyA=;
        b=VV0dkxz3gw06Udj9o+ZkW7sNmgt80R6OGRBzZ9urZ/aMCjd+Wg0M75+mXIC0Dab+xw
         LYfNWfMnEuP8f5jUkIs90i8LtjRnV5spcgzJ3dooM5B24yRA/Rt8z4g3/DMzaYzNhxlB
         Dr+4fThoEp0BPx4Qojdx5NWR1iEKQ0axegC2/+ue0t8MLTEatnJSp2Vwmb4uDMEtw5PT
         ORBFDBlyItNGJcMZPQgwV2vVYVpcyvFopjMM9WbkMZRxbkKND0DKGQDZUHnYEk9zz6tg
         7WmpN1kPDPjuHI34D47jEuBj0X1xnylxbkFgzwh/RXKH7gmXuEc9uvoDu92jAM7LNXYN
         VbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UU24XtQJM7Lsz+2wyte3r2CcjDdGFIfX+8DQsgDKdyA=;
        b=q+Gl/ET40i8pb3KW+7BS8VAEUWeGatpxiiQD5PD5NR/ns3Cl16xo2sdRX3DgjtEv8B
         hjDB839ddMdBnL1i/ebi7q5UY+1nY2UBdlmLV0b6f9HoUa4hKc1YFi6qVwfCMdjFAv0y
         HUMNI+rz1Qfu20+7emhZVjVYlONbNd43meACMr6qY2wuwhFIrzxFrcDHHFql4KWCQ419
         PyyEhWZk/9FwwIrnkVpEaSANewmgwfyLbij/3bhAajPbhp8C6k/m71YdUGn5cscQf7/Q
         W/euptVSEiWSfdE0pI2Z4GUJk9p7tOT9LM+irIAdMfZJaiWde2fvzNqZ5mfPDPvwuLJf
         kgJA==
X-Gm-Message-State: APjAAAXw5wFKV2/2i5qtDTBH2gp5zJTx3WRvuOuraXEXGptajZhkIlAW
        s8ptU9byKDIpR/pzZO/T9In86nS2wp8=
X-Google-Smtp-Source: APXvYqwdcNc62PC8j6ycYyisyw31YIwrsC5BTfObeAkHfWqrnxjKcRXmUapoLxjrwC3f+brpL0mbBQ==
X-Received: by 2002:a63:1204:: with SMTP id h4mr36836943pgl.288.1579160493333;
        Wed, 15 Jan 2020 23:41:33 -0800 (PST)
Received: from localhost (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id d14sm2323825pjz.12.2020.01.15.23.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 23:41:32 -0800 (PST)
Date:   Thu, 16 Jan 2020 09:41:28 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Increment management interface revision
Message-ID: <20200116074128.GA4849@pgaladyx-mobl.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org
References: <20200115203532.136198-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115203532.136198-1-marcel@holtmann.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Jan 15, 2020, Marcel Holtmann wrote:
> Increment the mgmt revision due to the recently added commands.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/mgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to bluetooth-next. Thanks.

Johan
