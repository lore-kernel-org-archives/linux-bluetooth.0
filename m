Return-Path: <SRS0=BBV2=6L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E787C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC9F20728
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Apr 2020 16:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIZac+Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgD0QpE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0QpE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Apr 2020 12:45:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B3C03C1A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:45:03 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e20so27307475otk.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2020 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9DyM8UfugjZad1HwaxWSXRJUfjmOnHjEV8g3tGv2+2M=;
        b=hIZac+BfM3AcB/HTEiVz9qdJ6WB7qgON/ZqYKfoxVIXrl18NIyhiVOmlnL3LROI2HL
         +WylYc2ORZTBkoZ3xpRXl26nJHW0RQ5UGiNuUh9YjRaJHAavep8P8IiSek+TZK7Yct8M
         gz7PNiHH92cV5meKE6koL7hmzXeBt9yaS7e2mWFMPBw93oOWo/tGeM1i/CCjxUXMBvqV
         nOXTidjjvVOSSuhqiptTvJruQXCqZKZU+SxL8WGU/jyfQemoCrN5uS7j10CetvqHO/xs
         LFoFe4ka2Yv7+AT1Ton1L0erFRBO3qv/6lrwtiiiMVL6TxLYxKtbZKvPfkzpsEuhRau2
         ZokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9DyM8UfugjZad1HwaxWSXRJUfjmOnHjEV8g3tGv2+2M=;
        b=cEKkDeuwkrFcU/R9Qa6lmg2AHO0s77XqdYeD1xmFeZ7s2Szb4ZhiVy0jTlg604AD42
         KvgHYtQ5pPQvWjU8rofEoJR/GmDBlHCsS0HtzSmJ+QjwiaLobeZOlD7d1mbePyJO+GpL
         5HKWNEIjXPEWltgEHXp1MvOyzqVNr5uMJ59LDTbPLU0Y4b2QmCe2rUTNmeFJLkquDopd
         uast7LgcyX7dGWmOTtpTukm6Lr/fYwJwvWvwKBs8EaCJ6Nu7p7vIB7JW2hUGS/qqW3na
         hblIOVu0jix8bz31ZybS6jMoHIeEhp0rEWnkrhxLkNC5jFl2ixvBggxLPJCvyPK+E93C
         kd6g==
X-Gm-Message-State: AGi0PuZXILSTdfQZZ1HIGNbVymch2gRVU3heTRuNyxZ+AW75HazS9aib
        8+asFpzxoTnk6G3RQAdcNNB85VhkwTGU9aQz4zDPlJDT
X-Google-Smtp-Source: APiQypIo+NsPkEnxdPykcm90wIy9Tqzlh5b1Phem8Hh2hKSpvXAEF/WfaB8GUXvvnm2FH/yY91s/DqExwC4CPryxXm4=
X-Received: by 2002:aca:acd0:: with SMTP id v199mr15904364oie.82.1588005902396;
 Mon, 27 Apr 2020 09:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200426210247.757-1-pali@kernel.org>
In-Reply-To: <20200426210247.757-1-pali@kernel.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Apr 2020 09:44:50 -0700
Message-ID: <CABBYNZ+whHfHr27X8RgBpYv1980itzwTQmO03oR=DJDbgx78tQ@mail.gmail.com>
Subject: Re: [PATCH] device: Return error when ConnectProfile DBus method
 fails (second fix)
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Sun, Apr 26, 2020 at 2:05 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> This is fixup of commit 3aa815a31017e8793b030b04ef704ce85455b9aa. There i=
s
> another place which needs to distinguish between Connect and ConnectProfi=
le
> DBus method.
> ---
>  src/device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index 229579378..7b0eb256e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1861,7 +1861,9 @@ static DBusMessage *connect_profiles(struct btd_dev=
ice *dev, uint8_t bdaddr_type
>         dev->pending =3D create_pending_list(dev, uuid);
>         if (!dev->pending) {
>                 if (dev->svc_refreshed) {
> -                       if (find_service_with_state(dev->services,
> +                       if (dbus_message_is_method_call(msg, DEVICE_INTER=
FACE,
> +                                                       "Connect") &&
> +                               find_service_with_state(dev->services,
>                                                 BTD_SERVICE_STATE_CONNECT=
ED))

Perhaps it would be better to have a helper function that checks this for u=
s.

>                                 return dbus_message_new_method_return(msg=
);
>                         else
> --
> 2.20.1
>


--=20
Luiz Augusto von Dentz
