Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4150C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 00:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387421AbiEFAOH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 20:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387496AbiEFAOB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 20:14:01 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E141E9
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 17:10:19 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t16so4759562qtr.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6K6Sw0e0kU2B0jUSxKlOQGUoPtC0rMLwAwwlud3IvR0=;
        b=bwUdLxqKhF2VjdlHdhhVfXeUNkmcyI3KF5NmusuR8ryyp7wu0enTHDYbIwzvFHv3EK
         SxPvOf0AiznKaMTqTYpTeXYHhH+QU/t/Ev254+pgbJfru379MnmBQI9Uwwsnw/KpAgD9
         lzXD+V5LGp9LwOJ7AuT/NR6Ix7uzhkJ94JW9QSPN5cORhQH9Rc4RyzPP0we1Jp2LqChF
         kOvVz0sOGGSie5WrymtDeRISPBrdCgzoAwPWkSN+yLaenBFAOCIicxV0KJEjfqa/kUtb
         QbM6dKotS8QOdx8DLathazjheu9fWXCjySzeRdBe0mh4W6VUOpnCcFz3PskGvHOuy3r4
         93Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6K6Sw0e0kU2B0jUSxKlOQGUoPtC0rMLwAwwlud3IvR0=;
        b=vyHi9DmCinciqVEcWTANlZcOLHpzbVX803QAymuQgicKH2IhXH4vwKYc8EVQlHJcux
         NLMUlOMnEzizf+xJh2KK8ScHU4hjPoIWm2VWHukbHFaYrvGatWK5uoXcuYeI9X6fbhiH
         +zEyzfq4B9fyuo6xGHpLoS8k0M6nS+wC8Ya6FG55rRMJbadWiyFRZXCFQ64oHfHUHw4z
         70x7LRjVF2SCHZWSVsJYtsYgkxHtLKq/zYCHdB3L0BW4q80UcaogeTGyybIi/otVSoPR
         y1zm9LRgpG3+SjZXDgl7hcXViZ/laULtWgmortJ244nqzPDOFsrgiGEAboebpm+SzJXe
         apZg==
X-Gm-Message-State: AOAM533TTTrCX4EEEi8G07deopLZngkCRVo+AbFOn+gna3TxkR6QL761
        B3xCef60y6NyZv3yuhFzb8cJ4ATKmhBufg==
X-Google-Smtp-Source: ABdhPJysG8IM4CRNgp+oRL2/CjeA9If1svl6wpE71nXPoH8hqlR1hqP1pBZ+3cYsHvgyWQm5IB5jiA==
X-Received: by 2002:ac8:5dcd:0:b0:2eb:9458:4985 with SMTP id e13-20020ac85dcd000000b002eb94584985mr606295qtx.85.1651795818330;
        Thu, 05 May 2022 17:10:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.11.195])
        by smtp.gmail.com with ESMTPSA id j17-20020ac874d1000000b002f39b99f6bdsm1694584qtr.87.2022.05.05.17.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 17:10:18 -0700 (PDT)
Message-ID: <6274676a.1c69fb81.6bfd8.992a@mx.google.com>
Date:   Thu, 05 May 2022 17:10:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1114111973223222603=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/8] Bluetooth: eir: Add helpers for managing service data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220505230550.3450617-1-luiz.dentz@gmail.com>
References: <20220505230550.3450617-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1114111973223222603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=638909

---Test result---

Test Summary:
CheckPatch                    FAIL      22.41 seconds
GitLint                       PASS      8.48 seconds
SubjectPrefix                 PASS      7.15 seconds
BuildKernel                   PASS      41.27 seconds
BuildKernel32                 PASS      37.28 seconds
Incremental Build with patchesPASS      250.41 seconds
TestRunner: Setup             PASS      601.80 seconds
TestRunner: l2cap-tester      PASS      20.58 seconds
TestRunner: bnep-tester       PASS      7.72 seconds
TestRunner: mgmt-tester       FAIL      122.10 seconds
TestRunner: rfcomm-tester     PASS      11.74 seconds
TestRunner: sco-tester        PASS      11.63 seconds
TestRunner: smp-tester        PASS      11.49 seconds
TestRunner: userchan-tester   PASS      8.12 seconds

Details
##############################
Test: CheckPatch - FAIL - 22.41 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[2/8] Bluetooth: hci_core: Introduce hci_recv_event_data\CHECK:SPACING: No space is necessary after a cast
#138: FILE: net/bluetooth/hci_core.c:3035:
+	hdr = (void *) hdev->recv_event->data;

