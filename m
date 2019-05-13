Return-Path: <SRS0=zNJH=TN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464ACC04AA7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 14:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084102084A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 May 2019 14:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t1KL55KI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbfEMOvx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 May 2019 10:51:53 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:44269 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbfEMOvx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 May 2019 10:51:53 -0400
Received: by mail-pg1-f181.google.com with SMTP id z16so6889394pgv.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2019 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=D3/VmHhj/71ke+w64kXAqk0EPn2jtZGzyEMFSnVlsVM=;
        b=t1KL55KIelperdzWcdaB2CSsGP7XvbixHPcd6wuoiOIrsu5tPoRFo9vpy+OrqT6JnR
         cQqeWCyHFilSCf43NCVTOB2aBQmQDm1l8d+OLa/7UF0hQLGb1bF3oUPIZbRT2l/VWfyu
         W1QYq+jt1BT5rL7xXCp2jK6fIMYi/ODHQHwCSZztrjnk9x7GRUDPeqDZgc66MNq5vRrn
         HyoCSMWbhyjQ+dZW9pg16mFoinfFtZEzpaZx7kEfrHywVW+QmbcaxYBuTCLakY81YvoM
         d1ceaukfcYivnIkt4G2IGrAikpZ0VipBp70PyerASD87PMiMmKOm1HTaOqTdCwVrYmG8
         Kb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D3/VmHhj/71ke+w64kXAqk0EPn2jtZGzyEMFSnVlsVM=;
        b=kPisfa7L89fzc14XjkEaHZmukugRgZLD/PpLdr6DrZMQ0JLfpzPcE3Yk3+/vzBqy5L
         mp73HTGS69Qkg/5hWNpLXvvLbqS7BROYUBz8w1SnSowa5LtjSWEiEu5pkXv7tUIieOzZ
         rKkK390C+ByA/qUnJywhop+8Ro3UVCnf7ozmFgXQuut1r9WYtfmgw/gGDdtvatH3XjuT
         9Sl7jFSgabqNDMTrW3/Y6gGJazkNwFXUh/aKxfFU2BrMaJMX3dRSh9YkrNYbHml3McFc
         xD4MldHzclNLRZX8x+LNhrFYJKiSJXV+qAqXCECu66imBl7278c8excbvSInxgKn6hID
         5kjg==
X-Gm-Message-State: APjAAAVqe21yXHhmgotNR8OFHkUCS8+wbW1lrwArz2+xTqEPNEnSBcj2
        O/HifYfY1jaAVG0EsmqndMkUAv+hIBsM9JfrUMOeXvMRUxA=
X-Google-Smtp-Source: APXvYqwGi1B9YnEVZXO6QnBoBVEAlrwbtwX7d9xqOoHoTmZ8bjLDRPjaP1dyVGqA30DySIycGTBBLvpPSZzT4ubzmJk=
X-Received: by 2002:a63:7413:: with SMTP id p19mr29222187pgc.259.1557759112548;
 Mon, 13 May 2019 07:51:52 -0700 (PDT)
MIME-Version: 1.0
From:   Youssif Saeed <youssif.am.saeed@gmail.com>
Date:   Mon, 13 May 2019 15:51:41 +0100
Message-ID: <CA+T8qpYV_wiLMbUQcsn2v1bYU0Wub_wa3U2fjUbj-MmM=N70sQ@mail.gmail.com>
Subject: Local Private Non-resolvable Address Support
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

Is there support for setting the local address to be non-resolvable
private address through the command line (e.g. btmgmt or
bluetoothctl)? If there isn't, then is there a way to set this through
the D-Bus API? This is needed for a few PTS tests including the one I
am currently working on:-

GAP/CONN/ACEP/BV-02-C

I am using BlueZ 5.50 on an Ubuntu machine running Linux 4.15.0-47-generic.

Thanks
Youssif
