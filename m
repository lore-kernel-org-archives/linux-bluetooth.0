Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F25C05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Feb 2023 16:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjBHQiO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 11:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjBHQiH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 11:38:07 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5094E50B
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 08:38:00 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id w2so3918231ilg.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Feb 2023 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/MKd3WvkXa4VoOXv+GuI/Wavwx1PXjU+iVclLbMQq2U=;
        b=Nw+AOlH44SZxWBXUx4ay5806V4B80TLh1gejHKPfAHQjE7Gvs5VXj+ai5aChjb8GaH
         RXXhMev8KfJXuorZ0y8JPFHxT36B/kmpcmco+jOt5cYu/H9mkdIuMR6mZ6BOxGUbmiAW
         OW4+YbURFYZyeBgqNldMm2abDBBVdA5scyqOShHQhEeODL0NRJjkGQqAMQ8oXidQDS4Q
         zpJS9lcnC9Szv4ldVnZJkCrxWAQ1qetNj4V89PwQFMp3zkltd9RvEUF2WaCW1BKSJnp6
         BRdHn5An62x1R/HrtnttPFUIOhmSRnulJ0/RPV4sA8hGBJFhtf5yzJhBBicoX4KL167a
         E+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MKd3WvkXa4VoOXv+GuI/Wavwx1PXjU+iVclLbMQq2U=;
        b=KvOKTjUYh0E+E9rJ+RYEF2WxuUq/YUAxs3Xdz2UfKG87KicvAHpQy0vtJkpUVpbyk5
         N3LKoSqfSetGHdrUIszjWCI4GBBC2eShyLYsBezDoTWaaKkFZRRtocpIfPVK0tIJcxx2
         He2WVkiVdCo+tFuFBN6Qdon560UQVAQf7K+hLOlg1zboYtM/njk5RvsY7xeSsNrL4FFB
         lzkGj7cjiHpGqisC1pygO/TY25fJghHgGSqWQjyAHUMgZy16oNRt6q+s382DOSvgYEC5
         zzrGpZXPSY2dpswfirG6pBN0QmTsveIgwEiknrooww7YhuW7g2OWwKeGN01A9GFzxOU1
         fHmw==
X-Gm-Message-State: AO0yUKVXfkHYl9ZJbcg0uEP2bTHHKmPs04rz1NW1u5/9O+FpEa2gBIE9
        p6tI+ixgySlLeMoHPCFX658Vh6kGSek=
X-Google-Smtp-Source: AK7set9T8MhmCrDvs5d4Rjf2dPgPPatzqFbE46wldxVj5XRdA60svu8thhsUpo1l2inA9kEv/wln/A==
X-Received: by 2002:a05:6e02:1b06:b0:313:dffd:6268 with SMTP id i6-20020a056e021b0600b00313dffd6268mr7288695ilv.30.1675874280007;
        Wed, 08 Feb 2023 08:38:00 -0800 (PST)
Received: from [172.17.0.2] ([40.77.92.114])
        by smtp.gmail.com with ESMTPSA id m11-20020a92cacb000000b0030c68d38255sm5108607ilq.38.2023.02.08.08.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:37:59 -0800 (PST)
Message-ID: <63e3cfe7.920a0220.fb4b6.d081@mx.google.com>
Date:   Wed, 08 Feb 2023 08:37:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0712041242794528846=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bage@debian.org
Subject: RE: Bluetooth: btrtl: add support for the RTL8723CS
In-Reply-To: <20230208155220.1640-2-bage@debian.org>
References: <20230208155220.1640-2-bage@debian.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0712041242794528846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=719976

---Test result---

Test Summary:
CheckPatch                    PASS      3.06 seconds
GitLint                       PASS      0.59 seconds
SubjectPrefix                 PASS      0.19 seconds
BuildKernel                   PASS      33.43 seconds
CheckAllWarning               PASS      35.10 seconds
CheckSparse                   WARNING   39.33 seconds
CheckSmatch                   WARNING   108.99 seconds
BuildKernel32                 PASS      30.56 seconds
TestRunnerSetup               PASS      443.07 seconds
TestRunner_l2cap-tester       PASS      16.38 seconds
TestRunner_iso-tester         PASS      16.95 seconds
TestRunner_bnep-tester        PASS      5.46 seconds
TestRunner_mgmt-tester        PASS      109.76 seconds
TestRunner_rfcomm-tester      PASS      8.68 seconds
TestRunner_sco-tester         PASS      8.12 seconds
TestRunner_ioctl-tester       PASS      9.59 seconds
TestRunner_mesh-tester        PASS      6.93 seconds
TestRunner_smp-tester         PASS      8.09 seconds
TestRunner_userchan-tester    PASS      5.73 seconds
IncrementalBuild              PASS      34.60 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============0712041242794528846==--
