Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBDBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 19:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbiCaTP0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiCaTPS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 15:15:18 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D7B189
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 12:13:24 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g8so360635qke.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=q4cudOYJJnbYU5prewcdU0h03kAhfUtCvRf0knDUvMo=;
        b=ehcWDw6MfGiFrqpZsOUvj7+aT99Fs0i6zEt82tWZcFEdIHEc0fRoD531yangibPkPn
         uWl9J4uUqM1hZCvtv+aGqHYNlx/xF8RrukOBmQee8Mu9uOlwPRyngPLksGzjGfllTysM
         l35JHMFMgCfc84824i2AbRuaFdoMsNed+Qyi0dVVNEc5GPU6CLKpCRTIGNrae35zX9IU
         cp7Hn4PMj8Ik7hXuGHZOsvP2SqjLCrlNu4QnWteYpdMQVXQTsZq/HxuLt2hvngnEl+LD
         Ph5DMsNtb005HRizGdCUiB6HoodFq7yTSnNDZbFbHI3QvkFd664oRQR5xpywzAB1hPhk
         9uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=q4cudOYJJnbYU5prewcdU0h03kAhfUtCvRf0knDUvMo=;
        b=4V01n+KsR674RZrWYVCyjQEsyby8mmQ4+/pL9rlye9W44Ewb4ho+1LRocxlsWYg3GE
         sXD8Kwr/gSeNV8eCML3Pa3p/RiJwY9Ly4oUUS808YnQr8IdrLI8MX5k78CIJI1lKzRx3
         1QkjIDh+LAFJ2Zei9184NddFWVgHfqiK15XcTP4c0BcswX9y6ES9c5zgurLs/7E7WKPN
         wPeDyx0qBc1wmmUi4UcV4bVuJkV587NCKHenZmCRNfP78Yxc2SaLNmJe/Jfd6TjAdy37
         e618M7qHjw5eFbvo3mvlUDaK9fJ2U9lt7uVkeRPQKxevYdqrITvHxQXn1SoUYS91m/pj
         YjqA==
X-Gm-Message-State: AOAM532SeaIPW0uMuzc1aP0YmDCKX1a3a92/uJql/C+B/5Xu1TbGHduv
        9nw4xB+QvviHW8dopvMh/GTvoHogeCI=
X-Google-Smtp-Source: ABdhPJyS1zMD1+GqHaFqnsyku5LnfRB2+oO/o6rkDFlDc8xwaZlrSc+8OfG8dT1I+D4ZT57lifR7RQ==
X-Received: by 2002:a05:620a:1a99:b0:680:f33c:dbd3 with SMTP id bl25-20020a05620a1a9900b00680f33cdbd3mr4382379qkb.17.1648754003477;
        Thu, 31 Mar 2022 12:13:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.45.211])
        by smtp.gmail.com with ESMTPSA id x18-20020a05622a001200b002eb856d7786sm131172qtw.84.2022.03.31.12.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:13:23 -0700 (PDT)
Message-ID: <6245fd53.1c69fb81.422be.112c@mx.google.com>
Date:   Thu, 31 Mar 2022 12:13:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0403375580905212255=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add Mesh functionality to net/bluetooth
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220331180749.456913-2-brian.gix@intel.com>
References: <20220331180749.456913-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0403375580905212255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627934

---Test result---

Test Summary:
CheckPatch                    FAIL      8.65 seconds
GitLint                       PASS      3.18 seconds
SubjectPrefix                 PASS      2.83 seconds
BuildKernel                   PASS      37.04 seconds
BuildKernel32                 PASS      34.36 seconds
Incremental Build with patchesPASS      107.50 seconds
TestRunner: Setup             PASS      556.09 seconds
TestRunner: l2cap-tester      PASS      18.26 seconds
TestRunner: bnep-tester       PASS      7.21 seconds
TestRunner: mgmt-tester       FAIL      116.15 seconds
TestRunner: rfcomm-tester     PASS      9.51 seconds
TestRunner: sco-tester        PASS      9.22 seconds
TestRunner: smp-tester        PASS      9.13 seconds
TestRunner: userchan-tester   PASS      7.74 seconds

Details
##############################
Test: CheckPatch - FAIL - 8.65 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[2/3] Bluetooth: Implement support for Mesh\WARNING:TYPO_SPELLING: 'recieving' may be misspelled - perhaps 'receiving'?
#67: 
and recieving Bluetooth Mesh advertising packets, and delivery to
    ^^^^^^^^^

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#687: FILE: net/bluetooth/hci_request.c:2122:
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+				hci_dev_test_flag(hdev, HCI_MESH))

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#747: FILE: net/bluetooth/hci_request.c:2336:
+	 * with no filtering */

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#766: FILE: net/bluetooth/hci_request.c:2400:
+			hci_req_sync(hdev, mesh_scan, DISCOV_LE_SCAN_INT,
+					HCI_CMD_TIMEOUT, status);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#770: FILE: net/bluetooth/hci_request.c:2404:
+			hci_req_sync(hdev, active_scan,
+					hdev->le_scan_int_discovery,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#839: FILE: net/bluetooth/hci_sync.c:1146:
+int hci_mesh_send_sync(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type,
+							u8 *data, u8 len)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#862: FILE: net/bluetooth/hci_sync.c:1169:
+	__hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_PARAM,
+				       sizeof(cp_param), &cp_param,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#866: FILE: net/bluetooth/hci_sync.c:1173:
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
+			     sizeof(cp_data), &cp_data, HCI_CMD_TIMEOUT);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1088: FILE: net/bluetooth/mgmt.c:1033:
+static void mesh_send_complete(struct hci_dev *hdev,
+						struct mgmt_mesh_tx *mesh_tx)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1093: FILE: net/bluetooth/mgmt.c:1038:
+	mgmt_event(MGMT_EV_MESH_PACKET_CMPLT, hdev, &handle, sizeof(handle),
+								NULL);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1122: FILE: net/bluetooth/mgmt.c:1067:
+	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+			mesh_send_start_complete);

