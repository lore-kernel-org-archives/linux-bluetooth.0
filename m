Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACE0C7EE32
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 12:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjE3M4H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 08:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjE3M4E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 08:56:04 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5890DFC
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 05:55:31 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-19edebe85adso3866775fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685451316; x=1688043316;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:mime-version:from:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydfqnBT/MH5jWAEc4HfsXF28wAlCWRUBKDBvnb36REg=;
        b=I66vNI4bNs/X74KDWDqmhz+srx0X+HipfNPlyOF8ggIgiydvkZpOHIzklEPk+eBfTY
         I9Tho+UlhxY6n2+g1NSnucEOGE5tjDj7Xab8kD0zqM/SL7BER2NXsenIoIos9zn9KHko
         CAxj8rkN4kmOwjCZSweuZku5kWSq6qqkjgnsYyQn1AH+wEqrP8NpBDWLjtmwe4/7s+Au
         /iHFR0vmIWV6ZWXpvef017t0JMkkDkkkQu1lk6M093p5vBT8lskSJGGNhu/653HrngpR
         jiomhRWZhEMLo06UmlV+4pCt0+OgPZVYAeiK5lz0GFaX4RpTKvZ48ZG8sjEqedvVfcU+
         k/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451316; x=1688043316;
        h=reply-to:references:in-reply-to:subject:to:reply-to:references
         :in-reply-to:subject:to:mime-version:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydfqnBT/MH5jWAEc4HfsXF28wAlCWRUBKDBvnb36REg=;
        b=C+85lZ4Z436Za5lgXCKRZ9K764IP8g9XZgpivGh32gW7uyhEtBEKq5Wde5SBq3ch8G
         ij8zKfBawoFu+nqq7tQ5JR7aqhxxMizVMVZVu6Bw+iZISdkZhnpSjeu+MGOjHyt/yhQB
         rnfd35t6jpCI6HswJMQ3NDRR6zdSO0ala9SeWBr8CrUi0vm2qZ716Fak51tUOZjrmEBM
         pZyBtAVUk/AxtBokNnK6F3v7HDDZLyieRKZDktbZXo5I2PLRM9qoKc2yp/5azrnTzlkK
         e0ACvOxIWAgyvfH386Eabf5S6kRI4uPN35HDvOJKKf7Vso4x7BhbFfoQ73b+/OzGikg+
         nAdA==
X-Gm-Message-State: AC+VfDzQ07v3/CdUSM1PB6TziYnzVGKFZ4KfoN6duVoOUluDA8KT4TYF
        6fOPA0uq/MKsoCQg3cQ0H6+yA6N9Txw=
X-Google-Smtp-Source: ACHHUZ7nCMCWqVRXey9JEf+8GM6KguIVAH9cwAkENwEE60V9+rC8p8fRDZI2OldUcbSo9dLJ7nVLUg==
X-Received: by 2002:a05:6870:a89d:b0:19f:6711:8e08 with SMTP id eb29-20020a056870a89d00b0019f67118e08mr1137187oab.30.1685451316263;
        Tue, 30 May 2023 05:55:16 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.174.231])
        by smtp.gmail.com with ESMTPSA id y19-20020a056830109300b006acfdbdf37csm5510969oto.31.2023.05.30.05.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:55:15 -0700 (PDT)
Message-ID: <6475f233.050a0220.c6eea.8d34@mx.google.com>
Date:   Tue, 30 May 2023 05:55:15 -0700 (PDT)
From:   bluez.test.bot@gmail.com
Content-Type: multipart/mixed; boundary="===============6988559729830396430=="
MIME-Version: 1.0
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530122629.231821-2-dragos.panait@windriver.com>
References: <20230530122629.231821-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
To:     linux-bluetooth@vger.kernel.org, dragos.panait@windriver.com
Subject: RE: Hardening against CVE-2023-2002
In-Reply-To: <20230530123944.241927-2-dragos.panait@windriver.com>
References: <20230530123944.241927-2-dragos.panait@windriver.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6988559729830396430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:987
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6988559729830396430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sock.c:980
error: net/bluetooth/hci_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6988559729830396430==--
