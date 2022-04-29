Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B4FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Apr 2022 12:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356313AbiD2MGE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Apr 2022 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbiD2MGD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Apr 2022 08:06:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C256C37
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Apr 2022 05:02:45 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y3so5481857qtn.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Apr 2022 05:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=SstPgasRIgU1OkRSVX5+voo9qBznetTY7Fv/nZunjMk=;
        b=X4iwAnLtJwAq781OPHsVQhGis6e33fJp8XMXAd8Pnc9RBonnWRTY02oFnoTFtOlYcX
         Dj8K4mjADiBeD+FMeNfWKiEug4cPHVfB+tJIxgwg0cCszLWNRme0wbYnrJWyvwOwhQf8
         zPkde0Ev27SVEYFO3sxNgP8kQnYekHaWuEDkhkaJmBv/sRZCXzk0DE3lQM3xVOK20juD
         Rm6XqNAj2gQqLOh8hwDUgRwy9Waa0Q8gn3es9Ms6exYbdx9srIb9cV7nh4lwjl80RoZm
         kENnBS9qU7pSO63FbNkYF9/wbYzQkJnQ0a3k4Y8vgPQte3ob8yM5NGJ43LdcPqeemBtN
         fM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=SstPgasRIgU1OkRSVX5+voo9qBznetTY7Fv/nZunjMk=;
        b=7XeYGxcgCzIIz1/kUDtaulqiaWyBZiBjO8SNyzHpDLz506YuUnRMLpM2QrLMF2Ax/a
         Cj+Ff+MC0uSipGCAgKZZSlQ58G2ZalwLRjpZB+nzx8S66n2JiKzS/2Ey7++faflo7d8V
         +yBdBYaNm1iGCiWqDvndLcVAffoeysFwJhkK2tAWG/mKlQC+Sgngqc/KFbXU5AasFCb9
         kizJ4uGzv8qEczSIRxpTKEb/2ntxTuaUNvnll8QBynwRyl6ZA+HE0xXvE+7spkZugW3B
         QqLG7+t6/ap/49ekmn2MaaSDfNwOeIzsxxIyDJvRIUqLwrER1heQeP3R49nB1NNtwnTD
         L7mw==
X-Gm-Message-State: AOAM532mIhS2Bj71QadEDOZXhEi5b7aUI75B3ai3KJ4apCY+ydAfro76
        b17YrSawvfO22pQhjjFACexYUvOmMXTlzg==
X-Google-Smtp-Source: ABdhPJzL68YVJYBaD1TgJRiE+pIygsGBS8dORDhkmwgRqjy1N50Lo8B7W8PB1kmTt1UliMKZgPmpnA==
X-Received: by 2002:a05:622a:16:b0:2f3:99ba:9842 with SMTP id x22-20020a05622a001600b002f399ba9842mr387211qtw.411.1651233764163;
        Fri, 29 Apr 2022 05:02:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.72.29])
        by smtp.gmail.com with ESMTPSA id h186-20020a376cc3000000b00699c789a757sm1345190qkc.132.2022.04.29.05.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:02:43 -0700 (PDT)
Message-ID: <626bd3e3.1c69fb81.85bcc.7e64@mx.google.com>
Date:   Fri, 29 Apr 2022 05:02:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6438334304583584559=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jtornosm@redhat.com
Subject: RE: btusb: CSR chip hangs when unbound
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220429114113.356263-1-jtornosm@redhat.com>
References: <20220429114113.356263-1-jtornosm@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6438334304583584559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=636921

---Test result---

Test Summary:
CheckPatch                    FAIL      2.40 seconds
GitLint                       FAIL      0.98 seconds
SubjectPrefix                 FAIL      0.83 seconds
BuildKernel                   PASS      40.73 seconds
BuildKernel32                 PASS      36.23 seconds
Incremental Build with patchesPASS      48.50 seconds
TestRunner: Setup             PASS      588.54 seconds
TestRunner: l2cap-tester      PASS      19.99 seconds
TestRunner: bnep-tester       PASS      7.46 seconds
TestRunner: mgmt-tester       PASS      116.45 seconds
TestRunner: rfcomm-tester     PASS      11.38 seconds
TestRunner: sco-tester        PASS      11.05 seconds
TestRunner: smp-tester        PASS      11.04 seconds
TestRunner: userchan-tester   PASS      7.56 seconds

Details
##############################
Test: CheckPatch - FAIL - 2.40 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
btusb: CSR chip hangs when unbound\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#72: 
for CSR chip when usb device is unbound. Besides, "skip_unconfigure"  sysfs 

ERROR:OPEN_BRACE: that open brace { should be on the previous line
#94: FILE: drivers/bluetooth/btusb.c:4837:
 		if (le16_to_cpu(udev->descriptor.idVendor)  == 0x0a12 &&
 		    le16_to_cpu(udev->descriptor.idProduct) == 0x0001)
+		{

ERROR:CODE_INDENT: code indent should use tabs where possible
#99: FILE: drivers/bluetooth/btusb.c:4842:
+                         * index 0 (unconfigure) is sent, avoid this at least$

ERROR:CODE_INDENT: code indent should use tabs where possible
#100: FILE: drivers/bluetooth/btusb.c:4843:
+                         * if it is unbound */$

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#100: FILE: drivers/bluetooth/btusb.c:4843:
+                         * if it is unbound */

ERROR:CODE_INDENT: code indent should use tabs where possible
#128: FILE: drivers/usb/core/sysfs.c:1193:
+                                      struct device_attribute *attr, char *buf)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#128: FILE: drivers/usb/core/sysfs.c:1193:
+                                      struct device_attribute *attr, char *buf)$

ERROR:CODE_INDENT: code indent should use tabs where possible
#143: FILE: drivers/usb/core/sysfs.c:1208:
+                                      struct device_attribute *attr,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#143: FILE: drivers/usb/core/sysfs.c:1208:
+                                      struct device_attribute *attr,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#144: FILE: drivers/usb/core/sysfs.c:1209:
+                                      const char *buf, size_t count)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#144: FILE: drivers/usb/core/sysfs.c:1209:
+                                      const char *buf, size_t count)$

WARNING:SSCANF_TO_KSTRTO: Prefer kstrto<type> to single variable sscanf
#150: FILE: drivers/usb/core/sysfs.c:1215:
+	if (sscanf(buf, "%d", &val) != 1 || val < 0 || val > 1)
+		return -EINVAL;

total: 6 errors, 6 warnings, 83 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12831884.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.98 seconds
Run gitlint with rule in .gitlint
btusb: CSR chip hangs when unbound
7: B2 Line has trailing whitespace: "The reason is CSR chip hangs when usb configuration command with index 0 "
10: B2 Line has trailing whitespace: "To avoid this unwanted result, it is necessary not to send this command "
11: B2 Line has trailing whitespace: "for CSR chip when usb device is unbound. Besides, "skip_unconfigure"  sysfs "
16: B2 Line has trailing whitespace: "On the other hand, this is not important if usb device is going to be bound "


##############################
Test: SubjectPrefix - FAIL - 0.83 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============6438334304583584559==--
