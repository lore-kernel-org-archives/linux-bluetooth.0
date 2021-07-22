Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4835C6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B779C6127C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGVHJb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhGVHJ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 03:09:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59668C061575
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:50:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bt15so5025430pjb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ndSVAW3iRtufV7R2AXFIwT6AFyV0rBvngCbYgMD1GRM=;
        b=NttiZSBP7jmvBINhUk5ckdpM/Z+U/OwOyq6bfhWBam1gcnkOt5TpzHPTjruSYPw3l/
         CKel8684HH5xsCeXbF3w3kgLRkKa9uICtN/YoxQNweu7lTftBsQT3NnEmrdN+ZZBTooK
         Z49qOfl8Z20K9UTXX0B++xtDF0z20HCyHEAEZvzCDd/Uz+CowXuBewNp+2wnpNFYmRPd
         nQkcvTBCQS90Eh/BNaTEzCQH9I9ipjJq2JEtiPO1dvMXaA/FDiOqEpUn67Wyhvsvmndl
         doxaYaohL6r9+ZYADF2ZmiJw6pBvKV1Iocv3jLI3qHaCgVfPeBva+QraGvbjSPrRs01V
         VWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ndSVAW3iRtufV7R2AXFIwT6AFyV0rBvngCbYgMD1GRM=;
        b=eBGHRyPsqJdC6APfjL+9qpvWb91hwtlPvolfa6DllwjfdS6hlptAL+e6jsRCmbjEPQ
         zgwYRnGVTP+kuivn/1LOX7225UADBYhA0lBIM0JPLjoZMgGRx3Np5PjBZZFAm0gcgF/d
         7htSfrR0fM/sxGB+l+HhrTNR2KGfTPkP+vMsD1dUf6CUO8aubLPPfCCITcHaQp55HZNh
         OiDof+rKK5ZHMXv4MwVakTpws2fG/YLCj+24gvGwiuTkLA2lzhOzhFZiCgphs+VD0Wdd
         WPvXjkOvgOdF+Eo94TH29hFoRlI2p1fEOilHUH4PMq1JsK/SUmgSfthcS+GwhJQ4PNsB
         D7Og==
X-Gm-Message-State: AOAM5336Z7bKxsah3yaZwUoE4K7Xxr/atwyAdiMIkrFSFXZtrwAZvC2T
        Sro3vTJhsP13/lXIy/IPxrSGLdR9vVc=
X-Google-Smtp-Source: ABdhPJxapgwYIRux1C7G5AmmvEbxcAl9LY8ZZj1Uzyz60FncOxWD5JP0CEKuOy2UbWiQsm480gfnEw==
X-Received: by 2002:a05:6a00:189d:b029:338:c077:ba11 with SMTP id x29-20020a056a00189db0290338c077ba11mr30890610pfh.21.1626940202670;
        Thu, 22 Jul 2021 00:50:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.175.249.50])
        by smtp.gmail.com with ESMTPSA id z6sm2182826pjr.50.2021.07.22.00.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 00:50:02 -0700 (PDT)
Message-ID: <60f9232a.1c69fb81.ecd77.79a1@mx.google.com>
Date:   Thu, 22 Jul 2021 00:50:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7354260759179685985=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: Hi manintainers,
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210722152159.Bluez.v2.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
References: <20210722152159.Bluez.v2.1.Ic71b1ed97538a06d02425ba502690bdab1c5d836@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7354260759179685985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=519517

---Test result---

Test Summary:
CheckPatch                    FAIL      4.32 seconds
GitLint                       PASS      1.46 seconds
Prep - Setup ELL              PASS      53.87 seconds
Build - Prep                  PASS      0.17 seconds
Build - Configure             PASS      9.65 seconds
Build - Make                  FAIL      102.43 seconds
Make Check                    FAIL      0.45 seconds
Make Distcheck                FAIL      109.03 seconds
Build w/ext ELL - Configure   PASS      9.76 seconds
Build w/ext ELL - Make        FAIL      87.91 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
plugins/admin_policy: add ServiceAllowList property
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#63: FILE: plugins/admin_policy.c:186:
+					const GDBusPropertyTable *property,
 					                         ^

- total: 1 errors, 0 warnings, 82 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin_policy: add ServiceAllowList property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins/admin_policy: add AffectedByPolicy property
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#65: FILE: plugins/admin_policy.c:268:
+					const GDBusPropertyTable *property,
 					                         ^

- total: 1 errors, 0 warnings, 121 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin_policy: add AffectedByPolicy property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

plugins/admin_policy: persist policy settings
WARNING:LINE_SPACING: Missing a blank line after declarations
#151: FILE: plugins/admin_policy.c:337:
+	struct queue *uuid_list = NULL;
+	gchar **uuids = NULL;

