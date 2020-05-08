Return-Path: <SRS0=6WQ0=6W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4EEC38A2A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 07:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D44A2070B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 May 2020 07:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVYHpBNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgEHHrc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 May 2020 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgEHHrc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 May 2020 03:47:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC1C05BD43
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 May 2020 00:47:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 188so662671lfa.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 May 2020 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jZKTFHMIJlGMM14PZe7K6scszTebsc+OXnRVGapY1wo=;
        b=cVYHpBNJup7Ybow21yoOrENNJdMGniycST/M5yDZkgJYB4CVS9FYuwg4Z1eZkrW4hs
         x2gfe5uqVbFqnKSjXaIZw77HMwfx8VDs1TLgWYMcZ6Nx11CWywcGP8YcJeGSzjHlWPRz
         vtYHrFcKP8Uw5q7ZBMaIC8ESwepS2X7JCROxudveOk0nTBNeSopZLpTXBUIWbukJ2HiD
         Cz8VZECMUVbX52rYDkq7J5ebdCI1APpxVTrtuxo8IgdbmS1rviuYNQuWZglCzmITH/Of
         kDwjqFxLVgBUKKGdnKEAlnEtAhM9mvg+xVXSejROOLaBQc4qvHdRKtekpUuSTYpF+glY
         Rzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jZKTFHMIJlGMM14PZe7K6scszTebsc+OXnRVGapY1wo=;
        b=ohOs7Apw/hY8hYuV5YH1P4l2Gp5rYPdL37/Xx/1xUtfTkNwva9jTvs2lG7v3Dqo5y6
         19+BbZF6xZVQMrW8A5WU/tfBPUnC6pF2Jeljadg0PKNH8ZI4mY0TjVuVh+781pwIAABu
         a51ApyNLOJOI5RF7xkW0fLJya4VX1G2I6XP9Uz+8Q56qF/00OGFrdwyteNWv+cNsOx9x
         MjKmHC++cauDg1hjsrVbKbKnNs6ItpaduIWbfjdpx2opf1yr/rLr6sQKIbLFqSA2Dwgh
         6NySxPLpghvGAqTy9iX/Vor9+BW9DPJJRG5pumK0AJWvS8eBhRy5DAGGL0lOMQCIBASK
         YT5g==
X-Gm-Message-State: AOAM531oEj0f06iv/YOVsmIFkc11ZVp48tUPnr5xxCRTsP+Xizpr9BCA
        /uPFe1Q1bgKFIdMAHczAAQq7kVQz+po/nIR//OoZi8bH61I=
X-Google-Smtp-Source: ABdhPJwWmcMBBb3OXLumXMKLGXDdakp5JGunYN8AJdBlz5U5OOU5ngZwk5UFSLsVIF8oUR1R7NBrl+gZ5PApWAW2f/E=
X-Received: by 2002:a19:10:: with SMTP id 16mr991130lfa.145.1588924049500;
 Fri, 08 May 2020 00:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWtcQOVcb4-a6aCztjszh4gmk_QVXgHsn9FLOeb-zpLpg@mail.gmail.com>
In-Reply-To: <CA+icZUWtcQOVcb4-a6aCztjszh4gmk_QVXgHsn9FLOeb-zpLpg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 8 May 2020 09:47:18 +0200
Message-ID: <CA+icZUVXpY8bu+QNeCmnrqhZ2XMc-8hnATi3nd2bKeK+Ls0yhQ@mail.gmail.com>
Subject: Re: [btintel][ID 8086:0189 Intel Corp.] unexpected event for opcode
 0x0000 / SCO packet for unknown connection handle
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Addendum:

# hciconfig -a
hci0:   Type: Primary  Bus: USB
        BD Address: 88:53:2E:AC:C3:16  ACL MTU: 310:10  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:603027 acl:2085 sco:0 events:288 errors:0
        TX bytes:9260 acl:169 sco:0 commands:81 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'iniza'
        Class: 0x1c010c
        Service Classes: Rendering, Capturing, Object Transfer
        Device Class: Computer, Laptop
        HCI Version: 3.0 (0x5)  Revision: 0x1b07
        LMP Version: 3.0 (0x5)  Subversion: 0xfc00
        Manufacturer: Intel Corp. (2)

- Sedat -
