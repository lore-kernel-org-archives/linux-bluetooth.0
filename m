Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15D5C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 17:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834CB6512D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 17:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhCPRvi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 13:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhCPRvY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 13:51:24 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D71C061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 10:51:23 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l15so25739qvl.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kv11q06ou9TL3Yug63VSSvpF7cozEgANGD9bDiw7EsE=;
        b=Wym8yf9TOvO0tm1VajmdwhwmClXxbACv5OpZ18O8z9BzApVni07iqnnPkAtzCNFJk/
         ALY8xRx6zv2jWKgnc69k0tewupUss1hNyRYkFxNlrxGfw4dA7hmohEK1Um9o4m4Ir1QQ
         8OES3wj1QyfJsoGTL+S06EGgUd35fKM6lvilBGuWlnBwyS4JXrAGt9CMW0aoHkBx0EWc
         pZjPKes0qChiKPZkfSvksRE8o/rOP7GlFMqQMfJiUQDPvpU9Sl8BwMokvdqA+i51qOa/
         TbSv26o4d249rA/tempH4bxN0NyUISDUq8grPatD9Tf0nDdwJeXM86n7pgb9PP65YmYA
         Ok3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kv11q06ou9TL3Yug63VSSvpF7cozEgANGD9bDiw7EsE=;
        b=oQJvMenXkwkCC+B+ejwFkt2vu0hFV9PN3aQUKSoif3JkFr4I01HxjMQBhAg6RXIzEu
         nLpWgp+J8bMvlpVic7hgHZjPwhWGw5L6mt2yYgEl1BcUhjxMKXfx689c3Owi7KnjqZWs
         8lTwRbffQp/Ctse2VJkv8Yi9T0qMRVRIlUNki7ieerZ6UEeh/E7ZCptvyn9K5Jh2u6xG
         yGUiG7MYMUV4xuLQuRFJna4eSAIy5vfjW9re0b99CriJn7aahwLr/QD5O6Z6HmdhLkfH
         B/QZKLlpuuSOEMvNRMlN6F6BENp1r5TCTSpnZGOdYu7ob7iDDGftBdK5jFUmmCJyDdo5
         pI8Q==
X-Gm-Message-State: AOAM531zH6SJU8tGSIQWmFW3/R6kUUA4gVdptSJoACduZHdek5kyNS3P
        zsrzs/aHH5qbr/Pc2/ZOHaCis+eJylyYxg==
X-Google-Smtp-Source: ABdhPJwOxCq1+fHenAiR7JiccSx63Hd62e6N6qq44ovfQLlYkMGPh48XQ+YCwoI7gWUFK6CIfY26iA==
X-Received: by 2002:a05:6214:c8a:: with SMTP id r10mr937563qvr.13.1615917082766;
        Tue, 16 Mar 2021 10:51:22 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.46.51])
        by smtp.gmail.com with ESMTPSA id 21sm15535477qkv.12.2021.03.16.10.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:51:21 -0700 (PDT)
Message-ID: <6050f019.1c69fb81.cfb41.48cf@mx.google.com>
Date:   Tue, 16 Mar 2021 10:51:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6511733376826811817=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: adapter: Fix discovery trigger for 0 second delay
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316171836.28501-2-frederic.danis@collabora.com>
References: <20210316171836.28501-2-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6511733376826811817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=449327

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============6511733376826811817==--
