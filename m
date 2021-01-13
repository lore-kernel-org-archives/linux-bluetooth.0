Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DE9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 04:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF4523133
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 04:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhAME0p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jan 2021 23:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbhAME0p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jan 2021 23:26:45 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8CCC061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jan 2021 20:26:05 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q137so1525970iod.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jan 2021 20:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=As2A4k2vWQwbpTH+bp0EWKAwZ6fPxhh7DyUzmSfaqKc=;
        b=cSSx7QqgY8QNf7MA0MB+8SEmwvtrxmlf2qE4J1w7gGXvJakyq5gLDJo4d9bH396xq9
         fIUYnYgWoVEf7sE9SBPOYwgSDie9BeM4xIrL6MFspCML7pJegpBSN7un4X2jKovJBgvA
         tziFDLuruRd8TLrjPmIp2BUI11jat3ObylxBsCdYz/f4rowOs+lmk3RDWmjmffc2tJP3
         C9zaXmAYHntuwHoc2P/E9yFQky7JnWhCU8bTdmdjQPyLOmW2l7OX3eOReMM3V5CqlcVa
         uCZLrf76ghUjXlv3GgDlTHCo1tGfJGcy8qB/U4CG7ll8D/MJjkw4LgyFWiEzkPqTAxPp
         Pyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=As2A4k2vWQwbpTH+bp0EWKAwZ6fPxhh7DyUzmSfaqKc=;
        b=E3/5rkvKEB9HtwdVgvyCglweI5Fn9dRL0hoTw8QQehyTpbxPU2yiYRcljQxD0tHVK5
         zkQJLmJVCL55OBJN5knxdo7I/dZtUateoLG07fIu7pQ58ammZ2LpcgoX7eIKlfFA9jjj
         uwFzAR1fHq9R4286DIkRZs7yl49SzUpwoa0/C7lzw4frdvTQF94AAQ9A/DfH1ylqwYxu
         FbgqZZWZzmjO3fkuBFacUb0hYTmy+yCPEFsVKEHrGM8H1NRxk+ixPSyA2nw6kgVHbMm2
         sFaxsGayIjwU5uBtAGhObCV4/vMn+HtqqaNaRMcuRFaeGxJDg1fdSYYmWFBEN4fMVX6j
         BsPw==
X-Gm-Message-State: AOAM531nzMK7b7l+oVMj+VyqUnfeP8g8iAL33X41ZsfU1BK/B909J31l
        RGbCiPuMcGEcWg7KRglDglgITSgcz+s=
X-Google-Smtp-Source: ABdhPJz38TdX2OSbKOZYuYmCixkEOXY2qyjfCcFdSnzQm+nq1YNPRfP84QaHdBTF+Y3ddnKuzjMHIw==
X-Received: by 2002:a6b:7217:: with SMTP id n23mr185091ioc.143.1610511964546;
        Tue, 12 Jan 2021 20:26:04 -0800 (PST)
Received: from [172.17.0.2] ([20.49.47.223])
        by smtp.gmail.com with ESMTPSA id k76sm920971ilk.36.2021.01.12.20.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 20:26:04 -0800 (PST)
Message-ID: <5ffe765c.1c69fb81.f8f81.4cb4@mx.google.com>
Date:   Tue, 12 Jan 2021 20:26:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1948563130473469856=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez] core: Align parameters name of ScanAdvMonitoring
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210113115556.Bluez.1.Ib657f37256b0e7adf3915ac5341c9d20db2fd2ef@changeid>
References: <20210113115556.Bluez.1.Ib657f37256b0e7adf3915ac5341c9d20db2fd2ef@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1948563130473469856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=413561

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


--===============1948563130473469856==--
