Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B358C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 17:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7DC2076A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 17:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyS5SXuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgI1RGQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgI1RGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 13:06:16 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966A0C061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 10:06:15 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h17so1670674otr.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whuOOfjkSMEKV7Nn7GWXEYtRVnaUWQrA6ny9OE81iQM=;
        b=lyS5SXujcxJ0lDbZT//bprD+4cMSUHJmyQo+XUaaWImeIK8nOz8o9uiKEGCQT2f6gE
         j3o8evcg1U7mxJ24UNlwSSWHzIDbSaqRxNZEbmZkusx86Z1B1BDygL9M4lIJTva7llXq
         h0zVlVPbcrMmC1cmUMVd8icmENeXckBfI6uyqD12xNPkYnCDbXPHT219AbO5VJdUZXM+
         dXrzrm4efSnTHcm41drBfqarznvoGgPTZHTD+TP932tLD4DAy2kURmhHeAM1SwdbES8D
         IYB6thK/0fQ/f7xxKX3Z1/NCwfetor3Cv4S9QTpOCsNX2COX2kgMhfL16gcRG/lSMoa4
         A2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whuOOfjkSMEKV7Nn7GWXEYtRVnaUWQrA6ny9OE81iQM=;
        b=W0BXFkKYFw89jacT1yULNLq3CLRjp+C0UxQ0sZuKL9rlyCjheX39AnGWlEiQ4UiZSH
         6VcxfXdBdCxk2GG5mNhCvwQxde85g0geTgyL8EyZxHkcZO2soiujqq45WXST4pjsGDOg
         fqBhX7P0FkOfUW7r766vu5MiYhbgD4aKBI1aet1KCW9LQ1/lu3JqNY6Xj6XkdaYCSLt1
         CanhlaAQ7oqBMuGqMEezVGBoN6ytsZLDxcbKJbq5Lx2FrEn+O3XCFScrGfjBbqdsDFUL
         sKd/g73WeGGznBQ/sVQtC2O1TipN8z1O/4C+DjIDbNCmK4pkdaAjMUbbzDuKzsqn4XxW
         R17w==
X-Gm-Message-State: AOAM533TBc8ba9BPSbh1ikYfpSxjObMAHH0lu48U+e4mLHlR/Yx9rRs/
        dm5cc8xQt56Sy3ywwLHxKBVLt7h8Hu/ltLIEHrQqj1i9
X-Google-Smtp-Source: ABdhPJzUxftSLnSukLjkwQuQcVYx66hmfZnkjGiCqTRy6t0kzb+cTJux5tTpCJFaXg4c9xFKpWABaYwvTYRxCe+xfU0=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr1556301otd.362.1601312774150;
 Mon, 28 Sep 2020 10:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <CANozA0iGDYLM9-Nm4eOxPr7TM=BYDrWRbaA4z6uB1-A3R16KfQ@mail.gmail.com>
In-Reply-To: <CANozA0iGDYLM9-Nm4eOxPr7TM=BYDrWRbaA4z6uB1-A3R16KfQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 28 Sep 2020 10:06:01 -0700
Message-ID: <CABBYNZKm2anZF1F++OGw3UA9vkL6GX-GyoPcE5cvZcqsMT566A@mail.gmail.com>
Subject: Re: Replacing malloc/memset with calloc
To:     Aravind Machiry <machiry@cs.ucsb.edu>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Aravind,

On Mon, Sep 28, 2020 at 12:12 AM Aravind Machiry <machiry@cs.ucsb.edu> wrote:
>
> Hello,
>
> There are several places (at least in sdp.c) where `malloc` and
> memset(,0,) pattern Is used. All these can be replaced with calloc for
> efficiency.
>
> Is there any specific reason why malloc/memset is preferred?

It just old code that no one bother updating so far, we do have a
macro called malloc0 which does call calloc though.

-- 
Luiz Augusto von Dentz
