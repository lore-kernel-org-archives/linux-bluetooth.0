Return-Path: <SRS0=lCj9=MW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00907C43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Oct 2018 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3312085B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Oct 2018 09:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1JVLH73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3312085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJJRQ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:16:56 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:40170 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJRQ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Oct 2018 13:16:56 -0400
Received: by mail-vs1-f47.google.com with SMTP id z130-v6so4424807vsc.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Oct 2018 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1SW7WKih+FNOZ57Ov+m7+cNel50EKjX7Vh87c9ackOo=;
        b=V1JVLH73D+m79CSvDjPSwKgPqNER7B/BYvdjIuod96rOyNpx/shQa/Qsi3pBqPprnu
         c4hvYiC/bsjqfojhDa298sdAv3zr+7S6YVx/393+SzBRCxa9zuvwzI7nVQfUZ1JNsNX6
         hXLai/qKB4kU2s8geSTI1F7MdZW7Ic3j5BmGJd+RFvDW6MFQGGTfqqWKWLgYF8QVPnNB
         8DDiarAPl/rSkuCeDENahhzZJ9lR1mrHS7xc3VEPescQbRuv/7x/LO46S5pWNJkYuRYj
         N5t5CvUE1Z+g5XKUQlX8RKcJQ1CEMWCuJqTZHwCuxyZ30TLR0roH/iKMRm5sa49cNoU7
         yQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1SW7WKih+FNOZ57Ov+m7+cNel50EKjX7Vh87c9ackOo=;
        b=hhf77VYcPtOrzT7fHEgjAyggOAKR4HyO6BIsdb6MvSf+/Bn6vmIerjbI0k04H1qUEN
         I2XZGKHk6+IWsFXX4oiTLFz4dR1PNu5W8gFY3CYgWKL5q1YTyCk5ge4T7ySU0vOwD2Ax
         NTnxF6JBAGzI6Zq/5jN9TGX6Fm9/+HcYtG43uZ9Gx2NzszyvaAmiXvGyBbieTKKPUx2B
         c5OYlrRcq47L5Sekx/NKIia8/T44u7nqUYyy9IO8bpCoG+xjzmsrKkbL3FcqXDCUX80J
         c1c0JWFA2lZcccVT49TlLvtfuyliNUt5EwcbRE8P9I8EJeoVvyf6EAAads5TQkdHE/GD
         LFSQ==
X-Gm-Message-State: ABuFfoiXgotSAS1xQNWFexzkbJ66Gi7BqUToYtiaVwnFzwENRClzlnJA
        OtNWHo7FQsdqwj5Eewzx5EFlq9QYk0c2p08mdfXgWBOG
X-Google-Smtp-Source: ACcGV62eCp1sJdcgf6bjhsGmxEdBJqJKIhd7MEFrUzChSarXrCIkeS5J8y8AADDfwE4PdfZ6NFZGpnBHTVv8Luaksrg=
X-Received: by 2002:ab0:598b:: with SMTP id g11mr12656231uad.131.1539165331837;
 Wed, 10 Oct 2018 02:55:31 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Yoo <choongbeom@gmail.com>
Date:   Wed, 10 Oct 2018 18:55:20 +0900
Message-ID: <CAO9gXyQNtt7x15sEsNo-2qb2xLOC_8OB_wkti1_d8tvq8fysNQ@mail.gmail.com>
Subject: How to enable "util_debug" function in att.c
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,
How to see output log from "util_debug" function in att.c
I searched it for few days but I don't have any clue yet.
How can I see the logs in console?
(Env. - linux and bluez5.41.)

I found enabling daemon log by adding "-d" flag in bluetooth.service
file but it's not what I want.



Thanks,
Calvin
