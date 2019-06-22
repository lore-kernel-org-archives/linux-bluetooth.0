Return-Path: <SRS0=TRpe=UV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BE6C43613
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 18:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43C220656
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jun 2019 18:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtjrUkOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfFVSrs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jun 2019 14:47:48 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:45533 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFVSrs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jun 2019 14:47:48 -0400
Received: by mail-pg1-f170.google.com with SMTP id z19so1965283pgl.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Jun 2019 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jdRbN6+rzSGAQAeY9ArrsNO1qXRMFkvtD0km4DRfOlA=;
        b=PtjrUkOsBb/EAtCOpTrCKwQ6FJ+47JZeS8ca1di0U+/JlLWPAVPXG7JiyYGd7HDBvS
         cvcoOCczm0Yna2MtR/ygCxu13nNbfsxpfX1Tq0f3oxXau7CNQpZX6IgRx8qAFlgf/X81
         0YO/dZE75m5qf159/IePeAeQyJNJTIySQKtlUhkatsXSzQp1iJ8xgwmpLyX5OGxKuUp7
         pDfWLN0OfmXGI8WI8l7NM1NdAjYBWiXv7cNBBDjDQueO6tdQTUHdqWQf7NZTjNJmwvg4
         zk/UayAGQyuiwgcjSXjF8Hyj7ocbAiPsPLwnpqKUmAIrSCV68E0K7m8X2ZWm+6je1wr6
         Hu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jdRbN6+rzSGAQAeY9ArrsNO1qXRMFkvtD0km4DRfOlA=;
        b=UYDTtHUy8BJ1FC35oJ3h8SNAd2HAoTu7dZ2Gw8JcwU/cQKV5/1NRbh9oc3TWt4oKRL
         0bgurVViFiItK8KZTnY7FmOO3m+nAH8SzrNQ48/3Arj/qSQ8/cT7jaUcj2k/G4J8HptP
         6isfSCFbkVzPRlfB/aSw01b8g0S2Y78no8zO5/G7ivM9FNu3Yt6sM+hgiWgFBRXgYf9K
         7AJPjjKvSKJSmKDrCNQcb/+KYd7IpVsktTm4ymCn8zokkJ/p2fqAQdOQJmjmiItJs8yN
         okf8J3hqO7JXeI0f5gN3Z50Roclo4SxGm3nwaLsncHb4M5lZ751K/GDrSJDXb4oCiBum
         dRrA==
X-Gm-Message-State: APjAAAVofMo2196HE5Fe7GEpipwvN7OIYOXGRYHuII1JNpnVXOhX2vp/
        1P35yXZVOADsDXPd5GQfLtNs7yVTAepNMJ4m8MTknQBD6Fg=
X-Google-Smtp-Source: APXvYqwFBLb8gd59AljidUrmndljg+LOGmAG0M0NdaDXyYb2h8Cc4kxUL6YK7kAvk/ddSEUFgwoNNLU+Tlg0RJMbnSE=
X-Received: by 2002:a63:456:: with SMTP id 83mr19214381pge.67.1561229267284;
 Sat, 22 Jun 2019 11:47:47 -0700 (PDT)
MIME-Version: 1.0
From:   Bhushan S <bhushan.az@gmail.com>
Date:   Sun, 23 Jun 2019 00:17:33 +0530
Message-ID: <CAG2NicJ_0Q+ewHtDyQNtM3yZn4Og+VPPphaYneEEZA1dd7PUBQ@mail.gmail.com>
Subject: obexd: file size not reported consistently by fstat.
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I am debugging out-bound transfer(obexd client) and want to track size
of outgoing files.
I am using bluez-5.50 version on Raspberry Pi (raspbian) with blueman
as UI manager.

While debugging I encountered fstat() is not reporting file size consistently.

obexd[906]: obexd/client/session.c:obc_session_unref() 0xd5d050: ref=2
obexd[906]: obexd/client/transfer.c:transfer_open()  Debug : Opened
file : /home/pi/Downloads/download.jpeg
obexd[906]: obexd/client/transfer.c:obc_transfer_put()  Debug :
transfer_open successful, file : /home/pi/Downloads/download.jpeg
obexd[906]: obexd/client/transfer.c:obc_transfer_put() Debug : Size
from fstat : 1 bytes
obexd[906]: obexd/client/transfer.c:obc_transfer_register() 0xd59c20
registered /org/bluez/obex/client/session0/transfer0
obexd[906]: obexd/client/session.c:obc_session_ref() 0xd5d050: ref=3

The file name and size is displayed correctly on the receiving device
though. Is that done through sdp ?

I am sure I'm missing something basic here. Appreciate if someone could help.

Thanks,
--bhushan
