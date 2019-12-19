Return-Path: <SRS0=Qms+=2J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7657EC43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 22:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46905227BF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 22:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8/VJTqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLSWMt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:12:49 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36498 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSWMt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Dec 2019 17:12:49 -0500
Received: by mail-ot1-f50.google.com with SMTP id w1so9104128otg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Dec 2019 14:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYlBA8c06y1TAyvR/8bqnGyH1KBkLIKGqbAByEVlB7w=;
        b=q8/VJTqXDh7splLFpxnzQd5nzETiLmYcKVMcPzImi3Xzz8/9gCd0usFCi9l1fugIx8
         F5w77G1sNOKA2QAI/98YEKQ7sxbtXCba1kqpU0UYekTJSgerjyEPBOxyWu4BBYQR2WOA
         wnygP25zRg4dRIcMynRoG30AeZ6OHhpJGSDO3MYTZ6DJuG323AVrDQaoDNN+Uw3eYUv8
         w/Dbhdl6YJ0W7SA5uVB52Y6zT1/Yru2I6QPnrCL6F/8LgPH1cYbAl1Xrvfm+hagTtQZe
         DtS+BmpeAYsSTzYyaCzv7c3jSRvdIM8iRu9pihvDUfmKKHDaAv0EpBmeRV/WpXItyS7m
         N1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYlBA8c06y1TAyvR/8bqnGyH1KBkLIKGqbAByEVlB7w=;
        b=Ng7v6Fetz+Sq+KarsVhuqwbqZIE0J6y9skLS2DkOpR+6E73SO20L4cp8LPKcOGcKah
         YZsHj0flMSrUendudetymMUKAeTYBmcgkEqrQzg/2V0L/LKMF2gF9cCiPS4PPd3XyMrk
         F6nYLN4Rk4WxrYVjmMto7hcziaLJ1kjmC9iWBNvmtje9fVoLCvYqbde3RbzLx9lStLjZ
         hHH/Df+qqIuUFIXZyNNT14JXjlk9QgXVF39wYjDrcnU+JoT0MdbohK0uWePEPLDsWuvA
         N0SD30nbyNzubWhOJTdlT7dI2YbO/ckqEbhg9bQxSf2DFHbvmTnEL6GFyTa/IrG1UfI7
         DSxw==
X-Gm-Message-State: APjAAAVh4u0eOIGobovnId5BjB6/tLeKQNT3m7CF1AlwV98VXZsIsljv
        9k1mjUonz1O/J4KM3F/wIZgUMeoli7R1jJ0AJ2pZbdmn
X-Google-Smtp-Source: APXvYqzGKfRELMfyGm981wJoCVWHlMJPeDZKFhv1rgQjvpkv78JDg5lJGvpTK2tULi3/AluSm+P+EfU23+XQU3g0sEo=
X-Received: by 2002:a05:6830:605:: with SMTP id w5mr7413005oti.79.1576793568584;
 Thu, 19 Dec 2019 14:12:48 -0800 (PST)
MIME-Version: 1.0
References: <a3757dc933d70f4f23b85d8a152d21dd54f6d2ff.camel@peiker-cee.de>
In-Reply-To: <a3757dc933d70f4f23b85d8a152d21dd54f6d2ff.camel@peiker-cee.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 19 Dec 2019 14:12:36 -0800
Message-ID: <CABBYNZ+xSJn9ba1w8h_hk+RoHPCb-TWDM7syTpKVUt34Rja3Pw@mail.gmail.com>
Subject: Re: GATT server does not handle "Invalid Offset" and "Invalid
 Attribute Value Length" errors properly
To:     Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Konstantin,

On Thu, Dec 19, 2019 at 12:36 AM Konstantin Forostyan
<konstantin.forostyan@peiker-cee.de> wrote:
>
> Hi,
>
> According to Bluetooth specs (BLUETOOTH CORE SPECIFICATION Version 5.1
> | Vol 3, Part F 3.4.6.1 Prepare Write Request):
>
> "... The Attribute Value validation is done when an Execute Write
> Request is received. Hence, any Invalid Offset or Invalid Attribute
> Value Length errors are generated when an Execute Write Request is
> received. ..."
>
> In contrary to the specs, 'bluetoothd' is sending error response during
> prepare write. The following patch changes this behaviour:
>
>
> --- a/src/shared/gatt-server.c  2018-06-01 10:37:36.000000000 +0200
> +++ b/src/shared/gatt-server.c  2019-12-13 12:25:22.000000000 +0100
> @@ -1223,7 +1223,17 @@
>
>         handle = get_le16(pwcd->pdu);
>
> -       if (err) {
> +       if ((0 != err) && (BT_ATT_ERROR_INVALID_OFFSET != err)
> +               && (BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN != err)) {
>                 bt_att_send_error_rsp(pwcd->server->att,
>                                         BT_ATT_OP_PREP_WRITE_REQ,
> handle, err);
>                 free(pwcd->pdu);

Yep, I remember this one actually since we did fix something similar
in Zephyr we would need to move the error checking to execute, btw is
this with bluetoothd or gatt-server tool, the later is probably not
recommended for qualification as it is more of a validation tool it
may not be feature complete.


-- 
Luiz Augusto von Dentz
