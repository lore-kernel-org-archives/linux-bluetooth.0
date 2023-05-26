Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531BEC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 May 2023 14:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbjEZOgK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 May 2023 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbjEZOgJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 May 2023 10:36:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C65E50
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 07:35:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f60e536250so13372575e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 May 2023 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685111676; x=1687703676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqtBAQs9ehNEua0TlmiNfhKnKVDdiurGVVofP/hcpAY=;
        b=fgVkZupSZ6Kyp9cr9FAJNKJ7oTh5+a8Bwz3I9jofAM4DGsl4+Oov4wXTf3Ya6ItvOB
         DyWXSbc19YfbqAsbHoHPoT4RB9wC25aowSwVldyuedtwP7D2/YhoCNm2kOfivn0cOB17
         z35cff8EqvIprOd5vFy7z0kD/aYzI42YTDI6L7mHpiZvxn+0GoCoqoOTIWx/e7Xawy7a
         W6h2k4BaDhwEJH0v86Z3iTVH8/LnB1/0oKHofKcAmLYQJuTSNhSDaSIhe87OsTFeFP3X
         RVX8Al6Y5WlzrdtkJTAIKBs61Kfi48T1dpM6dBfi4qy62WHKQp5wLj6x15riqU514/UA
         xmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111676; x=1687703676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqtBAQs9ehNEua0TlmiNfhKnKVDdiurGVVofP/hcpAY=;
        b=X/Ls4MMGOQNgQp3mH2nngU/txsEsU7aduLMBj2CoF/VcWWWNhR4+vxv0G4iSq3Bscq
         X1KM9A0AkEOsvbXhV84iFpO62IxEVoqHwlq7JfHLqfNHcyRe4QreesrTLTyTD2xDy+KP
         /Mj+oOXAa9H/rly7cCiu25CIYJNEm/dNhED28cTM65IRbSau05mp1Rn8Z3c6SPDmLNI+
         Evchh35twa0PhM5X7U8rMUPHwBZnDNE968i6xVWf/cOjjSwfkAGN+QJnLkjYp1ivHo1y
         41gL9a6+CJnxfMNyekF3zldEY1kN13EMIvOm342/Z6DteXPhpj7MuGk7EuO2JJMm1fM9
         LpRg==
X-Gm-Message-State: AC+VfDwMqIya700b5xS6ry00946L3YB6aDoddJEUJmqlOPqe4KxwnT+N
        yI84YzxozTACQYPw7ivvqTH1A0e5GWpeBx644uY=
X-Google-Smtp-Source: ACHHUZ5QzJMztNXUqGpyA+1+Ra8QUvZsK2hGm+JrxZcfhiuVk3gidHX8xUP5PCisKyX+KspufH68lg==
X-Received: by 2002:adf:fe84:0:b0:30a:c707:902b with SMTP id l4-20020adffe84000000b0030ac707902bmr3469809wrr.25.1685111675734;
        Fri, 26 May 2023 07:34:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bcd0c000000b003f601a31ca2sm5452587wmj.33.2023.05.26.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:34:33 -0700 (PDT)
Date:   Fri, 26 May 2023 17:34:30 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: don't check for out-of-bounds value
Message-ID: <fdab8adc-0f61-4664-a2f9-6f532b0c85be@kili.mountain>
References: <20230526-l2cap-16bit-v1-1-2cfb83dd28ee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-l2cap-16bit-v1-1-2cfb83dd28ee@kernel.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, May 26, 2023 at 04:16:54PM +0200, Simon Horman wrote:
> @@ -4161,8 +4161,12 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
>  
>  	result = L2CAP_CR_NO_MEM;
>  
> -	/* Check for valid dynamic CID range (as per Erratum 3253) */
> -	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_DYN_END) {
> +	/* Check for valid dynamic CID range (as per Erratum 3253).
> +	 * As scid is an unsigned 16bit variable it's maximum
> +	 * value is L2CAP_CID_DYN_END (0xffff): there is no need to check
> +	 * if scid exceeds that value here.
> +	 */
> +	if (scid < L2CAP_CID_DYN_START) {

This is a false positive.  To me the warning looks reasonable.  But one
way we could silence it would be to keep a list of macros where the
check is impossible but we still want to have it.

I could create something where we do:

echo "L2CAP_CID_DYN_END" >> smatch_data/kernel.allowed_impossible_limits

I'd do the same for unsigned comparisons with zero like:


        if (dpmcp_dev->obj_desc.ver_major < DPMCP_MIN_VER_MAJOR ||
            (dpmcp_dev->obj_desc.ver_major == DPMCP_MIN_VER_MAJOR &&
             dpmcp_dev->obj_desc.ver_minor < DPMCP_MIN_VER_MINOR)) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                dev_err(&dpmcp_dev->dev,
                        "ERROR: Version %d.%d of DPMCP not supported.\n",

echo "DPMCP_MIN_VER_MINOR" >> smatch_data/kernel.allowed_impossible_limits

I can do that on Monday if you want.  Other static checkers might
complain still though.

regards,
dan carpenter

