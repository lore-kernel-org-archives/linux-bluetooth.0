Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34F5C636D3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjAaLQJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 06:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjAaLQD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 06:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D404B4B6
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 03:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675163710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r5WDosCN8ptqhgrL1cgVrQgfmxbqRf8M/DBi7ayRhQA=;
        b=JOj28pt/5tSkoR2voFgvxr/7OhWYhEkibJo5LD4HWS0ZPJduxO3d3Lf3xYp7L7RKAtOcm0
        89XNojvtuvUrUUwnzKcHEhkaOszzIEEKaaX+901qrn/BFv19NgaEz+twfHkTlKEJGTjLrd
        87j+VeOlFO/WzXhVhqPRO+k8mseKxuw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-UNpIgpF2O_CrHg3dzYPuIA-1; Tue, 31 Jan 2023 06:15:08 -0500
X-MC-Unique: UNpIgpF2O_CrHg3dzYPuIA-1
Received: by mail-qt1-f198.google.com with SMTP id f22-20020a05622a1a1600b003b8674f2302so2666141qtb.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 03:15:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5WDosCN8ptqhgrL1cgVrQgfmxbqRf8M/DBi7ayRhQA=;
        b=cOCxtHLtTm//8YctLUGwNbxo+tZmJPnqhJn9ycA3bbdu5ESAF/P7CdEr8BDWtK0oHa
         ulfICrqlGs+7ajSLM1Yl7hKf/axcGUyMANfcmLL0Adb2nXncc4lrXqrxUeGjORhTrnXR
         IFn0dZrd/+D4o03bNmfZYft3VTKsAyrQpTAvKfjiCDglezeHjoU35BAp37qr/bTaJmqW
         mm8Blc6kUL1smXrR438Djgw0FI+IL6h/qORkh5Zt2n7rJgYlbqBA9TJTdy3OVoiwXziA
         n7UsXOWgtQm/LRSOIG5lXXd2ks9KnF1QbC/x4pOLWdULNTgYOBbM7Zk44WwJ+7xcgd9E
         L+xA==
X-Gm-Message-State: AO0yUKUgVluGj5bYwcuzO1I/+EYSdeBrnBw9h6ugTkZUNCb3OFU2nDC3
        yCQXIO7FeFuzQdDnMwiP9qzvewZQqjznPlU/YkJY7b1KhISqa73iY1PcXIHcm5CElRKMkAbQ5F7
        fmwT9SF8CqLlZA1mWoIP5O9AS9jMn
X-Received: by 2002:a05:6214:b85:b0:537:6dfa:efaf with SMTP id fe5-20020a0562140b8500b005376dfaefafmr33023143qvb.13.1675163708314;
        Tue, 31 Jan 2023 03:15:08 -0800 (PST)
X-Google-Smtp-Source: AK7set9PvPYF6HAkQ+AlinxEAf03bWrkLFOaUAgoOy2qSI7bVMAHunwsC9vjqR1Y96nmCMq2TF5yVg==
X-Received: by 2002:a05:6214:b85:b0:537:6dfa:efaf with SMTP id fe5-20020a0562140b8500b005376dfaefafmr33023117qvb.13.1675163708088;
        Tue, 31 Jan 2023 03:15:08 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id bs32-20020a05620a472000b0071d7ade87afsm4839339qkb.67.2023.01.31.03.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:15:07 -0800 (PST)
Date:   Tue, 31 Jan 2023 06:15:05 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: sc8280xp: Define uart2
Message-ID: <Y9j4ORb4r8+QXx4J@x1>
References: <20230131043816.4525-1-steev@kali.org>
 <20230131043816.4525-4-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131043816.4525-4-steev@kali.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Jan 30, 2023 at 10:38:15PM -0600, Steev Klimaszewski wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Steev Klimaszewski <steev@kali.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>