CHECK:SPACING: No space is necessary after a cast
#146: FILE: net/bluetooth/hci_core.c:3043:
+			ev = (void *) hdev->recv_event->data + offset;

total: 0 errors, 0 warnings, 2 checks, 67 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12840314.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[3/8] Bluetooth: Add initial implementation of CIS connections\WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#249: FILE: include/net/bluetooth/hci.h:2066:
+} __attribute__ ((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#254: FILE: include/net/bluetooth/hci.h:2071:
+} __attribute__ ((packed));

ERROR:CODE_INDENT: code indent should use tabs where possible
#298: FILE: include/net/bluetooth/hci_core.h:655:
+        CONN_REASON_ISO_CONNECT,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#298: FILE: include/net/bluetooth/hci_core.h:655:
+        CONN_REASON_ISO_CONNECT,$

WARNING:SPACING: Unnecessary space before function pointer arguments
#323: FILE: include/net/bluetooth/hci_core.h:749:
+	void (*cleanup)		(struct hci_conn *conn);

ERROR:CODE_INDENT: code indent should use tabs where possible
#370: FILE: include/net/bluetooth/hci_core.h:1103:
+^I^I^I^I^I^I        bdaddr_t *ba,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#371: FILE: include/net/bluetooth/hci_core.h:1104:
+^I^I^I^I^I^I        __u8 ba_type)$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 23)
#379: FILE: include/net/bluetooth/hci_core.h:1112:
+		if (c->type != ISO_LINK)
+		       continue;

WARNING:TABSTOP: Statements should start on a tabstop
#380: FILE: include/net/bluetooth/hci_core.h:1113:
+		       continue;

ERROR:CODE_INDENT: code indent should use tabs where possible
#394: FILE: include/net/bluetooth/hci_core.h:1127:
+^I^I^I^I^I^I        __u8 handle)$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 23)
#402: FILE: include/net/bluetooth/hci_core.h:1135:
+		if (c->type != ISO_LINK)
+		       continue;

WARNING:TABSTOP: Statements should start on a tabstop
#403: FILE: include/net/bluetooth/hci_core.h:1136:
+		       continue;

ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in parentheses
#547: FILE: net/bluetooth/af_bluetooth.c:41:
+#define BT_MAX_PROTO	BTPROTO_LAST + 1

WARNING:BRACES: braces {} are not necessary for single statement blocks
#769: FILE: net/bluetooth/hci_conn.c:1411:
+		if (!cis) {
+			return ERR_PTR(-ENOMEM);
+		}

WARNING:UNNECESSARY_ELSE: else is not generally useful after a break or return
#908: FILE: net/bluetooth/hci_conn.c:1550:
+		return -EINVAL;
+	else

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#970: FILE: net/bluetooth/hci_conn.c:1612:
+		le = hci_connect_le_scan(hdev, dst, dst_type,
+					  BT_SECURITY_LOW,

ERROR:CODE_INDENT: code indent should use tabs where possible
#972: FILE: net/bluetooth/hci_conn.c:1614:
+                                          CONN_REASON_ISO_CONNECT);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#972: FILE: net/bluetooth/hci_conn.c:1614:
+                                          CONN_REASON_ISO_CONNECT);$

CHECK:SPACING: No space is necessary after a cast
#1280: FILE: net/bluetooth/hci_core.c:3808:
+	struct hci_iso_hdr *hdr = (void *) skb->data;

