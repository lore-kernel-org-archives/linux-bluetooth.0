Return-Path: <SRS0=76SB=XE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E645C00307
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Sep 2019 09:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304312086D
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Sep 2019 09:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4iNqokb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbfIIJtq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:49:46 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:39427 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390028AbfIIJtq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Sep 2019 05:49:46 -0400
Received: by mail-vs1-f44.google.com with SMTP id y62so8309846vsb.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Sep 2019 02:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fE3X+AkZ+kRw+CbTBflxnghoXQ4tgfiTsjBLRDJg41U=;
        b=Z4iNqokbiZ7uVAmqlbMz3yk99DR2kCxGVdNvsFoTOaP9zPGNEPL/qXD/SYLSX1eBm3
         3619e7Nf49ZmDnGZ4gwQIMH+atAan5lmkL91PI3rJvTRdIGxatCst1Dgea69/MNbXnVO
         XGlnImAdgGa3Y7pMnYkEtRclees6Q8MnQZn2FhKjYp1H2zDq6FTc7Mtei+DsZG/beCjR
         LbdlpX6AHaD9nlKUKbN0ElM7pm1DgDI67lYPm9KMgWGvy1yHY6NNsgsJ/UBgXTl1wosF
         8TqMRWg4uTjQjvuE0hxNAoOPsskxJ0CVWWcAK1c1FVPqJ0duaHXOCZ5b2jFGIjsZaD5R
         BgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fE3X+AkZ+kRw+CbTBflxnghoXQ4tgfiTsjBLRDJg41U=;
        b=BGS2bQbp8eyM3QsetjJ9SunEXIZ1soDh+ACRBPkxB2SB+mwWrs+4J0ZgUJJsoinIHd
         9+CETOLBy+yI+waY/PFgbSd2ecgC3j0hawpxkG8nPkI84rONi6vgIVN+UIJNdlGwpD1u
         B2rJzioIVGQJHYrzJHu6K6GgkUkFxV+TCvdhF8XjOWL9Xvt3C4r6d6c4idJbjl+ljC4N
         I1BJls90H4jcFGpwhryehZYh0yyKAD2eNOi4bkakWgVGUNniI/JnoH7caiYdISsYP0uM
         Gh+cAt1/nle9opwLKGTsr/uHm66qE74+X5QC7S4PHv45mUHhiG1omA/+mW6B+Fwh7E4u
         +PTg==
X-Gm-Message-State: APjAAAVju3IXCBXVWjD1XjpgGJcNginIhew6VnHejw9jokCm9P+sH+Xn
        Ah+biJ5Ns5VgRbF5BDmaBPDNKe0oi/Uuf4uO2Avd4TBF+po=
X-Google-Smtp-Source: APXvYqxOLITnL+XpPRLdRoIHF9y9ISi3QE1sRKSDDw0DWBsBs1Th3gN/CeXd6ZFuy/me42hMSx9ebpjiyUZyIfkQhzQ=
X-Received: by 2002:a67:dd97:: with SMTP id i23mr11904743vsk.131.1568022585238;
 Mon, 09 Sep 2019 02:49:45 -0700 (PDT)
MIME-Version: 1.0
From:   anurag biradar <anuragbiradar@gmail.com>
Date:   Mon, 9 Sep 2019 15:19:32 +0530
Message-ID: <CAP1EGUKNdCnaFZLy4rut2zOP0sjmVS+6ZEeQ3vz1M8MQJTDKVQ@mail.gmail.com>
Subject: [Mesh] Query regarding Configuration Client Model
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello All

I was browsing through code for PB-ADV bearer based mesh
implementation in bluez.
I am trying for Provisioner role, able to provision a node. As of now
struck with Configuration Client Model.
I couldn't see any interface exposed by bluez to do this, is it
something like bluez is expecting application to implement
Configuration Client Model using "DevKeySend" and
"DevKeyMessageReceive" method calls and store all required binding and
appkey details in application or in future bluez will implement
Configuration Client Model and expose interface to access those
information.

 Any guidance would be very helpful.

Thanks and Regards
Anurag