- total: 0 errors, 1 warnings, 204 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] plugins/admin_policy: persist policy settings" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - FAIL
Desc: Build the BlueZ source tree
Output:
/usr/bin/ld: src/adapter.o: in function `start_discovery_timeout':
/github/workspace/src/src/adapter.c:1732: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `device_path_cmp':
/github/workspace/src/src/adapter.c:901: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `parse_discoverable':
/github/workspace/src/src/adapter.c:2449: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2452: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_duplicate_data':
/github/workspace/src/src/adapter.c:2438: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2441: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `process_auth_queue':
/github/workspace/src/src/adapter.c:7101: undefined reference to `dbus_error_init'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7102: undefined reference to `dbus_set_error_const'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7121: undefined reference to `agent_get'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7129: undefined reference to `agent_authorize_service'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7139: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7112: undefined reference to `device_is_trusted'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7146: undefined reference to `dbus_error_free'
/usr/bin/ld: src/adapter.o: in function `agent_auth_cb':
/github/workspace/src/src/adapter.c:7077: undefined reference to `agent_unref'
/usr/bin/ld: src/adapter.o: in function `invalidate_rssi_and_tx_power':
/github/workspace/src/src/adapter.c:1512: undefined reference to `device_set_rssi'
/usr/bin/ld: src/adapter.o: in function `adapter_remove_connection':
/github/workspace/src/src/adapter.c:6978: undefined reference to `device_remove_connection'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6980: undefined reference to `device_is_authenticating'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6984: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6981: undefined reference to `device_cancel_authentication'
/usr/bin/ld: src/adapter.o: in function `discovery_complete':
/github/workspace/src/src/adapter.c:1622: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1623: undefined reference to `g_dbus_send_message'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1626: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1620: undefined reference to `g_dbus_send_reply'
/usr/bin/ld: src/adapter.o: in function `property_get_modalias':
/github/workspace/src/src/adapter.c:3216: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `iter_append_uuid':
/github/workspace/src/src/adapter.c:3159: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_discovering':
/github/workspace/src/src/adapter.c:3131: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_pairable_timeout':
/github/workspace/src/src/adapter.c:3099: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_mode':
/github/workspace/src/src/adapter.c:2810: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o:/github/workspace/src/src/adapter.c:2810: more undefined references to `dbus_message_iter_append_basic' follow
/usr/bin/ld: src/adapter.o: in function `property_get_roles':
/github/workspace/src/src/adapter.c:3227: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3245: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3232: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3237: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3242: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_uuids':
/github/workspace/src/src/adapter.c:3180: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3188: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3192: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3195: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: src/adapter.o: in function `get_discovery_filters':
/github/workspace/src/src/adapter.c:3290: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3292: undefined reference to `dbus_message_iter_init_append'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3294: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3298: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3302: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: src/adapter.o: in function `parse_discovery_filter_dict':
/github/workspace/src/src/adapter.c:2526: undefined reference to `dbus_message_iter_init'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2527: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2528: undefined reference to `dbus_message_iter_get_element_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2531: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2533: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2540: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2542: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2543: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2546: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2550: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2555: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: src/adapter.o: in function `convert_file':
/github/workspace/src/src/adapter.c:5791: undefined reference to `textfile_foreach'
/usr/bin/ld: src/adapter.o: in function `convert_proximity_entry':
/github/workspace/src/src/adapter.c:6162: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_gatt_entry':
/github/workspace/src/src/adapter.c:6117: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_ccc_entry':
/github/workspace/src/src/adapter.c:6070: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_names_entry':
/github/workspace/src/src/adapter.c:5533: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_primaries_entry':
/github/workspace/src/src/adapter.c:5979: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5992: undefined reference to `bt_string2uuid'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6004: undefined reference to `create_file'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6021: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_entry':
/github/workspace/src/src/adapter.c:5769: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `fix_storage':
/github/workspace/src/src/adapter.c:6276: undefined reference to `textfile_get'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6282: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6285: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6288: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6291: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6294: undefined reference to `textfile_del'
/usr/bin/ld: src/adapter.o:/github/workspace/src/src/adapter.c:6297: more undefined references to `textfile_del' follow
/usr/bin/ld: src/adapter.o: in function `probe_devices':
/github/workspace/src/src/adapter.c:4305: undefined reference to `btd_device_get_uuids'
/usr/bin/ld: src/adapter.o: in function `rpa_resolution_func':
/github/workspace/src/src/adapter.c:9398: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `exp_debug_func':
/github/workspace/src/src/adapter.c:9353: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `local_name_changed_callback':
/github/workspace/src/src/adapter.c:780: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_service_insert':
/github/workspace/src/src/adapter.c:1173: undefined reference to `record_sort'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1173: undefined reference to `record_sort'
/usr/bin/ld: src/adapter.o: in function `parse_pathloss':
/github/workspace/src/src/adapter.c:2404: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2407: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_rssi':
/github/workspace/src/src/adapter.c:2390: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2393: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_pattern':
/github/workspace/src/src/adapter.c:2462: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2465: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_transport':
/github/workspace/src/src/adapter.c:2420: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2423: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_uuids':
/github/workspace/src/src/adapter.c:2359: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2362: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2368: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2372: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2382: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2363: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: src/adapter.o: in function `adapter_add_connection':
/github/workspace/src/src/adapter.c:4826: undefined reference to `device_add_connection'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src/src/adapter.c:5915: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5918: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5920: undefined reference to `record_from_string'
/usr/bin/ld: src/adapter.o: in function `record_has_uuid':
/github/workspace/src/src/adapter.c:5803: undefined reference to `bt_uuid2string'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src/src/adapter.c:5926: undefined reference to `gatt_parse_record'
/usr/bin/ld: src/adapter.o: in function `store_sdp_record':
/github/workspace/src/src/adapter.c:5865: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src/src/adapter.c:5939: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `discovery_free':
/github/workspace/src/src/adapter.c:1565: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1552: undefined reference to `g_dbus_remove_watch'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1561: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1561: undefined reference to `g_dbus_send_message'
/usr/bin/ld: src/adapter.o: in function `store_adapter_info':
/github/workspace/src/src/adapter.c:486: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/src/adapter.c:511: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `property_set_pairable_timeout':
/github/workspace/src/src/adapter.c:3111: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3115: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3119: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `property_set_alias':
/github/workspace/src/src/adapter.c:2747: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2788: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2779: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2784: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `store_link_key':
/github/workspace/src/src/adapter.c:8055: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8070: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `remove_keys':
/github/workspace/src/src/adapter.c:9085: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `load_config':
/github/workspace/src/src/adapter.c:6362: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6380: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `convert_config':
/github/workspace/src/src/adapter.c:6243: undefined reference to `read_pairable_timeout'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6247: undefined reference to `read_discoverable_timeout'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6251: undefined reference to `read_on_mode'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6257: undefined reference to `read_local_name'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6260: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_device_storage':
/github/workspace/src/src/adapter.c:6179: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6195: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6211: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6215: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6222: undefined reference to `textfile_foreach'
/usr/bin/ld: src/adapter.o:/github/workspace/src/src/adapter.c:6226: more undefined references to `textfile_foreach' follow
/usr/bin/ld: src/adapter.o: in function `load_devices':
/github/workspace/src/src/adapter.c:4647: undefined reference to `device_address_cmp'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4668: undefined reference to `device_set_paired'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4669: undefined reference to `device_set_bonded'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4673: undefined reference to `device_set_paired'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4674: undefined reference to `device_set_bonded'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4680: undefined reference to `device_set_ltk_enc_size'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4690: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4654: undefined reference to `device_create_from_storage'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4659: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: src/adapter.o: in function `store_conn_param':
/github/workspace/src/src/adapter.c:8451: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_irk':
/github/workspace/src/src/adapter.c:8359: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_csrk':
/github/workspace/src/src/adapter.c:8291: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_longtermkey':
/github/workspace/src/src/adapter.c:8167: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `adapter_set_name':
/github/workspace/src/src/adapter.c:848: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:857: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_find_device':
/github/workspace/src/src/adapter.c:877: undefined reference to `device_addr_type_cmp'
/usr/bin/ld: /github/workspace/src/src/adapter.c:892: undefined reference to `device_set_le_support'
/usr/bin/ld: /github/workspace/src/src/adapter.c:890: undefined reference to `device_set_bredr_support'
/usr/bin/ld: src/adapter.o: in function `set_device_wakeable_complete':
/github/workspace/src/src/adapter.c:5236: undefined reference to `device_set_wake_allowed_complete'
/usr/bin/ld: src/adapter.o: in function `adapter_authorize':
/github/workspace/src/src/adapter.c:7177: undefined reference to `device_is_disconnecting'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7198: undefined reference to `device_wait_for_svc_complete'
/usr/bin/ld: src/adapter.o: in function `device_unblocked_callback':
/github/workspace/src/src/adapter.c:9004: undefined reference to `device_unblock'
/usr/bin/ld: src/adapter.o: in function `device_blocked_callback':
/github/workspace/src/src/adapter.c:8982: undefined reference to `device_block'
/usr/bin/ld: src/adapter.o: in function `unpaired_callback':
/github/workspace/src/src/adapter.c:9134: undefined reference to `device_set_unpaired'
/usr/bin/ld: src/adapter.o: in function `device_flags_changed_callback':
/github/workspace/src/src/adapter.c:5289: undefined reference to `btd_device_flags_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_service_add':
/github/workspace/src/src/adapter.c:1191: undefined reference to `add_record_to_server'
/usr/bin/ld: src/adapter.o: in function `adapter_service_remove':
/github/workspace/src/src/adapter.c:1202: undefined reference to `sdp_record_find'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1214: undefined reference to `remove_record_from_server'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_remove_device':
/github/workspace/src/src/adapter.c:1263: undefined reference to `btd_adv_monitor_device_remove'
/usr/bin/ld: src/adapter.o: in function `service_auth_cancel':
/github/workspace/src/src/adapter.c:1240: undefined reference to `dbus_error_init'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1241: undefined reference to `dbus_set_error_const'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1245: undefined reference to `dbus_error_free'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1248: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1249: undefined reference to `agent_unref'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_remove_device':
/github/workspace/src/src/adapter.c:1289: undefined reference to `device_remove'
/usr/bin/ld: src/adapter.o: in function `service_auth_cancel':
/github/workspace/src/src/adapter.c:1237: undefined reference to `device_remove_svc_complete_callback'
/usr/bin/ld: src/adapter.o: in function `discovery_cleanup':
/github/workspace/src/src/adapter.c:1539: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1539: undefined reference to `device_is_connectable'
/usr/bin/ld: src/adapter.o: in function `adapter_remove':
/github/workspace/src/src/adapter.c:6441: undefined reference to `device_remove'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6450: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6454: undefined reference to `btd_gatt_database_destroy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6457: undefined reference to `btd_adv_manager_destroy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6460: undefined reference to `btd_adv_monitor_manager_destroy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6463: undefined reference to `btd_battery_provider_manager_destroy'
/usr/bin/ld: src/adapter.o: in function `remove_temporary_devices':
/github/workspace/src/src/adapter.c:626: undefined reference to `device_is_temporary'
/usr/bin/ld: src/adapter.o: in function `adapter_create_device':
/github/workspace/src/src/adapter.c:1223: undefined reference to `device_create'
/usr/bin/ld: src/adapter.o: in function `user_passkey_notify_callback':
/github/workspace/src/src/adapter.c:7598: undefined reference to `device_notify_passkey'
/usr/bin/ld: src/adapter.o: in function `new_irk_callback':
/github/workspace/src/src/adapter.c:8408: undefined reference to `device_update_addr'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8411: undefined reference to `device_merge_duplicate'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8419: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8408: undefined reference to `device_update_addr'
/usr/bin/ld: src/adapter.o: in function `new_csrk_callback':
/github/workspace/src/src/adapter.c:8333: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: src/adapter.o: in function `connected_callback':
/github/workspace/src/src/adapter.c:8923: undefined reference to `device_name_known'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8933: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8926: undefined reference to `device_store_cached_name'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8927: undefined reference to `btd_device_device_set_name'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8916: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8919: undefined reference to `device_set_class'
/usr/bin/ld: src/adapter.o: in function `device_connect_cb':
/github/workspace/src/src/adapter.c:3362: undefined reference to `g_dbus_send_error'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3364: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3339: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3341: undefined reference to `g_dbus_send_reply'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3345: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3346: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3353: undefined reference to `device_discover_services'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3354: undefined reference to `device_wait_for_svc_complete'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3350: undefined reference to `device_attach_att'
/usr/bin/ld: src/adapter.o: in function `adapter_add_profile':
/github/workspace/src/src/adapter.c:4803: undefined reference to `device_probe_profile'
/usr/bin/ld: src/adapter.o: in function `adapter_remove_profile':
/github/workspace/src/src/adapter.c:4814: undefined reference to `device_remove_profile'
/usr/bin/ld: src/adapter.o: in function `bonding_complete':
/github/workspace/src/src/adapter.c:7767: undefined reference to `device_bonding_complete'
/usr/bin/ld: src/adapter.o: in function `bonding_attempt_complete':
/github/workspace/src/src/adapter.c:7796: undefined reference to `device_bonding_attempt_retry'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7803: undefined reference to `device_is_retrying'
/usr/bin/ld: src/adapter.o: in function `connect_failed_callback':
/github/workspace/src/src/adapter.c:9052: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9063: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9071: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9053: undefined reference to `device_cancel_authentication'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9072: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9064: undefined reference to `device_is_retrying'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9065: undefined reference to `device_cancel_authentication'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9066: undefined reference to `device_bonding_failed'
/usr/bin/ld: src/adapter.o: in function `new_long_term_key_callback':
/github/workspace/src/src/adapter.c:8235: undefined reference to `device_set_ltk_enc_size'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8232: undefined reference to `device_set_bonded'
/usr/bin/ld: src/adapter.o: in function `new_link_key_callback':
/github/workspace/src/src/adapter.c:8119: undefined reference to `device_set_bonded'
/usr/bin/ld: src/adapter.o: in function `start_discovery_complete':
/github/workspace/src/src/adapter.c:1680: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `connect_device':
/github/workspace/src/src/adapter.c:3420: undefined reference to `dbus_message_iter_init'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3421: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3477: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3422: undefined reference to `dbus_message_iter_get_element_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3425: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3456: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3460: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3473: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3427: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3434: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3436: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3437: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3440: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3444: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3447: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3451: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3418: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3415: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3480: undefined reference to `btd_error_already_exists'
/usr/bin/ld: src/adapter.o: in function `device_connect':
/github/workspace/src/src/adapter.c:3378: undefined reference to `dbus_message_ref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3400: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3400: undefined reference to `g_dbus_send_message'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3402: undefined reference to `dbus_message_unref'
/usr/bin/ld: src/adapter.o: in function `remove_device':
/github/workspace/src/src/adapter.c:3258: undefined reference to `dbus_message_get_args'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3271: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3273: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3275: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3260: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3267: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3278: undefined reference to `device_request_disconnect'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3264: undefined reference to `btd_error_does_not_exist'
/usr/bin/ld: src/adapter.o: in function `btd_cancel_authorization':
/github/workspace/src/src/adapter.c:7290: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7291: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7284: undefined reference to `device_remove_svc_complete_callback'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_pincode_reply':
/github/workspace/src/src/adapter.c:7419: undefined reference to `device_bonding_restart_timer'
/usr/bin/ld: src/adapter.o: in function `pin_code_request_callback':
/github/workspace/src/src/adapter.c:7685: undefined reference to `device_bonding_iter'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7710: undefined reference to `device_request_pincode'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7693: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7694: undefined reference to `device_notify_pincode'
/usr/bin/ld: src/adapter.o: in function `user_confirm_request_callback':
/github/workspace/src/src/adapter.c:7485: undefined reference to `device_confirm_passkey'
/usr/bin/ld: src/adapter.o: in function `user_passkey_request_callback':
/github/workspace/src/src/adapter.c:7559: undefined reference to `device_request_passkey'
/usr/bin/ld: src/adapter.o: in function `adapter_set_io_capability':
/github/workspace/src/src/adapter.c:8505: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `adapter_init':
/github/workspace/src/src/adapter.c:10044: undefined reference to `btd_get_dbus_connection'
/usr/bin/ld: src/adapter.o: in function `adapter_start':
/github/workspace/src/src/adapter.c:5354: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `settings_changed':
/github/workspace/src/src/adapter.c:570: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:563: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:566: undefined reference to `btd_adv_manager_refresh'
/usr/bin/ld: /github/workspace/src/src/adapter.c:540: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `reply_pending_requests':
/github/workspace/src/src/adapter.c:5373: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5374: undefined reference to `device_bonding_failed'
/usr/bin/ld: src/adapter.o: in function `adapter_stop':
/github/workspace/src/src/adapter.c:7010: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7017: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7028: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `settings_changed':
/github/workspace/src/src/adapter.c:552: undefined reference to `btd_exit'
/usr/bin/ld: src/adapter.o: in function `adapter_stop':
/github/workspace/src/src/adapter.c:7024: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `property_set_mode_complete':
/github/workspace/src/src/adapter.c:2844: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: src/adapter.o: in function `stop_discovery_complete':
/github/workspace/src/src/adapter.c:1971: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_connect_list_add':
/github/workspace/src/src/adapter.c:4994: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4981: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4987: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `adapter_connect_list_remove':
/github/workspace/src/src/adapter.c:5021: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5027: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `stop_passive_scanning_complete':
/github/workspace/src/src/adapter.c:1441: undefined reference to `device_connect_le'
/usr/bin/ld: src/adapter.o: in function `adapter_whitelist_add':
/github/workspace/src/src/adapter.c:5083: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `adapter_whitelist_remove':
/github/workspace/src/src/adapter.c:5122: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `adapter_auto_connect_add':
/github/workspace/src/src/adapter.c:5178: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5183: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5184: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: src/adapter.o: in function `adapter_set_device_wakeable':
/github/workspace/src/src/adapter.c:5249: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5250: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5255: undefined reference to `btd_device_get_current_flags'
/usr/bin/ld: src/adapter.o: in function `adapter_auto_connect_remove':
/github/workspace/src/src/adapter.c:5331: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5332: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5327: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_new':
/github/workspace/src/src/adapter.c:6408: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6411: undefined reference to `bt_modalias'
/usr/bin/ld: src/adapter.o: in function `update_found_devices':
/github/workspace/src/src/adapter.c:6741: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6761: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6731: undefined reference to `btd_adv_monitor_content_filter'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6741: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6787: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6804: undefined reference to `device_set_legacy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6807: undefined reference to `device_set_rssi_with_delta'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6812: undefined reference to `device_set_tx_power'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6819: undefined reference to `device_name_known'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6822: undefined reference to `btd_device_device_set_name'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6834: undefined reference to `device_add_eir_uuids'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6841: undefined reference to `device_set_manufacturer_data'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6846: undefined reference to `device_set_service_data'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6849: undefined reference to `device_set_data'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6854: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6858: undefined reference to `btd_adv_monitor_notify_monitors'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6775: undefined reference to `device_set_bredr_support'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6777: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6829: undefined reference to `btd_device_set_pnpid'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6809: undefined reference to `device_set_rssi'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6788: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6815: undefined reference to `device_set_appearance'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6852: undefined reference to `device_set_flags'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6825: undefined reference to `device_set_class'
/usr/bin/ld: src/adapter.o: in function `adapter_create_device':
/github/workspace/src/src/adapter.c:1223: undefined reference to `device_create'
/usr/bin/ld: src/adapter.o: in function `update_found_devices':
/github/workspace/src/src/adapter.c:6909: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6781: undefined reference to `device_store_cached_name'
/usr/bin/ld: src/adapter.o: in function `property_set_mode':
/github/workspace/src/src/adapter.c:2889: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2974: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2892: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2903: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: src/adapter.o: in function `property_set_discoverable_timeout':
/github/workspace/src/src/adapter.c:3048: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3052: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3056: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `set_discovery_filter':
/github/workspace/src/src/adapter.c:2591: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2639: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2597: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2600: undefined reference to `btd_error_not_supported'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2604: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2630: undefined reference to `g_dbus_add_disconnect_watch'
/usr/bin/ld: src/adapter.o: in function `start_discovery':
/github/workspace/src/src/adapter.c:2289: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2306: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2297: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2329: undefined reference to `g_dbus_add_disconnect_watch'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2352: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2343: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2347: undefined reference to `dbus_message_ref'
/usr/bin/ld: src/adapter.o: in function `discovery_stop':
/github/workspace/src/src/adapter.c:2231: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `stop_discovery':
/github/workspace/src/src/adapter.c:2646: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2671: undefined reference to `dbus_message_ref'
/usr/bin/ld: src/adapter.o: in function `read_info_complete':
/github/workspace/src/src/adapter.c:9544: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `adapter_register':
/github/workspace/src/src/adapter.c:8729: undefined reference to `g_dbus_register_interface'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8747: undefined reference to `agent_get'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8749: undefined reference to `agent_get_io_capability'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8751: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8761: undefined reference to `btd_gatt_database_new'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8769: undefined reference to `btd_adv_manager_new'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8771: undefined reference to `g_dbus_get_flags'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8774: undefined reference to `btd_adv_monitor_manager_create'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8788: undefined reference to `g_dbus_get_flags'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8793: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8807: undefined reference to `btd_profile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8813: undefined reference to `btd_gatt_database_restore_svc_chng_ccc'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8825: undefined reference to `sdp_record_find'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8790: undefined reference to `btd_battery_provider_manager_create'
/usr/bin/ld: src/adapter.o: in function `services_modified':
/github/workspace/src/src/adapter.c:8715: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `update_device_allowed_services':
/github/workspace/src/src/adapter.c:3490: undefined reference to `btd_device_update_allowed_services'
/usr/bin/ld: src/adapter.o: in function `invalidate_rssi_and_tx_power':
/github/workspace/src/src/adapter.c:1513: undefined reference to `device_set_tx_power'
/usr/bin/ld: src/adapter.o: in function `pincode_reply_complete':
/github/workspace/src/src/adapter.c:7380: undefined reference to `device_bonding_restart_timer'
/usr/bin/ld: src/adapter.o: in function `device_browse_cb':
/github/workspace/src/src/adapter.c:3319: undefined reference to `btd_device_connect_services'
/usr/bin/ld: src/adapter.o: in function `probe_devices':
/github/workspace/src/src/adapter.c:4305: undefined reference to `device_probe_profiles'
/usr/bin/ld: src/adapter.o: in function `dev_class_changed_callback':
/github/workspace/src/src/adapter.c:367: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `add_uuid_complete':
/github/workspace/src/src/adapter.c:969: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `local_name_changed_callback':
/github/workspace/src/src/adapter.c:783: undefined reference to `attrib_gap_set'
/usr/bin/ld: src/adapter.o: in function `add_uuid_complete':
/github/workspace/src/src/adapter.c:969: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_unref':
/github/workspace/src/src/adapter.c:5513: undefined reference to `g_dbus_unregister_interface'
/usr/bin/ld: src/adapter.o: in function `adapter_get_agent':
/github/workspace/src/src/adapter.c:6964: undefined reference to `agent_get'
/usr/bin/ld: src/adapter.o: in function `property_set_mode_complete':
/github/workspace/src/src/adapter.c:2839: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `adapter_shutdown':
/github/workspace/src/src/adapter.c:10127: undefined reference to `btd_exit'
/usr/bin/ld: src/adapter.o: in function `property_set_discoverable':
/github/workspace/src/src/adapter.c:3016: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `property_set_powered':
/github/workspace/src/src/adapter.c:2992: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `stop_discovery':
/github/workspace/src/src/adapter.c:2664: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2675: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2654: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2669: undefined reference to `dbus_message_new_method_return'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5952: tools/mcaptest] Error 1
make: *** [Makefile:4142: all] Error 2


##############################
Test: Make Check - FAIL
Desc: Run 'make check'
Output:
/usr/bin/ld: src/adapter.o: in function `start_discovery_timeout':
/github/workspace/src/src/adapter.c:1732: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `device_path_cmp':
/github/workspace/src/src/adapter.c:901: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `parse_discoverable':
/github/workspace/src/src/adapter.c:2449: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2452: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_duplicate_data':
/github/workspace/src/src/adapter.c:2438: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2441: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `process_auth_queue':
/github/workspace/src/src/adapter.c:7101: undefined reference to `dbus_error_init'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7102: undefined reference to `dbus_set_error_const'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7121: undefined reference to `agent_get'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7129: undefined reference to `agent_authorize_service'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7139: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7112: undefined reference to `device_is_trusted'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7146: undefined reference to `dbus_error_free'
/usr/bin/ld: src/adapter.o: in function `agent_auth_cb':
/github/workspace/src/src/adapter.c:7077: undefined reference to `agent_unref'
/usr/bin/ld: src/adapter.o: in function `invalidate_rssi_and_tx_power':
/github/workspace/src/src/adapter.c:1512: undefined reference to `device_set_rssi'
/usr/bin/ld: src/adapter.o: in function `adapter_remove_connection':
/github/workspace/src/src/adapter.c:6978: undefined reference to `device_remove_connection'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6980: undefined reference to `device_is_authenticating'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6984: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6981: undefined reference to `device_cancel_authentication'
/usr/bin/ld: src/adapter.o: in function `discovery_complete':
/github/workspace/src/src/adapter.c:1622: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1623: undefined reference to `g_dbus_send_message'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1626: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1620: undefined reference to `g_dbus_send_reply'
/usr/bin/ld: src/adapter.o: in function `property_get_modalias':
/github/workspace/src/src/adapter.c:3216: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `iter_append_uuid':
/github/workspace/src/src/adapter.c:3159: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_discovering':
/github/workspace/src/src/adapter.c:3131: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_pairable_timeout':
/github/workspace/src/src/adapter.c:3099: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_mode':
/github/workspace/src/src/adapter.c:2810: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o:/github/workspace/src/src/adapter.c:2810: more undefined references to `dbus_message_iter_append_basic' follow
/usr/bin/ld: src/adapter.o: in function `property_get_roles':
/github/workspace/src/src/adapter.c:3227: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3245: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3232: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3237: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3242: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_uuids':
/github/workspace/src/src/adapter.c:3180: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3188: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3192: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3195: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: src/adapter.o: in function `get_discovery_filters':
/github/workspace/src/src/adapter.c:3290: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3292: undefined reference to `dbus_message_iter_init_append'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3294: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3298: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3302: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: src/adapter.o: in function `parse_discovery_filter_dict':
/github/workspace/src/src/adapter.c:2526: undefined reference to `dbus_message_iter_init'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2527: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2528: undefined reference to `dbus_message_iter_get_element_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2531: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2533: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2540: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2542: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2543: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2546: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2550: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2555: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: src/adapter.o: in function `convert_file':
/github/workspace/src/src/adapter.c:5791: undefined reference to `textfile_foreach'
/usr/bin/ld: src/adapter.o: in function `convert_proximity_entry':
/github/workspace/src/src/adapter.c:6162: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_gatt_entry':
/github/workspace/src/src/adapter.c:6117: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_ccc_entry':
/github/workspace/src/src/adapter.c:6070: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_names_entry':
/github/workspace/src/src/adapter.c:5533: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_primaries_entry':
/github/workspace/src/src/adapter.c:5979: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5992: undefined reference to `bt_string2uuid'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6004: undefined reference to `create_file'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6021: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_entry':
/github/workspace/src/src/adapter.c:5769: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `fix_storage':
/github/workspace/src/src/adapter.c:6276: undefined reference to `textfile_get'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6282: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6285: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6288: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6291: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6294: undefined reference to `textfile_del'
/usr/bin/ld: src/adapter.o:/github/workspace/src/src/adapter.c:6297: more undefined references to `textfile_del' follow
/usr/bin/ld: src/adapter.o: in function `probe_devices':
/github/workspace/src/src/adapter.c:4305: undefined reference to `btd_device_get_uuids'
/usr/bin/ld: src/adapter.o: in function `rpa_resolution_func':
/github/workspace/src/src/adapter.c:9398: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `exp_debug_func':
/github/workspace/src/src/adapter.c:9353: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `local_name_changed_callback':
/github/workspace/src/src/adapter.c:780: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_service_insert':
/github/workspace/src/src/adapter.c:1173: undefined reference to `record_sort'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1173: undefined reference to `record_sort'
/usr/bin/ld: src/adapter.o: in function `parse_pathloss':
/github/workspace/src/src/adapter.c:2404: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2407: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_rssi':
/github/workspace/src/src/adapter.c:2390: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2393: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_pattern':
/github/workspace/src/src/adapter.c:2462: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2465: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_transport':
/github/workspace/src/src/adapter.c:2420: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2423: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_uuids':
/github/workspace/src/src/adapter.c:2359: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2362: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2368: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2372: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2382: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2363: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: src/adapter.o: in function `adapter_add_connection':
/github/workspace/src/src/adapter.c:4826: undefined reference to `device_add_connection'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src/src/adapter.c:5915: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5918: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5920: undefined reference to `record_from_string'
/usr/bin/ld: src/adapter.o: in function `record_has_uuid':
/github/workspace/src/src/adapter.c:5803: undefined reference to `bt_uuid2string'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src/src/adapter.c:5926: undefined reference to `gatt_parse_record'
/usr/bin/ld: src/adapter.o: in function `store_sdp_record':
/github/workspace/src/src/adapter.c:5865: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src/src/adapter.c:5939: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `discovery_free':
/github/workspace/src/src/adapter.c:1565: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1552: undefined reference to `g_dbus_remove_watch'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1561: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1561: undefined reference to `g_dbus_send_message'
/usr/bin/ld: src/adapter.o: in function `store_adapter_info':
/github/workspace/src/src/adapter.c:486: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/src/adapter.c:511: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `property_set_pairable_timeout':
/github/workspace/src/src/adapter.c:3111: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3115: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3119: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `property_set_alias':
/github/workspace/src/src/adapter.c:2747: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2788: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2779: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2784: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `store_link_key':
/github/workspace/src/src/adapter.c:8055: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8070: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `remove_keys':
/github/workspace/src/src/adapter.c:9085: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `load_config':
/github/workspace/src/src/adapter.c:6362: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6380: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `convert_config':
/github/workspace/src/src/adapter.c:6243: undefined reference to `read_pairable_timeout'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6247: undefined reference to `read_discoverable_timeout'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6251: undefined reference to `read_on_mode'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6257: undefined reference to `read_local_name'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6260: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_device_storage':
/github/workspace/src/src/adapter.c:6179: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6195: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6211: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6215: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6222: undefined reference to `textfile_foreach'
/usr/bin/ld: src/adapter.o:/github/workspace/src/src/adapter.c:6226: more undefined references to `textfile_foreach' follow
/usr/bin/ld: src/adapter.o: in function `load_devices':
/github/workspace/src/src/adapter.c:4647: undefined reference to `device_address_cmp'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4668: undefined reference to `device_set_paired'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4669: undefined reference to `device_set_bonded'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4673: undefined reference to `device_set_paired'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4674: undefined reference to `device_set_bonded'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4680: undefined reference to `device_set_ltk_enc_size'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4690: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4654: undefined reference to `device_create_from_storage'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4659: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: src/adapter.o: in function `store_conn_param':
/github/workspace/src/src/adapter.c:8451: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_irk':
/github/workspace/src/src/adapter.c:8359: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_csrk':
/github/workspace/src/src/adapter.c:8291: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_longtermkey':
/github/workspace/src/src/adapter.c:8167: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `adapter_set_name':
/github/workspace/src/src/adapter.c:848: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:857: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_find_device':
/github/workspace/src/src/adapter.c:877: undefined reference to `device_addr_type_cmp'
/usr/bin/ld: /github/workspace/src/src/adapter.c:892: undefined reference to `device_set_le_support'
/usr/bin/ld: /github/workspace/src/src/adapter.c:890: undefined reference to `device_set_bredr_support'
/usr/bin/ld: src/adapter.o: in function `set_device_wakeable_complete':
/github/workspace/src/src/adapter.c:5236: undefined reference to `device_set_wake_allowed_complete'
/usr/bin/ld: src/adapter.o: in function `adapter_authorize':
/github/workspace/src/src/adapter.c:7177: undefined reference to `device_is_disconnecting'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7198: undefined reference to `device_wait_for_svc_complete'
/usr/bin/ld: src/adapter.o: in function `device_unblocked_callback':
/github/workspace/src/src/adapter.c:9004: undefined reference to `device_unblock'
/usr/bin/ld: src/adapter.o: in function `device_blocked_callback':
/github/workspace/src/src/adapter.c:8982: undefined reference to `device_block'
/usr/bin/ld: src/adapter.o: in function `unpaired_callback':
/github/workspace/src/src/adapter.c:9134: undefined reference to `device_set_unpaired'
/usr/bin/ld: src/adapter.o: in function `device_flags_changed_callback':
/github/workspace/src/src/adapter.c:5289: undefined reference to `btd_device_flags_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_service_add':
/github/workspace/src/src/adapter.c:1191: undefined reference to `add_record_to_server'
/usr/bin/ld: src/adapter.o: in function `adapter_service_remove':
/github/workspace/src/src/adapter.c:1202: undefined reference to `sdp_record_find'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1214: undefined reference to `remove_record_from_server'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_remove_device':
/github/workspace/src/src/adapter.c:1263: undefined reference to `btd_adv_monitor_device_remove'
/usr/bin/ld: src/adapter.o: in function `service_auth_cancel':
/github/workspace/src/src/adapter.c:1240: undefined reference to `dbus_error_init'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1241: undefined reference to `dbus_set_error_const'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1245: undefined reference to `dbus_error_free'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1248: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1249: undefined reference to `agent_unref'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_remove_device':
/github/workspace/src/src/adapter.c:1289: undefined reference to `device_remove'
/usr/bin/ld: src/adapter.o: in function `service_auth_cancel':
/github/workspace/src/src/adapter.c:1237: undefined reference to `device_remove_svc_complete_callback'
/usr/bin/ld: src/adapter.o: in function `discovery_cleanup':
/github/workspace/src/src/adapter.c:1539: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:1539: undefined reference to `device_is_connectable'
/usr/bin/ld: src/adapter.o: in function `adapter_remove':
/github/workspace/src/src/adapter.c:6441: undefined reference to `device_remove'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6450: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6454: undefined reference to `btd_gatt_database_destroy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6457: undefined reference to `btd_adv_manager_destroy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6460: undefined reference to `btd_adv_monitor_manager_destroy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6463: undefined reference to `btd_battery_provider_manager_destroy'
/usr/bin/ld: src/adapter.o: in function `remove_temporary_devices':
/github/workspace/src/src/adapter.c:626: undefined reference to `device_is_temporary'
/usr/bin/ld: src/adapter.o: in function `adapter_create_device':
/github/workspace/src/src/adapter.c:1223: undefined reference to `device_create'
/usr/bin/ld: src/adapter.o: in function `user_passkey_notify_callback':
/github/workspace/src/src/adapter.c:7598: undefined reference to `device_notify_passkey'
/usr/bin/ld: src/adapter.o: in function `new_irk_callback':
/github/workspace/src/src/adapter.c:8408: undefined reference to `device_update_addr'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8411: undefined reference to `device_merge_duplicate'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8419: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8408: undefined reference to `device_update_addr'
/usr/bin/ld: src/adapter.o: in function `new_csrk_callback':
/github/workspace/src/src/adapter.c:8333: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: src/adapter.o: in function `connected_callback':
/github/workspace/src/src/adapter.c:8923: undefined reference to `device_name_known'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8933: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8926: undefined reference to `device_store_cached_name'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8927: undefined reference to `btd_device_device_set_name'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8916: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8919: undefined reference to `device_set_class'
/usr/bin/ld: src/adapter.o: in function `device_connect_cb':
/github/workspace/src/src/adapter.c:3362: undefined reference to `g_dbus_send_error'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3364: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3339: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3341: undefined reference to `g_dbus_send_reply'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3345: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3346: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3353: undefined reference to `device_discover_services'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3354: undefined reference to `device_wait_for_svc_complete'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3350: undefined reference to `device_attach_att'
/usr/bin/ld: src/adapter.o: in function `adapter_add_profile':
/github/workspace/src/src/adapter.c:4803: undefined reference to `device_probe_profile'
/usr/bin/ld: src/adapter.o: in function `adapter_remove_profile':
/github/workspace/src/src/adapter.c:4814: undefined reference to `device_remove_profile'
/usr/bin/ld: src/adapter.o: in function `bonding_complete':
/github/workspace/src/src/adapter.c:7767: undefined reference to `device_bonding_complete'
/usr/bin/ld: src/adapter.o: in function `bonding_attempt_complete':
/github/workspace/src/src/adapter.c:7796: undefined reference to `device_bonding_attempt_retry'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7803: undefined reference to `device_is_retrying'
/usr/bin/ld: src/adapter.o: in function `connect_failed_callback':
/github/workspace/src/src/adapter.c:9052: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9063: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9071: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9053: undefined reference to `device_cancel_authentication'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9072: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9064: undefined reference to `device_is_retrying'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9065: undefined reference to `device_cancel_authentication'
/usr/bin/ld: /github/workspace/src/src/adapter.c:9066: undefined reference to `device_bonding_failed'
/usr/bin/ld: src/adapter.o: in function `new_long_term_key_callback':
/github/workspace/src/src/adapter.c:8235: undefined reference to `device_set_ltk_enc_size'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8232: undefined reference to `device_set_bonded'
/usr/bin/ld: src/adapter.o: in function `new_link_key_callback':
/github/workspace/src/src/adapter.c:8119: undefined reference to `device_set_bonded'
/usr/bin/ld: src/adapter.o: in function `start_discovery_complete':
/github/workspace/src/src/adapter.c:1680: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `connect_device':
/github/workspace/src/src/adapter.c:3420: undefined reference to `dbus_message_iter_init'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3421: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3477: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3422: undefined reference to `dbus_message_iter_get_element_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3425: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3456: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3460: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3473: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3427: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3434: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3436: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3437: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3440: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3444: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3447: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3451: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3418: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3415: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3480: undefined reference to `btd_error_already_exists'
/usr/bin/ld: src/adapter.o: in function `device_connect':
/github/workspace/src/src/adapter.c:3378: undefined reference to `dbus_message_ref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3400: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3400: undefined reference to `g_dbus_send_message'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3402: undefined reference to `dbus_message_unref'
/usr/bin/ld: src/adapter.o: in function `remove_device':
/github/workspace/src/src/adapter.c:3258: undefined reference to `dbus_message_get_args'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3271: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3273: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3275: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3260: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3267: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3278: undefined reference to `device_request_disconnect'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3264: undefined reference to `btd_error_does_not_exist'
/usr/bin/ld: src/adapter.o: in function `btd_cancel_authorization':
/github/workspace/src/src/adapter.c:7290: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7291: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7284: undefined reference to `device_remove_svc_complete_callback'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_pincode_reply':
/github/workspace/src/src/adapter.c:7419: undefined reference to `device_bonding_restart_timer'
/usr/bin/ld: src/adapter.o: in function `pin_code_request_callback':
/github/workspace/src/src/adapter.c:7685: undefined reference to `device_bonding_iter'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7710: undefined reference to `device_request_pincode'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7693: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7694: undefined reference to `device_notify_pincode'
/usr/bin/ld: src/adapter.o: in function `user_confirm_request_callback':
/github/workspace/src/src/adapter.c:7485: undefined reference to `device_confirm_passkey'
/usr/bin/ld: src/adapter.o: in function `user_passkey_request_callback':
/github/workspace/src/src/adapter.c:7559: undefined reference to `device_request_passkey'
/usr/bin/ld: src/adapter.o: in function `adapter_set_io_capability':
/github/workspace/src/src/adapter.c:8505: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `adapter_init':
/github/workspace/src/src/adapter.c:10044: undefined reference to `btd_get_dbus_connection'
/usr/bin/ld: src/adapter.o: in function `adapter_start':
/github/workspace/src/src/adapter.c:5354: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `settings_changed':
/github/workspace/src/src/adapter.c:570: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:563: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:566: undefined reference to `btd_adv_manager_refresh'
/usr/bin/ld: /github/workspace/src/src/adapter.c:540: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `reply_pending_requests':
/github/workspace/src/src/adapter.c:5373: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5374: undefined reference to `device_bonding_failed'
/usr/bin/ld: src/adapter.o: in function `adapter_stop':
/github/workspace/src/src/adapter.c:7010: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7017: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:7028: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `settings_changed':
/github/workspace/src/src/adapter.c:552: undefined reference to `btd_exit'
/usr/bin/ld: src/adapter.o: in function `adapter_stop':
/github/workspace/src/src/adapter.c:7024: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `property_set_mode_complete':
/github/workspace/src/src/adapter.c:2844: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: src/adapter.o: in function `stop_discovery_complete':
/github/workspace/src/src/adapter.c:1971: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_connect_list_add':
/github/workspace/src/src/adapter.c:4994: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4981: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:4987: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `adapter_connect_list_remove':
/github/workspace/src/src/adapter.c:5021: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5027: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `stop_passive_scanning_complete':
/github/workspace/src/src/adapter.c:1441: undefined reference to `device_connect_le'
/usr/bin/ld: src/adapter.o: in function `adapter_whitelist_add':
/github/workspace/src/src/adapter.c:5083: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `adapter_whitelist_remove':
/github/workspace/src/src/adapter.c:5122: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `adapter_auto_connect_add':
/github/workspace/src/src/adapter.c:5178: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5183: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5184: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: src/adapter.o: in function `adapter_set_device_wakeable':
/github/workspace/src/src/adapter.c:5249: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5250: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5255: undefined reference to `btd_device_get_current_flags'
/usr/bin/ld: src/adapter.o: in function `adapter_auto_connect_remove':
/github/workspace/src/src/adapter.c:5331: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5332: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src/src/adapter.c:5327: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_new':
/github/workspace/src/src/adapter.c:6408: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6411: undefined reference to `bt_modalias'
/usr/bin/ld: src/adapter.o: in function `update_found_devices':
/github/workspace/src/src/adapter.c:6741: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6761: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6731: undefined reference to `btd_adv_monitor_content_filter'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6741: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6787: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6804: undefined reference to `device_set_legacy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6807: undefined reference to `device_set_rssi_with_delta'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6812: undefined reference to `device_set_tx_power'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6819: undefined reference to `device_name_known'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6822: undefined reference to `btd_device_device_set_name'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6834: undefined reference to `device_add_eir_uuids'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6841: undefined reference to `device_set_manufacturer_data'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6846: undefined reference to `device_set_service_data'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6849: undefined reference to `device_set_data'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6854: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6858: undefined reference to `btd_adv_monitor_notify_monitors'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6775: undefined reference to `device_set_bredr_support'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6777: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6829: undefined reference to `btd_device_set_pnpid'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6809: undefined reference to `device_set_rssi'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6788: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6815: undefined reference to `device_set_appearance'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6852: undefined reference to `device_set_flags'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6825: undefined reference to `device_set_class'
/usr/bin/ld: src/adapter.o: in function `adapter_create_device':
/github/workspace/src/src/adapter.c:1223: undefined reference to `device_create'
/usr/bin/ld: src/adapter.o: in function `update_found_devices':
/github/workspace/src/src/adapter.c:6909: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/src/adapter.c:6781: undefined reference to `device_store_cached_name'
/usr/bin/ld: src/adapter.o: in function `property_set_mode':
/github/workspace/src/src/adapter.c:2889: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2974: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2892: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2903: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: src/adapter.o: in function `property_set_discoverable_timeout':
/github/workspace/src/src/adapter.c:3048: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3052: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src/src/adapter.c:3056: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `set_discovery_filter':
/github/workspace/src/src/adapter.c:2591: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2639: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2597: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2600: undefined reference to `btd_error_not_supported'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2604: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2630: undefined reference to `g_dbus_add_disconnect_watch'
/usr/bin/ld: src/adapter.o: in function `start_discovery':
/github/workspace/src/src/adapter.c:2289: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2306: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2297: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2329: undefined reference to `g_dbus_add_disconnect_watch'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2352: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2343: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2347: undefined reference to `dbus_message_ref'
/usr/bin/ld: src/adapter.o: in function `discovery_stop':
/github/workspace/src/src/adapter.c:2231: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `stop_discovery':
/github/workspace/src/src/adapter.c:2646: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2671: undefined reference to `dbus_message_ref'
/usr/bin/ld: src/adapter.o: in function `read_info_complete':
/github/workspace/src/src/adapter.c:9544: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `adapter_register':
/github/workspace/src/src/adapter.c:8729: undefined reference to `g_dbus_register_interface'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8747: undefined reference to `agent_get'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8749: undefined reference to `agent_get_io_capability'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8751: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8761: undefined reference to `btd_gatt_database_new'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8769: undefined reference to `btd_adv_manager_new'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8771: undefined reference to `g_dbus_get_flags'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8774: undefined reference to `btd_adv_monitor_manager_create'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8788: undefined reference to `g_dbus_get_flags'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8793: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8807: undefined reference to `btd_profile_foreach'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8813: undefined reference to `btd_gatt_database_restore_svc_chng_ccc'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8825: undefined reference to `sdp_record_find'
/usr/bin/ld: /github/workspace/src/src/adapter.c:8790: undefined reference to `btd_battery_provider_manager_create'
/usr/bin/ld: src/adapter.o: in function `services_modified':
/github/workspace/src/src/adapter.c:8715: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `update_device_allowed_services':
/github/workspace/src/src/adapter.c:3490: undefined reference to `btd_device_update_allowed_services'
/usr/bin/ld: src/adapter.o: in function `invalidate_rssi_and_tx_power':
/github/workspace/src/src/adapter.c:1513: undefined reference to `device_set_tx_power'
/usr/bin/ld: src/adapter.o: in function `pincode_reply_complete':
/github/workspace/src/src/adapter.c:7380: undefined reference to `device_bonding_restart_timer'
/usr/bin/ld: src/adapter.o: in function `device_browse_cb':
/github/workspace/src/src/adapter.c:3319: undefined reference to `btd_device_connect_services'
/usr/bin/ld: src/adapter.o: in function `probe_devices':
/github/workspace/src/src/adapter.c:4305: undefined reference to `device_probe_profiles'
/usr/bin/ld: src/adapter.o: in function `dev_class_changed_callback':
/github/workspace/src/src/adapter.c:367: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `add_uuid_complete':
/github/workspace/src/src/adapter.c:969: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `local_name_changed_callback':
/github/workspace/src/src/adapter.c:783: undefined reference to `attrib_gap_set'
/usr/bin/ld: src/adapter.o: in function `add_uuid_complete':
/github/workspace/src/src/adapter.c:969: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_unref':
/github/workspace/src/src/adapter.c:5513: undefined reference to `g_dbus_unregister_interface'
/usr/bin/ld: src/adapter.o: in function `adapter_get_agent':
/github/workspace/src/src/adapter.c:6964: undefined reference to `agent_get'
/usr/bin/ld: src/adapter.o: in function `property_set_mode_complete':
/github/workspace/src/src/adapter.c:2839: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `adapter_shutdown':
/github/workspace/src/src/adapter.c:10127: undefined reference to `btd_exit'
/usr/bin/ld: src/adapter.o: in function `property_set_discoverable':
/github/workspace/src/src/adapter.c:3016: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `property_set_powered':
/github/workspace/src/src/adapter.c:2992: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `stop_discovery':
/github/workspace/src/src/adapter.c:2664: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2675: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2654: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/src/adapter.c:2669: undefined reference to `dbus_message_new_method_return'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5952: tools/mcaptest] Error 1
make: *** [Makefile:10434: check] Error 2


##############################
Test: Make Distcheck - FAIL
Desc: Run distcheck to check the distribution
Output:
/usr/bin/ld: src/adapter.o: in function `start_discovery_timeout':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1732: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `device_path_cmp':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:901: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `parse_discoverable':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2449: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2452: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_duplicate_data':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2438: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2441: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `process_auth_queue':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7101: undefined reference to `dbus_error_init'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7102: undefined reference to `dbus_set_error_const'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7121: undefined reference to `agent_get'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7129: undefined reference to `agent_authorize_service'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7139: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7112: undefined reference to `device_is_trusted'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7146: undefined reference to `dbus_error_free'
/usr/bin/ld: src/adapter.o: in function `agent_auth_cb':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7077: undefined reference to `agent_unref'
/usr/bin/ld: src/adapter.o: in function `invalidate_rssi_and_tx_power':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1512: undefined reference to `device_set_rssi'
/usr/bin/ld: src/adapter.o: in function `adapter_remove_connection':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6978: undefined reference to `device_remove_connection'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6980: undefined reference to `device_is_authenticating'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6984: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6981: undefined reference to `device_cancel_authentication'
/usr/bin/ld: src/adapter.o: in function `discovery_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1622: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1623: undefined reference to `g_dbus_send_message'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1626: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1620: undefined reference to `g_dbus_send_reply'
/usr/bin/ld: src/adapter.o: in function `property_get_modalias':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3216: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `iter_append_uuid':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3159: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_discovering':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3131: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_pairable_timeout':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3099: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_mode':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2810: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o:/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2810: more undefined references to `dbus_message_iter_append_basic' follow
/usr/bin/ld: src/adapter.o: in function `property_get_roles':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3227: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3245: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3232: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3237: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3242: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_uuids':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3180: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3188: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3192: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3195: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: src/adapter.o: in function `get_discovery_filters':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3290: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3292: undefined reference to `dbus_message_iter_init_append'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3294: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3298: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3302: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: src/adapter.o: in function `parse_discovery_filter_dict':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2526: undefined reference to `dbus_message_iter_init'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2527: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2528: undefined reference to `dbus_message_iter_get_element_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2531: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2533: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2540: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2542: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2543: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2546: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2550: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2555: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: src/adapter.o: in function `convert_file':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5791: undefined reference to `textfile_foreach'
/usr/bin/ld: src/adapter.o: in function `convert_proximity_entry':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6162: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_gatt_entry':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6117: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_ccc_entry':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6070: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_names_entry':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5533: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_primaries_entry':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5979: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5992: undefined reference to `bt_string2uuid'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6004: undefined reference to `create_file'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6021: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_entry':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5769: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `fix_storage':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6276: undefined reference to `textfile_get'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6282: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6285: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6288: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6291: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6294: undefined reference to `textfile_del'
/usr/bin/ld: src/adapter.o:/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6297: more undefined references to `textfile_del' follow
/usr/bin/ld: src/adapter.o: in function `probe_devices':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4305: undefined reference to `btd_device_get_uuids'
/usr/bin/ld: src/adapter.o: in function `rpa_resolution_func':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9398: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `exp_debug_func':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9353: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `local_name_changed_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:780: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_service_insert':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1173: undefined reference to `record_sort'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1173: undefined reference to `record_sort'
/usr/bin/ld: src/adapter.o: in function `parse_pathloss':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2404: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2407: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_rssi':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2390: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2393: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_pattern':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2462: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2465: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_transport':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2420: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2423: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_uuids':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2359: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2362: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2368: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2372: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2382: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2363: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: src/adapter.o: in function `adapter_add_connection':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4826: undefined reference to `device_add_connection'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5915: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5918: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5920: undefined reference to `record_from_string'
/usr/bin/ld: src/adapter.o: in function `record_has_uuid':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5803: undefined reference to `bt_uuid2string'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5926: undefined reference to `gatt_parse_record'
/usr/bin/ld: src/adapter.o: in function `store_sdp_record':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5865: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5939: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `adapter_start':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5354: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `stop_passive_scanning_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1441: undefined reference to `device_connect_le'
/usr/bin/ld: src/adapter.o: in function `start_discovery':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2289: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2297: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2306: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2352: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2329: undefined reference to `g_dbus_add_disconnect_watch'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2343: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2347: undefined reference to `dbus_message_ref'
/usr/bin/ld: src/adapter.o: in function `discovery_free':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1565: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1552: undefined reference to `g_dbus_remove_watch'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1561: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1561: undefined reference to `g_dbus_send_message'
/usr/bin/ld: src/adapter.o: in function `set_discovery_filter':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2591: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2639: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2597: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2604: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2600: undefined reference to `btd_error_not_supported'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2630: undefined reference to `g_dbus_add_disconnect_watch'
/usr/bin/ld: src/adapter.o: in function `store_adapter_info':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:486: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:499: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:511: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `property_set_pairable_timeout':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3111: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3115: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3119: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `property_set_alias':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2747: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2788: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2779: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2784: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `property_set_discoverable_timeout':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3048: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3052: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3056: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `store_link_key':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8055: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8070: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `remove_keys':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9085: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `load_config':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6362: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6380: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `convert_config':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6243: undefined reference to `read_pairable_timeout'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6247: undefined reference to `read_discoverable_timeout'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6251: undefined reference to `read_on_mode'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6257: undefined reference to `read_local_name'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6260: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_device_storage':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6179: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6195: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6211: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6215: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6222: undefined reference to `textfile_foreach'
/usr/bin/ld: src/adapter.o:/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6226: more undefined references to `textfile_foreach' follow
/usr/bin/ld: src/adapter.o: in function `load_devices':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4647: undefined reference to `device_address_cmp'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4668: undefined reference to `device_set_paired'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4669: undefined reference to `device_set_bonded'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4673: undefined reference to `device_set_paired'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4674: undefined reference to `device_set_bonded'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4680: undefined reference to `device_set_ltk_enc_size'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4690: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4654: undefined reference to `device_create_from_storage'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4659: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: src/adapter.o: in function `store_conn_param':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8451: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_irk':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8359: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_csrk':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8291: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_longtermkey':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8167: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `adapter_set_name':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:848: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:857: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_find_device':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:877: undefined reference to `device_addr_type_cmp'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:892: undefined reference to `device_set_le_support'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:890: undefined reference to `device_set_bredr_support'
/usr/bin/ld: src/adapter.o: in function `set_device_wakeable_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5236: undefined reference to `device_set_wake_allowed_complete'
/usr/bin/ld: src/adapter.o: in function `adapter_authorize':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7177: undefined reference to `device_is_disconnecting'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7198: undefined reference to `device_wait_for_svc_complete'
/usr/bin/ld: src/adapter.o: in function `device_unblocked_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9004: undefined reference to `device_unblock'
/usr/bin/ld: src/adapter.o: in function `device_blocked_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8982: undefined reference to `device_block'
/usr/bin/ld: src/adapter.o: in function `unpaired_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9134: undefined reference to `device_set_unpaired'
/usr/bin/ld: src/adapter.o: in function `device_flags_changed_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5289: undefined reference to `btd_device_flags_changed'
/usr/bin/ld: src/adapter.o: in function `connect_device':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3418: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3420: undefined reference to `dbus_message_iter_init'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3421: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3477: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3415: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3422: undefined reference to `dbus_message_iter_get_element_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3425: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3456: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3460: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3473: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3427: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3434: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3436: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3437: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3440: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3444: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3447: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3451: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3480: undefined reference to `btd_error_already_exists'
/usr/bin/ld: src/adapter.o: in function `device_connect':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3378: undefined reference to `dbus_message_ref'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3400: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3400: undefined reference to `g_dbus_send_message'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3402: undefined reference to `dbus_message_unref'
/usr/bin/ld: src/adapter.o: in function `update_found_devices':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6741: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6761: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6731: undefined reference to `btd_adv_monitor_content_filter'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6741: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6787: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6804: undefined reference to `device_set_legacy'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6807: undefined reference to `device_set_rssi_with_delta'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6812: undefined reference to `device_set_tx_power'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6819: undefined reference to `device_name_known'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6822: undefined reference to `btd_device_device_set_name'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6834: undefined reference to `device_add_eir_uuids'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6841: undefined reference to `device_set_manufacturer_data'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6846: undefined reference to `device_set_service_data'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6849: undefined reference to `device_set_data'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6854: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6858: undefined reference to `btd_adv_monitor_notify_monitors'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6775: undefined reference to `device_set_bredr_support'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6777: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6829: undefined reference to `btd_device_set_pnpid'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6809: undefined reference to `device_set_rssi'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6788: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6815: undefined reference to `device_set_appearance'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6852: undefined reference to `device_set_flags'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6825: undefined reference to `device_set_class'
/usr/bin/ld: src/adapter.o: in function `adapter_create_device':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1223: undefined reference to `device_create'
/usr/bin/ld: src/adapter.o: in function `update_found_devices':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6909: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6781: undefined reference to `device_store_cached_name'
/usr/bin/ld: src/adapter.o: in function `adapter_service_add':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1191: undefined reference to `add_record_to_server'
/usr/bin/ld: src/adapter.o: in function `adapter_service_remove':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1202: undefined reference to `sdp_record_find'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1214: undefined reference to `remove_record_from_server'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_remove_device':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1263: undefined reference to `btd_adv_monitor_device_remove'
/usr/bin/ld: src/adapter.o: in function `service_auth_cancel':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1240: undefined reference to `dbus_error_init'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1241: undefined reference to `dbus_set_error_const'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1245: undefined reference to `dbus_error_free'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1248: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1249: undefined reference to `agent_unref'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_remove_device':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1289: undefined reference to `device_remove'
/usr/bin/ld: src/adapter.o: in function `service_auth_cancel':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1237: undefined reference to `device_remove_svc_complete_callback'
/usr/bin/ld: src/adapter.o: in function `discovery_cleanup':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1539: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1539: undefined reference to `device_is_connectable'
/usr/bin/ld: src/adapter.o: in function `settings_changed':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:540: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `reply_pending_requests':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5373: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5374: undefined reference to `device_bonding_failed'
/usr/bin/ld: src/adapter.o: in function `settings_changed':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:570: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:563: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:566: undefined reference to `btd_adv_manager_refresh'
/usr/bin/ld: src/adapter.o: in function `adapter_stop':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7010: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7017: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7028: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `settings_changed':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:552: undefined reference to `btd_exit'
/usr/bin/ld: src/adapter.o: in function `adapter_stop':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7024: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `property_set_mode_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2844: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: src/adapter.o: in function `start_discovery_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1680: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `stop_discovery_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1971: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `discovery_stop':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2231: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `stop_discovery':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2646: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2671: undefined reference to `dbus_message_ref'
/usr/bin/ld: src/adapter.o: in function `adapter_remove':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6441: undefined reference to `device_remove'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6450: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6454: undefined reference to `btd_gatt_database_destroy'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6457: undefined reference to `btd_adv_manager_destroy'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6460: undefined reference to `btd_adv_monitor_manager_destroy'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6463: undefined reference to `btd_battery_provider_manager_destroy'
/usr/bin/ld: src/adapter.o: in function `remove_temporary_devices':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:626: undefined reference to `device_is_temporary'
/usr/bin/ld: src/adapter.o: in function `property_set_mode':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2889: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2974: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2892: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2903: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: src/adapter.o: in function `remove_device':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3258: undefined reference to `dbus_message_get_args'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3267: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3271: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3273: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3275: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3260: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3264: undefined reference to `btd_error_does_not_exist'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3278: undefined reference to `device_request_disconnect'
/usr/bin/ld: src/adapter.o: in function `adapter_create_device':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1223: undefined reference to `device_create'
/usr/bin/ld: src/adapter.o: in function `user_passkey_notify_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7598: undefined reference to `device_notify_passkey'
/usr/bin/ld: src/adapter.o: in function `new_irk_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8408: undefined reference to `device_update_addr'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8411: undefined reference to `device_merge_duplicate'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8419: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8408: undefined reference to `device_update_addr'
/usr/bin/ld: src/adapter.o: in function `new_csrk_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8333: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: src/adapter.o: in function `connected_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8923: undefined reference to `device_name_known'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8933: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8926: undefined reference to `device_store_cached_name'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8927: undefined reference to `btd_device_device_set_name'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8916: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8919: undefined reference to `device_set_class'
/usr/bin/ld: src/adapter.o: in function `device_connect_cb':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3362: undefined reference to `g_dbus_send_error'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3364: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3339: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3341: undefined reference to `g_dbus_send_reply'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3345: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3346: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3353: undefined reference to `device_discover_services'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3354: undefined reference to `device_wait_for_svc_complete'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3350: undefined reference to `device_attach_att'
/usr/bin/ld: src/adapter.o: in function `bonding_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7767: undefined reference to `device_bonding_complete'
/usr/bin/ld: src/adapter.o: in function `bonding_attempt_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7796: undefined reference to `device_bonding_attempt_retry'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7803: undefined reference to `device_is_retrying'
/usr/bin/ld: src/adapter.o: in function `connect_failed_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9052: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9063: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9071: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9053: undefined reference to `device_cancel_authentication'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9072: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9064: undefined reference to `device_is_retrying'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9065: undefined reference to `device_cancel_authentication'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9066: undefined reference to `device_bonding_failed'
/usr/bin/ld: src/adapter.o: in function `new_long_term_key_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8235: undefined reference to `device_set_ltk_enc_size'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8232: undefined reference to `device_set_bonded'
/usr/bin/ld: src/adapter.o: in function `new_link_key_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8119: undefined reference to `device_set_bonded'
/usr/bin/ld: src/adapter.o: in function `adapter_add_profile':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4803: undefined reference to `device_probe_profile'
/usr/bin/ld: src/adapter.o: in function `adapter_remove_profile':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4814: undefined reference to `device_remove_profile'
/usr/bin/ld: src/adapter.o: in function `adapter_connect_list_add':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4994: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4981: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4987: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `adapter_connect_list_remove':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5021: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5027: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `adapter_whitelist_add':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5083: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `adapter_whitelist_remove':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5122: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `adapter_auto_connect_add':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5178: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5183: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5184: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: src/adapter.o: in function `adapter_set_device_wakeable':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5249: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5250: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5255: undefined reference to `btd_device_get_current_flags'
/usr/bin/ld: src/adapter.o: in function `adapter_auto_connect_remove':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5331: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5332: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5327: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_new':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6408: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6411: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6411: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6409: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6411: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o:/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6411: more undefined references to `btd_opts' follow
/usr/bin/ld: src/adapter.o: in function `btd_adapter_new':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6411: undefined reference to `bt_modalias'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6415: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6416: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `btd_cancel_authorization':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7290: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7291: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7284: undefined reference to `device_remove_svc_complete_callback'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_pincode_reply':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7419: undefined reference to `device_bonding_restart_timer'
/usr/bin/ld: src/adapter.o: in function `pin_code_request_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7685: undefined reference to `device_bonding_iter'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7710: undefined reference to `device_request_pincode'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7693: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7694: undefined reference to `device_notify_pincode'
/usr/bin/ld: src/adapter.o: in function `user_confirm_request_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7485: undefined reference to `device_confirm_passkey'
/usr/bin/ld: src/adapter.o: in function `user_passkey_request_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7559: undefined reference to `device_request_passkey'
/usr/bin/ld: src/adapter.o: in function `adapter_set_io_capability':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8505: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `read_info_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9544: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9587: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `adapter_register':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8729: undefined reference to `g_dbus_register_interface'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8747: undefined reference to `agent_get'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8749: undefined reference to `agent_get_io_capability'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8751: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8757: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8761: undefined reference to `btd_gatt_database_new'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8769: undefined reference to `btd_adv_manager_new'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8771: undefined reference to `g_dbus_get_flags'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8774: undefined reference to `btd_adv_monitor_manager_create'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8788: undefined reference to `g_dbus_get_flags'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8793: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8807: undefined reference to `btd_profile_foreach'
/usr/bin/ld: src/adapter.o: in function `load_defaults':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4519: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `adapter_register':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8813: undefined reference to `btd_gatt_database_restore_svc_chng_ccc'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8822: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `read_info_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:9722: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `load_bredr_defaults':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4312: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4315: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4321: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o:/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4327: more undefined references to `btd_opts' follow
/usr/bin/ld: src/adapter.o: in function `adapter_register':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8825: undefined reference to `sdp_record_find'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8827: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8827: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8827: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8826: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8826: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o:/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4316: more undefined references to `btd_opts' follow
/usr/bin/ld: src/adapter.o: in function `adapter_register':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8790: undefined reference to `btd_battery_provider_manager_create'
/usr/bin/ld: src/adapter.o: in function `load_bredr_defaults':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4340: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `load_le_defaults':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4386: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `load_bredr_defaults':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4346: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `load_le_defaults':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4392: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `load_bredr_defaults':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4352: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o:/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4398: more undefined references to `btd_opts' follow
/usr/bin/ld: src/adapter.o: in function `adapter_init':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:10044: undefined reference to `btd_get_dbus_connection'
/usr/bin/ld: src/adapter.o: in function `services_modified':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:8715: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `update_device_allowed_services':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3490: undefined reference to `btd_device_update_allowed_services'
/usr/bin/ld: src/adapter.o: in function `invalidate_rssi_and_tx_power':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:1513: undefined reference to `device_set_tx_power'
/usr/bin/ld: src/adapter.o: in function `pincode_reply_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:7380: undefined reference to `device_bonding_restart_timer'
/usr/bin/ld: src/adapter.o: in function `device_browse_cb':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3319: undefined reference to `btd_device_connect_services'
/usr/bin/ld: src/adapter.o: in function `probe_devices':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:4305: undefined reference to `device_probe_profiles'
/usr/bin/ld: src/adapter.o: in function `dev_class_changed_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:367: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `add_uuid_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:969: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `local_name_changed_callback':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:783: undefined reference to `attrib_gap_set'
/usr/bin/ld: src/adapter.o: in function `add_uuid_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:969: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `property_set_mode_complete':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2839: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `stop_discovery':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2654: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2664: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2669: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2675: undefined reference to `btd_error_failed'
/usr/bin/ld: src/adapter.o: in function `property_set_discoverable':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:3016: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `property_set_powered':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:2992: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_unref':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:5513: undefined reference to `g_dbus_unregister_interface'
/usr/bin/ld: src/adapter.o: in function `adapter_get_agent':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:6964: undefined reference to `agent_get'
/usr/bin/ld: src/adapter.o: in function `adapter_shutdown':
/github/workspace/src/bluez-5.60/_build/sub/../../src/adapter.c:10127: undefined reference to `btd_exit'
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile:5952: tools/mcaptest] Error 1
make[1]: *** [Makefile:4142: all] Error 2
make: *** [Makefile:10355: distcheck] Error 1


