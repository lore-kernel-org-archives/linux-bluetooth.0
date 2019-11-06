Return-Path: <SRS0=igZI=Y6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000F5C5DF62
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 06:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0832075C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 06:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp92QgAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfKFGfx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Nov 2019 01:35:53 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:39985 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfKFGfx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Nov 2019 01:35:53 -0500
Received: by mail-io1-f42.google.com with SMTP id p6so25745244iod.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Nov 2019 22:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=inGpfi3QnNPzVhnXRMKpIhHeIyukU0VzmErNS/kFmto=;
        b=Dp92QgAyS6lQPRaoZ3XnItzPXoLtLy/o3m+G6CZL6lyWrIN+Uw+5TKTjcNsD4VQVG6
         TadD00PIvGWmL5IRG0dES7APO2oT+L8ZXdDc4ExbibSspYtwMQ5H2Spa9l4wQsRcwSLJ
         1nybQeD+97OtHqfddpHI0Szc6vz+8RqqGqKIhHJGZv2DcDh0cYmYA+NGIAaWYyHg7gVF
         mzZpFsxAAM00FyhbrYobuz9qO8C3yFuso/yz2J7qXP6QWQNqACdsVeeLj1G+efuYIwdl
         8ezpHS5wD6xWMqotWMvVBZjVsyLpS/iSszisumgMH1gK2KP8pV+KgyxjbO4waIzq4c9a
         TE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=inGpfi3QnNPzVhnXRMKpIhHeIyukU0VzmErNS/kFmto=;
        b=Be5oLk4g1MH+A9uYVc3Ls6ZGqKHjnAsWrerPdtbaT0mIk7/tGOblPGIc3a0ASzJGWb
         PeLXgJEeIoMJq2G3Agsda3Yv/fUmsTrClJjNxrej6z3iempDwdWHNBtf4iMM/aZ6Nu4y
         uAS52NO3f+MvACpL+LJCUytcLqZkaaQ0fhQoU0MumP28quC9W28l7RRDZCygvHMv+Lg/
         lhICaU/59oLw1/6NTI9btXOzpOxWAMwScn858d89+RdfNaSVKFvdqJRWwkBNHahdGNQw
         A70EWKNU7te0x1341xYSPCnT9bRSXAV9p7ScHwuVfovq6+rrmpU7X7tQgm678XvDzR7B
         PChQ==
X-Gm-Message-State: APjAAAU0ES4JUdtzYasHpOK/wxkqntPP+TDCmbz7plqAaIVfsFGfNqPl
        3ExNiPPfRomM03/ZTtBa4EDfIUrdXsDtTMON+Sxt/Jf3Y0c=
X-Google-Smtp-Source: APXvYqweh5LSHAtfxcl8MySmS+fhU+pBVU1Yh2G0uirIfYQp9AXHEdHwpzAxBysz6RzcCY3Gd9HX9u5PaKEV9hV7g6M=
X-Received: by 2002:a05:6638:345:: with SMTP id x5mr17774382jap.137.1573022151952;
 Tue, 05 Nov 2019 22:35:51 -0800 (PST)
MIME-Version: 1.0
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 6 Nov 2019 12:05:40 +0530
Message-ID: <CAOVXEJJ=dMe=f8R23JmC_idSV=gy1mmH4NSQTZUpmQPedjgBxw@mail.gmail.com>
Subject: Bluez Compilation error for l_dbus_object_manager_enable arguments
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I am getting the below error for compiling the latest bluez

tools/mesh-cfgclient.c:1690:7: error: too many arguments to function
=E2=80=98l_dbus_object_manager_enable=E2=80=99
 1690 |  if (!l_dbus_object_manager_enable(dbus, "/"))


Regards,
Sathish N
