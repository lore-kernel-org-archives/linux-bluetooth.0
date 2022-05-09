Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61167C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 May 2022 23:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiEIXM0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 19:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiEIXMZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 19:12:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3631429743E
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 16:08:27 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id v11so1664767qkf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 May 2022 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aGfZXoetBdOt2HfVlStNrrxFDx+5HqvJlT3EyyDM8Is=;
        b=ZHU1ilVjsNru9IdL8rqvglBmgD3eIHH8WC0bTQAi9yEzervFcdWI3LSlxCeCvqyng0
         CkDFtDDlqPpD89w9D+GBrtUIl0rG/7EZ/vwsvMd1heCVkPSF1PwLdGqJFeGQ420MWsyN
         1eLMPS4D3R5JXrpNt7Ow1gsLlCJL3ng7xWnRb46m7X1RKk7mxfWTCGwSaaGkrXuYMItF
         PWf8a69F4vLWS9yXXWbN/nVDDYp6b0psOvXRc0yFMQN48uziUCWLHuJhyy0IB/xkMmRa
         xVXwlvQWP+t/ZuyVjDiKn0i5lZKNcCS3fEXVlnTA+W3nOly4MIEAFWd8WxdoeTu/nI2t
         NDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aGfZXoetBdOt2HfVlStNrrxFDx+5HqvJlT3EyyDM8Is=;
        b=Yio1jfrCXyUKEeUJzdMWUTZAfZ8ZShHjikFW53377qPi2eU3aKUtFFBmldtbotoq6x
         qW4oYHUQ9rB1lQNNBPQAYQx+sM/hwrvxHZiXAqJjoEw1ju1HNMsheCa4u5h0bkpr47bF
         qNUtpHbE2pYDwYD/AzsgL+tjAFp5CkSOMHvrneyvn0xFhhK95lX53yYCmJNnrh4esuS1
         IgYLZKbs7BjL8cotayFpKp5MMpUp+Ha+mmQyd+XFXB1YonGev1/+C2LK8lAml+sOPxTz
         /rRPKzGw95+Yl3Qhbib+IVZTvBlqjtIYatEiRAGA5vHgp6hvh70iIK6fQErZWDj5gZtR
         qHXA==
X-Gm-Message-State: AOAM533kJyeuh5mnk1pep/ANlbFnihG5TVwEfs1wshb+FnGhMZzrvZF3
        m8z4nuQ96YO6cvKEK5TzkJYJGIfvLQvFCw==
X-Google-Smtp-Source: ABdhPJwL3tNFfFvmIlkqdVZnOAvFWPal4eChfjWrtOQ+jAqlBneBaD/f62S3+lh0ZSEFlYsOHrxZ/g==
X-Received: by 2002:a05:620a:25d2:b0:699:bd31:aafb with SMTP id y18-20020a05620a25d200b00699bd31aafbmr13603621qko.531.1652137706092;
        Mon, 09 May 2022 16:08:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.201.151])
        by smtp.gmail.com with ESMTPSA id j14-20020ac84c8e000000b002f39b99f6a3sm8919784qtv.61.2022.05.09.16.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 16:08:25 -0700 (PDT)
Message-ID: <62799ee9.1c69fb81.66e08.db43@mx.google.com>
Date:   Mon, 09 May 2022 16:08:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0710563561870751579=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add Mesh functionality to net/bluetooth
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220509220512.482695-2-brian.gix@intel.com>
References: <20220509220512.482695-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0710563561870751579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639928

---Test result---

Test Summary:
CheckPatch                    FAIL      7.73 seconds
GitLint                       PASS      2.24 seconds
SubjectPrefix                 PASS      1.96 seconds
BuildKernel                   PASS      42.28 seconds
BuildKernel32                 PASS      37.92 seconds
Incremental Build with patchesPASS      88.64 seconds
TestRunner: Setup             PASS      631.56 seconds
TestRunner: l2cap-tester      PASS      21.33 seconds
TestRunner: bnep-tester       PASS      7.82 seconds
TestRunner: mgmt-tester       FAIL      127.66 seconds
TestRunner: rfcomm-tester     PASS      11.98 seconds
TestRunner: sco-tester        PASS      11.91 seconds
TestRunner: smp-tester        PASS      11.82 seconds
TestRunner: userchan-tester   PASS      8.21 seconds

Details
##############################
Test: CheckPatch - FAIL - 7.73 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2,1/2] Bluetooth: Implement support for Mesh\WARNING:TYPO_SPELLING: 'recieving' may be misspelled - perhaps 'receiving'?
#67: 
and recieving Bluetooth Mesh advertising packets, and delivery to
    ^^^^^^^^^

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#701: FILE: net/bluetooth/hci_request.c:2122:
+	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
+				hci_dev_test_flag(hdev, HCI_MESH))

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#761: FILE: net/bluetooth/hci_request.c:2338:
+	 * with no filtering */

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#780: FILE: net/bluetooth/hci_request.c:2402:
+			hci_req_sync(hdev, mesh_scan, DISCOV_LE_SCAN_INT,
+					HCI_CMD_TIMEOUT, status);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#784: FILE: net/bluetooth/hci_request.c:2406:
+			hci_req_sync(hdev, active_scan,
+					hdev->le_scan_int_discovery,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#865: FILE: net/bluetooth/hci_sync.c:1146:
+int hci_mesh_send_sync(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type,
+							u8 *data, u8 len)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#888: FILE: net/bluetooth/hci_sync.c:1169:
+	__hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_PARAM,
+				       sizeof(cp_param), &cp_param,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#892: FILE: net/bluetooth/hci_sync.c:1173:
+	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_DATA,
+			     sizeof(cp_data), &cp_data, HCI_CMD_TIMEOUT);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1114: FILE: net/bluetooth/mgmt.c:1033:
+static void mesh_send_complete(struct hci_dev *hdev,
+		struct mgmt_mesh_tx *mesh_tx, bool silent)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1120: FILE: net/bluetooth/mgmt.c:1039:
+		mgmt_event(MGMT_EV_MESH_PACKET_CMPLT, hdev, &handle,
+				sizeof(handle), NULL);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1149: FILE: net/bluetooth/mgmt.c:1068:
+	err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+			mesh_send_start_complete);