CHECK:LINE_SPACING: Please don't use multiple blank lines
#1158: FILE: net/bluetooth/mgmt.c:2095:
 
+

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1184: FILE: net/bluetooth/mgmt.c:2140:
+		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev,
+						cmd_status_rsp, &status);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1195: FILE: net/bluetooth/mgmt.c:2151:
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0,
+								&slots, 1);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1244: FILE: net/bluetooth/mgmt.c:2200:
+		err = hci_cmd_sync_queue(hdev, set_mesh_sync, cmd,
+						set_mesh_complete);

CHECK:LINE_SPACING: Please don't use multiple blank lines
#1246: FILE: net/bluetooth/mgmt.c:2202:
+
+

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1249: FILE: net/bluetooth/mgmt.c:2205:
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+						MGMT_STATUS_FAILED);

CHECK:SPACING: No space is necessary after a cast
#1262: FILE: net/bluetooth/mgmt.c:2218:
+	struct mgmt_cp_mesh_send *send = (void *) mesh_tx->param;

CHECK:SPACING: No space is necessary after a cast
#1283: FILE: net/bluetooth/mgmt.c:2239:
+	struct mgmt_cp_mesh_send *send = (void *) mesh_tx->param;

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1304: FILE: net/bluetooth/mgmt.c:2260:
+static int mesh_features(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 len)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1323: FILE: net/bluetooth/mgmt.c:2279:
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_MESH_READ_FEATURES, 0, &rp,
+			rp.used_handles + sizeof(rp) - MESH_HANDLES_MAX);

CHECK:SPACING: No space is necessary after a cast
#1332: FILE: net/bluetooth/mgmt.c:2288:
+	struct mgmt_cp_mesh_send_cancel *cancel = (void *) cmd->param;

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1350: FILE: net/bluetooth/mgmt.c:2306:
+	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
+								0, NULL, 0);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1357: FILE: net/bluetooth/mgmt.c:2313:
+static int mesh_send_cancel(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 len)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1394: FILE: net/bluetooth/mgmt.c:2350:
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
+					len <= MGMT_MESH_SEND_SIZE ||

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1408: FILE: net/bluetooth/mgmt.c:2364:
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+							MGMT_STATUS_BUSY);

CHECK:LINE_SPACING: Please don't use multiple blank lines
#1412: FILE: net/bluetooth/mgmt.c:2368:
+
+

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1420: FILE: net/bluetooth/mgmt.c:2376:
+		err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+						mesh_send_start_complete);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1425: FILE: net/bluetooth/mgmt.c:2381:
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+						MGMT_STATUS_FAILED);

CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'hdev->adv_tx_power != HCI_TX_POWER_INVALID'
#1477: FILE: net/bluetooth/mgmt.c:8166:
+	if ((hdev->adv_tx_power != HCI_TX_POWER_INVALID) || use_ext_adv(hdev))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1505: FILE: net/bluetooth/mgmt.c:10071:
+static void mesh_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr,
+		       u8 addr_type, s8 rssi, u32 flags, u8 *eir, u16 eir_len,

CHECK:LINE_SPACING: Please don't use multiple blank lines
#1542: FILE: net/bluetooth/mgmt.c:10108:
+
+

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1582: FILE: net/bluetooth/mgmt.c:10147:
+		mesh_device_found(hdev, bdaddr, addr_type, rssi, flags,
+				eir, eir_len, scan_rsp, scan_rsp_len, instant);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1597: FILE: net/bluetooth/mgmt_util.c:319:
+void mgmt_mesh_foreach(struct hci_dev *hdev,
+			  void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1678: FILE: net/bluetooth/mgmt_util.h:72:
+void mgmt_mesh_foreach(struct hci_dev *hdev,
+			  void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),

total: 0 errors, 2 warnings, 33 checks, 1441 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12797522.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[3/3] Bluetooth: Add experimental wrapper for MGMT based mesh\CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#121: FILE: net/bluetooth/mgmt.c:2179:
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#131: FILE: net/bluetooth/mgmt.c:2259:
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#140: FILE: net/bluetooth/mgmt.c:2314:
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#152: FILE: net/bluetooth/mgmt.c:2350:
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#217: FILE: net/bluetooth/mgmt.c:4372:
+	status = mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 				 MGMT_OP_READ_EXP_FEATURES_INFO,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#230: FILE: net/bluetooth/mgmt.c:4504:
+static int set_mgmt_mesh_func(struct sock *sk, struct hci_dev *hdev,
+				   struct mgmt_cp_set_exp_feature *cp,

CHECK:BRACES: Unbalanced braces around else statement
#266: FILE: net/bluetooth/mgmt.c:4540:
+	else {

CHECK:LINE_SPACING: Please don't use multiple blank lines
#272: FILE: net/bluetooth/mgmt.c:4546:
+
+

total: 0 errors, 0 warnings, 8 checks, 204 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12797521.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 116.15 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 492 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.120 seconds



---
Regards,
Linux Bluetooth


--===============0403375580905212255==--
