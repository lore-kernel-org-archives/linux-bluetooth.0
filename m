Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FBDC433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 18:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 878EA2073A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 18:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEjs/0m6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgJOSeY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbgJOSeX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Oct 2020 14:34:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6316AC061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 11:34:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d24so4726118lfa.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2020 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fXumMw6Ct4LQffIPTraW0kvUrjf7lJM7fYG/Hlb1Ns8=;
        b=SEjs/0m6xvJWyfWondopry3ouLFUWLfeCr6XNOyCPKvUPwoqsq4dzOwfUI8gUS52PZ
         ZDfpt0TOaEzbyZ8q7TDa9gjYAe+7zqgAXN+dJ4brwQL3GK0szUwzucvnkv7d37FFkjIX
         Cwuoxq6AOvaTwLNjYVBBWMTrhaNTSv0YOeEPUxZb9ip3APRUySCIn5qZ2mVKmVY99Mos
         JOwqUsOJP5vnYwUZaMFoFOt2tveB9JBs5Hq/KSMSxqMPLt6b+isneD5j9xyh/Vu2bHhJ
         hCDUP4g7iiIqwA3CG3UHEENp4xFbuNPSNuXpzE6mSZUec8+hFFpXezt6fzquOuwDlM82
         /GBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fXumMw6Ct4LQffIPTraW0kvUrjf7lJM7fYG/Hlb1Ns8=;
        b=G3c5hqRu+HFf3x/lonOKeHAXcw742BbcqxkJxhJ/DivoOEFB2W4gR3Hj8DqaIFs5E2
         0EegkI6mcMlmlfiEw/Yd+18JFVRKWI3jC7PHfZxh43OxJ+auhpNqZw85zJBjefjAVAq9
         FufIv6R5qNBUlS/0Jwbt+YbiwMJjJ0NFlTIn5HMGi8wVV5x4G5jtZeVYro9ncA1TUF7G
         Glv+zpb4zlLhuYHohPYxWQVMM7k0UrL8t4939Rt2lx8jfBD4bpQGxudW+XC0AMCsd4Yg
         ruIQ7tBecd//WMaMJm7Tm2kjwXhum2WjbjBxNkU4vm3Ev8CZIvSYe64OyQ7w9L3CuGli
         /B/w==
X-Gm-Message-State: AOAM531bFZZrUU9968tu/ygiBOC6cUf6UfWdENnyctk8P8UTzyvjN+mt
        lfbhW9uNBZrE6Z/mBzTcYRmJ6VgKLro9hxMLfTU+PD32BhOu6A==
X-Google-Smtp-Source: ABdhPJzyNEqTfCDaw3xJHfxOtHtmcX+e2vx3yvVavGQTm2U2RnZ2MxJBTpBK6avSCx9b/ND6m6P8GSJiZT+0phSGlnQ=
X-Received: by 2002:a19:e014:: with SMTP id x20mr1417359lfg.444.1602786861547;
 Thu, 15 Oct 2020 11:34:21 -0700 (PDT)
MIME-Version: 1.0
From:   Alexandre Augusto <alexandre.a.giron@gmail.com>
Date:   Thu, 15 Oct 2020 15:34:09 -0300
Message-ID: <CABLzjm8S1J5MRhrwFu1pbX9fub7X5nXmYRWmtRsmVRObeJOCbw@mail.gmail.com>
Subject: Entropy source based on the RSSI
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

based on the motivation that IoT devices do not have many entropy
sources available, and also on the fact that trusting in a single
source may be risky, I have researched some additional ways to collect
randomness for the device, using bluetooth technology for that
purpose.

For those who are interested in:

Github: https://github.com/AAGiron/Bluerandom
Presentation: https://www.youtube.com/watch?v=iAKaKAmqCFo

I also want to say thanks in advance to Emil Lenngren for his valuable
comments, here in this mailing list (back in 2019), and also to the
Bluez community.

-- 
Alexandre Augusto Giron
