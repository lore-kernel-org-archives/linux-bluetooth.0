Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6F8EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 22:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFZWPj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 18:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFZWPV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 18:15:21 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581E3359E
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 15:13:59 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-765a311a7a9so74719185a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687817638; x=1690409638;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QlpYYAVC/MWdIUZuaUadftJpfVZkJVH5Wq1ooN45W+Q=;
        b=HOlRiGBwAxqNgXcLdXxFMZhkN6BsupBpMrGbnwR4So1iXo09PsjLlOR45G3YVoK8Hy
         3UGEwyzXq/4PE0c+Zdp7tYmWwj7Pq392PTdZ4VdUPhIzg3LwJWlyKG+4sY1ULmZwXv8j
         BIOuWg8bGnzQBZKAjkRBiJBdWKMil1yoWCuP2HQOn56ZWkS9VV1PCV+ZORKTHW4XC8HN
         g5eZJW2Ke2/jCfc6GavlAkmNMq/0xmYnR3MiFe1CXJ4EZP9YYHDHOfTpf4YidVWkLvJs
         SywlN2Qk5s80Wntm4MdqHfgHCLalO2QmmqhXfQX5qJ3GPl6GJfBFiSwy8VsAqJMoQdJw
         AzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817638; x=1690409638;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlpYYAVC/MWdIUZuaUadftJpfVZkJVH5Wq1ooN45W+Q=;
        b=erIdhgyROBJUo3yBNFPCQbstJHgzeUUczxt7w+lb0b4niRr6FgH1mRcvu19rYPILKT
         HsGrKO/Rnhgl9kGhXPODyczBmJPaB9HPwC8YU6dZz9tmi/Lz1BCKGRgIXcZUDAS/13u+
         MhyiPvmdKrqv0jY5lDV32gWAXaxFRwLow3IDaVqBBKEVt+w71iq+Pb0HJ9mgz0mNNRj9
         rfbGaXgHZO+JJANSNpxOCHE1PQ+HHJyXI5Zw8OwYEvvaIRVLdbztudSjY2fP5WwwbQgZ
         TXE1aLD0rSRfEjj5kcWM0J8CYyacfba0Vvb0uxHU9iRqqd5hNCGtFAmxby/+gGH1Gzpb
         A3YA==
X-Gm-Message-State: AC+VfDxH3oFqGIC3hPTenyMd+8IHwH7qT1K7T8wxp79DppC9Buu6sPJz
        tbI5v/ifT9pTdQlLfM9G5VRquGFd/Ao=
X-Google-Smtp-Source: ACHHUZ4JfY3mwrFwMp+bNeVAxevGh0aPcimLmxfpOD8k9aXfpE96VaI1iyoFuIWY+83ozH1xrGCfrg==
X-Received: by 2002:a05:620a:4111:b0:765:70df:d338 with SMTP id j17-20020a05620a411100b0076570dfd338mr7442314qko.9.1687817637692;
        Mon, 26 Jun 2023 15:13:57 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.98.52])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a124400b00762581d01dbsm3143568qkl.30.2023.06.26.15.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:13:57 -0700 (PDT)
Message-ID: <649a0da5.050a0220.a50e7.67e0@mx.google.com>
Date:   Mon, 26 Jun 2023 15:13:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6783403933793776064=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        aleksandr.mikhalitsyn@canonical.com
Subject: RE: [net-next] net: scm: introduce and use scm_recv_unix helper
In-Reply-To: <20230626215951.563715-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230626215951.563715-1-aleksandr.mikhalitsyn@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6783403933793776064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/unix/af_unix.c:2808
error: net/unix/af_unix.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6783403933793776064==--
