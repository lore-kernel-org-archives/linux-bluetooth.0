Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E213AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 14:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJEOCo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJEOCl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 10:02:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B116E889
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 07:02:29 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o7so10203917qkj.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Oct 2022 07:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=zoPfuJOzJdCyfrjfCuE9dC7lKeceBTQtSjDlE2WNkhc=;
        b=fqvIDpsWbHHhg70P2/4eXeede8nMoYVU35DdZHBC09AK8146XKajVYAZLQDP06x0/S
         E+08yIRyxg1SMrcH3KWRJMmHrjHDZn3lAlQQxurwPtFjDH0yHespzMm6nooWFjdEH8wN
         UDW5e6pTXWpUDDXxH3939/3tuVwwtEE1uKAPcnkZZzAKcFEy2cHr57kl+jC8qHDbr/IL
         b7XIIOnwa0yHsL2PHFHpQKlDCEqeteyczwVNp0dDqTcrpuGNk/d6g6+6vSMaaz0285aM
         qcyPfnFbdDzz/fOFPQUcuTMGmOua0ZopTGRGI4kJuwP7wRn0QCIcth35dMRaaq52ef8O
         IUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zoPfuJOzJdCyfrjfCuE9dC7lKeceBTQtSjDlE2WNkhc=;
        b=eV9z7h6wGxwf9TYfx07S+CAlyJO5bmAAABsdpdvkkHfmi9uciLXVlBlEL/7OeFMlxn
         GpLFZflM55A7dx7JydXP7Vngl1kas002l4nx7vcf+YRDQqiqw9qlH2r38B8rPON8gyKW
         JBfGiz7+F5q4UHUcVYNYrrOzoQaeIE8gyd6kZmGypljpDd4lvytYolKPl6Q+Roh7/O0p
         mLqX+30xMBHz8ku2fqpwCExAu5C98D8gcvsBvdw+5AMY+CmQ/7SZ9RU3iMydwpFUSpPk
         ZEU41R3Lgk7ucaEVVRlQuiSSlUHWXma50R8fu1JbbyS0TjAsVA8Dtopub+QfIGbWb75b
         zvIw==
X-Gm-Message-State: ACrzQf0zf8+ObTiIcp21dye2OdIcVBagO9PhkZzlS6ZvwThWJnhEdur3
        08c7YjhpLZL0ToNSlkUmrRSZ0SfE+8E=
X-Google-Smtp-Source: AMsMyM7U/p4bfY8MIyxqGJAnD1JUm/gxE2o2LrZdG3JhGN5MHZehmnQM4puHC4I82sBExpMctIGl2A==
X-Received: by 2002:a05:620a:4447:b0:6c6:c438:1ced with SMTP id w7-20020a05620a444700b006c6c4381cedmr20789349qkp.658.1664978547347;
        Wed, 05 Oct 2022 07:02:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.205.106])
        by smtp.gmail.com with ESMTPSA id hf22-20020a05622a609600b0035bb8168daesm444696qtb.57.2022.10.05.07.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:02:27 -0700 (PDT)
Message-ID: <633d8e73.050a0220.424a8.1065@mx.google.com>
Date:   Wed, 05 Oct 2022 07:02:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4960780027136856774=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v3] Bluetooth: btusb: Workaround for spotty SCO quality
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221005124936.2390-1-hildawu@realtek.com>
References: <20221005124936.2390-1-hildawu@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4960780027136856774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683218

---Test result---

Test Summary:
CheckPatch                    PASS      2.07 seconds
GitLint                       FAIL      1.14 seconds
SubjectPrefix                 PASS      0.97 seconds
BuildKernel                   PASS      34.10 seconds
BuildKernel32                 PASS      29.76 seconds
Incremental Build with patchesPASS      42.40 seconds
TestRunner: Setup             PASS      502.49 seconds
TestRunner: l2cap-tester      PASS      17.10 seconds
TestRunner: iso-tester        PASS      16.19 seconds
TestRunner: bnep-tester       PASS      6.33 seconds
TestRunner: mgmt-tester       PASS      103.52 seconds
TestRunner: rfcomm-tester     PASS      10.14 seconds
TestRunner: sco-tester        PASS      9.48 seconds
TestRunner: ioctl-tester      PASS      10.75 seconds
TestRunner: smp-tester        PASS      9.54 seconds
TestRunner: userchan-tester   PASS      6.58 seconds

Details
##############################
Test: GitLint - FAIL - 1.14 seconds
Run gitlint with rule in .gitlint
[v3] Bluetooth: btusb: Workaround for spotty SCO quality
20: B1 Line exceeds max length (271>80): "23327    ;131.399466000; HCI SCO Data IN    ; 0B 00 48 8C A3 55 4F 8A D5 56 E9 35 56 37 8D 55 87 53 55 59 66 D5 57 1D B5 54 00 01 08 AD 00 00 E0 10 00 00 00 85 C6 D5 60 E9 B5 52 94 6D 54 E4 9B 55 B1 B6 D5 62 91 B5 57 84 6D 56 E4 5B 55 75 C6 D5 51 2D B5 53 9A 6D 54 A5 1B;"
21: B1 Line exceeds max length (271>80): "23328    ; 131.399648000; HCI SCO Data OUT  ; 0B 00 48 01 C8 AD 00 00 AA DB BA AA A9 72 B4 D9 5D AF 14 53 0C 75 B0 A6 F3 8A 51 B3 54 17 B1 A6 D5 62 C5 D5 6B 35 29 8D C5 1C 56 4C 24 96 9B 8D B5 D7 1A B2 8D BC DA 3B 8C 46 AE 1D 4D A4 04 01 F8 AD 00 00 3D EC BB A9 98 8B 28;"
22: B1 Line exceeds max length (272>80): "23329    ; 131.409467000; HCI SCO Data IN    ; 0B 00 48 55 55 C6 D5 62 29 B5 57 B2 6D 54 00 01 38 AD 00 00 E0 10 00 00 00 0B 00 D5 62 55 C6 57 B2 29 B5 00 01 6D 54 00 00 38 AD 00 00 E0 10 00 00 00 92 36 D5 5A ED B5 58 6C 6D 55 B3 1B 55 6B 26 D5 52 D1 B5 54 23 6D 56 82 DB;"
23: B1 Line exceeds max length (271>80): "23330    ; 131.409629000; HCI SCO Data OUT  ; 0B 00 48 6D 5B BE DB 89 34 66 E9 FA 99 A6 6E E5 6D 9F 1A 1C 57 D2 66 92 63 98 99 A9 3B 8A 6C 3E 5B 5A 34 A4 96 E2 21 21 8C F8 88 0F 3D E0 52 48 85 18 00 01 08 AD 00 00 0C EB BA A9 A8 28 CA 9A D0 3C 33 45 4A F9 90 FB CA 4B 39;"
24: B1 Line exceeds max length (218>80): "23331    ; 131.429464000; HCI SCO Data IN    ; 55 AB 36 D5 48 A9 B5 56 AA 6D 56 D2 DB 55 75 36 D5 56 2D B5 57 5B 6D 54 00 0B 00 48 01 C8 AD 00 00 E0 10 00 00 00 5E C6 D5 56 E1 B5 56 43 6D 55 CA DB 55 7D C6 D5 5B 31 B5;"




---
Regards,
Linux Bluetooth


--===============4960780027136856774==--
