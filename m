Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA592C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6698820773
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 11:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtK84m7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKWLEh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKWLEg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 06:04:36 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C91C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 03:04:36 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id t13so15510927ilp.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2020 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RmVVqtSJagzRgsqsgV42uEBoYapVc7ymVmj8Ivc0uRo=;
        b=BtK84m7OtyRar51ENZrvXCbuPQvuwcXwrjpEuabWlQxi2IEFV7dAqPeVgvgoVfwRBJ
         kC964ZyvWq29pjacOJwFqVRZicUFCbgOicU/4H7mAdIkU3SlxUzDdouwgChKl2XdA9Rj
         piqrwM1/zr20sDhoLVL9n02ms/kJ43FxiLYYmRT4wS/h1dwz47Z1TbEaEQ5PbfkK4ghk
         qO7OiulPqGkMRXTuTR5mJSQDYStPf72af4Y322ArlEGLegM0l17oqeZ83Jb9ZOIyhSNQ
         +FRo/FqGc0cKMHNuSN7OZ9LHFMIDkHOb/ECjEsDr8Idr0In5RUkGnbW7jJlt2KW3tHsa
         bPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RmVVqtSJagzRgsqsgV42uEBoYapVc7ymVmj8Ivc0uRo=;
        b=ICKQ8xioZtgqQsY47tkR75twI51ie3MS6anHJjcXazmd9a0mdd00UNKcsgq8Qy4uSK
         j+8ULjQHbkiIixzj+Zl7neiapUES8SXiIgLwByPiEcy0Pq4I6McCL4q/e3IwKYJxyKmi
         jXHYy1lvcwaVtnNsyrqOsc6xThiXcoeJIC15pMPCMU3O+ERQ384+TgCEPpU63CtsCJva
         fvYB6oK2nCitAzWPolfGW6j0BibN/f/wz0DL09Y9aQPCo0RnWdKJ9qu9uiYv4gnqUs/I
         ykOCguqs+Pg16E7q+I4zUuDDW8taqcJJBX40xPBGQ0anp5jeBxJGPss7IKWADrGvFCze
         J/KQ==
X-Gm-Message-State: AOAM532QqmCUF7KBTSXyjuZgHWd/aGsRsxOw/O0MZmey0UCdx4dXLHNo
        eqkdvpRjPy1/CUC9AbcGxcYUWPnGWs8=
X-Google-Smtp-Source: ABdhPJyllSgnO/kD/NQVR3OP146iuGQMneRwCNnZv/Koqi7AOpZNTkhKKWZxxC0SJ7S1cZCRwCOreQ==
X-Received: by 2002:a92:d811:: with SMTP id y17mr35773548ilm.107.1606129475702;
        Mon, 23 Nov 2020 03:04:35 -0800 (PST)
Received: from [172.17.0.2] ([52.179.176.107])
        by smtp.gmail.com with ESMTPSA id n10sm5996009iom.36.2020.11.23.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:04:35 -0800 (PST)
Message-ID: <5fbb9743.1c69fb81.0713.4361@mx.google.com>
Date:   Mon, 23 Nov 2020 03:04:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4465879550858219847=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: btusb: 2 fixes for handling of fake CSR USB dongles
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201123101308.7291-2-hdegoede@redhat.com>
References: <20201123101308.7291-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4465879550858219847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=389341

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134
1: T1 Title exceeds max length (91>72): "Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134"
17: B1 Line exceeds max length (98>80): "Fixes: cde1a8a99287 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")"

Bluetooth: btusb: Add workaround for remote-wakeup issues with some fake CSR controllers
1: T1 Title exceeds max length (88>72): "Bluetooth: btusb: Add workaround for remote-wakeup issues with some fake CSR controllers"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============4465879550858219847==--
