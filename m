Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB866C04A68
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jul 2022 13:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiG0Nhn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jul 2022 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiG0Nhl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jul 2022 09:37:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2F33E0F
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jul 2022 06:37:36 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id w14so952527ilg.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jul 2022 06:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/wOa3CPYbRmAShI0VXNMcOx0o3X9bIcXCObGm9Al13A=;
        b=eMj37N/5XJeUvTNSKspHHMAJ78i2+PU8HvIC2gxH9gJA5vEUBY+qZfSUSTRZ5rn0Lk
         yeYHCau8xomWPRHDkavFFYKOogYMnDpwsjB+wUqXJtObbha4SHNbOSVsEYiB0Szc98Vw
         uJYSytRrI2/dmdaSKgqdSE0jCnVSAyUqK3iL7phnGnNCBeHl0E/WuiUqy7gPH18TPXkJ
         5EZa2a0rtjBt3quz5ggxaxuE0RtE+fEz9d2+g38Dy+W9vSS7GBvitg0zIvZVt80j0ZDI
         bBPkYd0TmsuefgnViV6mq3NnheuClgCw03ETYvdCZMW+oqWaH9f2Uo/YsrWvG2PVwvP0
         VBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/wOa3CPYbRmAShI0VXNMcOx0o3X9bIcXCObGm9Al13A=;
        b=4PKmbeq9b3vVTj7TFlxR7x5HABI89WySNJ3dKI7yLjKmQ/GVlTZPapj4XHhkhLfdh4
         82DMkLHcidLzpb4mVZpGp+LXNHST3xhVW7X0/hR4hlE7hNzfsr+62vSPsDOQnfpwAknm
         b6EdaHs0yR1e9jVB2muAvS9tkKf0PfQVdnSWrhZX3uLiiQ0pE4fNpIaD8vMYmCXFYeMi
         uKra18TVIix+AfPHdFhT9gdL0Jr84SFjbHlWGx7a1c+Uj3+NhIu6wCzfj2u7mQwDShfL
         viDu+02UZEgeguHzZKs0/fzb7FBTSnDZKkEsQL+Ysctse4cjOXgXBcdR+Pm78kSy/oMu
         RKEg==
X-Gm-Message-State: AJIora87OWi+f0atydklCpRxL74QUauNJUGQ0rVk/o511x60ZO1pIu+V
        DVqU2L6C6Tl5r1R7TLwLJc2GvE1yaEo=
X-Google-Smtp-Source: AGRyM1uMuYtdhMADcZx+nguR6VEUCmLVsXIKupIo6LcKGJRxYbr+rxWW7SxzemYINQUJ3ojMPWtFRQ==
X-Received: by 2002:a05:6e02:1e0b:b0:2dd:1065:30f1 with SMTP id g11-20020a056e021e0b00b002dd106530f1mr8423575ila.87.1658929056031;
        Wed, 27 Jul 2022 06:37:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.9.62.216])
        by smtp.gmail.com with ESMTPSA id f2-20020a926a02000000b002dc21dec1d9sm6792762ilc.16.2022.07.27.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 06:37:35 -0700 (PDT)
Message-ID: <62e13f9f.1c69fb81.fd496.8c42@mx.google.com>
Date:   Wed, 27 Jul 2022 06:37:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7767625105961950769=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.carpenter@oracle.com
Subject: RE: [1/2] Bluetooth: ISO: unlock on error path in iso_sock_setsockopt()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <YuEq2Aey0VOrxPB+@kili>
References: <YuEq2Aey0VOrxPB+@kili>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7767625105961950769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=663427

---Test result---

Test Summary:
CheckPatch                    PASS      3.49 seconds
GitLint                       PASS      1.67 seconds
SubjectPrefix                 PASS      1.21 seconds
BuildKernel                   PASS      35.53 seconds
BuildKernel32                 PASS      31.02 seconds
Incremental Build with patchesPASS      48.90 seconds
TestRunner: Setup             PASS      509.47 seconds
TestRunner: l2cap-tester      PASS      17.95 seconds
TestRunner: bnep-tester       PASS      6.84 seconds
TestRunner: mgmt-tester       PASS      106.23 seconds
TestRunner: rfcomm-tester     PASS      10.13 seconds
TestRunner: sco-tester        PASS      9.97 seconds
TestRunner: smp-tester        PASS      9.88 seconds
TestRunner: userchan-tester   PASS      6.87 seconds



---
Regards,
Linux Bluetooth


--===============7767625105961950769==--
