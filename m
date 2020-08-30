Return-Path: <SRS0=5eoE=CI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D6C433E7
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 12:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39822145D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 12:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5v8ttYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgH3MYu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Aug 2020 08:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgH3MYn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Aug 2020 08:24:43 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C32C061575
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 05:24:43 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id di5so1360216qvb.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LLH7Mj3wAP9wZ/6kJgEd+cqv5coSB18fRNoZkFjthho=;
        b=a5v8ttYPL8pxPcFauREW2qtBuHWiv36lO/eTuJDxv0sGAluK5LZbhBoYzCVF2Ao9BM
         oScxqMVb2iFQCCaUVN4lQYozgyP11TvuuGyTk8Q7M431L/+xwNj3zAaZv1REOEfMriyn
         04vcAXEU6n8ZPVdXtITXWrD21Qbqn8KXs8qtkzGCKrSA6Vh408ijWqpOW2cIHE+qSSe/
         E4ph1HnkpLFkKz+I9M2yRyOnYRpVSON/lFEg7R2EHH2Cza3ld0W7Kw5+1TlxtK6GruIh
         qEw368LYjuqzldhok2WVEreSyADh3LhKHKGgtK3sctr1oSgRmciAFIUtjOphIrdF2Wqs
         ufXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LLH7Mj3wAP9wZ/6kJgEd+cqv5coSB18fRNoZkFjthho=;
        b=MwqmkeCy/IrjX9K2j7/+6pRpO7GL0DhJ7I231WNdageuqlzvW0aDRPG6sEvVWlLFox
         Hmx5H6u1uENhEhFJwKdX7L08KvE349ElyLE4c1tup2glN7WUtITJw4LMxE3to/helcMA
         mQ2RER7VuxQRTkPGyP7XVrteMVqcrxRn9VEASmKU5ncpY/J+lq8HdFQ+8jF6qlFA8cf4
         3gbJ+7l+/KBR4GrT/sAcaIobgTiriZw1BmSFAkd3p+uWLkPHQ9egeAMGQ1HURxfvTF7R
         60xNUTcMHnO87/Ej3w4Plk5U7IOVDqZLUU/lc0/QLnfcJlnS+H8OdPl4mGqkldW+yP7i
         oOew==
X-Gm-Message-State: AOAM533cFaofSewyXNpJVPWbLIlq86i4XZJBWthb+2f0PlxGFJ8EOe8R
        UBRlPubMKzZuGcS5Bf4nV0WEJKKeR8ftDA==
X-Google-Smtp-Source: ABdhPJyu6NSxzW3F70zwcLaEhsF1x9uqDi9fy1lHxlv3lLsQlJvqLNGOM1R5YNZWWzgyG+DGJbG4jw==
X-Received: by 2002:a0c:a024:: with SMTP id b33mr1536748qva.0.1598790281245;
        Sun, 30 Aug 2020 05:24:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.147.165.209])
        by smtp.gmail.com with ESMTPSA id k72sm3193084qke.121.2020.08.30.05.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 05:24:40 -0700 (PDT)
Message-ID: <5f4b9a88.1c69fb81.8664e.a201@mx.google.com>
Date:   Sun, 30 Aug 2020 05:24:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3041058955183442164=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hanzefang@gmail.com
Subject: RE: [BlueZ] hcidump: fix a crash in le_meta_ev_dump()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200830115948.GA9519@ubuntu>
References: <20200830115948.GA9519@ubuntu>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3041058955183442164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============3041058955183442164==--
