Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474FBC636D3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjA3SgE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbjA3SgD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:36:03 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC155A0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:35:52 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id l7so3632588ilf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JVOXOqeBkUzv7w+DJXVYtSV7Tudb+bW9b2tA1Y6leoE=;
        b=DEBjFKjzXLR42YqXh/3YiB+fLpeBIvrrKiZANML0r1FMrdUxR9PbqOo770gLCwXEpP
         WihyafAWWDBmoiqoAboOwQpAmjUoWvyP08gaRUls43Pumup+YjWS9RGK6JwLRb19nUy9
         8C6snehz0vceqrErbniof1asS/chJqtnFgFBtsSUkqtnd7XRTRWuENOj+YIZmRMvLnsi
         yXSBiWk9aZskKFswrFcovyizEoC9jPFCDhRn7XfYxkBHr0LyUu7z3EB/YWpfuWE2ixJn
         n5SIF24MYIU/0WZ3eN6UpRpczP1jbTVHJ2/DWKMBO1D4l9tqklp/UVbwsHyJsKHp+r6T
         Jjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVOXOqeBkUzv7w+DJXVYtSV7Tudb+bW9b2tA1Y6leoE=;
        b=hCwfMBauWpcUnnaxcuySsWwqpSQF0/hX1L1KRg8Ob4kEOs7LDEtaCM77+tjhonsN/B
         lRhNNnQLKvUtiGAUHvXRbkgyG4jBpkRIw+7GiAINKgZzlhWD3jAUa58joGXaFsGJtJSh
         l4xEZKHC4dsSA0XcujS2jc+evoqT7GRfXY7MbuLga2SoIq2uTQbmsDqhw1hZpoIZZnkP
         dgSt2bAB1YbFlSux6nIq1Z8nZE0BdvejTK4PQrq/RB9puFKFPS1jOiWVLC0WvWH/0IaU
         CpoYWyehF4GhwKQT8wddI7D0NcfIaLP6MsG4gYBuyjBIM5YPyWf+ATtD/D8wsWgYgeV8
         /9XQ==
X-Gm-Message-State: AO0yUKXOf4jHXXNBADEPrcjRRx1GZJQ9qk7ajGg1RlmaN6Q+EgFXCUwV
        VyAlUTkUlFTGVhGXfNlGR5d92AMpBfg=
X-Google-Smtp-Source: AK7set/kAG1vrQC52GBV2JZD7ya3GSo1Js2onlpKP0Th9iGHKgGqtuYaBvtNbkmpgodNw2NoQoTvaQ==
X-Received: by 2002:a92:ca4d:0:b0:310:fdd5:c2ab with SMTP id q13-20020a92ca4d000000b00310fdd5c2abmr2467535ilo.27.1675103751293;
        Mon, 30 Jan 2023 10:35:51 -0800 (PST)
Received: from [172.17.0.2] ([40.77.92.209])
        by smtp.gmail.com with ESMTPSA id p9-20020a02b009000000b003a601f9938asm4844807jah.178.2023.01.30.10.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:35:51 -0800 (PST)
Message-ID: <63d80e07.020a0220.c8278.909c@mx.google.com>
Date:   Mon, 30 Jan 2023 10:35:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3190591323489983533=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: Add support for NXP bluetooth chipsets
In-Reply-To: <20230130180504.2029440-2-neeraj.sanjaykale@nxp.com>
References: <20230130180504.2029440-2-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3190591323489983533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=717061

---Test result---

