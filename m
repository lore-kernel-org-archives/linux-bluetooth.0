Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF95CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F95F64EC3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 08:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhBVI2B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 03:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBVI2B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 03:28:01 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2ACC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 00:27:20 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id c17so55623889ljn.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Feb 2021 00:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:organization:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMrufL/HWS/oVc+M/wxD1n1khTqCK3HNRe37HFZrsag=;
        b=OJkvtlizNr0R690RQg0wJy+7Qh0xz5uhOdIZoRB9XyTbl1VDvMqBcLF44cjZVn98tv
         a7NOr1Jq4Vc0aDalc3elHhGoRPYOZH25ooP6rF5ZsfAbWYw3g/jLNxq2a6o8mEsLnSMp
         Ismk6ciRY1D/cK3B527my+zzfMlJhBfivqBJbHr8AJTnP8PHzrz/k2w/Www+pt9zGtJA
         shCXDXz6ra7oHgACraVcgx5R3DBLHli4A+mj9Mi1LvyGab3zEj9O/RcfjRm7K2AjajH4
         BdQ7nU7jiMNDzyfVvmsuaMWCem3zKGEKZV3p7CJPZGCLLwbwACjVqHcOz2d3m25kTsrb
         y+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gMrufL/HWS/oVc+M/wxD1n1khTqCK3HNRe37HFZrsag=;
        b=c0cGj/1BY9JWs4gGrcM0CeUbA6Po24kUHQLFmSgsmPOrB7XXaBzmJ3u9Ke3tKFumR8
         QwTT2zOZ411KE5YC1hzDQZJdSA7R+gQXiwzT2EnVIRQr/M0xJq5XjJz3CfQidHxjQ5J4
         lkhgGxdM4+qAAXrd382wfCUZ39ZttNh1CkjZo53bbwD0PQOfS3JX3ZppPep4E3t4VHhy
         HLpJLi15HggX4Yy6IwktzB9bng2/6G5bJFJLrImrdExNYpZcbjEQmM2Xhno1YicGo+70
         dyAQQvVqLKT6KfzHaNoJiv9dWbeFL0YwbLi1nV06IH/gdcaWE54OWHd3AKwfAxfH8izg
         6I9w==
X-Gm-Message-State: AOAM532rFHfT/E/L/0agE4v4WmgipQeUdSai7ZPtl5HSZ9XGPrCTY354
        gO0RNUAyDxlvC+a6tqlb8uLUKb5DkcYmqQ==
X-Google-Smtp-Source: ABdhPJzQk0qikqv1R8KCmyeS8BgSgqhZIR8U6U4xIpK/pcfe/QnSJ7Sqf5qWmF1T07koqomtX3QZhA==
X-Received: by 2002:a2e:9ec6:: with SMTP id h6mr5555936ljk.12.1613982439137;
        Mon, 22 Feb 2021 00:27:19 -0800 (PST)
Received: from ix.localnet ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id q9sm1836689lfb.253.2021.02.22.00.27.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 00:27:18 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] sixaxis: Fix Bluetooth PS3 clone joypad being named like the original
Date:   Mon, 22 Feb 2021 09:27:16 +0100
Message-ID: <2568708.mvXUDI8C0e@ix>
Organization: CODECOUP
In-Reply-To: <20210218190545.109454-1-szymon.janc@codecoup.pl>
References: <20210218190545.109454-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thursday, 18 February 2021 20:05:45 CET Szymon Janc wrote:
> When cable pairing a PS3 clone device, we should try and keep the USB device
> name to create a new btd_device so that the joypad is named after its USB
> name when connecting through Bluetooth.
> 
> If that isn't done, "Shanwan" clone joypads are named like the genuine
> joypads, and kernel Bluetooth quirks aren't applied.
> 
> gh-issue: https://github.com/bluez/bluez/issues/46
> ---
>  plugins/sixaxis.c        |  5 ++++-
>  profiles/input/server.c  |  2 +-
>  profiles/input/sixaxis.h | 13 ++++++++++++-
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index d693a86c0..517cecc47 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -387,6 +387,7 @@ get_pairing_type_for_device(struct udev_device *udevice,
> uint16_t *bus, char **sysfs_path)
>  {
>  	struct udev_device *hid_parent;
> +	const char *hid_name;
>  	const char *hid_id;
>  	const struct cable_pairing *cp;
>  	uint16_t vid, pid;
> @@ -401,7 +402,9 @@ get_pairing_type_for_device(struct udev_device *udevice,
> uint16_t *bus, if (!hid_id || sscanf(hid_id, "%hx:%hx:%hx", bus, &vid,
> &pid) != 3) return NULL;
> 
> -	cp = get_pairing(vid, pid);
> +	hid_name = udev_device_get_property_value(hid_parent, "HID_NAME");
> +
> +	cp = get_pairing(vid, pid, hid_name);
>  	*sysfs_path = g_strdup(udev_device_get_syspath(udevice));
> 
>  	return cp;
> diff --git a/profiles/input/server.c b/profiles/input/server.c
> index d8b413744..79cf08a66 100644
> --- a/profiles/input/server.c
> +++ b/profiles/input/server.c
> @@ -120,7 +120,7 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const
> bdaddr_t *dst) vid = btd_device_get_vendor(device);
>  	pid = btd_device_get_product(device);
> 
> -	cp = get_pairing(vid, pid);
> +	cp = get_pairing(vid, pid, NULL);
>  	if (cp && (cp->type == CABLE_PAIRING_SIXAXIS ||
>  					cp->type == 
CABLE_PAIRING_DS4))
>  		return true;
> diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
> index a3cda70e4..ab8831995 100644
> --- a/profiles/input/sixaxis.h
> +++ b/profiles/input/sixaxis.h
> @@ -29,7 +29,7 @@ struct cable_pairing {
>  };
> 
>  static inline const struct cable_pairing *
> -get_pairing(uint16_t vid, uint16_t pid)
> +get_pairing(uint16_t vid, uint16_t pid, const char *name)
>  {
>  	static const struct cable_pairing devices[] = {
>  		{
> @@ -40,6 +40,14 @@ get_pairing(uint16_t vid, uint16_t pid)
>  			.version = 0x0000,
>  			.type = CABLE_PAIRING_SIXAXIS,
>  		},
> +		{
> +			.name = "SHANWAN PS3 GamePad",
> +			.source = 0x0002,
> +			.vid = 0x054c,
> +			.pid = 0x0268,
> +			.version = 0x0000,
> +			.type = CABLE_PAIRING_SIXAXIS,
> +		},
>  		{
>  			.name = "Navigation Controller",
>  			.source = 0x0002,
> @@ -73,6 +81,9 @@ get_pairing(uint16_t vid, uint16_t pid)
>  		if (devices[i].pid != pid)
>  			continue;
> 
> +		if (name && strcmp(name, devices[i].name))
> +			continue;
> +
>  		return &devices[i];
>  	}

Applied.

-- 
pozdrawiam
Szymon Janc


