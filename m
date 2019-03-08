Return-Path: <SRS0=I3Ez=RL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1107C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 15:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9849C20868
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Mar 2019 15:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="WSrMa6cF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfCHPUm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:20:42 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:35893 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHPUm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Mar 2019 10:20:42 -0500
Received: by mail-lf1-f53.google.com with SMTP id 197so4627839lfz.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2019 07:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XI/A6bdSkFtuYEnKSfFlkXfXzvTOEhfztOnMqyHCYbI=;
        b=WSrMa6cFXKCW5Z0lH5pewqjfOKjQ1e0NYujo6Ed6Y/8f4dT7/w6kmhX7i4f7Kse3/X
         H/TDiA2FUo+Vd3ntfPT/yyThWS5HkSzQ4xLBb1k/eV1IH1R9vefsnCmnF4h5dIKC5Gn9
         gD7DKxhroNViGUAbFbZRRjJyw4pV2VJIr4gcDvMhwwFkB5bixuazO+L9rw0UoQlgywO1
         ZuAPsGR73qXEYEW4k6RulS4x8l7zJdJOm1SVBg7YIs4KjyM3dP0hBtOg9SbYicf8M8+i
         kLspsDFSEnttkZ8+3z+cKAOBwkczSpmP4IjjKT53b/5xCTuV83qbEkPUEl11W1ENXbXJ
         FoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XI/A6bdSkFtuYEnKSfFlkXfXzvTOEhfztOnMqyHCYbI=;
        b=NTG/ItlhdJQe3X0vt8yva6qHyA3jgx6OF22ijJGF2L01lg2GSVJSN9yXuK4UHjuuqB
         rt0dbUZOUXz9i7RwU5k+yc82hYHlQ9rP0u6wr5b9UP5WkP+eHWOEfN0vXSF91Uw6aJ3B
         eI4MnxuvZMZXM1Ux1x7MsNXOw0DKPrdKm6KFvdOz5puGGJqpJloH40BLTQhawrBZB2U3
         uP954cJWW4MYfeVRDVI691VCsPMfTl9liiMuJam68Kbau3+KnZgfk3Gl2eBIecaPOa//
         VFrp/xHKFJxpFKhSWRrlkxpC4GrDgucUBSyME+EwfImZ9cwqw2Jj/6dAQWRU0Ap6160K
         ZU+w==
X-Gm-Message-State: APjAAAXv8sAHs+vRiidny2TfQRQfLQxFcAUh+PBagfQZgF7f8istiSSR
        tGFl9XpsGiwsfO1Gz7fNAyz4H3sZj3c=
X-Google-Smtp-Source: APXvYqyQre0kBdfJI7nEy/NbIwSUzkaBm5N2nR5V6U8O/ddwitctQvkhXRpmSvrzc8y3C99NzxHf/Q==
X-Received: by 2002:a19:2d44:: with SMTP id t4mr10186460lft.90.1552058439637;
        Fri, 08 Mar 2019 07:20:39 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id s14sm1471270lje.4.2019.03.08.07.20.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 07:20:38 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Fix LE Set Extended Advertising Parameters TX power decoding
Date:   Fri, 08 Mar 2019 16:20:36 +0100
Message-ID: <141098209.CQRiSTOYlq@ix>
Organization: CODECOUP
In-Reply-To: <20190226125629.30277-1-szymon.janc@codecoup.pl>
References: <20190226125629.30277-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday, 26 February 2019 13:56:29 CET Szymon Janc wrote:
> TX power of 127 has special meaning for this command.
> ---
>  monitor/packet.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 96cacddd5..7f4d6b1ea 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -1115,7 +1115,7 @@ static void print_power_level(int8_t level, const char
> *type) {
>  	print_field("TX power%s%s%s: %d dbm (0x%2.2x)",
>  		type ? " (" : "", type ? type : "", type ? ")" : "",
> -								
level, level);
> +							level, 
(uint8_t) level);
>  }
> 
>  static void print_host_flow_control(uint8_t enable)
> @@ -6944,7 +6944,10 @@ static void le_set_ext_adv_params_cmd(const void
> *data, uint8_t size) print_peer_addr_type("Peer address type",
> cmd->peer_addr_type);
>  	print_addr("Peer address", cmd->peer_addr, cmd->peer_addr_type);
>  	print_adv_filter_policy("Filter policy", cmd->filter_policy);
> -	print_power_level(cmd->tx_power, NULL);
> +	if (cmd->tx_power == 0xff)
> +		print_field("TX power: Host has no preference (0xff)");
> +	else
> +		print_power_level(cmd->tx_power, NULL);
> 
>  	switch (cmd->primary_phy) {
>  	case 0x01:

Applied.

-- 
pozdrawiam
Szymon Janc


