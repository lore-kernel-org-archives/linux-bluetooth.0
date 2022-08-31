Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FB5ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 21:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiHaVSB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 17:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiHaVSA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 17:18:00 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D6DDD4DE
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 14:17:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so11146892otk.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=ZV694DubARgmL9sIbAPHkn6SL6SBwtksw21g5o1B/CE=;
        b=DboJGd++mp0pVABh4KP3VFXfzJ1LwutkDtMo7wne6DQdmAKdd6ZQ2OOsb/1R20WHAb
         lBBJoR2puhvvZiWE8EysirX3EXa3c1bx/umZ9erRQO5XQ9DPJ5IhBo5WjU9ExixZkfIq
         NrumCcd8CH1Nn6WxNlbYiZGPplyFbhor26hQjd70cvN534mAfoC32mibUdVxtBVmKjgc
         HLz/FGb8LTNDJDrVrKGaUtX5cudvVPq3fLJA6UIF7QjM1WjT27ouHIOgs0r/FJ/uzpRz
         uA68E+jW85cj6wsQQ5xbbQ95YV1qz42b1dHpsu/B5KhM1lHLTYO8eOMNheZJoddeZ/d6
         CUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ZV694DubARgmL9sIbAPHkn6SL6SBwtksw21g5o1B/CE=;
        b=Aubzmq33BrVM+0+raolnm9U5Riv4gDK+e4+/R0QTOODt0URNCMYOPhrfqyV4VjwU8O
         GxHYM/N/+rsRDhj+OxVsbmGerN54rDYFcsaEh+Hog7NAmjVfoQv5LbKr4d8j7uc870xP
         ogEvmwOzwVe46g+eCtbCX3uYIqVIaQVst9fLefiZMDd/cWmj08DeKM4WT1UnaJoklZgO
         XQCkWcRyayaGhvzlpJz2zqphLsuE2FxpA5oB8C4pZWwEaxpB2UVBS8dtzQH1ImTZRMDE
         pbcbRoimnjhbJOQqkBA1cmJiH2FixyHX/YNWf6iD4XslJutpXMZaX/UvjQwQtNtOZCaE
         5JTw==
X-Gm-Message-State: ACgBeo0NIcETdHi1YLMiY/c0W07FcXuOf/lK2LTvvighcyMl6JAf9VZV
        s54qZJ1dhQOD9tWtaRHJN413hFQ1syg=
X-Google-Smtp-Source: AA6agR5nh1EDGY5kquuR6QN62IYHbFja4JL8pXkkSd9ZUA6QWmr8KUaLHDX/YFKc7Fgj2m4XtCqnPQ==
X-Received: by 2002:a05:6830:22e6:b0:639:4cc1:4bfd with SMTP id t6-20020a05683022e600b006394cc14bfdmr11383492otc.375.1661980677520;
        Wed, 31 Aug 2022 14:17:57 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.168.187])
        by smtp.gmail.com with ESMTPSA id y4-20020a544d84000000b00342fedaf7d9sm7783912oix.43.2022.08.31.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:17:57 -0700 (PDT)
Message-ID: <630fd005.540a0220.33a25.7440@mx.google.com>
Date:   Wed, 31 Aug 2022 14:17:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4753361953263725352=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Add mesh testing support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220831201101.260925-2-brian.gix@intel.com>
References: <20220831201101.260925-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4753361953263725352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672954

---Test result---

