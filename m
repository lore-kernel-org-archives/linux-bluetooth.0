Return-Path: <SRS0=2QA5=RH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEA5C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Mar 2019 06:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE53B2082F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Mar 2019 06:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhQ91FO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfCDGK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:10:26 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55099 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfCDGKZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Mar 2019 01:10:25 -0500
Received: by mail-wm1-f50.google.com with SMTP id f3so932607wmj.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Mar 2019 22:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IqMPVY8zf5eTB3U86QouNQZaZRyC3bBKqdGlH7YHfTQ=;
        b=jhQ91FO52XieVxb3JbU4XHB5QXRGSB2yuT41QPbGQJUAOs+29O86aoHjkGJ3/CKRxW
         cV4+F2wuq11N78Xm0nKz+vpz8eppT8L7cfJskNcJcyMwULwoKX0l0hxEWP1EF5GfLmbu
         z0TcUfRxZ9jr0vJXy7z5N1GDCrvCJ6bIY5X5lIeAs+BDCWcf7CPPfLki4GdiCKHh+7QZ
         Zuqnc0RjqqLpGLVJq27fNa6E/BnLrHenAmZSNobBMVNIahvVjiSTovgsV8W4UkklGhSY
         mJ/8Gv944qn7UDVsZ2WqOw3FErKuXOd9uwuj5dcnPs4IlMv/wj3GOtcO7DritWYmxCGG
         GtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IqMPVY8zf5eTB3U86QouNQZaZRyC3bBKqdGlH7YHfTQ=;
        b=Kynwy6JWQOXVlBShgpgjM3rNLgFbKe4IjgPkIuWTri28s8UMxYta5UeFPxgqXMahe3
         He/gc/FM2A6a5pIvpsUnIL4+5RSG53BNajemaunT4n3WiZzV5t0y3/txagnXo6J3zvc6
         ZCTpC/8pVMpaezBsCfMiQmwX+xnlNXs7jzOxjgasp5uhIRUD544bOc6HLe5HeMu6j3C6
         NTPjbnwRTo5it9Gu3eFmPnq5z1Ijrjo02vUkdfLeOHW0xMvO6eCWkf7TXz2YeGqwDQ9y
         VS1kMrEclU6pKnLzUU5ligCBMnieKmQCkl/n8n/kXsRCZpfEE9b8IM2BG0pRPScEHOAc
         TYxQ==
X-Gm-Message-State: AHQUAuaBU8NgRXyUygtcsPcF/7BcStDJTSX4YHmr7BhJgq9VZI6qKYsq
        zim4QH/i+/F2O+EpBEVRpoQsyqHKgx8YwH8/6f67gsSW
X-Google-Smtp-Source: AHgI3IZ6U1zUDRLPRlqLTOnXnehJ33zRR3DX9/dnjDHgrgmCMg1rMvsLba33yD7iR27+pJpKGGai60cS4WCNPgKww2c=
X-Received: by 2002:a7b:c8c8:: with SMTP id f8mr10106008wml.36.1551679823748;
 Sun, 03 Mar 2019 22:10:23 -0800 (PST)
MIME-Version: 1.0
From:   Peter Wagner <wagnerpeter932@gmail.com>
Date:   Mon, 4 Mar 2019 07:10:13 +0100
Message-ID: <CAP4jTnWrEUDtV7jAq8E=U-jzPWTm1egC62QdZmneOvETc1_N5A@mail.gmail.com>
Subject: Is it possible to Switch off the 3Mbit/s EDR mode without disabling
 the 2Mbit/s EDR mode with Bluez?
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

on a embedded device which is using the qca9377 BT chip I like to use
Bluetooth classic with the BR and EDR mode.
For some reason i have to ensure that the 8DPSK modulation type is not used.
For that reason i have to disable the ACL frame types 3-DH1, 3-DH3 and
3-DH5 on my embedded device. The mentioned ACL frame types above are
related to the 3Mbit/s EDR mode.
So my goal is to switch off the 3Mbit's EDR mode without disabling the
2Mbit's EDR mode.
I already tried to switch off this ACL frame types with the deprecated
hciconfig tool of Bluez version 5.50, but without success. (hciconfig
-a hci0 ptype DM1,DM3,DM5,DH1,DH3,DH5,2-DH1,2-DH3,2-DH5)
After a WireShark trace of the pairing process there was still the
"EDR ACL 3 Mbps Mode": flag "true" in the "Read Remote Supported
Features" response .
So is it possible to switch off the 3 Mbit/s EDR mode on the qca9377 BT-Chip?

Best regards,

Peter
