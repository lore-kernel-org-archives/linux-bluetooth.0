Return-Path: <SRS0=rf5u=4Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F169C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 15:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA40206D7
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Mar 2020 15:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=orcam.com header.i=@orcam.com header.b="ZSTYRyRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCHPnF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:43:05 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:44487 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgCHPnF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Mar 2020 11:43:05 -0400
Received: by mail-il1-f182.google.com with SMTP id j69so6421912ila.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Mar 2020 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orcam.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=thzyibvwtj9tr0d3DBcjt6RE8apW59NkSoFnJvAIh4o=;
        b=ZSTYRyRy8sXTCdZOLUNql0GXkgmPIGrVwr0/GPWov7sXm+RO6cPU21kdBAF86doMIz
         smH/W1nwjLl02oIWX66X+CLlBkXCVp8Olny3rqkSi/TBzJZgsVOMDN1I2AG7fr1kFEMh
         lmiaEpmdLXZihQV8mu5a9FucKz7dBpfpUhttQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=thzyibvwtj9tr0d3DBcjt6RE8apW59NkSoFnJvAIh4o=;
        b=LPZEXRYacEmZpTRQQK6g8RT8PT+082v4eS484VJqYEtI3802Kp/8BDUkAe4W9pV/kJ
         VsUs3iur5zMk7ePs0ErHdriljv0DRTH9eh3lkc5417ZF1lj10Ug4GhNevXRr8WFG7ghi
         pkKwRo0u/+bwXwbMglQJkBn27HIvAQT4/T8c9kkrv0Na83rMVEqVLCVC7srSvl9d3gpk
         kSXZHAn+z9T/N2/7YMDVaSSAzA8gUi15WNRTkRKd2cDmz5kZeH6XG8nPlXR9nWByoFbM
         +0ukXPUiZYC+0UgYEKURheFA9fdGZD+JZHYThUsfHjYluRfSdFRlJsIw15cPLOgIYcVI
         Y8HQ==
X-Gm-Message-State: ANhLgQ39upr4UfjswHfAaW9Jf06olxiRQtvmOeXmn5EhJ6kzec1Tby+0
        X5xu1/M/xUE0lkBRMQYT98yRKoOlT7371xl7rVRbvRkpXbY=
X-Google-Smtp-Source: ADFU+vv3Owa55S4KVp9D99xlI9dkNpSR5er0sgzSaJDIkXHkBMLtTqX7SLvDulEOG3CDQFwDAqMTBLrQPgT+KI8fPPg=
X-Received: by 2002:a92:d9c4:: with SMTP id n4mr11379489ilq.124.1583682184390;
 Sun, 08 Mar 2020 08:43:04 -0700 (PDT)
MIME-Version: 1.0
From:   Ordit Gross <ordit.gross@orcam.com>
Date:   Sun, 8 Mar 2020 17:42:53 +0200
Message-ID: <CAB+bgRanN9W4oH00rATmgarRnk4NXPXOdT2K+ZYDLMM1pYmtuQ@mail.gmail.com>
Subject: avoid cross-transport key derivation
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hi all,

our application connects both to mobile (ble) and speakers (br/edr)
using bluez stack.
our controller is configured as follows:
current settings: powered connectable bondable ssp br/edr le secure-conn

ever since IOS started supporting CTKD (cross-transport key
derivation) at IOS13, pairing to mobile causes also link key
distribution and brief br/edr connection follows the ble connection.
I would like to avoid the link key distribution at the pairing stage.
the only way I was able to achieve that is by disabling either
secure-conn or ssp which is undesirable as disabling either of them
block other functionality.
what is the recommended approach?

** when br/edr is turned off we do not experience disconnections from
mobile app running with IOS13. and vis versa.
looking on HCI dump from mobile side the disconnections is initiated
from mobile side, however the application is not the one initiating
the disconnections.
any advice is greatly appreciated
Ordit
