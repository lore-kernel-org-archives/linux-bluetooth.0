Return-Path: <SRS0=vuCz=AH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9B7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 16:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D97206BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 16:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF4UZcvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgFZQ6s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgFZQ6s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jun 2020 12:58:48 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE2BC03E979
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 09:58:47 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 18so9238808otv.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vua2T+KlaIr3fUeN0vSsbqUspAA4gYaW74cx0pZWJkY=;
        b=iF4UZcvY5OWmajzYS69B7wXThIBgFk2h248P6FgksG4eQ9CD0DZgylf+E/gZ1dPbmc
         vK/s5K6FzqKhUNYwBxsqi1RhXr9s7dE+QXH7VL6bWPFdqozyL7fpnlO8xcP54jZzUt8W
         GLIAJT4U1uFEGIj44FDtC6QRgsXAibJEHIdq6S7DgfcJxRikihn7WR57U/Oh1NwsgaO5
         fmDYqzfH1L6bopZezSmcQ3NhxF3w6kvBSxTpNdV2HoPdqFYSvyrSunT1BAHcbcBCiCZI
         +CPSYSgFU0q309ZkPNAr3PW02thNxr2GGyJxV+7Oo1pIvgqEEyAjdeeqAntmdiOydlez
         sAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vua2T+KlaIr3fUeN0vSsbqUspAA4gYaW74cx0pZWJkY=;
        b=YlwK8Epks+0N1y7MLC339T7+aMzsd0/RcomaNC6Iy8vXPSgwnPxez66D5VUc6wtycJ
         5gc7JEX839OgY1eDEuThsW4R080lcWz7Wn621RxzeAR4///GZVWUJqntQuczDA4OEovR
         wYkKyzfJnhm2O/sFSWLe3xmDQNwUlw0f1oJF9tKb5Djm/cTArl0ZXJHJMuq/RZsbDO9Y
         g0lUrdAvibLOww3BkfcLRvKPkU1AwNisFBWXnjh1OrpWV+EQwxAylqsCxCzGejteNn8o
         gDI0lZrFxCZYFf+rzJUJXYTi7+7Q6hBxpQ87qCrfUvdzzTQ2G5R4PfYDJkKS70B383AA
         A4RQ==
X-Gm-Message-State: AOAM530QZhtSDNqrIbOIWGN3fT1xiX50cGhloPXO5E/4rqTtXcB6cB4+
        I8+J5L8LDwlVGoecFLvVXwJ9wSI0/FiJcFADniLgZxvP
X-Google-Smtp-Source: ABdhPJww3D5bs2wzksvY7nlVENqQF5wU9N3SiXxCq7RkAARwDlMM6VoksOyxezyVe3wDSiOQ418HxVx8IY/Ydrwt0zQ=
X-Received: by 2002:a4a:948d:: with SMTP id k13mr3290840ooi.9.1593190727156;
 Fri, 26 Jun 2020 09:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <37bbc9912da0efcf5e7afd252eba90309f53c79a.camel@linux.intel.com>
In-Reply-To: <37bbc9912da0efcf5e7afd252eba90309f53c79a.camel@linux.intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 26 Jun 2020 09:58:35 -0700
Message-ID: <CABBYNZJ34-f3_2vZStRaghc8jn9YPPc+Av93bBOuU1Jek7Fprg@mail.gmail.com>
Subject: Re: [BlueZ PATCH V2] btp: Update connect event structure
To:     Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Cc:     Linux Bluetooth Mailing List <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Thu, Jun 25, 2020 at 5:10 PM Tedd Ho-Jeong An
<tedd.an@linux.intel.com> wrote:
>
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
>
> This patch updates the connect event struct to align withe the btp spec.
>
>  Opcode 0x82 - Device Connected event
>     Controller Index:   <controller id>
>     Event parameters:   Address_Type (1 octet)
>                         Address (6 octets)
>                         Connection Interval (2 octets)
>                         Connection Latency (2 octets)
>                         Supervision Timeout (2 octets)
> ---
>  src/shared/btp.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/shared/btp.h b/src/shared/btp.h
> index f0ac3a1ee..cc71a71df 100644
> --- a/src/shared/btp.h
> +++ b/src/shared/btp.h
> @@ -259,6 +259,9 @@ struct btp_device_found_ev {
>  struct btp_gap_device_connected_ev {
>         uint8_t address_type;
>         bdaddr_t address;
> +       uint16_t connection_interval;
> +       uint16_t connection_latency;
> +       uint16_t supervision_timeout;
>  } __packed;

This appears to be an API break, or we don't for BTP to be stable?

>  #define BTP_EV_GAP_DEVICE_DISCONNECTED         0x83
> --
> 2.17.1
>
>


-- 
Luiz Augusto von Dentz
