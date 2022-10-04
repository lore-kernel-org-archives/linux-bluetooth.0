Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471EBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 10:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiJDKNI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 06:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJDKNG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 06:13:06 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD9E29CA8
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 03:13:05 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a2so6580644iln.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Oct 2022 03:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=qzKSg64Xf1srfELw0M4P6sswwnbibKiggqTO7BD5Awo=;
        b=anJbaSpxbEUTkuoR76nP2J8sHHUO6yaNnLA00q1+BmnH5dfTfjcg9DXUdCM/uqWNvV
         shc1vZ5bya0++RdPt1bHSO6VNoI7IYN3iB0ZfRxD/Uk5a39Q04WG+5yIkli+PVdKUIre
         +KNbEUJGuizsaOA/0sQ/TtYyzOsDVbL4/v+0DhOEYJOJLDUHRha++TsHlR4JDSKOzlAW
         LQ7kk7iqxbdHSJgvBhcHtzMnfjV+JGeFMNOenVVFLeFx6qXw5/6/XRyY/aa9y5oU35q6
         VfSexvJkwXiV0A395wLg+c1MbqaYE2dohmh45iQPIOZzj+MBqMK5OgCR071rGsFhbg4p
         mMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=qzKSg64Xf1srfELw0M4P6sswwnbibKiggqTO7BD5Awo=;
        b=Uxif6bi4EYfTmV1rFHM9XzPt8aMnOmNExwZY3Zog4DmK0x5Fj1+Xf89Mq0E/7ya7bo
         MqHZ9VMpWYGfxf4XZzIIf5LFP/zfsYZ19wlnKUvPh8TOAS+lwvkEbDQUVoH2SArg/d5W
         tyZLgS7uBE8qUbh8dzOs3M9WVsmJgWOQvMqQrYvBQxqxRdXD4MvVzcWFfomLT1BCJ0JA
         aB60ZwHw00vD1pU2jesm7YMqKiojqw6GqORY2V226cpbd8z7OxTjEzTgxjoN859hN0YX
         c4VCGCXFjtI9opUTwAbi6XJe97KmXPKP6PdNBFLfXiAtTPC4WohENXh/zqE5W78mDRNY
         miJg==
X-Gm-Message-State: ACrzQf0yHDH0nW6dDRDQX+gUqhVEJ8I+QAHt40Kxh539MzNw5vIO/M4m
        bRAsJcfd02LC6z8xFHpzygznUBHrNHs=
X-Google-Smtp-Source: AMsMyM4p59kEhCMzUSMI/I4jtB9QmFH+fs29n7jje0VAo/oTL8/4Di/genAuY95BIazWdPaGihTLwg==
X-Received: by 2002:a92:d742:0:b0:2eb:2b2c:d2a with SMTP id e2-20020a92d742000000b002eb2b2c0d2amr11080046ilq.21.1664878384739;
        Tue, 04 Oct 2022 03:13:04 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.17.49])
        by smtp.gmail.com with ESMTPSA id y18-20020a92d212000000b002f16e7021f6sm4792957ily.22.2022.10.04.03.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 03:13:04 -0700 (PDT)
Message-ID: <633c0730.920a0220.be88.5122@mx.google.com>
Date:   Tue, 04 Oct 2022 03:13:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6235280456830838488=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [v2] Bluetooth: btusb: Introduce generic USB reset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221004174632.v2.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
References: <20221004174632.v2.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6235280456830838488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682952

---Test result---

Test Summary:
CheckPatch                    PASS      1.87 seconds
GitLint                       FAIL      0.80 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      35.71 seconds
BuildKernel32                 PASS      29.33 seconds
Incremental Build with patchesPASS      42.42 seconds
TestRunner: Setup             PASS      500.23 seconds
TestRunner: l2cap-tester      PASS      16.58 seconds
TestRunner: iso-tester        PASS      15.56 seconds
TestRunner: bnep-tester       PASS      6.13 seconds
TestRunner: mgmt-tester       PASS      99.98 seconds
TestRunner: rfcomm-tester     PASS      9.77 seconds
TestRunner: sco-tester        PASS      9.18 seconds
TestRunner: ioctl-tester      PASS      10.33 seconds
TestRunner: smp-tester        PASS      9.27 seconds
TestRunner: userchan-tester   PASS      6.31 seconds

Details
##############################
Test: GitLint - FAIL - 0.80 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: btusb: Introduce generic USB reset
18: B1 Line exceeds max length (87>80): "ERR kernel: [  716.929206] Bluetooth: hci_cmd_timeout() hci0: command 0x0000 tx timeout"
19: B1 Line exceeds max length (109>80): "ERR kernel: [  716.929218] Bluetooth: btusb_rtl_cmd_timeout() hci0: No gpio to reset Realtek device, ignoring"
22: B1 Line exceeds max length (87>80): "ERR kernel: [  225.270048] Bluetooth: hci_cmd_timeout() hci0: command 0x0000 tx timeout"
23: B1 Line exceeds max length (89>80): "ERR kernel: [  225.270060] Bluetooth: btusb_rtl_cmd_timeout() hci0: Resetting usb device."
24: B1 Line exceeds max length (88>80): "INFO kernel: [  225.386613] usb 3-3: reset full-speed USB device number 3 using xhci_hcd"




---
Regards,
Linux Bluetooth


--===============6235280456830838488==--
