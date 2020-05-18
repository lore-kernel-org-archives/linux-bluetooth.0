Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804452075F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuGVEjET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgERWje (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 18:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgERWjd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 18:39:33 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B381C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:39:32 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l1so9583192qtp.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sNj2Ez/E3Ep/Pzpn+P/YZtWbMkiDOMfrcsOTGS5KxaM=;
        b=cuGVEjET1C6cr/ILT/sOf5Tx9JRQD25010j5iOcXmXiYc72KWzEfp8nqbwmpxhhjeE
         QulTcWpwYapIAjpmcQuZ+4hHNhjVUlbtgJihGO9xq6pIa43q/UFqwxJ9Rheh8nIU8Jwv
         KPHzhtOuKWvK6SpQBNlHU3hsgKTcpw0g6OW1Unu+CFtYlq9bHBFhmh9wfDbptsUveeHS
         YPDBAWuR/1FlIoqfLH6Yd2KFzbH8Wckvucx7neiGajUsKjHIxFlxPd2q41xvANP7c+ye
         LptHgVgomJeV9SZp1CPVL/OMBc6uVS8yJlpMMbJfyqbwfsogmcCK7qyDcgFZB9MTJFJy
         za8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sNj2Ez/E3Ep/Pzpn+P/YZtWbMkiDOMfrcsOTGS5KxaM=;
        b=Ad/NMpchSs6BYaqzUcYAclrqmiiLFlwXYj0HoAL7jH2EwpLIgmHE9x0Yy+wGd6WO20
         f6S14G5Fc1nassfpPt0PJ10vuLAHdSu/XVzTzMjr7PB2QUBgqIo9fA7CVDKPM9Rvgdk8
         Ys37P+eavtQ9a4ltRY5Ja9mDNLFfW+nI1fuezHyExxKGMF0ZLzouaQHuqfPa0I9NNMVv
         uf51oB8wGvK7L4GcSousmXXFswiYxPCw3IgeWLpMpJUmOxoOvfO1o/+ySb4t4rjjgEgZ
         LhauVfio+dTpNox2Y96KODMGwbJaXo6mMUFRWQxiRbwYuprAfhWPIlkVYTf9Ld+sESXz
         /xSQ==
X-Gm-Message-State: AOAM530phsCJxU3xC+nkie69eokAHqAhguR2+/xZ8uzUGTeYXS55p3zL
        zRGZsBM0ARNGegANflv6XXZ/TrINWlw=
X-Google-Smtp-Source: ABdhPJwv63TxBWbih/lOrP6DhjbprcNOwUi4yoeGIvRDcHp4CHffpXqp8hcmKawGnTrg+GCPGVkWLA==
X-Received: by 2002:aed:2213:: with SMTP id n19mr19401699qtc.246.1589841571452;
        Mon, 18 May 2020 15:39:31 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.97.121])
        by smtp.gmail.com with ESMTPSA id o14sm9064455qkj.27.2020.05.18.15.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:39:31 -0700 (PDT)
Message-ID: <5ec30ea3.1c69fb81.8827d.291b@mx.google.com>
Date:   Mon, 18 May 2020 15:39:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4744803685400908548=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/4] a2dp: Fix caching endpoints for unknown version
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200518222908.146911-1-luiz.dentz@gmail.com>
References: <20200518222908.146911-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4744803685400908548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
makecheck Failed

Outputs:
./test-driver: line 107: 14841 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[3]: *** [Makefile:9726: test-suite.log] Error 1
make[2]: *** [Makefile:9834: check-TESTS] Error 2
make[1]: *** [Makefile:10228: check-am] Error 2
make: *** [Makefile:10230: check] Error 2



---
Regards,
Linux Bluetooth

--===============4744803685400908548==--
