Return-Path: <SRS0=Hm6j=RK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF97CC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 19:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C079820675
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Mar 2019 19:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AKvYIYBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCGTSm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:18:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40474 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfCGTSm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Mar 2019 14:18:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id u9so12018750pgo.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Mar 2019 11:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TV6edWcbYlz3eOY46NTUo2s3D92DBu7jHBspRKtTVuY=;
        b=AKvYIYBHonii6PjzihkI89A/58rguXKVbyCvwlgv38Thf44mGEdVYXDZ4pxI4RI90n
         1SdZTFlhDv2JYfRhpGOqhhwbfHz8WqCaf3mtwy9vk+uv4W55pv8cXAwaz8afXx2mSilU
         9qu3TuvF3P7K4yiUPOdIhs0+k3Rq7pymvbZOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TV6edWcbYlz3eOY46NTUo2s3D92DBu7jHBspRKtTVuY=;
        b=euKXHFWzNewPkvMw/LqTU9dKI2Qm1TgDIIlWA7RWnqkLE5Z+Fvie46SO3MEQ+OFbqW
         XmUxvU/Fp1w8h7+Dr1/kvuE92S1FC/i23BCTCaoj5QwcvQTOCCB9zDxXjY/jr8SPBNoX
         qvcyZX9FslluU7xtBTfnvob3AN03/G56/7njNSMtRiR8YcRjopGYHftcZPmkrVp6BkcX
         hmz4Uxz9ZDZwmETVnUNLMpxKweWQTElmawjPRtWAIlmegqRkOZ6li8GQAooqTLKV33QA
         v5AtoSzrHOy/JmUF4jF9DEnmasG2zRESuwpjfKI9HEVwkvq+C2aftPKN0vqu9BDffnuP
         GG7w==
X-Gm-Message-State: APjAAAXG4oH+bYjhetfPjYLKMVa/cuOo/OBCD3Ox+O7OLGH4nDiQtx55
        m3Z1saqPNQsBXfLgQdiv+x5rWw==
X-Google-Smtp-Source: APXvYqzg7zeAqvorizTK3T0lBY3Ud5Hh4BZSMQv+Gij7w57AefHiOvXXC463y2F5t3/Pa3v+7DdK/g==
X-Received: by 2002:aa7:8b17:: with SMTP id f23mr14499703pfd.171.1551986321882;
        Thu, 07 Mar 2019 11:18:41 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n15sm15676625pfi.173.2019.03.07.11.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 11:18:41 -0800 (PST)
Date:   Thu, 7 Mar 2019 11:18:40 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Harish Bandi <c-hbandi@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Enable Bluetooth functionality for wcn3998.
Message-ID: <20190307191840.GC138592@google.com>
References: <1551961012-23898-1-git-send-email-c-hbandi@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551961012-23898-1-git-send-email-c-hbandi@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+ device tree folks

On Thu, Mar 07, 2019 at 05:46:50PM +0530, Harish Bandi wrote:
> This patch series we add support for wcn3998 BT chip set. This new chipset
> is based from the wcn3990 with minimal power numbers. So here in this patch
> The major difference between wcn3990 and wcn3998 is only power numbers. where
> as init process and fw download is same with wcn3990.So we are leveraging the 
> existing code of wcn3990 along with readiing the voltages from the dts file. 

About how many different variants are we talking?

Couldn't you just use a different compatible string for each variant
and specify the voltage/current limits in the hci_qca.c driver, as
currently done for the WCN3990? I understand that it requires touching
the driver for each new variant, but it might be preferable to specify
these static values in a single location, instead of repeating them in
the DT snippets of every device that uses such a controller, with the
possiblity of configuration errors.

The DT folks can probably provide guidance on what is typically done
in cases like this.

Thanks

Matthias