CHECK:LINE_SPACING: Please don't use multiple blank lines
#1185: FILE: net/bluetooth/mgmt.c:2096:
 
+

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1211: FILE: net/bluetooth/mgmt.c:2141:
+		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev,
+						cmd_status_rsp, &status);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1222: FILE: net/bluetooth/mgmt.c:2152:
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER, 0,
+								&slots, 1);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1271: FILE: net/bluetooth/mgmt.c:2201:
+		err = hci_cmd_sync_queue(hdev, set_mesh_sync, cmd,
+						set_mesh_complete);

CHECK:LINE_SPACING: Please don't use multiple blank lines
#1273: FILE: net/bluetooth/mgmt.c:2203:
+
+

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1276: FILE: net/bluetooth/mgmt.c:2206:
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_MESH_RECEIVER,
+						MGMT_STATUS_FAILED);

CHECK:SPACING: No space is necessary after a cast
#1289: FILE: net/bluetooth/mgmt.c:2219:
+	struct mgmt_cp_mesh_send *send = (void *) mesh_tx->param;

CHECK:SPACING: No space is necessary after a cast
#1310: FILE: net/bluetooth/mgmt.c:2240:
+	struct mgmt_cp_mesh_send *send = (void *) mesh_tx->param;

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1331: FILE: net/bluetooth/mgmt.c:2261:
+static int mesh_features(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 len)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1350: FILE: net/bluetooth/mgmt.c:2280:
+	mgmt_cmd_complete(sk, hdev->id, MGMT_OP_MESH_READ_FEATURES, 0, &rp,
+			rp.used_handles + sizeof(rp) - MESH_HANDLES_MAX);

CHECK:SPACING: No space is necessary after a cast
#1359: FILE: net/bluetooth/mgmt.c:2289:
+	struct mgmt_cp_mesh_send_cancel *cancel = (void *) cmd->param;

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1377: FILE: net/bluetooth/mgmt.c:2307:
+	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
+								0, NULL, 0);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1384: FILE: net/bluetooth/mgmt.c:2314:
+static int mesh_send_cancel(struct sock *sk, struct hci_dev *hdev,
+						void *data, u16 len)

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1421: FILE: net/bluetooth/mgmt.c:2351:
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
+					len <= MGMT_MESH_SEND_SIZE ||

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1435: FILE: net/bluetooth/mgmt.c:2365:
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+							MGMT_STATUS_BUSY);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1446: FILE: net/bluetooth/mgmt.c:2376:
+		err = hci_cmd_sync_queue(hdev, mesh_send_sync, mesh_tx,
+						mesh_send_start_complete);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1451: FILE: net/bluetooth/mgmt.c:2381:
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+						MGMT_STATUS_FAILED);

CHECK:UNNECESSARY_PARENTHESES: Unnecessary parentheses around 'hdev->adv_tx_power != HCI_TX_POWER_INVALID'
#1503: FILE: net/bluetooth/mgmt.c:8166:
+	if ((hdev->adv_tx_power != HCI_TX_POWER_INVALID) || use_ext_adv(hdev))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1531: FILE: net/bluetooth/mgmt.c:10071:
+static void mesh_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr,
+		       u8 addr_type, s8 rssi, u32 flags, u8 *eir, u16 eir_len,

CHECK:LINE_SPACING: Please don't use multiple blank lines
#1568: FILE: net/bluetooth/mgmt.c:10108:
+
+

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1608: FILE: net/bluetooth/mgmt.c:10147:
+		mesh_device_found(hdev, bdaddr, addr_type, rssi, flags,
+				eir, eir_len, scan_rsp, scan_rsp_len, instant);

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1646: FILE: net/bluetooth/mgmt_util.c:319:
+void mgmt_mesh_foreach(struct hci_dev *hdev,
+			  void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#1738: FILE: net/bluetooth/mgmt_util.h:72:
+void mgmt_mesh_foreach(struct hci_dev *hdev,
+			  void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),

total: 0 errors, 2 warnings, 32 checks, 1488 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12844125.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v2,2/2] Bluetooth: Add experimental wrapper for MGMT based mesh\CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#122: FILE: net/bluetooth/mgmt.c:2180:
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#132: FILE: net/bluetooth/mgmt.c:2260:
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#141: FILE: net/bluetooth/mgmt.c:2315:
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#153: FILE: net/bluetooth/mgmt.c:2351:
+	if (!lmp_le_capable(hdev) ||
+			!hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#218: FILE: net/bluetooth/mgmt.c:4372:
+	status = mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
 				 MGMT_OP_READ_EXP_FEATURES_INFO,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#231: FILE: net/bluetooth/mgmt.c:4504:
+static int set_mgmt_mesh_func(struct sock *sk, struct hci_dev *hdev,
+				   struct mgmt_cp_set_exp_feature *cp,

CHECK:BRACES: Unbalanced braces around else statement
#267: FILE: net/bluetooth/mgmt.c:4540:
+	else {

CHECK:LINE_SPACING: Please don't use multiple blank lines
#273: FILE: net/bluetooth/mgmt.c:4546:
+
+

total: 0 errors, 0 warnings, 8 checks, 204 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12844124.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 127.66 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 492 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.148 seconds



---
Regards,
Linux Bluetooth


--===============0710563561870751579==--
