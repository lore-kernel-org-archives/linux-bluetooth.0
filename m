Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BF4C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Nov 2022 21:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiKQV5r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 16:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbiKQV5d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 16:57:33 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2997993B
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 13:56:51 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id t10so4566012ljj.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 13:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9u5lD63lU5T0aCmu75vgamGZja15WrL8aVLwmrpGkL8=;
        b=N8Y0eTzGzRqfRExNYGU4ilC8RW/vxNNblPAGYShTWFPLRmmTn1SslHPsuKCMFG9Qho
         YDcqz85MMl+TaXdU2VGwMX1B9uQ8gOnmyuNFbJ/+ZIpk9/KY1VhiZOqst4YWsaBGpCOt
         EzPzSOvoGz/SXQ3Fy2f5M0nHPDbVqrNRXUCEZq3ifgQBCgFgqsdFGiuWwiCJyAYna67U
         8DeWAKMzCoAQGspgNsX2PsLe6/f58dtJT4Stvc8v3zIEqsq/WM31pN6eQzwLeuSdQI8L
         sL/HqldziJmuAYiAyq8DzWW71ixZt3dQnD8JxyudyBZK9zyaugjTHVvYS+QITtNrVO+M
         wb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9u5lD63lU5T0aCmu75vgamGZja15WrL8aVLwmrpGkL8=;
        b=Jw8zYQh1lzuaY0VUNmrQ/V865xy/Y85kMmGpCphm7YrHI9f2km51H3ZiX/PiyYmdve
         OOx5ObqHcc6rcI48N95e/xR7GpHqFKEOiB3mFxaMRqidKzYG2udqPo61PcYdSH71zE5m
         5foSHLV2pT3ccHW1myktT04hQ1iAPke7MfPnhsTJ2+9bSdAiC6gGSOz9wTsZdqSKjtey
         hwSol8CJEPWu/PMHGyW9j47pKMeMHpR7Il8mRG4wU3tmzavrx5gRmv5WahOtgX1HgNOF
         /aAeySqNVnZi8CAk7ItiIo3JQ9hlbxKI5w/ezDPhdLPhKSAClbM6UhAgXgPCWntAGnIY
         4v9w==
X-Gm-Message-State: ANoB5pmGsAZzoCFF1HOPUltRjeTV4EiMps47KG/nMaDWbObWk4CJPbH9
        GvPNtfGni72ZM3apKOWD44H0eFsSEojYGwHWQu+DfukG
X-Google-Smtp-Source: AA0mqf4sPTUYM5ztgbYd56ClIk7Cc+nE5iB5rMGtBImij5T+o63GcnRDnT/qSppZCV5Uzn1U1F/roLhYN1Tu8JNwt/8=
X-Received: by 2002:a05:651c:2221:b0:26f:bb12:2af5 with SMTP id
 y33-20020a05651c222100b0026fbb122af5mr1792013ljq.293.1668722209221; Thu, 17
 Nov 2022 13:56:49 -0800 (PST)
MIME-Version: 1.0
References: <92dfa5c7-90db-8100-b481-2bd4972a0ec1@voxel.at>
In-Reply-To: <92dfa5c7-90db-8100-b481-2bd4972a0ec1@voxel.at>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Nov 2022 13:56:37 -0800
Message-ID: <CABBYNZKF=XUuq1_G_h-ZA8DMTtZiV4VQr-9_jUDjw2Da5sZ9gA@mail.gmail.com>
Subject: Re: Connecting to a BR/EDR+BLE device a via dbus?
To:     Simon Vogl <simon@voxel.at>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Thu, Nov 17, 2022 at 8:20 AM Simon Vogl <simon@voxel.at> wrote:
>
> Dear all,
>
> we are communicating with a headset-ish device that offers classic
> bluetooth services and BLE characteristics in parallel.
>
> We have code to talk to the Bluetooth classic part via bluetoothd/dbus,
> and we have code for talking to the BLE parts based on the C-library /
> gatt-client code ; both run in parallel for some time but not
> super-stable, so I'd like to move the code over to a dbus version.
>
> As the device starts advertising BLE characteristics only after a
> classic connection has been established, it appears as a Bluetooth
> classic device on the system bus, and I did not find a way to start GATT
> discovery via the 'official' dbus-API.
>
> I don't fear to tweak bluetoothd nor ~ctl, but would like to know if
> someone already some development going in that direction?

Perhaps what is needed is to connect ATT over BREDR that way you don't
need 2 bearers to be connected, bt_att already supports connecting
over classic but we never took the step to connect ATT once we figured
it supported the ATT PSM given is not very common to have a classic
profile that uses GATT attributes.

> Simon
>
> --
>
> VoXel Interaction Design  |www.voxel.at
> DI Dr.techn. Simon Vogl   |simon@voxel.at
> Tomaschekweg 46           |  +43 650 2323 555
> A-4040 Linz - Austria     |
> Office address: Industriezeile 35, 4020 Linz (2nd floor)
>


-- 
Luiz Augusto von Dentz