Test Summary:
CheckPatch                    FAIL      4.92 seconds
GitLint                       FAIL      1.21 seconds
SubjectPrefix                 FAIL      0.57 seconds
BuildKernel                   PASS      32.32 seconds
CheckAllWarning               PASS      34.84 seconds
CheckSparse                   PASS      39.59 seconds
CheckSmatch                   PASS      109.75 seconds
BuildKernel32                 PASS      30.92 seconds
TestRunnerSetup               PASS      432.43 seconds
TestRunner_l2cap-tester       PASS      16.18 seconds
TestRunner_iso-tester         PASS      16.69 seconds
TestRunner_bnep-tester        PASS      5.44 seconds
TestRunner_mgmt-tester        PASS      107.72 seconds
TestRunner_rfcomm-tester      PASS      8.74 seconds
TestRunner_sco-tester         PASS      7.93 seconds
TestRunner_ioctl-tester       PASS      9.32 seconds
TestRunner_mesh-tester        PASS      6.77 seconds
TestRunner_smp-tester         PASS      7.81 seconds
TestRunner_userchan-tester    PASS      5.73 seconds
IncrementalBuild              PASS      36.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/3] serdev: Add method to assert break
WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#126: FILE: drivers/tty/serdev/core.c:413:
+		return -ENOTSUPP;

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#149: FILE: drivers/tty/serdev/serdev-ttyport.c:256:
+		return -ENOTSUPP;

WARNING: function definition argument 'struct serdev_controller *' should also have an identifier name
#173: FILE: include/linux/serdev.h:95:
+	int (*break_ctl)(struct serdev_controller *, unsigned int);

WARNING: function definition argument 'unsigned int' should also have an identifier name
#173: FILE: include/linux/serdev.h:95:
+	int (*break_ctl)(struct serdev_controller *, unsigned int);

WARNING: function definition argument 'struct serdev_device *' should also have an identifier name
#181: FILE: include/linux/serdev.h:206:
+int serdev_device_break_ctl(struct serdev_device *, int);

WARNING: function definition argument 'int' should also have an identifier name
#181: FILE: include/linux/serdev.h:206:
+int serdev_device_break_ctl(struct serdev_device *, int);

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#191: FILE: include/linux/serdev.h:262:
+	return -ENOTSUPP;

total: 0 errors, 7 warnings, 65 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13121548.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,3/3] Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets
WARNING: MAINTAINERS entries use one tab after TYPE:
#171: FILE: MAINTAINERS:22843:
+F:      drivers/bluetooth/btnxpuart*

WARNING: line length of 102 exceeds 100 columns
#257: FILE: drivers/bluetooth/btnxpuart.c:45:
+										u32 plen, void *param)

WARNING: line length of 101 exceeds 100 columns
#656: FILE: drivers/bluetooth/btnxpuart.c:444:
+										(char *)&uart_config,

WARNING: line length of 106 exceeds 100 columns
#657: FILE: drivers/bluetooth/btnxpuart.c:445:
+										sizeof(uart_config) - 4));

WARNING: line length of 103 exceeds 100 columns
#677: FILE: drivers/bluetooth/btnxpuart.c:465:
+										sizeof(nxp_cmd7) - 4));

WARNING: Missing a blank line after declarations
#691: FILE: drivers/bluetooth/btnxpuart.c:479:
+	struct nxp_bootloader_cmd *hdr = (struct nxp_bootloader_cmd *)buf;
+	return __le32_to_cpu(hdr->payload_len);

WARNING: Block comments should align the * on each line
#745: FILE: drivers/bluetooth/btnxpuart.c:533:
+		/* The CRC did not match at the other end.
+		* That's why the request to re-send.

WARNING: Block comments should align the * on each line
#752: FILE: drivers/bluetooth/btnxpuart.c:540:
+		/* The FW bin file is made up of many blocks of
+		* 16 byte header and payload data chunks. If the

WARNING: Block comments should align the * on each line
#763: FILE: drivers/bluetooth/btnxpuart.c:551:
+			/* All OK here. Increment offset by number
+			* of previous successfully sent bytes.

total: 0 errors, 9 warnings, 1401 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13121550.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/3] dt-bindings: net: bluetooth: Add NXP bluetooth support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B1 Line exceeds max length (86>80): " create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.yaml"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3190591323489983533==--
