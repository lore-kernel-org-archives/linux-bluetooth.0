Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD1C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F4964EFD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCPXh7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 19:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhCPXh1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 19:37:27 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B5CC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:37:26 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id l132so37152209qke.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=l8yJlGxgOEHoEKWKErh1LnZNn7nCYomZBvWAXPuPf2U=;
        b=jd74cqAEUiBLXqY/uH+omyQ9PCfGYX0wpiyYoysx/Qfp2jEabgvs36Zu2zuDJnXDCn
         9ru1+A/PSIKTpHrTQrIJBl3AmCaFjWbwqRFqcogsz2rx++UgfaB6jNdm/tjDW88AfRvQ
         h19gbWpj19gzjeMjISblKXTcp3QQ7G2WUUbg6hGW8jzzz0NNc5gIUQfv139ytLq9YQdi
         J4j4VTRSX8SvlTF5YnHN7rqkg6sBMuOBsYb1jGTXoDdbAURY8IIkXClnZRLKoymZv74Y
         OpsBaP5DuDp0FtHfD3DTRhjDq6Gf5p0r+E0/1+OAMjUF9wcVWGxNyyqW8gOFbNGDfMZ+
         8uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=l8yJlGxgOEHoEKWKErh1LnZNn7nCYomZBvWAXPuPf2U=;
        b=g1I6l9vH7dEbFykK2nTcvcGCmJydElRufckN2CRRJQquI8qIEcfEfEuNAu5YaojxEl
         UTv+IE24Nf0QTx7IqwH+Fi8IcQc1CJuMw6o48tNid6XZt2/hEJXWe+5pu/mRJFf7zsJc
         x0AKcQz69u6Z/RFTlhL4uVQvWI7pgS/ypOQ9axx0BrmgHw5kBqZC2VFZbpHc0zi0y0PB
         neQF4kHU4r36pLJs70EolYADvyQv355K03KQY+Eadol9Xdl4LlMrCKGJG1q8u8tAHBxn
         CtwynsBUmZhJNmBEVBRrMOpCMciel5tbEmsxAAJ1tPEYM/jWogUWEDCs+wy7u6fOxnXP
         RXEA==
X-Gm-Message-State: AOAM531GmQe360hHwEcDx3VrHKZN/h/cF2JVjo2ChyrpeJvoG1ATE6SL
        l4K4h2ZdPIL9rEgqZRsxaX1Y2kQMMW8Deg==
X-Google-Smtp-Source: ABdhPJzQCT6OtPtyC4R3YkmUhPor07InrHJbbJ6HTznQ/oNqB+Krj8xW8Ywncnskr2WUO43WRoKs8Q==
X-Received: by 2002:a37:a30f:: with SMTP id m15mr1604680qke.433.1615937845662;
        Tue, 16 Mar 2021 16:37:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.15.92])
        by smtp.gmail.com with ESMTPSA id d24sm15922647qko.54.2021.03.16.16.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 16:37:25 -0700 (PDT)
Message-ID: <60514135.1c69fb81.079b.7e61@mx.google.com>
Date:   Tue, 16 Mar 2021 16:37:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0217249455868348962=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: Expose extended adv feature support via bluez API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316162044.Bluez.v4.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
References: <20210316162044.Bluez.v4.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0217249455868348962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=449579

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


--===============0217249455868348962==--
