Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301E0C76191
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 12:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023FD2067C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 12:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="Ay6HzyVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfGOMvt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:51:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42549 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbfGOMvt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 08:51:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so16060368lje.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2019 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uW9ZbqyI7Efd9W1Wys1KIdshufsy2OCMex5cqnA5RuY=;
        b=Ay6HzyVpfzl2uq8IUbydWoyTA/dBs7ZpPAYVHVjL3KieLE0NUQe/aoxgMqCNmzURpz
         Z8vcg8frRTh0QOwQ6XXglVTVuLXMJWNRWg2Dm4vF2sxTyuD7MYBtBoy1qeVuKT6sWNiu
         cB7gz38o2BzLB8mMhKk6CumrjJFmncK7dRn84SuPTR7t/7fpZb45Gej72hcrBF06vRCS
         ghsre6ieXAUmOMMxRiNTdVsfVAH6oArzgdo1KeUL0vV3LTmv9rnwluTIsNVRiM0W8oMg
         bsriN2QDoS319eiZF5mexNVvzpCQBIDXcXagVHIJdyeRhK28ioQ798txbaYn0nav7dtX
         Boxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uW9ZbqyI7Efd9W1Wys1KIdshufsy2OCMex5cqnA5RuY=;
        b=sMAAkgYkbDHrcL8tytK83ohYw2xyVdxjuk56MbEoyAiVp+FbokZGheSy4w5bjAo3hP
         rjKi3qUAqtsOn+WSA2qQbAbtHtgtUZSPUSG43Y63iaqzMtfwPhJZomchpQrmq9FxiSmQ
         KdfDmAvsYEICGeQdp6b1fdcrIO55qj3GOKamosgqXfCYLD3oxtSMj+7PfIzUCT03Cvik
         KYtEd3Ji59rtV9JE5FQZns4YCi75h9YHCZ+qPGLNQmst3kJ7ar920HO/mlorjxkD81Zl
         jiRFb7572P/mficwFhEdDfUIhGt1IK+vNowdYvhb8Y+wpqz41SWpeLppi8mb3B9DwvCu
         8DBA==
X-Gm-Message-State: APjAAAU/fEAYQG5ZN+KPVBgAWZzP9X6gLfPtzC9A1N1DsUSsrptUl9pX
        mCi5rDcJSNgx9Pvw9wSo0Y3OJOdyE1U=
X-Google-Smtp-Source: APXvYqxGAB/DRYC05fX3TnDa9JsHHgX3k0dTfGTfLaegPmctp/BMSArVj3JrKmYZjJRZW2mfFEVKXg==
X-Received: by 2002:a2e:980e:: with SMTP id a14mr14145065ljj.60.1563195107143;
        Mon, 15 Jul 2019 05:51:47 -0700 (PDT)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id t1sm3147039lji.52.2019.07.15.05.51.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 05:51:46 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] input/hog: Remove HID device after HoG device disconnects
Date:   Mon, 15 Jul 2019 14:51:44 +0200
Message-ID: <1623552.bYGA88Ch3a@ix>
Organization: CODECOUP
In-Reply-To: <20190614153125.2605-1-hadess@hadess.net>
References: <20190614153125.2605-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Friday, 14 June 2019 17:31:25 CEST Bastien Nocera wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> When the Bluetooth LE device disconnects, make sure to also destroy the
> uHID device so that we don't have a lingering HID device accessible from
> user-space.
> 
> This also fixes the input subsystem never seeing the device reattaching,
> causing settings that should be applied on connection not to be applied.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=202909
> 
> Tested-by: Bastien Nocera <hadess@hadess.net>
> ---
>  profiles/input/hog.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 23c9c1529..83c017dcb 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -199,6 +199,8 @@ static int hog_disconnect(struct btd_service *service)
>  	struct hog_device *dev = btd_service_get_user_data(service);
> 
>  	bt_hog_detach(dev->hog);
> +	bt_hog_unref(dev->hog);
> +	dev->hog = NULL;
> 
>  	btd_service_disconnecting_complete(service, 0);

I've tested this with device I have and introduced delay is acceptable imho.
Since this fix end-user usabiblity for some of the devices on the market I 
think the trade-off is justified.

Patch is now applied.

-- 
pozdrawiam
Szymon Janc


