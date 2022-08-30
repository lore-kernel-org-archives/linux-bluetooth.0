Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D21ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 22:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiH3WbJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 18:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiH3Waq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 18:30:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52584ED7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 15:28:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w8so8413672lft.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lrHR5AxqUMygPO4vrKfQ6iTOv+xjndE+OQ+3I2sFYLg=;
        b=bnS+4z5i/kP41rYhR0IxDz93x5VjI78Ksq72U50Xhn6DYskOhtCLaAvVyYfcIsmLeq
         uPZUp/5GowB44i0QuZYcl1w5EbeTkM6codRbAOZOEUGWKB3+ynTc2vFV/RQkBgHD3h14
         U2Mr0zjvefc5kOCO9deJVFRyP90UO7lu/xqyfE9ktHGIB1Lc9u8q20D1STnqOb3sfewY
         vFGBphgACDR7NmrrN7RBSW+kOecers4xVWAoDA+6VrnJyDP02hkwbTs+sheHF0w2qiFM
         LS9h1YOZRHtBgX0xyReFOGFIuk2fn/kwo7hACCTcr7w3xo3HkUabTNnUXpykPz6jVR3C
         vXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lrHR5AxqUMygPO4vrKfQ6iTOv+xjndE+OQ+3I2sFYLg=;
        b=QSLSzj+0WVfPjBWH3DxESpT7gBCStB1s9wSxLAyeF4K0eOmvOH4aG2j+NYf4VokLpW
         ZIs0TSMbcvMLtrQ04LJK7GOwEwUvqnbxFngebeYswvgJXK9d0vQ5ynTqi0XHrhqWDXpq
         LZvlXFE6bXXw6tpnK15eEQXUgddWWyKsw3MJetwDNKfqdvehElgmO1wmFk0n21iJJf8p
         FgJWCaNc03tmOnXSMZGA7PizjgPgj8Rh+zN6+CKMtIXUE7u9mWwXAHK63uuG9dEGrinl
         2E0wW5YEj6R4dKcaQYl6lQaMUZcROffzIRnln/mUK1EkMv+fxDg61JWoBOjzNEOD+ORP
         iOrQ==
X-Gm-Message-State: ACgBeo2zjFMfPy5efUpTdUyD3reK7CtMbjSuoYYDlWRCYTdncdGtddlO
        6ljNevufNHuq6ecUk7RXo30tiy9XPQU0B7+VbrAg0p3H
X-Google-Smtp-Source: AA6agR7SJNo5SYR1ZpXYEewCDLUej61SLMrjusp+nG1iPFXAhcLGI7HDZQRmMgbg4LetknoqW17kyC19qlcTUEjxQEM=
X-Received: by 2002:a05:6512:1ce:b0:494:81fc:e755 with SMTP id
 f14-20020a05651201ce00b0049481fce755mr971744lfp.106.1661898524461; Tue, 30
 Aug 2022 15:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <SJ0PR13MB5755C6DDC8E269258C410586FE709@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <SJ0PR13MB5755709642FB995921E6F68CFE759@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <3dd715a9d8b30ccb6dce4d4e1e034cf8d0458d44.camel@hadess.net>
 <DM8PR13MB5111064C283B3B2F2E8C3681FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
 <DM8PR13MB511149D1CDA49915538C8FC5FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
In-Reply-To: <DM8PR13MB511149D1CDA49915538C8FC5FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 30 Aug 2022 15:28:32 -0700
Message-ID: <CABBYNZJNdQeXwVcnjsukMaPvn9s0zHWN2_i_T8Hidyj0WcGM=Q@mail.gmail.com>
Subject: Re: What could cause pairing to fail when bluetoothctl is not running?
To:     John Klug <John.Klug@multitech.com>
Cc:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi John,

On Tue, Aug 30, 2022 at 3:22 PM John Klug <John.Klug@multitech.com> wrote:
>
> I am now looking at what is going on with a sniffer.  For some reason in 5.10, the AuthReq always comes from the slave (BlueZ is the master, GATT client):
>
> 5.10 kernel which fails, leaving out empty PDU, L2CAP Fragments, etc.  This sequence is reproducible.
>
> Sent slave CONNECT_IND
> Rcvd Security Request: AuthReq: Bonding, SecureConnection
> Sent Pairing Failed: Pairing not Supported
> Sent Pairing Failed: Pairing not Supported
> Rcvd Exchange MTU Response ...
> Sent Pairing Request: AuthReq: No Bonding, SecureConnection | Initiator Key(s): <none> | Responder key(s) IRK
> Sent Control Opcode LL_LENGTH_RSP
> Rcvd Pairing Response: AuthReq: No Bonding, SecureConnection | Initiator Key(s): <none> | Responder key(s)
> Sent Pairing Public Key
> Sent Read By Type Request, Sever Supported Features, Handles: ...
> Recvd Pairing Public Key
> Rcvd Pairing Confirm
> Rcvd Error Response - Attribute Not Found, Handle: 0x0001 (Unknown)
> Sent Pairing Random
> Sent Read by Group Type Request, Gatt ...
> Rcvd Pairing Random
> Send Pairing Failed: Numeric Comparison Failed
>
> The 5.4 kernel always works, but BlueZ/Linux sends the first AuthReq:
>
> Sent Slave CONNECT_IND
> Sent Pairing Request: AuthReq: No Bonding, SecureConnection | Initiator Key(s): <none> | Responder key(s)
> Rcvd Pairing Response: AuthReq: No Bonding, SecureConnection | Initiator Key(s): <none> | Responder key(s)
> Sent Read By Type Request, Sever Supported Features, Handles: ...
> Rcvd Pairing Response: AuthReq: No Bonding, SecureConnection | Initiator Key(s): <none> | Responder
> Sent Read by Group Type Request, Gatt ..
> Rcvd Pairing Confirm
> Rcvd Read by Group Type Response, Attribute ..
> Sent Pairing Random
> Sent Read by Group Type Request, Gatt ..
> Rcvd Pairing Random
> Sent Pairing DHKey Check
>
> Should the program be sending a Pair using the Device API?  Is there something else to cause the public key exchange?  In the 5.4 case, the "Paired" property is always being set by the Device API.

Either way you need a pairing agent in case the device for some reason
removes its link key and then you need to repair, besides the agent
also does authorization when the device is not trusted, have you tried
just running bluetoothctl to see if that makes it work?

-- 
Luiz Augusto von Dentz
