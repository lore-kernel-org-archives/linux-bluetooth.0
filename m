Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E0AC352A1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 02:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiLGCld (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiLGClc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 21:41:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1EB54763
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 18:41:32 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so164528pje.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Dec 2022 18:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ImB5znFjAYz559OE6Hq4NVInR4rKheqe2nZPx8EN3As=;
        b=eHbmBrqyF/Rk7Mbqg6ld6nyCL2SI8GZUd1Oq6ZJJsxLR8dtEPf6ZtFDtokB7jrilTF
         /4vY/D8BS8WjCYnJ/Ef99k1dBUFXIolMVg85SCYopEyE8XN2dj5NrEnV+e9lYqd6BHYk
         ZxX1s2FSRCq9ZGjigxOYBN8wEHG6o02OjOl/vS6HeYzS6DquItQYvw8c4pwHrgmE2sZJ
         ahG0NiDDkYjvsWM5mP5OUk+p8BMroxaeSgr3eUEbIQv7uZQURSlXPj+Te7EIj5D7FDYb
         SoX3hKUco+lIzQNgW+Fn4i6Kq3WHFutx6ccBbxl/tJlES8ME/ofyz7xSHsnSTbRtPmi3
         U42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImB5znFjAYz559OE6Hq4NVInR4rKheqe2nZPx8EN3As=;
        b=VfE6nM85p2a9nk8lcRWZG0f8t3kksRK/1FAbCEYpQaamHx5QGgdrYcnePMa29Y7+u9
         70kVEecfSsKY5EHvgVr99/4Ej3zT9c2KkkDtE6m5o8bKenG98y7mDLqh+amKqJFaU5wq
         20DbT8cqS3a84yda86VcUoEISOsSyx8TQehXTZK8/yZp5gOtyF1KjhVYuG8DkV+tYjWp
         GbkwJwjaarpUysHLY5vyYcWVvAjtYFdqu4m86DTaOMXk+6KzMHIJMJycrvufZ1/Fx6Ri
         O3Fl9AA2xaZuIehywobIq4zXeR/ThJ+mjnTeVfby7mVPdNV1tYVtzUe4KXHk0PK0bfbM
         tnbA==
X-Gm-Message-State: ANoB5pkaSsA4wj+hCbG2hSiZU9WINE5pH4ue4nWqjrsAcqJKfJhoW9Ds
        hcOBTvxoq/NDpbJqlaqUcphAl7XHV1I=
X-Google-Smtp-Source: AA0mqf6ihbVP9YGFbg8Eak0SsIcptdiLzOvDJ0sA1rmPIfhM1Nw0JqIHCd5VYFUHW+iTg2lX7GRyKA==
X-Received: by 2002:a17:90a:2e0c:b0:218:c1d3:4cd8 with SMTP id q12-20020a17090a2e0c00b00218c1d34cd8mr77586096pjd.37.1670380891463;
        Tue, 06 Dec 2022 18:41:31 -0800 (PST)
Received: from [172.17.0.2] ([168.61.5.40])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a6d0200b0020d24ea4400sm64571pjj.38.2022.12.06.18.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 18:41:31 -0800 (PST)
Message-ID: <638ffd5b.170a0220.b1c2f.034f@mx.google.com>
Date:   Tue, 06 Dec 2022 18:41:31 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3757339681285001143=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Avoid circular locking dependency
In-Reply-To: <20221207013501.4162096-1-luiz.dentz@gmail.com>
References: <20221207013501.4162096-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3757339681285001143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=702363

---Test result---

Test Summary:
CheckPatch                    PASS      0.59 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      35.19 seconds
BuildKernel32                 PASS      31.79 seconds
TestRunnerSetup               PASS      437.89 seconds
TestRunner_l2cap-tester       PASS      16.29 seconds
TestRunner_iso-tester         PASS      16.04 seconds
TestRunner_bnep-tester        PASS      5.57 seconds
TestRunner_mgmt-tester        PASS      108.97 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         PASS      8.98 seconds
TestRunner_ioctl-tester       PASS      10.23 seconds
TestRunner_mesh-tester        PASS      7.03 seconds
TestRunner_smp-tester         PASS      8.72 seconds
TestRunner_userchan-tester    PASS      5.83 seconds
IncrementalBuild              PASS      32.32 seconds



---
Regards,
Linux Bluetooth


--===============3757339681285001143==--
