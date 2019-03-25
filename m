Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18C5C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 14:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE0F2085A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 14:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHXMWG2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbfCYOBe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:01:34 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:45760 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCYOBe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 10:01:34 -0400
Received: by mail-ua1-f50.google.com with SMTP id c13so1602574uao.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2019 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yH09TNSwmiYohuWybzh5BZRIbxW44y/+K8kYUNqosOY=;
        b=ZHXMWG2lp5qYdndNuyOIp0lpSbq++n8PK0L4ZLnm8DYfPQlrphEaPN9bbtlOOrd35C
         uiZozZLLQ0wuj94nysw0xa04DZPhjRhiblQo/jPoXYUTSnDlcKeGHtnwgR5N37eXougR
         +Jy6B2mlnaY6d1dWG+a7daE5mKBJDKwWckUJmiYsXpnVNHyOGV4MqhdB7R3hJt1N/Ok3
         aK8d1NM2YuBoXo4qaLIMTx9QasOacz00zudVkaT/niqbVhXKWIcWF/Q9QsC3rIRRfz8y
         O4ADy6C9pTQfs/RyWpiyGnNvaUOPtd5IlMmWQGjOp9ljATL6Y00wbNS/645yH1m2zcrh
         X4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yH09TNSwmiYohuWybzh5BZRIbxW44y/+K8kYUNqosOY=;
        b=ro//uxwjpK9OpocPiDBmDqcdQZIb6UvYuvIedZc6wODC8TMoGRx6jSk0IlaWD7gqEk
         PaeG+fDrKO8cFCdhcv5nXDlIBuAku+6mDNjru6XR0iuT15Njjuo953vPLZMMa8OPj3ek
         bAmjU0BET9cz33TO/7isCJe+Lvwb7um09Ze6XSAdGjWPIZ66BFqH7i5byAP26Zrsv2us
         Ml2Y6EiAAB62144saRRQOGHFHitjHNRxqwPMG/6OAgx53MT2x5nS3m30XqWAvtVVF2ca
         BASKla+yKyJQLUVIS/IC4wmsdUZJNw8yRI2IVlWQYOed0r64mmSnrHwxi6oG4jC/odFm
         kqhg==
X-Gm-Message-State: APjAAAVvSKFNwBAvknHeetrEyNMmPQtEubAwl6gLOyLwsk54jLFbrgl/
        vVu8M64Rb0BaGgAd70j1xTdxzB9EgvEXntLnY2hqOQ==
X-Google-Smtp-Source: APXvYqxLh3tWSYSNlgn7c3mXWV9Anr/d4zVJZ3BRgL49+rdSCEtx8gFfpH1rpcuADOtZo0tSO9Z6k/qSxNkugGWj0FI=
X-Received: by 2002:ab0:61da:: with SMTP id m26mr14199078uan.140.1553522493599;
 Mon, 25 Mar 2019 07:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABLzjm-SLs_AzgS2S=3ogN=P9Jk9OjBuSMaNFTpXawrAsNfe+g@mail.gmail.com>
 <CAO1O6sfDYV9q5z2b64SS1MDSuXUYS6fvxQWc00NsX_1qLxEorQ@mail.gmail.com>
 <CABLzjm_jO8=vVjSosWh=PjLpoeZuY8BSYPkSxKwomY4AYBPLGA@mail.gmail.com> <CAO1O6sdC8fuFjAh5J-O-qjcaaaft8WfepKLFgXQZpAf-TKkXQQ@mail.gmail.com>
In-Reply-To: <CAO1O6sdC8fuFjAh5J-O-qjcaaaft8WfepKLFgXQZpAf-TKkXQQ@mail.gmail.com>
From:   Alexandre Augusto <alexandre.a.giron@gmail.com>
Date:   Mon, 25 Mar 2019 11:01:21 -0300
Message-ID: <CABLzjm_W27upO=-7cxL-izG7-AD31+UipP2frpqdUVVoosoH-w@mail.gmail.com>
Subject: Re: Information about HCI LE Rand command
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

That's very interesting. Thank you.


Best regards,
Alexandre Giron
