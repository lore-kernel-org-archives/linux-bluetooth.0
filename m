Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AE1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 23:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359343AbiELXE1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 19:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359130AbiELXE1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 19:04:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9065AFAD5
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 16:04:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id i20so5618882qti.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 16:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Co4Vt0nur2TUEpjIv+z+UL5CztlH+sDr5WztWAlR/+A=;
        b=LxMwpTfOaJDQPPF8DnTThfQV/JVyQiBWJt9FIeOdeXjcT0zYXTk6hOvi8CV1y3+tiX
         sxLKYtzFNpy1D0u80kWR9n71AcX5t0mwSym3pXcymr5KWLBStGi8siu7si8Bq7wpoXSQ
         iRqWZ7AVF83p8s+JNI2dKl9LhVAT32LSctC4teQ4gydm7BoYputjaSBtu4rgVXXQTomq
         G5uBtE2Snu3TIVytTU7DAUatTyhqe+QiOMXleo8HG1APgHsLqclYf9EtNJwLO+pNTHB5
         Bx2lDnAkRolObKfyvECyR3iuB5lvi9IEdffbTqtWwMgagTyo8DTdRNA7GmUxNbKuL6Jr
         ve0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Co4Vt0nur2TUEpjIv+z+UL5CztlH+sDr5WztWAlR/+A=;
        b=ANFKEbzq0IR+8IzlG9cuY5xMGpROk3TwEFZ/wrdjuZqF7pEDIMmEc1fd13ruV6WYhA
         f+o1naLsGX2SPpZV4/lNUBlRg8AN2bWZXbfGdgXSx3UsKbpk40oX6Er4ypWPoip7e8ka
         S5ogvS/X89ZuQGNrTZwplL6nGmN9IEb//etKLeouoGoJIkre91s6hqBvzEfWf40fCing
         blLEb27jGDZMZczhQT2b1RkgB4uzGwzKgsjGNoP5IbObNAsACo1ayIogRxBGiVdJ2ME9
         pm0nFaOWodaxgwoj573NWX8Uj3+8Id6Pp5kPe8Ogd14QGvvnLMHW4OHOvOGwr2w0+dE0
         chKw==
X-Gm-Message-State: AOAM532adJMvvQst6fPGnlhNhW0hfdFbUelbgUW5Y9cel2pHJGXYpedY
        2Q0pgbeIv6opD2BNOhO2tt5G2FwTzQw=
X-Google-Smtp-Source: ABdhPJwB+oPZe376uKRcVwAozj+RRKd6xUINL77Oja+0GEeWV0zsP+/85FYeWDTtzipATVoec/Iyzg==
X-Received: by 2002:a05:622a:14d:b0:2f3:cf07:3065 with SMTP id v13-20020a05622a014d00b002f3cf073065mr2171935qtw.388.1652396664823;
        Thu, 12 May 2022 16:04:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.155.219])
        by smtp.gmail.com with ESMTPSA id p62-20020a374241000000b0069fc13ce224sm434577qka.85.2022.05.12.16.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 16:04:24 -0700 (PDT)
Message-ID: <627d9278.1c69fb81.722b0.2f19@mx.google.com>
Date:   Thu, 12 May 2022 16:04:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0629406853271289154=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_REMOTE_WAKEUP
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220512223043.1020767-1-luiz.dentz@gmail.com>
References: <20220512223043.1020767-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0629406853271289154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641169

---Test result---

Test Summary:
CheckPatch                    PASS      3.26 seconds
GitLint                       FAIL      1.95 seconds
SubjectPrefix                 PASS      1.73 seconds
BuildKernel                   PASS      31.18 seconds
BuildKernel32                 PASS      28.19 seconds
Incremental Build with patchesPASS      44.65 seconds
TestRunner: Setup             PASS      466.34 seconds
TestRunner: l2cap-tester      PASS      17.44 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      100.25 seconds
TestRunner: rfcomm-tester     PASS      9.68 seconds
TestRunner: sco-tester        PASS      9.43 seconds
TestRunner: smp-tester        PASS      9.49 seconds
TestRunner: userchan-tester   PASS      6.46 seconds

Details
##############################
Test: GitLint - FAIL - 1.95 seconds
Run gitlint with rule in .gitlint
[2/2] Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan
1: T1 Title exceeds max length (81>80): "[2/2] Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan"




---
Regards,
Linux Bluetooth


--===============0629406853271289154==--
