Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5D6C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 22:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64FCA20731
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 22:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GuwMFELi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIPWl1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 18:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgIPWl0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 18:41:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5465DC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:41:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j11so173210ejk.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=a+YMNe2j0claVsXWfMbHbK1oBa6IOCR2AWkVXO3KhqY=;
        b=GuwMFELiy0OMXISrfLEPt1g/oULXEINC02f3YHeKOTZhnNq61xo4z47ZvCRGDVXrET
         fnk36DRTGAMSsGH5+lfki8do9zfBa9e9gK2XpGspnE2wIiPofjBg8VnJm52GR8At4lHF
         wHhVVbNgmWclAyusRD0kzv4luH9gUsPu1nYAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=a+YMNe2j0claVsXWfMbHbK1oBa6IOCR2AWkVXO3KhqY=;
        b=n/ElACGnBuciXSAMT48t/sIwRNyiGBwUKj8ErnjSWUtv1qXI5Zm6shztS26YSfDe3V
         70hWtwZLFJEbxD+N5uBvV7AQQkcuaxdtAryCjwzOctRIV0Hk+DOiMdwg+WWO6SjwoXjv
         fUWyCtHuFdc/yxNWW740jngx1V3sz5M5lG7C8z7IrtwrTe8YfajosPGZiIRb8804N9K0
         Vv7HG9GX3U58zKay9JHY3uV6NWpJHtiP6tzxKKmv7kvTCzQS63/D5ziGf2dINfGFud+g
         yTP4Tr0gW2R4Y66J2xU4v9T4D7o6FkUuTJeEBz3Z/C8y/W2iMmvS14CToLNaToF5XANT
         wBvw==
X-Gm-Message-State: AOAM531IJ2ft9NuJ2Px6IcGDIlLadjALLmkYx07i9L2HbO2t0MvaDGHd
        pI9MzbEUF5fVVa6mVSYpHvWfiuaY6iUFHA==
X-Google-Smtp-Source: ABdhPJz0Ks2VsQQUsIZV+/p7Cejp1Yzbb2s+QtO35xuub2tATQT+Oj6vLnZBOtRwAG28MgEGEBk+MQ==
X-Received: by 2002:a17:906:16c8:: with SMTP id t8mr28759651ejd.272.1600296081742;
        Wed, 16 Sep 2020 15:41:21 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id s21sm15067346edw.23.2020.09.16.15.41.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 15:41:21 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id l9so132623wme.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 15:41:20 -0700 (PDT)
X-Received: by 2002:a1c:7f14:: with SMTP id a20mr6996267wmd.95.1600296080441;
 Wed, 16 Sep 2020 15:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200813002819.359374-1-sonnysasaka@chromium.org>
In-Reply-To: <20200813002819.359374-1-sonnysasaka@chromium.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 16 Sep 2020 15:41:09 -0700
X-Gmail-Original-Message-ID: <CAO271mneguPsiJRNjW44oGEHZSuYof0og9+cHxByqoOntjevYw@mail.gmail.com>
Message-ID: <CAO271mneguPsiJRNjW44oGEHZSuYof0og9+cHxByqoOntjevYw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] checkpatch: Ignore SPDX license tag
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear BlueZ maintainers,

I saw recent patches that BlueZ started adding SPDX license tags to
file headers. Is this where the convention is going? If so, please
ignore this patch.

On Wed, Aug 12, 2020 at 5:28 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> BlueZ does not use SPDX license tag on file headers.
>
> ---
>  .checkpatch.conf | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.checkpatch.conf b/.checkpatch.conf
> index 419733832..72c3529c3 100644
> --- a/.checkpatch.conf
> +++ b/.checkpatch.conf
> @@ -12,3 +12,4 @@
>  --ignore PREFER_PACKED
>  --ignore COMMIT_MESSAGE
>  --ignore SSCANF_TO_KSTRTO
> +--ignore SPDX_LICENSE_TAG
> --
> 2.26.2
>
