Return-Path: <SRS0=pLxO=6S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D0C47257
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E282073B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 May 2020 15:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1jj7SU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgEDPeC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 May 2020 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728641AbgEDPeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 May 2020 11:34:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE39DC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2020 08:34:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b20so9856029lff.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2020 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZLwGXO4YrFbu1XfPmcDo9I6U2sUktrJqjNs+SD1g2c=;
        b=j1jj7SU2btqpVZu7uW9plUfzvDRihXsd5nffKl1u4wpklez6Y/x/7K4M/kWWKBw7H5
         W3Gv8vAt3j2bRgy6gpE0hjAvoSDsYECdx0vSTTntTpPDNpUaqDSeDziIoxyS9ka1ca/V
         UqHgv5q3ZAxivl/dCjtxkEhaWd9cTqmhEJ49oXR5BOvCNlDiYQq1LBjUwWt3qgEjRD7A
         qaA1narIeFJCWXNyiLw7jhN5rWJZ0QCLC2Ewu7C5hxuAXCLc1uchYRmWylcVowG8hnsg
         iuMT+69E6Hiriy8zcg/OJT90DXbJ4b5Z1RiZ94LucvrVY/ynYqiNa3eq+V4ENyS11jNB
         JAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZLwGXO4YrFbu1XfPmcDo9I6U2sUktrJqjNs+SD1g2c=;
        b=fPNDzu554uirCBxjBQQmN4OA0FKZVMMDn2NSr9CGUYvz5hkdUWKnP7XRhciWAIDkgX
         mA5RnhjRl9Pm90IoEHuJ3wzUpgWbvt1Sl1w9Su7WJFNeYrfjq1PKy0h/25a10qU9+npn
         oLViA2alngNYzHocy+sOvLvMhKMgjZUkxEJCDa/rSgguyGfQpHVJW6kMyqjCjjppJhLc
         b/I526bEVxBl3rI5rnKTC6H2eDSG8rzNMs66FPQ2lRPGdEfW9Jethy/xQMRRetrotn0x
         PMCkp4CFPqkjTUH+k0SZ7ko85dy8L+z0p5UKfVdm41sZMju0hdfUzXkjZXrgRYj/jBnC
         AUuw==
X-Gm-Message-State: AGi0PuYuDVvu8IeTnufFWaoDPkJn3R6bOk3AZJlZLFZBYWF0nm4INIc+
        55XLJJY/WtSr0vHdZevTWmleMUmr7RvUPKO+RQGrbg==
X-Google-Smtp-Source: APiQypLTYS0zk9EDndF/TORoj3I3lAYRv3mD5rkYqnlcXpNco+b+o0TwLKUiEpxpPlCmr/rcGrsxEFyfxHvLA9bzY/w=
X-Received: by 2002:ac2:4892:: with SMTP id x18mr12470693lfc.142.1588606440011;
 Mon, 04 May 2020 08:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200504153134.226879-1-alainm@chromium.org>
In-Reply-To: <20200504153134.226879-1-alainm@chromium.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 4 May 2020 11:33:48 -0400
Message-ID: <CALWDO_XQAkU0yC3RnUiWygW5M1+iCpZVkD86P2Y6up3AscMmNA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1] Fixing opcode definition order
To:     Alain Michaud <alainm@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Please ignore, will send a v2 shortly.

On Mon, May 4, 2020 at 11:31 AM Alain Michaud <alainm@chromium.org> wrote:
>
> Fixing what looks like a bad merge in the opcode order.
>
> ---
>
>  lib/mgmt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/mgmt.h b/lib/mgmt.h
> index e46e08ba8..c81286460 100644
> --- a/lib/mgmt.h
> +++ b/lib/mgmt.h
> @@ -586,6 +586,8 @@ struct mgmt_cp_set_phy_confguration {
>
>  #define MGMT_OP_SET_BLOCKED_KEYS       0x0046
>
> +#define MGMT_OP_SET_WIDEBAND_SPEECH    0x0047
> +
>  #define MGMT_OP_READ_SECURITY_INFO     0x0048
>  struct mgmt_rp_read_security_info {
>         uint16_t sec_len;
> @@ -606,8 +608,6 @@ struct mgmt_cp_set_blocked_keys {
>         struct mgmt_blocked_key_info keys[0];
>  } __packed;
>
> -#define MGMT_OP_SET_WIDEBAND_SPEECH    0x0047
> -
>  #define MGMT_EV_CMD_COMPLETE           0x0001
>  struct mgmt_ev_cmd_complete {
>         uint16_t opcode;
> --
> 2.26.2.526.g744177e7f7-goog
>
