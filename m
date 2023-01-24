Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F078CC54E94
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 18:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjAXSjy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 13:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjAXSjx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 13:39:53 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74EA4F368
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 10:39:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so12559538pji.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 10:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z8GmxxVNvKWbhbaffkd7t4Rf+9RiycemmXtdA1MHtA0=;
        b=Ys/caYpi6deRUI4aEwjetSiCzALqRN0EFxtJtO0fg2fr78lUeZ3EQTJ3AcfDaVlz6P
         /RkdotHz449Cs7eyfvsENpO4q4oIduL5eC5OF1al0muM0liJYl+XcTV5GAtxD8tGrECj
         iYby6mtFojLIjcL7x79hHpOObeFyjf5zi8TSdO+p183/uK0b4PnwAKCEJ+Jze3w9zW9Q
         dTaK+Dk8atKptkcSyjHMLz8+JDYe5q5tdA3cKdITuZ5Lj201/KtUY5XhcYXV9wPf7Ipz
         nRGJ2ZbQJ8zv3LA+iJnCSfzHBIvtJixTie93YX+V8MfJ5A8AD8FzS21zoty6DI1a4AOn
         PiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8GmxxVNvKWbhbaffkd7t4Rf+9RiycemmXtdA1MHtA0=;
        b=qWp7EhJx9wglbyMXoSb/vAfY+OiZpULMJH3ojaj2ae4F/5R5IhGYUEN3By31w/l1WM
         TcgvkTRiJnrCdqcLd548VagjT+Mvb6Q3AJX9+DVcWWatQUhf6OeqZ0m5DI7SfONG7q4+
         DEh2TFnfcy2AxyyF1/Vuqf/VjZQaZYatxJSkdMjDWAuz4QEpMUL85bp4buUFe2L0KF5G
         UPcT+YDxGgHfax6evH5ZqZgiVVE7BjFXrPPLHzRQZfQfZikFwanUZZasU9tKMfZVXkd2
         8ZAx6pk8YH+PxWBUrEG+cQrjPtyHGZ998GwVnd24KkICvHMAcDdmvJmsymleMOk5QW9i
         bsFg==
X-Gm-Message-State: AFqh2krYvJjFXxPEQIldZV0IASr10Q64QplR7YRSuNC3kw/0J+jsEkDU
        bJ1VvU8Hi2AD1X9HTrXGKHN9+BtuIaQ=
X-Google-Smtp-Source: AMrXdXvaTpG+qatddUtKcH0grTex/rbI7NovYkI4InVQKcqP3q4JU/fY9SyB0uDNAlVWwmlkodI4TQ==
X-Received: by 2002:a17:903:40ce:b0:194:d09b:7986 with SMTP id t14-20020a17090340ce00b00194d09b7986mr20646010pld.23.1674585531068;
        Tue, 24 Jan 2023 10:38:51 -0800 (PST)
Received: from [172.17.0.2] ([13.91.161.22])
        by smtp.gmail.com with ESMTPSA id io17-20020a17090312d100b0019468fe44d3sm2007662plb.25.2023.01.24.10.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 10:38:50 -0800 (PST)
Message-ID: <63d025ba.170a0220.a8969.3c6f@mx.google.com>
Date:   Tue, 24 Jan 2023 10:38:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7665679689763079474=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230124174714.2775680-2-neeraj.sanjaykale@nxp.com>
References: <20230124174714.2775680-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7665679689763079474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715211

---Test result---

Test Summary:
CheckPatch                    FAIL      5.83 seconds
GitLint                       FAIL      1.08 seconds
SubjectPrefix                 FAIL      0.69 seconds
BuildKernel                   PASS      39.91 seconds
CheckAllWarning               PASS      43.63 seconds
CheckSparse                   PASS      49.53 seconds
CheckSmatch                   PASS      131.85 seconds
BuildKernel32                 PASS      38.35 seconds
TestRunnerSetup               PASS      549.60 seconds
TestRunner_l2cap-tester       PASS      19.06 seconds
TestRunner_iso-tester         PASS      20.69 seconds
TestRunner_bnep-tester        PASS      7.06 seconds
TestRunner_mgmt-tester        PASS      131.66 seconds
TestRunner_rfcomm-tester      PASS      10.84 seconds
TestRunner_sco-tester         PASS      10.02 seconds
TestRunner_ioctl-tester       PASS      11.71 seconds
TestRunner_mesh-tester        PASS      8.73 seconds
TestRunner_smp-tester         PASS      9.67 seconds
TestRunner_userchan-tester    PASS      7.27 seconds
IncrementalBuild              PASS      45.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,1/3] serdev: Add method to assert break
WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#124: FILE: drivers/tty/serdev/core.c:413:
+		return -ENOTSUPP;

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#147: FILE: drivers/tty/serdev/serdev-ttyport.c:256:
+		return -ENOTSUPP;

WARNING: function definition argument 'struct serdev_controller *' should also have an identifier name
#171: FILE: include/linux/serdev.h:95:
+	int (*break_ctl)(struct serdev_controller *, unsigned int);

WARNING: function definition argument 'unsigned int' should also have an identifier name
#171: FILE: include/linux/serdev.h:95:
+	int (*break_ctl)(struct serdev_controller *, unsigned int);

WARNING: function definition argument 'struct serdev_device *' should also have an identifier name
#179: FILE: include/linux/serdev.h:206:
+int serdev_device_break_ctl(struct serdev_device *, int);

WARNING: function definition argument 'int' should also have an identifier name
#179: FILE: include/linux/serdev.h:206:
+int serdev_device_break_ctl(struct serdev_device *, int);

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#189: FILE: include/linux/serdev.h:262:
+	return -ENOTSUPP;

total: 0 errors, 7 warnings, 65 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13114425.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v1,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#112: 
new file mode 100644

total: 0 errors, 1 warnings, 67 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13114426.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B1 Line exceeds max length (86>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============7665679689763079474==--