ERROR:TRAILING_STATEMENTS: trailing statements should be on next line (or did you mean 'else if'?)
#1525: FILE: net/bluetooth/hci_event.c:4344:
+			} if (hdev->le_pkts) {

ERROR:SPACING: space required after that ',' (ctx:VxV)
#1625: FILE: net/bluetooth/hci_event.c:6737:
+	bt_dev_dbg(hdev,"acl_handle 0x%4.4x cis_handle 0x%4.4x cig_id 0x%2.2x "
 	               ^

WARNING:SPLIT_STRING: quoted string split across lines
#1626: FILE: net/bluetooth/hci_event.c:6738:
+	bt_dev_dbg(hdev,"acl_handle 0x%4.4x cis_handle 0x%4.4x cig_id 0x%2.2x "
+		   "cis_id 0x%2.2x", acl_handle, cis_handle, ev->cig_id,

CHECK:LINE_SPACING: Please don't use multiple blank lines
#1690: FILE: net/bluetooth/hci_event.c:6888:
 
+

total: 8 errors, 12 warnings, 3 checks, 1537 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12840316.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[4/8] Bluetooth: Add BTPROTO_ISO socket type\WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#177: 
new file mode 100644

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#182: FILE: include/net/bluetooth/iso.h:1:
+/*

WARNING:BLOCK_COMMENT_STYLE: Block comments use * on subsequent lines
#183: FILE: include/net/bluetooth/iso.h:2:
+/*
+   BlueZ - Bluetooth protocol stack for Linux

WARNING:UNNECESSARY_ELSE: else is not generally useful after a break or return
#257: FILE: net/bluetooth/hci_core.c:3829:
+		return;
+	} else {

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#282: FILE: net/bluetooth/iso.c:1:
+/*

WARNING:BLOCK_COMMENT_STYLE: Block comments use * on subsequent lines
#283: FILE: net/bluetooth/iso.c:2:
+/*
+   BlueZ - Bluetooth protocol stack for Linux

CHECK:UNCOMMENTED_DEFINITION: spinlock_t definition without comment
#325: FILE: net/bluetooth/iso.c:44:
+	spinlock_t	lock;

CHECK:MACRO_ARG_PRECEDENCE: Macro argument 'c' may be better as '(c)' to avoid precedence issues
#335: FILE: net/bluetooth/iso.c:54:
+#define iso_conn_lock(c)	spin_lock(&c->lock);

WARNING:TRAILING_SEMICOLON: macros should not use a trailing semicolon
#335: FILE: net/bluetooth/iso.c:54:
+#define iso_conn_lock(c)	spin_lock(&c->lock);

CHECK:MACRO_ARG_PRECEDENCE: Macro argument 'c' may be better as '(c)' to avoid precedence issues
#336: FILE: net/bluetooth/iso.c:55:
+#define iso_conn_unlock(c)	spin_unlock(&c->lock);

WARNING:TRAILING_SEMICOLON: macros should not use a trailing semicolon
#336: FILE: net/bluetooth/iso.c:55:
+#define iso_conn_unlock(c)	spin_unlock(&c->lock);

CHECK:SPACING: No space is necessary after a cast
#342: FILE: net/bluetooth/iso.c:61:
+#define iso_pi(sk) ((struct iso_pinfo *) sk)

CHECK:ALLOC_SIZEOF_STRUCT: Prefer kzalloc(sizeof(*conn)...) over kzalloc(sizeof(struct iso_conn)...)
#410: FILE: net/bluetooth/iso.c:129:
+	conn = kzalloc(sizeof(struct iso_conn), GFP_KERNEL);

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#427: FILE: net/bluetooth/iso.c:146:
+ * Must be called on the locked socket. */

CHECK:LINE_SPACING: Please don't use multiple blank lines
#516: FILE: net/bluetooth/iso.c:235:
+
+

CHECK:BRACES: braces {} should be used on all arms of this statement
#735: FILE: net/bluetooth/iso.c:454:
+		if (iso_pi(sk)->conn->hcon) {
[...]
+		} else
[...]

CHECK:BRACES: Unbalanced braces around else statement
#742: FILE: net/bluetooth/iso.c:461:
+		} else

CHECK:SPACING: No space is necessary after a cast
#858: FILE: net/bluetooth/iso.c:577:
+	struct sockaddr_iso *sa = (struct sockaddr_iso *) addr;

CHECK:SPACING: No space is necessary after a cast
#899: FILE: net/bluetooth/iso.c:618:
+	struct sockaddr_iso *sa = (struct sockaddr_iso *) addr;

CHECK:SPACING: No space is necessary after a cast
#1034: FILE: net/bluetooth/iso.c:753:
+	struct sockaddr_iso *sa = (struct sockaddr_iso *) addr;

CHECK:BRACES: Blank lines aren't necessary after an open brace '{'
#1212: FILE: net/bluetooth/iso.c:931:
+	switch (optname) {
+

CHECK:BRACES: Blank lines aren't necessary after an open brace '{'
#1281: FILE: net/bluetooth/iso.c:1000:
+	switch (optname) {
+

CHECK:BRACES: braces {} should be used on all arms of this statement
#1492: FILE: net/bluetooth/iso.c:1211:
+	if (!status) {
[...]
+	} else
[...]

CHECK:BRACES: Unbalanced braces around else statement
#1498: FILE: net/bluetooth/iso.c:1217:
+	} else

CHECK:SPACING: No space is necessary after a cast
#1545: FILE: net/bluetooth/iso.c:1264:
+			hdr = (void *) skb->data + 4;

CHECK:SPACING: No space is necessary after a cast
#1548: FILE: net/bluetooth/iso.c:1267:
+			hdr = (void *) skb->data;

WARNING:LINE_SPACING: Missing a blank line after declarations
#1622: FILE: net/bluetooth/iso.c:1341:
+			struct sk_buff *rx_skb = conn->rx_skb;
+			conn->rx_skb = NULL;

total: 0 errors, 10 warnings, 17 checks, 1699 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12840317.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[5/8] Bluetooth: Add initial implementation of BIS connections\ERROR:CODE_INDENT: code indent should use tabs where possible
#501: FILE: include/net/bluetooth/hci_core.h:1064:
+^I^I^I^I^I^I        bdaddr_t *ba,$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (16, 23)
#539: FILE: include/net/bluetooth/hci_core.h:1205:
+		if (bacmp(&c->dst, BDADDR_ANY) || c->type != ISO_LINK)
+		       continue;

WARNING:TABSTOP: Statements should start on a tabstop
#540: FILE: include/net/bluetooth/hci_core.h:1206:
+		       continue;

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#847: FILE: net/bluetooth/hci_conn.c:814:
+ * */

CHECK:BRACES: Blank lines aren't necessary after an open brace '{'
#1167: FILE: net/bluetooth/hci_conn.c:1876:
+{
+

ERROR:SPACING: spaces required around that '=' (ctx:WxV)
#1181: FILE: net/bluetooth/hci_conn.c:1890:
+	u16 interval, sync_interval =0;
 	                            ^

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#1485: FILE: net/bluetooth/hci_event.c:3909:
+	 * Using Advertising handle get the connection state and update*/

CHECK:BRACES: Unbalanced braces around else statement
#1755: FILE: net/bluetooth/hci_request.c:830:
+	else {

WARNING:TYPO_SPELLING: 'Annoucement' may be misspelled - perhaps 'Announcement'?
#1963: FILE: net/bluetooth/hci_sync.c:1062:
+	 * advertising so it cannot used for the likes of Broadcast Annoucement
 	                                                            ^^^^^^^^^^^

WARNING:TYPO_SPELLING: 'Annoucement' may be misspelled - perhaps 'Announcement'?
#1969: FILE: net/bluetooth/hci_sync.c:1068:
+	/* Check if PA data doesn't contains a Basic Audio Annoucement then
 	                                                   ^^^^^^^^^^^

WARNING:TYPO_SPELLING: 'Annoucement' may be misspelled - perhaps 'Announcement'?
#1976: FILE: net/bluetooth/hci_sync.c:1075:
+	/* Check if advertising data already has a Broadcast Annoucement since
 	                                                     ^^^^^^^^^^^

total: 2 errors, 7 warnings, 2 checks, 1917 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12840321.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[6/8] Bluetooth: ISO: Add broadcast support\WARNING:TYPO_SPELLING: 'Whe' may be misspelled - perhaps 'When'?
#87: 
Whe using BTPROTO_ISO for broadcast the roles are:
^^^

WARNING:REPEATED_WORD: Possible repeated word: 'match'
#291: FILE: net/bluetooth/iso.c:479:
+ * match func - pass NULL to ignore/not match
+ * match func data - pass -1 to ignore/not match

CHECK:SPACING: No space is necessary after a cast
#322: FILE: net/bluetooth/iso.c:690:
+	struct sockaddr_iso *sa = (struct sockaddr_iso *) addr;

CHECK:LINE_SPACING: Please don't use multiple blank lines
#546: FILE: net/bluetooth/iso.c:1346:
 
+

ERROR:ASSIGN_IN_IF: do not use assignment in if condition
#650: FILE: net/bluetooth/iso.c:1474:
+	} else if ((ev2 = hci_recv_event_data(hdev,

total: 1 errors, 2 warnings, 2 checks, 557 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12840319.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestRunner: mgmt-tester - FAIL - 122.10 seconds
Run test-runner with mgmt-tester
Total: 493, Passed: 491 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Read Exp Feature - Success                           Failed       0.128 seconds
Read Exp Feature - Success (Index None)              Failed       0.124 seconds



---
Regards,
Linux Bluetooth


--===============1114111973223222603==--
