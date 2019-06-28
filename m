Return-Path: <SRS0=h1rX=U3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E7C4321A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3313E2133F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jun 2019 13:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="1mAMdVFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfF1N3i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:29:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37029 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfF1N3i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jun 2019 09:29:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id d11so3997531lfb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2019 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GlaLc+0AggAm5eHXMPSqqsfqEem9ma70DdgFECtsBg4=;
        b=1mAMdVFjw3I3/mPG23vtXJ24zKGfK79fDikHqFfycBSMm9ypSl5+J0wOu5w2Q1NFBJ
         b+KVHR+KuDoz0BMpFNHp3IkBrhHRHyPfFc11Fhd8BOzL+HQBaturEGu3fmfRSlpd6xlF
         C1GqIrRBd8WS+Sn7uqhFovU7r30EekiMCfAbPNJmQMtXOZA9Zhk7ff62MFXUNdGy9Cbc
         dfzQ0o19YI9Kduyn37DbeUO8uO/UB34zINmoRfzvGy9LusKLF9dRGgsTmk3Z83nEiL9R
         s9UB2ae8xfj6fejFYHWgAGBnC7WYHxA2oIETOMoyExwE7rkzO/vxIihNJVzHxNhtWewn
         ikBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GlaLc+0AggAm5eHXMPSqqsfqEem9ma70DdgFECtsBg4=;
        b=KyGwP4uBdLNP8ADwL+catiIysPkhAOE+indLb/EiJyG1E9w3LqRPYNdyvvFc2WL0F1
         y05J2q9wvYBmQ8wESkRO6aaAiCfe9E/F8pmTo0ppWwIfFzW+ojAm3VeT+BpJi9Vhbybc
         Di6tm2cUlUd9uEdCupnFlA7PI8EkcV2ErTo99BL3KePUHekwKVdB7IXycOJlhkf9VEvy
         SWdG/wOKgfDC767KhIJWd2DWSdWFOvXge7XvnXz9YJNt57OFKjMUPVWMzm4aEEIXCmaV
         JUM5HUKYtB3L1PCq60MBSdi+9WezNDkv3epxkWVnwUj2aE8wu9uRQ27J1ybbtO5j6oSv
         UNpA==
X-Gm-Message-State: APjAAAVPXWTMpIeKffJ0tCjqPc2RWkYmsXYp54qa2WaINZ2jNusC8goM
        ShFC3q0RzqF2aITtmMoYr8RiLaaOoKg=
X-Google-Smtp-Source: APXvYqwCTPdiaJoVH6ghBpApMODb6KCW0+Llj6UbUJchpKp7N0nX7oQjqcwXY2RBiBARrwUN/XDgbQ==
X-Received: by 2002:ac2:558a:: with SMTP id v10mr5201169lfg.41.1561728575391;
        Fri, 28 Jun 2019 06:29:35 -0700 (PDT)
Received: from mlowasrzechonek2133 ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id v17sm803380ljg.36.2019.06.28.06.29.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 06:29:34 -0700 (PDT)
Date:   Fri, 28 Jun 2019 15:29:32 +0200
From:   =?utf-8?Q?Micha=C5=82?= Lowas-Rzechonek 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 2/3] mesh: Add DevKeySend call
Message-ID: <20190628132932.bhcvcx4tzlfkertu@mlowasrzechonek2133>
Mail-Followup-To: linux-bluetooth@vger.kernel.org,
        Inga Stotland <inga.stotland@intel.com>
References: <20190628125205.21411-1-michal.lowas-rzechonek@silvair.com>
 <20190628125205.21411-3-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628125205.21411-3-michal.lowas-rzechonek@silvair.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 06/28, Michał Lowas-Rzechonek wrote:
> +	if (!l_dbus_message_get_arguments(msg, "oqqay", &ele_path, &dst,
> +							&net_idx, &iter_data))
> +		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);

I have a question here: what's the idea behind net_index argument in
this API? There is no such argument in regular Send() call, and I don't
quite get why.

regards
-- 
Michał Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
Silvair http://silvair.com
Jasnogórska 44, 31-358 Krakow, POLAND
