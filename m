Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351C3C5ACC6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB5920869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaL04nM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB5920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJQEHu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:07:50 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:43645 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEHt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:07:49 -0400
Received: by mail-lf1-f50.google.com with SMTP id p34-v6so17995751lfg.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SS8I7hVdicOA7YJNYTgV1gj3M6XA7H8nID5d/AtrgZA=;
        b=KaL04nM/4/Pd8Ig9aGZPRGzMGSx/cHiEgpyM9yl3ahK4y102fp/lf2KvQcSmd/oT+C
         QQ2R+0dP+oBHZ2Z34qbf0NrsyVWRdtl48z7Yk89ErmgsDtGmFpajDThxyzyHw5nryQoO
         Lpns1jWR6k80LwzYx1TDLQURSWq5P2qRyuAQffvtMfEvSvJVqBnT6S3rR4CqayKrl17W
         OPecvEADJcgL78nmckOr8iEoNBAdofFzUAVdeQwt1PapIPEJNRhGu8rjMC/kqOAXRXiD
         OnzB2qG6xDtuS5GHDL+uJgZki5s9RzUxsj8JCwazyk/pSWKy7ZgeotdsHSVSnQqB27Li
         wsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SS8I7hVdicOA7YJNYTgV1gj3M6XA7H8nID5d/AtrgZA=;
        b=m+HbbgBdVwoSQoJCqoW/bTD3YCCpE0a+wkyEHwMtxfBVXqUY+mv6LcA8VxdADyaywz
         rNt5NdEX5NJ/4/nVWRxxYWIjp7ensrhgTDle2gpmsx39TOvy+1YmAcMM4qkq2J3pwT39
         AhiQjAMq0lbj8Ph68GHZKmNixTuUmA2Tdj5ABHq0xYBFtsdm6q5uweEaYUfb3tnMvKWl
         QD6y+UoVXqnHwxGzXDRcyRb2fm744rcberDDFjfBwOHhdWHQ3up12Y/CJ8B8d8E85LG4
         uFrg1ODPf4iO0lCFSzlVmD8WYDIUipUzpOjIILQhPvhDNzbkXanLhcJiWgzChVzVg96n
         HDyg==
X-Gm-Message-State: ABuFfojiywDrsqhfAcvODoq7BoHgwd14/u1SBjJgAtjuB+EmlwvhBQvI
        3hKMI4f2LWPju/quRJEWnorrAd4nbrM=
X-Google-Smtp-Source: ACcGV63/iCChNtpvxKTUJ6PIyZorMtgvXLVZJUlOWvg9HLqP2IeWJyQzLRcMoNbA1uFaOTQ1KTWNfQ==
X-Received: by 2002:a19:4bc9:: with SMTP id y192-v6mr1312594lfa.144.1539720942155;
        Tue, 16 Oct 2018 13:15:42 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id n195-v6sm3308477lfb.26.2018.10.16.13.15.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:15:41 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:19:08 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/12] btmon: multiple memory management vulnerabilities fixed
Message-ID: <20181016201908.GA84982@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Multiple different memory management vulnerabilities were discovered in
btmon while fuzzing it with American Fuzzy Lop. Purpose of this fuzzing
effort was to find some bugs in btmon, analyse and fix them but also try
to exploit them. Also goal was to prove that fuzzing is low effort way
to find bugs that could end up being severe ones.

Most common weakness appeared to be buffer over-read which was usually
caused by missing boundary checks before accessing array. Integer
underflows were also quite common. Most interesting bug was simple
buffer overflow that was actually discovered already couple years ago
by op7ic: https://www.spinics.net/lists/linux-bluetooth/msg68898.html
but it was still not fixed. This particular vulnerability ended up being
quite easily exploitable if certain mitigation technics were disabled.

Matias Karhumaa (12):
  btmon: fix segfault caused by buffer over-read
  btmon: fix segfault caused by buffer over-read
  btmon: fix segfault caused by buffer over-read
  btmon: Fix crash caused by integer underflow
  btmon: fix stack buffer overflow
  btmon: fix multiple segfaults
  btmon: fix segfault caused by integer underflow
  btmon: fix segfault caused by integer undeflow
  btmon: fix segfault caused by buffer over-read
  btmon: fix segfault caused by buffer overflow
  btmon: fix segfault caused by integer underflow
  btmon: fix segfault caused by buffer over-read

 monitor/packet.c     | 56 +++++++++++++++++++++++++++++++++++++++++---
 monitor/sdp.c        | 21 ++++++++++++++++-
 src/shared/btsnoop.c |  5 ++++
 3 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.17.1

