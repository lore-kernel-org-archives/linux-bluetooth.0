Return-Path: <SRS0=zkq1=VQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8D3C76195
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jul 2019 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DD552173B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Jul 2019 09:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=senic-com.20150623.gappssmtp.com header.i=@senic-com.20150623.gappssmtp.com header.b="sY0HUe71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfGSJWM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:22:12 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40044 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfGSJWM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Jul 2019 05:22:12 -0400
Received: by mail-oi1-f169.google.com with SMTP id w196so2444003oie.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jul 2019 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=senic-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=k/4IBFkFkKr06/CcktiT5MhwF0nIpbRbTOoVQjnMHAE=;
        b=sY0HUe71kgz1EKPHt1PvmTQuNLcje3a1XQxnTJ6sOnBeVgggbggG7rDM0272Eggtjg
         fYf8ij5J9z5P2rcGVyBFInU49qkDHzTz2jpNPZJsHY9v6uqiYM1MT5IeiXN5xG3RDx3C
         aPFvonm5hkFEK9oBv5CYxqh6wIslnBAZjHFvFaQ/FH2gm5M1dCparLaQr0yEz2EhUxsd
         Ag7qGmhUDoARlNG709OEQklwNqJ+kQduW50KUDrFmRjF2eDb+EyXBinzSnjz37hkh7Ps
         zw/1u9wnbaDCu8fmo5DXFW9wRKbxuIr34nriUbL7luIIRQMbAwRu5F79nm5pcPNlce3B
         qcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=k/4IBFkFkKr06/CcktiT5MhwF0nIpbRbTOoVQjnMHAE=;
        b=XnUu5WBreJDWwI1tatLp0dsV8dE/OAexZ3y+M+zA7H4Ebq3Z2jVcaOhE9jXKPC33KA
         iv1cPKbyFCL+xC/VWR3/m+YBbTPoDNSO7/aHqo/Q3J1GE36OyQhHsN2Kjm5BXiDmcDsJ
         In8SU2QTnB3CW7bmHxv7wA2WnmP4N3mlGyunJ1zxWo+Nhp4+J3AXgVTjZj69Pvzjwl0E
         Cn5Zg53izjx/khjFMjUvrhHFfVmYwNC6hpTNWXEUflSaLAgwUpd+4Yvw5m+3AHHWoFD9
         vpIcQMyC6B9oeOkEh6trxbD1N9x04ijBT/O1RvyT58IRk3YzlZ0uSTM8dmuzaDLbBNMj
         NbCA==
X-Gm-Message-State: APjAAAWT8qK4fRNZq5jz+9PqWqsWcKLTpeHUNOx8VBxFUHJ403hkGWxj
        yggaMl6iJNbQ7lLNIt5F9g1lVR/XiiGs0J5XtZvXKNGO
X-Google-Smtp-Source: APXvYqwLbi4AKDsjIsiWSFpoZ05xZ1fayh6njNAFr9t9hytqxNBfw3rG3ps1tOkDb7Z6uNg+SujA1zKmx1Nr2X8hwKw=
X-Received: by 2002:aca:3602:: with SMTP id d2mr24094393oia.150.1563528127027;
 Fri, 19 Jul 2019 02:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOT_U5Yt+LO0rMf-QQGY8LoDF8G9psOXEVxhDTcqr_+14UCFvA@mail.gmail.com>
In-Reply-To: <CAOT_U5Yt+LO0rMf-QQGY8LoDF8G9psOXEVxhDTcqr_+14UCFvA@mail.gmail.com>
From:   Alan Martinovic <alan.martinovic@senic.com>
Date:   Fri, 19 Jul 2019 11:21:56 +0200
Message-ID: <CAOT_U5ZgYrwBx0Gju8dZ_5q1d1wEhRRxOihQM5kDOMTbfH2B0w@mail.gmail.com>
Subject: Clear cache via d-bus or disable it
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
up until now, I'd clear the BlueZ cache by executing:
    sudo rm /var/lib/bluetooth/*

that would give me a clean start without a need to
restart the service.

However I'm hoping to shift this so that it doesn't need
sudo. Is there an alternative to do this via d-bus?

Have tried:
    bluetoothctl remove "*"

but that doesn't clean the cache.

Or as an alternative, it possible to disable the cache all together?

Version is: BlueZ 5.50

Be Well,
Alan
