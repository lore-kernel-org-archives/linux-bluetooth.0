Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD3AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Feb 2022 18:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbiBASPN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241850AbiBASNN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Feb 2022 13:13:13 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD1AC06175C
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Feb 2022 10:12:54 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e16so15157598qtq.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Feb 2022 10:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KviW0KHmpr8TZlndOcYAoc0tmEB2Ni+0NoMD9fuvDk4=;
        b=l+g5GhpFYOMSxmNTzZQbYAUdV2U4zOUPZP2PeVuM06Z0pzw64DiXkxqG9YB902+yWw
         QeRv2mcJFXWLl9qV2EQM52p8C3BFqElPGWF8ZicVVCzJm2gZPF8LMVFt5TH3EUaHua7a
         PLHK7v9zDFGAFICE8yxMG0dZm7cnx5/NTDjxX16VjUWMIP9FHiToxMz+8F72plkFsi1C
         goq1bi+kyb7kUR8nG0vGzNcEyvEn5VR5kwerxyQmqDplDOMD/7ieYgQ1pbcoD0pqFyWO
         GPtDuFg0ja7vt0uxB8uSxcxirtAoU86QGO7/xAM8OwDHniBn+0TrQzPr/KdB/jT1J4af
         WbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KviW0KHmpr8TZlndOcYAoc0tmEB2Ni+0NoMD9fuvDk4=;
        b=Oy2Yazuf3knB0R1MwFWDPvPXs2zl01Myc6qT0zTgAeSZBysCPRpwy7IhIfSSazG5Ir
         L9kUuMu5Rbl/m0qKuF7LdehyhfQGbHeltwaub9j7m7l9uYVs7DQQdrif/JrTeB3KA33J
         m0c98kpKJu3CcsfiEi2lam00oZolX0iPn8MB80Jcfl71Kvf58iVj0ZislzLz7sCSvCHC
         V+jaC1seAtGbDfKcWEYUMIDIdn7zrqBhBGbx/oZOTuvG2DxBW2zRPAiny5Jazk75NVGP
         OHnoLa8ERx0GLTO0be2FhkIFspx7lUPC976yzat0mjFloa2HxpkQHGN5WuKGV91PVSH6
         kcxA==
X-Gm-Message-State: AOAM5332UwezYEGErt/eVBb/poB+0ZGnl/rtm3Forut2OOG3qWf7LoT+
        EV9CPUb1AbQHLUoHWAHwYDkTNMZnDzkezQ==
X-Google-Smtp-Source: ABdhPJzov2BejG5noWjcPjImUuNw+Y7fH3NW+UdH8yt09YWBh5uF9kyaJrVo/NUfSRPyqRVLVt6+fg==
X-Received: by 2002:ac8:5ac8:: with SMTP id d8mr14305590qtd.280.1643739173934;
        Tue, 01 Feb 2022 10:12:53 -0800 (PST)
Received: from [172.17.0.2] ([40.117.76.138])
        by smtp.gmail.com with ESMTPSA id f20sm3757415qtf.39.2022.02.01.10.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 10:12:53 -0800 (PST)
Message-ID: <61f97825.1c69fb81.739a8.15a8@mx.google.com>
Date:   Tue, 01 Feb 2022 10:12:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8352371845963031253=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, trix@redhat.com
Subject: RE: Bluetooth: hci_sync: fix undefined return of hci_disconnect_all_sync()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220201174256.1690515-1-trix@redhat.com>
References: <20220201174256.1690515-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8352371845963031253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=610424

---Test result---

Test Summary:
CheckPatch                    PASS      1.70 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      37.44 seconds
BuildKernel32                 PASS      32.39 seconds
Incremental Build with patchesPASS      44.16 seconds
TestRunner: Setup             PASS      604.98 seconds
TestRunner: l2cap-tester      PASS      16.73 seconds
TestRunner: bnep-tester       PASS      7.82 seconds
TestRunner: mgmt-tester       PASS      129.30 seconds
TestRunner: rfcomm-tester     PASS      9.40 seconds
TestRunner: sco-tester        PASS      9.86 seconds
TestRunner: smp-tester        PASS      9.72 seconds
TestRunner: userchan-tester   PASS      8.10 seconds



---
Regards,
Linux Bluetooth


--===============8352371845963031253==--
