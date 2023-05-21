Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4199BC77B73
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 16:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjEUQkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 12:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjEUQkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 12:40:23 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50054FD
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 09:37:48 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6af6db17a27so401127a34.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684687067; x=1687279067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0la8O521rfajwlsx3B90CMvlzQ/tO0FDB+T8vxJpjOQ=;
        b=g6L+u5aXtwT5qLrve926dY9PBfeJUurMGVc833YgABMZ9w5HHzrpXHzTLm9VMFLNDH
         8bExCVKEaiOkolD+fM+dNXpmF8i5mFKJLnPYYw3uczIz9Ly/xLtZQ4ubZpRNnC5vcJEt
         3VqENiu3JxRJB/ixINqMYP5PFVO1kyrBN0gzGYOvz5l5a8TTwvFbJsRQO8v+IsR8XdWg
         Xj6yr8IdCMnQ0YpD0RP2WVeDJxBwr+F4FD/4AjDWd5ptOKvjsr/IarTKHS3KN9anBcVS
         qnqblSeFopuHwlMqJNMnS3lc/PzvhrxTU9DERtobw7QS6pDkILuGY4gLp/zVqFZDEV1G
         +t6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684687067; x=1687279067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0la8O521rfajwlsx3B90CMvlzQ/tO0FDB+T8vxJpjOQ=;
        b=OE0sl7mXZiZ+3DCYFAcNcANwzbFX1P/uo2sB2ejCsCldnIZLUmkU/hwrA5jkAgdxo/
         Xxj0cDKB+ahjeZWilkfIdEkr/mSqq7U2SdYVTazULG2QqPUoKipUIrAwi7uAxvVys3F/
         S0f8/t2u8cZiLEA2v+HbIPa057GIkYR9xbuVzozGsNug/YveWzqlTZfAEEHkpb9DRxxD
         9qIo83/9rxqWXgiy9HlJLTXzVgaTUgQ1kGahSbzl5TOWRi3jAn3kKwXWOA6evFDZm06q
         snpQtLXYfnH7hZCtY9nQE1Y6jui0idCKEbhXF2g/WlzbZwKkjzM6Rv/V2Xl1IB/FCM/E
         In3w==
X-Gm-Message-State: AC+VfDxnA7qUTMNsZb/8n2yBPDc07iSNFauMCQh4/0LCCT5DW6TGDBFQ
        avdCrEFfvERFyoBJS0x5buqS6NvUo2w=
X-Google-Smtp-Source: ACHHUZ6QCz//SAVQmveq7LwxvY5bQk0IROSb0nkHOKsoAkNyMEtJXz/08DD+U93AN2KMmQ/4R6ztKw==
X-Received: by 2002:a05:6830:4dc:b0:6ab:8a:1cd9 with SMTP id s28-20020a05683004dc00b006ab008a1cd9mr4566570otd.12.1684687067466;
        Sun, 21 May 2023 09:37:47 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.23])
        by smtp.gmail.com with ESMTPSA id p1-20020a9d76c1000000b006a973ec4660sm1536187otl.78.2023.05.21.09.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 09:37:47 -0700 (PDT)
Message-ID: <646a48db.9d0a0220.aba4c.5518@mx.google.com>
Date:   Sun, 21 May 2023 09:37:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2892317075068852800=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: hci_sync req_complete_skb does not get called?
In-Reply-To: <6f0674a4bafc17ab4ab34b0fec99f9e4a1312a90.1684684404.git.pav@iki.fi>
References: <6f0674a4bafc17ab4ab34b0fec99f9e4a1312a90.1684684404.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2892317075068852800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: tools/iso-tester.c:2303
error: tools/iso-tester.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2892317075068852800==--
