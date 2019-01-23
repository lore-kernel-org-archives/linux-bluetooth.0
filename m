Return-Path: <SRS0=X26K=P7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A7EC282C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 11:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006EA20870
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jan 2019 11:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsL90nk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfAWLhK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:37:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39591 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbfAWLhK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jan 2019 06:37:10 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so959374pgl.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jan 2019 03:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mtg4APi49JWQK0YyPgM2MNw0kiZMYGnXlU08tJjwMY=;
        b=jsL90nk7iMi2D6EmpXcypwivheV1Da00n8mjJUejQ0BFae3TG+d7TaUX02abQreZz3
         o3VOj0nZ7qLJiI+693ya5J5zJKavTVQ7t0HkEq2dw30ZCFlbc/JVhMcbapKlixC4dfxb
         AGz1mIiyavFQXP6qHtxTTQO6iU6UU0vU3lwt2+1e+0NpbmRsOvw7F6xWKA5MtSiNlzFA
         tmffBgy8Z9Tbx+ycJMrJUBvSNMyQgwofxSv6Mb1gw9lvSqpp8mzf7uVSVi1lAuUk62Wg
         gZYOwzBTqC0VT6YeZleYJD6rw07vlC7hcXXGBO0helXGXz6OSSstAKdjSCqSF7wtnxSo
         M2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=3mtg4APi49JWQK0YyPgM2MNw0kiZMYGnXlU08tJjwMY=;
        b=gErOYbMzsjh6wWJLB0vbj0r9qdF+Owef9Af3ZCKV+BjUGoGpZNndu1eRFOcRuBAWKi
         fRdA0mvCpEGhn4JctqhLwpe/nHnRsWv2GE7yaCEIPay/mmc5Tu+t7yUUzqvDpIEV8Bjp
         BU3t4ISIq8raUTaOyWlf+yty49ufRfd9p/18z7b+Q8EqetdibgQ7JL6XKn6pa9Plc2NC
         65p2C3uewRMMPOD/JhZXrcXU3nVVuHaAwf73zzUwb+9rIPwv93bV2utkgYosxFy6Dzow
         QDp7bfzL9PMMSa2KTlQmOmow45wcmvZwDud67nAoRnRIw0RXVfDbyngiy9DDkyS+dXjG
         WfiQ==
X-Gm-Message-State: AJcUukewW2nmg/dmbE2B8qa2oD5WbF4v6EcG6tSmUV/tNcX6mBOx6yEK
        +GHNqTAJI2wnf0CLtuXLs0o=
X-Google-Smtp-Source: ALg8bN7DPcGWdDrVIdLF7szXEN8erO+Yx4evE2jUm664p07+T/F510xVUVdXXN7tTjNbj95a9AZcYA==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr1686387pgl.127.1548243429384;
        Wed, 23 Jan 2019 03:37:09 -0800 (PST)
Received: from localhost ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id a90sm33009488pfj.109.2019.01.23.03.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 03:37:08 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:37:04 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] Bluetooth: Verify that l2cap_get_conf_opt provides large
 enough buffer
Message-ID: <20190123113704.GB11718@fcahill-mobl1.ger.corp.intel.com>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org
References: <20190118124319.12187-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118124319.12187-1-marcel@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Fri, Jan 18, 2019, Marcel Holtmann wrote:
> The function l2cap_get_conf_opt will return L2CAP_CONF_OPT_SIZE + opt->len
> as length value. The opt->len however is in control over the remote user
> and can be used by an attacker to gain access beyond the bounds of the
> actual packet.
> 
> To prevent any potential leak of heap memory, it is enough to check that
> the resulting len calculation after calling l2cap_get_conf_opt is not
> below zero. A well formed packet will always return >= 0 here and will
> end with the length value being zero after the last option has been
> parsed. In case of malformed packets messing with the opt->len field the
> length value will become negative. If that is the case, then just abort
> and ignore the option.
> 
> In case an attacker uses a too short opt->len value, then garbage will
> be parsed, but that is protected by the unknown option handling and also
> the option parameter size checks.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/l2cap_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to bluetooth-next. Thanks.

Johan