##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - FAIL
Desc: Build BlueZ source with '--enable-external-ell' configuration
Output:
/usr/bin/ld: src/adapter.o: in function `start_discovery_timeout':
/github/workspace/src2/src/adapter.c:1732: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `device_path_cmp':
/github/workspace/src2/src/adapter.c:901: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `parse_discoverable':
/github/workspace/src2/src/adapter.c:2449: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2452: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_duplicate_data':
/github/workspace/src2/src/adapter.c:2438: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2441: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `process_auth_queue':
/github/workspace/src2/src/adapter.c:7101: undefined reference to `dbus_error_init'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7102: undefined reference to `dbus_set_error_const'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7121: undefined reference to `agent_get'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7129: undefined reference to `agent_authorize_service'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7139: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7112: undefined reference to `device_is_trusted'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7146: undefined reference to `dbus_error_free'
/usr/bin/ld: src/adapter.o: in function `agent_auth_cb':
/github/workspace/src2/src/adapter.c:7077: undefined reference to `agent_unref'
/usr/bin/ld: src/adapter.o: in function `invalidate_rssi_and_tx_power':
/github/workspace/src2/src/adapter.c:1512: undefined reference to `device_set_rssi'
/usr/bin/ld: src/adapter.o: in function `adapter_remove_connection':
/github/workspace/src2/src/adapter.c:6978: undefined reference to `device_remove_connection'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6980: undefined reference to `device_is_authenticating'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6984: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6981: undefined reference to `device_cancel_authentication'
/usr/bin/ld: src/adapter.o: in function `discovery_complete':
/github/workspace/src2/src/adapter.c:1622: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1623: undefined reference to `g_dbus_send_message'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1626: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1620: undefined reference to `g_dbus_send_reply'
/usr/bin/ld: src/adapter.o: in function `property_get_modalias':
/github/workspace/src2/src/adapter.c:3216: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `iter_append_uuid':
/github/workspace/src2/src/adapter.c:3159: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_discovering':
/github/workspace/src2/src/adapter.c:3131: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_pairable_timeout':
/github/workspace/src2/src/adapter.c:3099: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_mode':
/github/workspace/src2/src/adapter.c:2810: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o:/github/workspace/src2/src/adapter.c:2810: more undefined references to `dbus_message_iter_append_basic' follow
/usr/bin/ld: src/adapter.o: in function `property_get_roles':
/github/workspace/src2/src/adapter.c:3227: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3245: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3232: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3237: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3242: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: src/adapter.o: in function `property_get_uuids':
/github/workspace/src2/src/adapter.c:3180: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3188: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3192: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3195: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: src/adapter.o: in function `get_discovery_filters':
/github/workspace/src2/src/adapter.c:3290: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3292: undefined reference to `dbus_message_iter_init_append'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3294: undefined reference to `dbus_message_iter_open_container'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3298: undefined reference to `dbus_message_iter_append_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3302: undefined reference to `dbus_message_iter_close_container'
/usr/bin/ld: src/adapter.o: in function `parse_discovery_filter_dict':
/github/workspace/src2/src/adapter.c:2526: undefined reference to `dbus_message_iter_init'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2527: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2528: undefined reference to `dbus_message_iter_get_element_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2531: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2533: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2540: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2542: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2543: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2546: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2550: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2555: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: src/adapter.o: in function `convert_file':
/github/workspace/src2/src/adapter.c:5791: undefined reference to `textfile_foreach'
/usr/bin/ld: src/adapter.o: in function `convert_proximity_entry':
/github/workspace/src2/src/adapter.c:6162: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_gatt_entry':
/github/workspace/src2/src/adapter.c:6117: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_ccc_entry':
/github/workspace/src2/src/adapter.c:6070: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_names_entry':
/github/workspace/src2/src/adapter.c:5533: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_primaries_entry':
/github/workspace/src2/src/adapter.c:5979: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5992: undefined reference to `bt_string2uuid'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6004: undefined reference to `create_file'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6021: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_entry':
/github/workspace/src2/src/adapter.c:5769: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `fix_storage':
/github/workspace/src2/src/adapter.c:6276: undefined reference to `textfile_get'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6282: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6285: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6288: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6291: undefined reference to `textfile_del'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6294: undefined reference to `textfile_del'
/usr/bin/ld: src/adapter.o:/github/workspace/src2/src/adapter.c:6297: more undefined references to `textfile_del' follow
/usr/bin/ld: src/adapter.o: in function `probe_devices':
/github/workspace/src2/src/adapter.c:4305: undefined reference to `btd_device_get_uuids'
/usr/bin/ld: src/adapter.o: in function `rpa_resolution_func':
/github/workspace/src2/src/adapter.c:9398: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `exp_debug_func':
/github/workspace/src2/src/adapter.c:9353: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `local_name_changed_callback':
/github/workspace/src2/src/adapter.c:780: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_service_insert':
/github/workspace/src2/src/adapter.c:1173: undefined reference to `record_sort'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1173: undefined reference to `record_sort'
/usr/bin/ld: src/adapter.o: in function `parse_pathloss':
/github/workspace/src2/src/adapter.c:2404: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2407: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_rssi':
/github/workspace/src2/src/adapter.c:2390: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2393: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_pattern':
/github/workspace/src2/src/adapter.c:2462: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2465: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_transport':
/github/workspace/src2/src/adapter.c:2420: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2423: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: src/adapter.o: in function `parse_uuids':
/github/workspace/src2/src/adapter.c:2359: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2362: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2368: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2372: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2382: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2363: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: src/adapter.o: in function `adapter_add_connection':
/github/workspace/src2/src/adapter.c:4826: undefined reference to `device_add_connection'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src2/src/adapter.c:5915: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5918: undefined reference to `bt_uuid2string'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5920: undefined reference to `record_from_string'
/usr/bin/ld: src/adapter.o: in function `record_has_uuid':
/github/workspace/src2/src/adapter.c:5803: undefined reference to `bt_uuid2string'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src2/src/adapter.c:5926: undefined reference to `gatt_parse_record'
/usr/bin/ld: src/adapter.o: in function `store_sdp_record':
/github/workspace/src2/src/adapter.c:5865: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_sdp_entry':
/github/workspace/src2/src/adapter.c:5939: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `discovery_free':
/github/workspace/src2/src/adapter.c:1565: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1552: undefined reference to `g_dbus_remove_watch'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1561: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1561: undefined reference to `g_dbus_send_message'
/usr/bin/ld: src/adapter.o: in function `store_adapter_info':
/github/workspace/src2/src/adapter.c:486: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:511: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `property_set_pairable_timeout':
/github/workspace/src2/src/adapter.c:3111: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3115: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3119: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `property_set_alias':
/github/workspace/src2/src/adapter.c:2747: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2788: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2779: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2784: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `store_link_key':
/github/workspace/src2/src/adapter.c:8055: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8070: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `remove_keys':
/github/workspace/src2/src/adapter.c:9085: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `load_config':
/github/workspace/src2/src/adapter.c:6362: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6380: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `convert_config':
/github/workspace/src2/src/adapter.c:6243: undefined reference to `read_pairable_timeout'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6247: undefined reference to `read_discoverable_timeout'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6251: undefined reference to `read_on_mode'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6257: undefined reference to `read_local_name'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6260: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `convert_device_storage':
/github/workspace/src2/src/adapter.c:6179: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6195: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6211: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6215: undefined reference to `textfile_foreach'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6222: undefined reference to `textfile_foreach'
/usr/bin/ld: src/adapter.o:/github/workspace/src2/src/adapter.c:6226: more undefined references to `textfile_foreach' follow
/usr/bin/ld: src/adapter.o: in function `load_devices':
/github/workspace/src2/src/adapter.c:4647: undefined reference to `device_address_cmp'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4668: undefined reference to `device_set_paired'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4669: undefined reference to `device_set_bonded'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4673: undefined reference to `device_set_paired'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4674: undefined reference to `device_set_bonded'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4680: undefined reference to `device_set_ltk_enc_size'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4690: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4654: undefined reference to `device_create_from_storage'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4659: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: src/adapter.o: in function `store_conn_param':
/github/workspace/src2/src/adapter.c:8451: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_irk':
/github/workspace/src2/src/adapter.c:8359: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_csrk':
/github/workspace/src2/src/adapter.c:8291: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `store_longtermkey':
/github/workspace/src2/src/adapter.c:8167: undefined reference to `create_file'
/usr/bin/ld: src/adapter.o: in function `adapter_set_name':
/github/workspace/src2/src/adapter.c:848: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:857: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_find_device':
/github/workspace/src2/src/adapter.c:877: undefined reference to `device_addr_type_cmp'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:892: undefined reference to `device_set_le_support'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:890: undefined reference to `device_set_bredr_support'
/usr/bin/ld: src/adapter.o: in function `set_device_wakeable_complete':
/github/workspace/src2/src/adapter.c:5236: undefined reference to `device_set_wake_allowed_complete'
/usr/bin/ld: src/adapter.o: in function `adapter_authorize':
/github/workspace/src2/src/adapter.c:7177: undefined reference to `device_is_disconnecting'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7198: undefined reference to `device_wait_for_svc_complete'
/usr/bin/ld: src/adapter.o: in function `device_unblocked_callback':
/github/workspace/src2/src/adapter.c:9004: undefined reference to `device_unblock'
/usr/bin/ld: src/adapter.o: in function `device_blocked_callback':
/github/workspace/src2/src/adapter.c:8982: undefined reference to `device_block'
/usr/bin/ld: src/adapter.o: in function `unpaired_callback':
/github/workspace/src2/src/adapter.c:9134: undefined reference to `device_set_unpaired'
/usr/bin/ld: src/adapter.o: in function `device_flags_changed_callback':
/github/workspace/src2/src/adapter.c:5289: undefined reference to `btd_device_flags_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_service_add':
/github/workspace/src2/src/adapter.c:1191: undefined reference to `add_record_to_server'
/usr/bin/ld: src/adapter.o: in function `adapter_service_remove':
/github/workspace/src2/src/adapter.c:1202: undefined reference to `sdp_record_find'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1214: undefined reference to `remove_record_from_server'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_remove_device':
/github/workspace/src2/src/adapter.c:1263: undefined reference to `btd_adv_monitor_device_remove'
/usr/bin/ld: src/adapter.o: in function `service_auth_cancel':
/github/workspace/src2/src/adapter.c:1240: undefined reference to `dbus_error_init'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1241: undefined reference to `dbus_set_error_const'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1245: undefined reference to `dbus_error_free'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1248: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1249: undefined reference to `agent_unref'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_remove_device':
/github/workspace/src2/src/adapter.c:1289: undefined reference to `device_remove'
/usr/bin/ld: src/adapter.o: in function `service_auth_cancel':
/github/workspace/src2/src/adapter.c:1237: undefined reference to `device_remove_svc_complete_callback'
/usr/bin/ld: src/adapter.o: in function `discovery_cleanup':
/github/workspace/src2/src/adapter.c:1539: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:1539: undefined reference to `device_is_connectable'
/usr/bin/ld: src/adapter.o: in function `adapter_remove':
/github/workspace/src2/src/adapter.c:6441: undefined reference to `device_remove'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6450: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6454: undefined reference to `btd_gatt_database_destroy'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6457: undefined reference to `btd_adv_manager_destroy'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6460: undefined reference to `btd_adv_monitor_manager_destroy'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6463: undefined reference to `btd_battery_provider_manager_destroy'
/usr/bin/ld: src/adapter.o: in function `remove_temporary_devices':
/github/workspace/src2/src/adapter.c:626: undefined reference to `device_is_temporary'
/usr/bin/ld: src/adapter.o: in function `adapter_create_device':
/github/workspace/src2/src/adapter.c:1223: undefined reference to `device_create'
/usr/bin/ld: src/adapter.o: in function `user_passkey_notify_callback':
/github/workspace/src2/src/adapter.c:7598: undefined reference to `device_notify_passkey'
/usr/bin/ld: src/adapter.o: in function `new_irk_callback':
/github/workspace/src2/src/adapter.c:8408: undefined reference to `device_update_addr'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8411: undefined reference to `device_merge_duplicate'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8419: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8408: undefined reference to `device_update_addr'
/usr/bin/ld: src/adapter.o: in function `new_csrk_callback':
/github/workspace/src2/src/adapter.c:8333: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: src/adapter.o: in function `connected_callback':
/github/workspace/src2/src/adapter.c:8923: undefined reference to `device_name_known'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8933: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8926: undefined reference to `device_store_cached_name'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8927: undefined reference to `btd_device_device_set_name'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8916: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8919: undefined reference to `device_set_class'
/usr/bin/ld: src/adapter.o: in function `device_connect_cb':
/github/workspace/src2/src/adapter.c:3362: undefined reference to `g_dbus_send_error'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3364: undefined reference to `dbus_message_unref'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3339: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3341: undefined reference to `g_dbus_send_reply'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3345: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3346: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3353: undefined reference to `device_discover_services'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3354: undefined reference to `device_wait_for_svc_complete'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3350: undefined reference to `device_attach_att'
/usr/bin/ld: src/adapter.o: in function `adapter_add_profile':
/github/workspace/src2/src/adapter.c:4803: undefined reference to `device_probe_profile'
/usr/bin/ld: src/adapter.o: in function `adapter_remove_profile':
/github/workspace/src2/src/adapter.c:4814: undefined reference to `device_remove_profile'
/usr/bin/ld: src/adapter.o: in function `bonding_complete':
/github/workspace/src2/src/adapter.c:7767: undefined reference to `device_bonding_complete'
/usr/bin/ld: src/adapter.o: in function `bonding_attempt_complete':
/github/workspace/src2/src/adapter.c:7796: undefined reference to `device_bonding_attempt_retry'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7803: undefined reference to `device_is_retrying'
/usr/bin/ld: src/adapter.o: in function `connect_failed_callback':
/github/workspace/src2/src/adapter.c:9052: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:9063: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:9071: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:9053: undefined reference to `device_cancel_authentication'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:9072: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:9064: undefined reference to `device_is_retrying'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:9065: undefined reference to `device_cancel_authentication'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:9066: undefined reference to `device_bonding_failed'
/usr/bin/ld: src/adapter.o: in function `new_long_term_key_callback':
/github/workspace/src2/src/adapter.c:8235: undefined reference to `device_set_ltk_enc_size'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8232: undefined reference to `device_set_bonded'
/usr/bin/ld: src/adapter.o: in function `new_link_key_callback':
/github/workspace/src2/src/adapter.c:8119: undefined reference to `device_set_bonded'
/usr/bin/ld: src/adapter.o: in function `start_discovery_complete':
/github/workspace/src2/src/adapter.c:1680: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `connect_device':
/github/workspace/src2/src/adapter.c:3420: undefined reference to `dbus_message_iter_init'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3421: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3477: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3422: undefined reference to `dbus_message_iter_get_element_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3425: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3456: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3460: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3473: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3427: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3434: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3436: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3437: undefined reference to `dbus_message_iter_next'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3440: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3444: undefined reference to `dbus_message_iter_recurse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3447: undefined reference to `dbus_message_iter_get_arg_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3451: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3418: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3415: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3480: undefined reference to `btd_error_already_exists'
/usr/bin/ld: src/adapter.o: in function `device_connect':
/github/workspace/src2/src/adapter.c:3378: undefined reference to `dbus_message_ref'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3400: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3400: undefined reference to `g_dbus_send_message'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3402: undefined reference to `dbus_message_unref'
/usr/bin/ld: src/adapter.o: in function `remove_device':
/github/workspace/src2/src/adapter.c:3258: undefined reference to `dbus_message_get_args'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3271: undefined reference to `btd_device_set_temporary'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3273: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3275: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3260: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3267: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3278: undefined reference to `device_request_disconnect'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3264: undefined reference to `btd_error_does_not_exist'
/usr/bin/ld: src/adapter.o: in function `btd_cancel_authorization':
/github/workspace/src2/src/adapter.c:7290: undefined reference to `agent_cancel'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7291: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7284: undefined reference to `device_remove_svc_complete_callback'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_pincode_reply':
/github/workspace/src2/src/adapter.c:7419: undefined reference to `device_bonding_restart_timer'
/usr/bin/ld: src/adapter.o: in function `pin_code_request_callback':
/github/workspace/src2/src/adapter.c:7685: undefined reference to `device_bonding_iter'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7710: undefined reference to `device_request_pincode'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7693: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7694: undefined reference to `device_notify_pincode'
/usr/bin/ld: src/adapter.o: in function `user_confirm_request_callback':
/github/workspace/src2/src/adapter.c:7485: undefined reference to `device_confirm_passkey'
/usr/bin/ld: src/adapter.o: in function `user_passkey_request_callback':
/github/workspace/src2/src/adapter.c:7559: undefined reference to `device_request_passkey'
/usr/bin/ld: src/adapter.o: in function `adapter_set_io_capability':
/github/workspace/src2/src/adapter.c:8505: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `adapter_init':
/github/workspace/src2/src/adapter.c:10044: undefined reference to `btd_get_dbus_connection'
/usr/bin/ld: src/adapter.o: in function `adapter_start':
/github/workspace/src2/src/adapter.c:5354: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `settings_changed':
/github/workspace/src2/src/adapter.c:570: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:563: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:566: undefined reference to `btd_adv_manager_refresh'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:540: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `reply_pending_requests':
/github/workspace/src2/src/adapter.c:5373: undefined reference to `device_is_bonding'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5374: undefined reference to `device_bonding_failed'
/usr/bin/ld: src/adapter.o: in function `adapter_stop':
/github/workspace/src2/src/adapter.c:7010: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7017: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:7028: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `settings_changed':
/github/workspace/src2/src/adapter.c:552: undefined reference to `btd_exit'
/usr/bin/ld: src/adapter.o: in function `adapter_stop':
/github/workspace/src2/src/adapter.c:7024: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `property_set_mode_complete':
/github/workspace/src2/src/adapter.c:2844: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: src/adapter.o: in function `stop_discovery_complete':
/github/workspace/src2/src/adapter.c:1971: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `adapter_connect_list_add':
/github/workspace/src2/src/adapter.c:4994: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4981: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:4987: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `adapter_connect_list_remove':
/github/workspace/src2/src/adapter.c:5021: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5027: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `stop_passive_scanning_complete':
/github/workspace/src2/src/adapter.c:1441: undefined reference to `device_connect_le'
/usr/bin/ld: src/adapter.o: in function `adapter_whitelist_add':
/github/workspace/src2/src/adapter.c:5083: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `adapter_whitelist_remove':
/github/workspace/src2/src/adapter.c:5122: undefined reference to `device_get_address'
/usr/bin/ld: src/adapter.o: in function `adapter_auto_connect_add':
/github/workspace/src2/src/adapter.c:5178: undefined reference to `device_get_path'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5183: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5184: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: src/adapter.o: in function `adapter_set_device_wakeable':
/github/workspace/src2/src/adapter.c:5249: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5250: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5255: undefined reference to `btd_device_get_current_flags'
/usr/bin/ld: src/adapter.o: in function `adapter_auto_connect_remove':
/github/workspace/src2/src/adapter.c:5331: undefined reference to `device_get_address'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5332: undefined reference to `btd_device_get_bdaddr_type'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:5327: undefined reference to `device_get_path'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_new':
/github/workspace/src2/src/adapter.c:6408: undefined reference to `btd_opts'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6411: undefined reference to `bt_modalias'
/usr/bin/ld: src/adapter.o: in function `update_found_devices':
/github/workspace/src2/src/adapter.c:6741: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6761: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6731: undefined reference to `btd_adv_monitor_content_filter'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6741: undefined reference to `eir_parse'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6787: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6804: undefined reference to `device_set_legacy'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6807: undefined reference to `device_set_rssi_with_delta'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6812: undefined reference to `device_set_tx_power'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6819: undefined reference to `device_name_known'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6822: undefined reference to `btd_device_device_set_name'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6834: undefined reference to `device_add_eir_uuids'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6841: undefined reference to `device_set_manufacturer_data'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6846: undefined reference to `device_set_service_data'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6849: undefined reference to `device_set_data'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6854: undefined reference to `eir_data_free'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6858: undefined reference to `btd_adv_monitor_notify_monitors'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6765: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6775: undefined reference to `device_set_bredr_support'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6777: undefined reference to `device_update_last_seen'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6829: undefined reference to `btd_device_set_pnpid'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6809: undefined reference to `device_set_rssi'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6788: undefined reference to `device_is_temporary'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6815: undefined reference to `device_set_appearance'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6852: undefined reference to `device_set_flags'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6825: undefined reference to `device_set_class'
/usr/bin/ld: src/adapter.o: in function `adapter_create_device':
/github/workspace/src2/src/adapter.c:1223: undefined reference to `device_create'
/usr/bin/ld: src/adapter.o: in function `update_found_devices':
/github/workspace/src2/src/adapter.c:6909: undefined reference to `btd_device_is_connected'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:6781: undefined reference to `device_store_cached_name'
/usr/bin/ld: src/adapter.o: in function `property_set_mode':
/github/workspace/src2/src/adapter.c:2889: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2974: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2892: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2903: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: src/adapter.o: in function `property_set_discoverable_timeout':
/github/workspace/src2/src/adapter.c:3048: undefined reference to `dbus_message_iter_get_basic'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3052: undefined reference to `g_dbus_pending_property_success'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:3056: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `set_discovery_filter':
/github/workspace/src2/src/adapter.c:2591: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2639: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2597: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2600: undefined reference to `btd_error_not_supported'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2604: undefined reference to `btd_error_invalid_args'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2630: undefined reference to `g_dbus_add_disconnect_watch'
/usr/bin/ld: src/adapter.o: in function `start_discovery':
/github/workspace/src2/src/adapter.c:2289: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2306: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2297: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2329: undefined reference to `g_dbus_add_disconnect_watch'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2352: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2343: undefined reference to `dbus_message_new_method_return'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2347: undefined reference to `dbus_message_ref'
/usr/bin/ld: src/adapter.o: in function `discovery_stop':
/github/workspace/src2/src/adapter.c:2231: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `stop_discovery':
/github/workspace/src2/src/adapter.c:2646: undefined reference to `dbus_message_get_sender'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2671: undefined reference to `dbus_message_ref'
/usr/bin/ld: src/adapter.o: in function `read_info_complete':
/github/workspace/src2/src/adapter.c:9544: undefined reference to `btd_opts'
/usr/bin/ld: src/adapter.o: in function `adapter_register':
/github/workspace/src2/src/adapter.c:8729: undefined reference to `g_dbus_register_interface'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8747: undefined reference to `agent_get'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8749: undefined reference to `agent_get_io_capability'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8751: undefined reference to `agent_unref'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8761: undefined reference to `btd_gatt_database_new'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8769: undefined reference to `btd_adv_manager_new'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8771: undefined reference to `g_dbus_get_flags'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8774: undefined reference to `btd_adv_monitor_manager_create'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8788: undefined reference to `g_dbus_get_flags'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8793: undefined reference to `btd_gatt_database_get_db'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8807: undefined reference to `btd_profile_foreach'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8813: undefined reference to `btd_gatt_database_restore_svc_chng_ccc'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8825: undefined reference to `sdp_record_find'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:8790: undefined reference to `btd_battery_provider_manager_create'
/usr/bin/ld: src/adapter.o: in function `services_modified':
/github/workspace/src2/src/adapter.c:8715: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `update_device_allowed_services':
/github/workspace/src2/src/adapter.c:3490: undefined reference to `btd_device_update_allowed_services'
/usr/bin/ld: src/adapter.o: in function `invalidate_rssi_and_tx_power':
/github/workspace/src2/src/adapter.c:1513: undefined reference to `device_set_tx_power'
/usr/bin/ld: src/adapter.o: in function `pincode_reply_complete':
/github/workspace/src2/src/adapter.c:7380: undefined reference to `device_bonding_restart_timer'
/usr/bin/ld: src/adapter.o: in function `device_browse_cb':
/github/workspace/src2/src/adapter.c:3319: undefined reference to `btd_device_connect_services'
/usr/bin/ld: src/adapter.o: in function `probe_devices':
/github/workspace/src2/src/adapter.c:4305: undefined reference to `device_probe_profiles'
/usr/bin/ld: src/adapter.o: in function `dev_class_changed_callback':
/github/workspace/src2/src/adapter.c:367: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `add_uuid_complete':
/github/workspace/src2/src/adapter.c:969: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `local_name_changed_callback':
/github/workspace/src2/src/adapter.c:783: undefined reference to `attrib_gap_set'
/usr/bin/ld: src/adapter.o: in function `add_uuid_complete':
/github/workspace/src2/src/adapter.c:969: undefined reference to `g_dbus_emit_property_changed'
/usr/bin/ld: src/adapter.o: in function `btd_adapter_unref':
/github/workspace/src2/src/adapter.c:5513: undefined reference to `g_dbus_unregister_interface'
/usr/bin/ld: src/adapter.o: in function `adapter_get_agent':
/github/workspace/src2/src/adapter.c:6964: undefined reference to `agent_get'
/usr/bin/ld: src/adapter.o: in function `property_set_mode_complete':
/github/workspace/src2/src/adapter.c:2839: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `adapter_shutdown':
/github/workspace/src2/src/adapter.c:10127: undefined reference to `btd_exit'
/usr/bin/ld: src/adapter.o: in function `property_set_discoverable':
/github/workspace/src2/src/adapter.c:3016: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `property_set_powered':
/github/workspace/src2/src/adapter.c:2992: undefined reference to `g_dbus_pending_property_error'
/usr/bin/ld: src/adapter.o: in function `stop_discovery':
/github/workspace/src2/src/adapter.c:2664: undefined reference to `btd_error_busy'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2675: undefined reference to `btd_error_failed'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2654: undefined reference to `btd_error_not_ready'
/usr/bin/ld: /github/workspace/src2/src/adapter.c:2669: undefined reference to `dbus_message_new_method_return'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5952: tools/mcaptest] Error 1
make: *** [Makefile:4142: all] Error 2




---
Regards,
Linux Bluetooth


--===============7354260759179685985==--
