Return-Path: <SRS0=CLw3=RR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F6C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 11:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6C620693
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Mar 2019 11:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWKX3nNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfCNLyK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:54:10 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46513 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfCNLyK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Mar 2019 07:54:10 -0400
Received: by mail-oi1-f170.google.com with SMTP id j10so4118338oij.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2019 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SDntLG1E5KJS8pQ/hzm+fPTnPJ5piK01IQGLfjrR4+Y=;
        b=DWKX3nNcI41KamK6rroPIln0RoJoZKQcJublN56bcGSh3XxQ2rJoLbcyv600fmOjH+
         1rO8tO+A42AUtV7CHCvPg0M3WUdN/xWqwr+fPzo/tGOptw1glc9zkDKomryPBJunILaa
         +b7TZLGra6mQDKjFUL6Ah2DZDl0djU67NPXQVZUNIi6XlVEFOcsG2FFMk7ecbQniJw9b
         GsrRdUOBGwkBYMpbK48VQGyHXF3Bp2kroBoDgPRnoKraCuOaw/ygZKZjVM/ba02LvuVw
         hyDx2jo1Ym1plgYTJefo8aDDOBL+0q6yFRYOB6B5d1tAYS7N79FToKjlegSSKzQ35aOY
         YW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SDntLG1E5KJS8pQ/hzm+fPTnPJ5piK01IQGLfjrR4+Y=;
        b=CrGcson3JC0LKfUW95HH9xIf0siEIrrf9P1fayltzjHKip+a5dmHeG1T0ILgq/8YdY
         VVP6AJdtJwnoaipf25F05umYIFDsG+pHXKgNi4StDZub/yDwFV2BTN5GwCF/1BYUUtkZ
         J6DJYNmeCOKZbn67aDg8iCIX8laPIVzaT+R6hRMj+sf3A99Z7ELiZe2CeB/uDnTHSGsC
         IsbgVj6o+ZH1/NYay+RWGbrWShc8H8W9qHOkCsHKRQ1zT9iqd0ETFYGdQy9fOz8tFuVG
         5u5kFNbzRwlOqKDdOM6tLavk/GX3ExwtSJhtQamQWBjCtT0CH6MUIxjVF7BEhicF1pzc
         3d5g==
X-Gm-Message-State: APjAAAVFPPe4JQKj/adM+yufj241S/UTJUsBBU8e44FBfFlV894VnrTA
        r7QsjFxiVRKfE2zsQ0urDLacbSkcAfTmR2ynWkwrpVCAH0A=
X-Google-Smtp-Source: APXvYqw5wynQwirmuzzNs837RwcZv8VtUwudFzWJOY3PLd15Fp3a07zIFmV+ypNBc0pW3ESHXcQQ44XVdUQIR0QIgYs=
X-Received: by 2002:aca:dec4:: with SMTP id v187mr1857128oig.92.1552564449473;
 Thu, 14 Mar 2019 04:54:09 -0700 (PDT)
MIME-Version: 1.0
From:   Miguel Sancho <miguel.a.sancho@gmail.com>
Date:   Thu, 14 Mar 2019 12:53:58 +0100
Message-ID: <CAGuyqoHmCT7N3JCEr5otjXOvQN-FQhxYjVAb7zT+_Lcc3oTGxg@mail.gmail.com>
Subject: BlueZ 5.50: Delay in LE Read Remote Used Features response
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
using bluetoothd 5.50 to connect to a paired remote control,
I see a 4s delay in receiving the response to the LE Read Remote Used
Features request.

LE Create Connection
LE Connection Complete
LE Read Remote Used Features
..
4s
..
LE Read Remote Used Features Complete

Is there any configuration or work-around in bluetoothd to try to
overcome this issue? f.e a config to avoid sending the
ReadRemoteUsedFeatures, or a timer setting that can fix the scenario.

Thanks in advance
