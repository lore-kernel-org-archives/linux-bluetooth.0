Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C94C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 04:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B635613AA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 04:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhESEmb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 May 2021 00:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbhESEmb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 May 2021 00:42:31 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F30C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 21:41:11 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q15so8548788pgg.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 21:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3QbSbLPI6KFau5SMsJj2VQiXQD0J6qb1qFkmipXcu9c=;
        b=P01ugnN2t7Zxcr4d1TdgUdXgPa7ahsbEWf1b0DvF50IZTgeoYD3hzVkde92er6KCwc
         7P2zKaI+7j828Vk0LWFm692znfKJM8Up/DbIuL1yztePFH72rUErPGWsZI+AR9nOvgi9
         kAuKygHkhgcmI4+XO3K9dUi5z9N20KA3Za69KjAYllfzjVVJIas3SK809Z89QI869neC
         ZFL/ZdsqN6QMz9U5FK1ZLsDqV9TwG2OrqyumqNeb8EFak0k0qDBXjc47OoKwLqahFaxA
         G3n6JyqHPOUWLCjiXKlh8ANqLRkkoTlG/DT2tVsXMdpSxiJ7p5UT+2oc24fdTLghlPYF
         ydPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3QbSbLPI6KFau5SMsJj2VQiXQD0J6qb1qFkmipXcu9c=;
        b=WvcEwJ9QrUxsiCFq5PPLORvz7eu25esmeFGHhTRX3M0/P8zQjbtGhWMBi5pcLjwVpf
         WWp8Sqr2ng835apojmCqlWUMRj3DRxK/5z2ElE7FUeKMnnY+deh1IIRKrZyToobQngwF
         Sowiuc/n2ZpmRdOVLCidHa2b8JNw3O2mWUbiQONA2x+DPMX9lLO3x5sgSV2dNfhi+LYk
         QJCqQAfA+sSbnuPgvAaPU6KWBeRFsnNCc9MPCfjuBhg61vAgbOknNvp2Zt8K0vagqm+4
         meT9c6EVjyB/V2ui/mJDw4sO3xHvF/Fsn+9EOtiv1Qskh7pVol6Wp6zL5cKBjNS8boEd
         qxGw==
X-Gm-Message-State: AOAM533S7wxnYearBWWRWW3g/7/Cn5LwzreVrHUML6qwtXVXYfIyGtEJ
        v3IhH1gEgS1a2ulf8jB52BM=
X-Google-Smtp-Source: ABdhPJx+mcDJ7U9IwBIv0R9crVH+pNXKtaGpUFRO52x0uMzkulY2kWtyoFN2CcKO7CrZ3nab+Y0Lcg==
X-Received: by 2002:a05:6a00:a8a:b029:2ce:a0c2:1f6d with SMTP id b10-20020a056a000a8ab02902cea0c21f6dmr8796633pfl.3.1621399270671;
        Tue, 18 May 2021 21:41:10 -0700 (PDT)
Received: from han1-mobl3 ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id x6sm4606265pfj.24.2021.05.18.21.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:41:10 -0700 (PDT)
Message-ID: <625ddaac272571a89451dbff5be28270cd63e15b.camel@gmail.com>
Subject: Re: [Bluez PATCH v1] core: Fix loading AVDTP options
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     Howard Chung <howardchung@google.com>,
        linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yun-Hao Chung <howardchung@chromium.org>,
        mmandlik@chromium.org, apusaka@chromium.org
Date:   Tue, 18 May 2021 21:41:08 -0700
In-Reply-To: <20210507123246.Bluez.v1.1.I15d73dd47b94af906daa3f5a25d4fc5db8cc5b29@changeid>
References: <20210507123246.Bluez.v1.1.I15d73dd47b94af906daa3f5a25d4fc5db8cc5b29@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Fri, 2021-05-07 at 12:32 +0800, Howard Chung wrote:
> From: Yun-Hao Chung <howardchung@chromium.org>
> 
> Fix misassigned AVDTP StreamMode option, which causes StreamMode not
> being set.
> Fix AVDTP SessionMode option not freed.
> 
> Reviewed-by: mmandlik@chromium.org
> Reviewed-by: apusaka@chromium.org

Reviewed-by: Tedd Ho-Jeong An <tedd.an@intel.com>

> ---
> 
>  src/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/main.c b/src/main.c
> index c32bda7d407d..7612d6984890 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -774,9 +774,10 @@ static void parse_config(GKeyFile *config)
>  			DBG("Invalid mode option: %s", str);
>  			btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
>  		}
> +		g_free(str);
>  	}
>  
> -	val = g_key_file_get_integer(config, "AVDTP", "StreamMode", &err);
> +	str = g_key_file_get_string(config, "AVDTP", "StreamMode", &err);
>  	if (err) {
>  		DBG("%s", err->message);
>  		g_clear_error(&err);
> @@ -791,6 +792,7 @@ static void parse_config(GKeyFile *config)
>  			DBG("Invalid mode option: %s", str);
>  			btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
>  		}
> +		g_free(str);
>  	}
>  
>  	parse_br_config(config);