Test Summary:
CheckPatch                    FAIL      4.06 seconds
GitLint                       PASS      1.72 seconds
Prep - Setup ELL              PASS      32.70 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      10.35 seconds
Build - Make                  PASS      972.06 seconds
Make Check                    PASS      13.30 seconds
Make Check w/Valgrind         PASS      356.55 seconds
Make Distcheck                PASS      294.85 seconds
Build w/ext ELL - Configure   PASS      10.47 seconds
Build w/ext ELL - Make        PASS      103.79 seconds
Incremental Build w/ patches  PASS      245.56 seconds
Scan Build                    PASS      803.34 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/2] tools: Add mesh-tester to test Kernel mesh support
WARNING:LONG_LINE: line length of 101 exceeds 80 columns
#699: FILE: tools/mesh-tester.c:590:
+			tester_warn("Invalid cmd response parameter size %d %d", length, expect_len);

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#936: FILE: tools/mesh-tester.c:827:
+       struct test_data *data = tester_get_data();$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#937: FILE: tools/mesh-tester.c:828:
+       const struct generic_data *test = data->test_data;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#938: FILE: tools/mesh-tester.c:829:
+       const void *send_param = test->send_param;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#939: FILE: tools/mesh-tester.c:830:
+       uint16_t send_len = test->send_len;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#940: FILE: tools/mesh-tester.c:831:
+       unsigned int id;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#941: FILE: tools/mesh-tester.c:832:
+       uint16_t index;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#943: FILE: tools/mesh-tester.c:834:
+       index = test->send_index_none ? MGMT_INDEX_NONE : data->mgmt_index;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#945: FILE: tools/mesh-tester.c:836:
+       if (test->expect_settings_set || test->expect_settings_unset) {$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (7, 15)
#945: FILE: tools/mesh-tester.c:836:
+       if (test->expect_settings_set || test->expect_settings_unset) {
+               tester_print("Registering new settings notification");

ERROR:CODE_INDENT: code indent should use tabs where possible
#946: FILE: tools/mesh-tester.c:837:
+               tester_print("Registering new settings notification");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#946: FILE: tools/mesh-tester.c:837:
+               tester_print("Registering new settings notification");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#948: FILE: tools/mesh-tester.c:839:
+               id = mgmt_register(data->mgmt, MGMT_EV_NEW_SETTINGS, index,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#948: FILE: tools/mesh-tester.c:839:
+               id = mgmt_register(data->mgmt, MGMT_EV_NEW_SETTINGS, index,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#949: FILE: tools/mesh-tester.c:840:
+                               command_generic_new_settings, NULL, NULL);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#949: FILE: tools/mesh-tester.c:840:
+                               command_generic_new_settings, NULL, NULL);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#950: FILE: tools/mesh-tester.c:841:
+               data->mgmt_settings_id = id;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#950: FILE: tools/mesh-tester.c:841:
+               data->mgmt_settings_id = id;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#952: FILE: tools/mesh-tester.c:843:
+               id = mgmt_register(data->mgmt_alt, MGMT_EV_NEW_SETTINGS, index,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#952: FILE: tools/mesh-tester.c:843:
+               id = mgmt_register(data->mgmt_alt, MGMT_EV_NEW_SETTINGS, index,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#953: FILE: tools/mesh-tester.c:844:
+                               command_generic_new_settings_alt, NULL, NULL);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#953: FILE: tools/mesh-tester.c:844:
+                               command_generic_new_settings_alt, NULL, NULL);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#954: FILE: tools/mesh-tester.c:845:
+               data->mgmt_alt_settings_id = id;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#954: FILE: tools/mesh-tester.c:845:
+               data->mgmt_alt_settings_id = id;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#955: FILE: tools/mesh-tester.c:846:
+               test_add_condition(data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#955: FILE: tools/mesh-tester.c:846:
+               test_add_condition(data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#956: FILE: tools/mesh-tester.c:847:
+       }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#958: FILE: tools/mesh-tester.c:849:
+       if (test->expect_alt_ev) {$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (7, 15)
#958: FILE: tools/mesh-tester.c:849:
+       if (test->expect_alt_ev) {
+               tester_print("Registering %s notification",

ERROR:CODE_INDENT: code indent should use tabs where possible
#959: FILE: tools/mesh-tester.c:850:
+               tester_print("Registering %s notification",$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#959: FILE: tools/mesh-tester.c:850:
+               tester_print("Registering %s notification",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#960: FILE: tools/mesh-tester.c:851:
+                                       mgmt_evstr(test->expect_alt_ev));$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#960: FILE: tools/mesh-tester.c:851:
+                                       mgmt_evstr(test->expect_alt_ev));$

ERROR:CODE_INDENT: code indent should use tabs where possible
#961: FILE: tools/mesh-tester.c:852:
+               id = mgmt_register(data->mgmt_alt, test->expect_alt_ev, index,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#961: FILE: tools/mesh-tester.c:852:
+               id = mgmt_register(data->mgmt_alt, test->expect_alt_ev, index,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#962: FILE: tools/mesh-tester.c:853:
+                                       command_generic_event_alt, NULL, NULL);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#962: FILE: tools/mesh-tester.c:853:
+                                       command_generic_event_alt, NULL, NULL);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#963: FILE: tools/mesh-tester.c:854:
+               data->mgmt_alt_ev_id = id;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#963: FILE: tools/mesh-tester.c:854:
+               data->mgmt_alt_ev_id = id;$

ERROR:CODE_INDENT: code indent should use tabs where possible
#964: FILE: tools/mesh-tester.c:855:
+               test_add_condition(data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#964: FILE: tools/mesh-tester.c:855:
+               test_add_condition(data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#965: FILE: tools/mesh-tester.c:856:
+       }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#967: FILE: tools/mesh-tester.c:858:
+       if (test->expect_hci_command) {$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (7, 15)
#967: FILE: tools/mesh-tester.c:858:
+       if (test->expect_hci_command) {
+               tester_print("Registering HCI command callback");

ERROR:CODE_INDENT: code indent should use tabs where possible
#968: FILE: tools/mesh-tester.c:859:
+               tester_print("Registering HCI command callback");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#968: FILE: tools/mesh-tester.c:859:
+               tester_print("Registering HCI command callback");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#969: FILE: tools/mesh-tester.c:860:
+               hciemu_add_central_post_command_hook(data->hciemu,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#969: FILE: tools/mesh-tester.c:860:
+               hciemu_add_central_post_command_hook(data->hciemu,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#970: FILE: tools/mesh-tester.c:861:
+                                               command_hci_callback, data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#970: FILE: tools/mesh-tester.c:861:
+                                               command_hci_callback, data);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#971: FILE: tools/mesh-tester.c:862:
+               test_add_condition(data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#971: FILE: tools/mesh-tester.c:862:
+               test_add_condition(data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#972: FILE: tools/mesh-tester.c:863:
+       } else if (test->expect_hci_list) {$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (7, 15)
#972: FILE: tools/mesh-tester.c:863:
+       } else if (test->expect_hci_list) {
[...]
+               tester_print("Registering HCI command list callback");

ERROR:CODE_INDENT: code indent should use tabs where possible
#973: FILE: tools/mesh-tester.c:864:
+               /* Use this when it needs to check more than 1 hci command.$

ERROR:CODE_INDENT: code indent should use tabs where possible
#974: FILE: tools/mesh-tester.c:865:
+                * However, it cannot be used with expect_hci_command.$

ERROR:CODE_INDENT: code indent should use tabs where possible
#975: FILE: tools/mesh-tester.c:866:
+                */$

ERROR:CODE_INDENT: code indent should use tabs where possible
#976: FILE: tools/mesh-tester.c:867:
+               tester_print("Registering HCI command list callback");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#976: FILE: tools/mesh-tester.c:867:
+               tester_print("Registering HCI command list callback");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#977: FILE: tools/mesh-tester.c:868:
+               hciemu_add_central_post_command_hook(data->hciemu,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#977: FILE: tools/mesh-tester.c:868:
+               hciemu_add_central_post_command_hook(data->hciemu,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#978: FILE: tools/mesh-tester.c:869:
+                                       command_hci_list_callback, data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#978: FILE: tools/mesh-tester.c:869:
+                                       command_hci_list_callback, data);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#979: FILE: tools/mesh-tester.c:870:
+               add_expect_hci_list(data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#979: FILE: tools/mesh-tester.c:870:
+               add_expect_hci_list(data);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#980: FILE: tools/mesh-tester.c:871:
+       }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#982: FILE: tools/mesh-tester.c:873:
+       if (test->send_opcode == 0x0000) {$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (7, 15)
#982: FILE: tools/mesh-tester.c:873:
+       if (test->send_opcode == 0x0000) {
+               tester_print("Executing no-op test");

ERROR:CODE_INDENT: code indent should use tabs where possible
#983: FILE: tools/mesh-tester.c:874:
+               tester_print("Executing no-op test");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#983: FILE: tools/mesh-tester.c:874:
+               tester_print("Executing no-op test");$

ERROR:CODE_INDENT: code indent should use tabs where possible
#984: FILE: tools/mesh-tester.c:875:
+               return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#984: FILE: tools/mesh-tester.c:875:
+               return;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#985: FILE: tools/mesh-tester.c:876:
+       }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#987: FILE: tools/mesh-tester.c:878:
+       tester_print("Sending %s (0x%04x)", mgmt_opstr(test->send_opcode),$

ERROR:CODE_INDENT: code indent should use tabs where possible
#988: FILE: tools/mesh-tester.c:879:
+                                                       test->send_opcode);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#988: FILE: tools/mesh-tester.c:879:
+                                                       test->send_opcode);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#990: FILE: tools/mesh-tester.c:881:
+       if (test->send_func)$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (7, 15)
#990: FILE: tools/mesh-tester.c:881:
+       if (test->send_func)
+               send_param = test->send_func(&send_len);

ERROR:CODE_INDENT: code indent should use tabs where possible
#991: FILE: tools/mesh-tester.c:882:
+               send_param = test->send_func(&send_len);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#991: FILE: tools/mesh-tester.c:882:
+               send_param = test->send_func(&send_len);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#993: FILE: tools/mesh-tester.c:884:
+       if (test->force_power_off) {$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (7, 15)
#993: FILE: tools/mesh-tester.c:884:
+       if (test->force_power_off) {
+               mgmt_send_nowait(data->mgmt, test->send_opcode, index,

ERROR:CODE_INDENT: code indent should use tabs where possible
#994: FILE: tools/mesh-tester.c:885:
+               mgmt_send_nowait(data->mgmt, test->send_opcode, index,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#994: FILE: tools/mesh-tester.c:885:
+               mgmt_send_nowait(data->mgmt, test->send_opcode, index,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#995: FILE: tools/mesh-tester.c:886:
+                                       send_len, send_param,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#995: FILE: tools/mesh-tester.c:886:
+                                       send_len, send_param,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#996: FILE: tools/mesh-tester.c:887:
+                                       command_generic_callback, NULL, NULL);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#996: FILE: tools/mesh-tester.c:887:
+                                       command_generic_callback, NULL, NULL);$

ERROR:CODE_INDENT: code indent should use tabs where possible
#997: FILE: tools/mesh-tester.c:888:
+               power_off(data->mgmt_index);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#997: FILE: tools/mesh-tester.c:888:
+               power_off(data->mgmt_index);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#998: FILE: tools/mesh-tester.c:889:
+       } else {$

WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (7, 15)
#998: FILE: tools/mesh-tester.c:889:
+       } else {
+               mgmt_send(data->mgmt, test->send_opcode, index, send_len,

ERROR:CODE_INDENT: code indent should use tabs where possible
#999: FILE: tools/mesh-tester.c:890:
+               mgmt_send(data->mgmt, test->send_opcode, index, send_len,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#999: FILE: tools/mesh-tester.c:890:
+               mgmt_send(data->mgmt, test->send_opcode, index, send_len,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#1000: FILE: tools/mesh-tester.c:891:
+                                       send_param, command_generic_callback,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#1000: FILE: tools/mesh-tester.c:891:
+                                       send_param, command_generic_callback,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#1001: FILE: tools/mesh-tester.c:892:
+                                       NULL, NULL);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#1001: FILE: tools/mesh-tester.c:892:
+                                       NULL, NULL);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#1002: FILE: tools/mesh-tester.c:893:
+       }$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#1004: FILE: tools/mesh-tester.c:895:
+       test_add_condition(data);$

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#1247: FILE: tools/mesh-tester.c:1138:
+		 * for a callback. */

WARNING:LINE_SPACING: Missing a blank line after declarations
#1281: FILE: tools/mesh-tester.c:1172:
+			unsigned char off[] = { 0x00 };
+			tester_print("Setup sending %s (0x%04x)",

/github/workspace/src/12961389.patch total: 36 errors, 66 warnings, 1472 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12961389.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4753361953263725352==--
