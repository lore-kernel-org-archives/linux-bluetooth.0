Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DA7C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 04:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD04207FF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 04:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sa9RIWTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgLAEEX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgLAEEX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 23:04:23 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1C8C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 20:03:42 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id v11so234965qtq.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Nov 2020 20:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7iMN0UEc3XZHtQjyHr4MOuhlJZWUCfTc4gcl5Fb1fcs=;
        b=sa9RIWTS9QApS8hbfN0C2hbiNqqsPo7Q+BmOaDrbHfvWo7RtxHPS0bwa2xCApXIVLB
         heGD1LsX+qbIleW9R+Cm7DQCKoFikkrndxVopuMaY4QOpb8aP6niY7X6uB78HLBjPXPY
         tXXg52lNgtCXzl64+4wNbDXBn4ncDhZdOdDwJ6XqUwu58iIHGPOVS0uBMlGU+f7+m1ia
         tGkXFyJEwQoXcEspwNwA9Tgk3nSWLdNgBHiSFxAWvyH6x/mcEn0ORn2zVdOLe5QXh0HD
         tAbGW/mcVWbTyGXaa6iweZyXNzhHqtBun8wb1sD6+dmDaaUOn08AWJBWUVY8elB7y9nm
         fTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7iMN0UEc3XZHtQjyHr4MOuhlJZWUCfTc4gcl5Fb1fcs=;
        b=NIKqBUZRIZOFvBB4qmunGUUu3JdCzQoPpkfjaEpuCt85LUcEZR8wXnVHR+Yiyi6jzy
         AHm9TPdqISEOXQeh+v/TB7mzVJcrtCfuP1YCfdBaLRGU0JS6KChCIPd4UsQdj3xB+k2s
         +8fabm1Dq3XUoqg4PwkYNIakPbeqURQ5DQoE7c0sf5lnsc5Np75rqsQUmW9MfBPIKdnM
         F75EY7ygtuq8R1mNRKPXk5KdWXKiI47bSf15wHOM2V6uFbLYR5rBWpaLkWi6Nlw5Ya/k
         +diN+yskOteAiiJjDYcVVga2Fy42aeagyn3kr6YmJGeI5sH8Ty2ef92llbNh7IniXUJf
         v0og==
X-Gm-Message-State: AOAM5331pdds05i8qlsHvACsLlULi0UiLFAVWaMokpdEtLYJAwzp8SbA
        dSvvyrkJQrjm8tAplkKl+NRDTXSEV02sXg==
X-Google-Smtp-Source: ABdhPJyi6/7oW3N0bF4EWTYEJTQmTjnFBJwSwXmai236WeEKsUU3n6jNQ7tF1rZ2PZ1o7yFpXsyRoQ==
X-Received: by 2002:ac8:43d3:: with SMTP id w19mr968236qtn.18.1606795421904;
        Mon, 30 Nov 2020 20:03:41 -0800 (PST)
Received: from [172.17.0.2] ([52.167.169.35])
        by smtp.gmail.com with ESMTPSA id n21sm589658qke.32.2020.11.30.20.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 20:03:41 -0800 (PST)
Message-ID: <5fc5c09d.1c69fb81.8156a.28af@mx.google.com>
Date:   Mon, 30 Nov 2020 20:03:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0558569317328673723=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zijuhu@codeaurora.org
Subject: RE: [v1] Bluetooth: support download nvm with different board id for wcn6855
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1606791564-2443-1-git-send-email-zijuhu@codeaurora.org>
References: <1606791564-2443-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0558569317328673723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=393653

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============0558569317328673723==--
