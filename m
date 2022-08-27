Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83902ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Aug 2022 03:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbiH0Dxa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 23:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH0Dx3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 23:53:29 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8EFDEB6F
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 20:53:28 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f14so2592186qkm.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 20:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=BrD7kt3oRorzn0yCY36lsfaUu6rLtUIDNtMWc0czxtM=;
        b=FxqlquBK9ko/knmMZhGqP4DQMqrkYMSgkRYOm0C9evrlcwennJKUShZPBjkHNTPzN2
         Q7tVtB1oIViODXawfWYW4qJMRYtNmP6/ecaYtiARNfn1Yv1roV8yYsJCcZM+OxnM8rqW
         3R3a7a3hWQ28Q+sMv1Qv4gQCwygQpKRCqdCvPOCJTy8gT+adBNMk1/UgEqFYIo3c76XS
         j8X0LCXCTogL5f59JjhUjWjuOvofbOsNFkmEicq/IuHfea4cMhRUvBjzVyOhBEWjD3JL
         57+/rf6gQZRWPPSPrT7oze0AbhGHXik1xNmpzZGoFeyEbR/l9a3UjsoWQNEDy2MJdze8
         82ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=BrD7kt3oRorzn0yCY36lsfaUu6rLtUIDNtMWc0czxtM=;
        b=iaiJaT7oKBRqgFSQSbGrhPQMOFQFMQZbSzERt23clk5NURtLf+d9Vx1sZBezoeXyMe
         AEweQ+mHOhSWn4qA216ZhdLByZlDKM4QOYjgF41E3I3Pyh53+ESB5L5Q4/07tJqMe1V3
         5kVDH968JKHW0Iiz8ddN5spFqYpm5u/cc4mzIDWq1WPZ50JwA64doa6uq+hV3JzuTkfq
         y7/3dEefJ5qFSkg9317KGZZ6g93rb4umv6pXv7xuK9s+BrmoWCpHmEum53p1LCbnG1mq
         3d/p8Wo/WZYCMz04P0RtZ2wYj+9dB1tk3meA7RmnV+iW4MOkZW7kkBf8dn9F6Rm1bPcI
         V2VA==
X-Gm-Message-State: ACgBeo1/DS298cbppT/mmd26isIo/acc2mfbU2yvKttvYqM/R7PanxNI
        cjlzunwqMq83Wxwskntmwy3oaNoWrqk=
X-Google-Smtp-Source: AA6agR7Yi43SjUJvXGTkB/QL4zRyaTfgiPSM3ajI1BsjunppmikCmy5wSOxoU7nIZDeWnBjpmFhZQw==
X-Received: by 2002:a37:795:0:b0:6ba:7ed0:679f with SMTP id 143-20020a370795000000b006ba7ed0679fmr1857508qkh.721.1661572406985;
        Fri, 26 Aug 2022 20:53:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.106.163.65])
        by smtp.gmail.com with ESMTPSA id bs31-20020a05620a471f00b006bb83c2be40sm1076609qkb.59.2022.08.26.20.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 20:53:26 -0700 (PDT)
Message-ID: <63099536.050a0220.bafc4.3dda@mx.google.com>
Date:   Fri, 26 Aug 2022 20:53:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8744681669549891414=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Initial BAP support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220827000540.113414-2-luiz.dentz@gmail.com>
References: <20220827000540.113414-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8744681669549891414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=671664

---Test result---

Test Summary:
CheckPatch                    FAIL      25.43 seconds
GitLint                       PASS      11.57 seconds
Prep - Setup ELL              PASS      32.49 seconds
Build - Prep                  PASS      0.91 seconds
Build - Configure             PASS      10.61 seconds
Build - Make                  PASS      980.59 seconds
Make Check                    PASS      12.43 seconds
Make Check w/Valgrind         PASS      345.00 seconds
Make Distcheck                PASS      293.60 seconds
Build w/ext ELL - Configure   PASS      10.78 seconds
Build w/ext ELL - Make        PASS      100.36 seconds
Incremental Build w/ patches  PASS      1302.00 seconds
Scan Build                    WARNING   1109.66 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v3,03/11] shared/bap: Add initial code for handling BAP
ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#369: FILE: src/shared/bap.c:19:
+ *  License along with this library; if not, write to the Free Software$

ERROR:FSF_MAILING_ADDRESS: Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.
#370: FILE: src/shared/bap.c:20:
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA$

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1742: FILE: src/shared/bap.c:1392:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1748: FILE: src/shared/bap.c:1398:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1761: FILE: src/shared/bap.c:1411:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1767: FILE: src/shared/bap.c:1417:
+		/* Fallthrough */

ERROR:SPACING: space required before the open parenthesis '('
#4468: FILE: src/shared/bap.c:4118:
+			switch(lpac->type) {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#5148: FILE: src/shared/bap.h:16:
+#define __packed __attribute__((packed))

WARNING:SPACING: Unnecessary space before function pointer arguments
#5255: FILE: src/shared/bap.h:123:
+	int (*select) (struct bt_bap_pac *pac, struct bt_bap_pac_qos *qos,

WARNING:SPACING: Unnecessary space before function pointer arguments
#5258: FILE: src/shared/bap.h:126:
+	int (*config) (struct bt_bap_stream *stream, struct iovec *cfg,

WARNING:SPACING: Unnecessary space before function pointer arguments
#5261: FILE: src/shared/bap.h:129:
+	void (*clear) (struct bt_bap_stream *stream, void *user_data);

/github/workspace/src/12956744.patch total: 3 errors, 8 warnings, 5278 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12956744.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v3,04/11] profiles: Add initial code for bap plugin
ERROR:SPACING: space prohibited before that close parenthesis ')'
#618: FILE: profiles/audio/bap.c:490:
+						{ "properties", "a{sv}" } ),

ERROR:INITIALISED_STATIC: do not initialise statics to 0
#1428: FILE: profiles/audio/bap.c:1300:
+static unsigned int bap_id = 0;

WARNING:SPACING: Unnecessary space before function pointer arguments
#2354: FILE: profiles/audio/transport.c:116:
+	void			(*set_state) (struct media_transport *transport,

/github/workspace/src/12956741.patch total: 2 errors, 1 warnings, 2836 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12956741.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[v3,08/11] client/player: Add support for PACS endpoints
ERROR:SPACING: space prohibited before that close parenthesis ')'
#631: FILE: client/player.c:1886:
+					GDBUS_ARGS({ "cfg", "ay" } ),

ERROR:SPACING: space prohibited before that close parenthesis ')'
#634: FILE: client/player.c:1889:
+					GDBUS_ARGS({ "properties", "a{sv}" } ),

ERROR:SPACING: space prohibited before that close parenthesis ')'
#635: FILE: client/player.c:1890:
+					GDBUS_ARGS({ "properties", "a{sv}" } ),

/github/workspace/src/12956742.patch total: 3 errors, 0 warnings, 799 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12956742.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
client/player.c:1757:25: warning: Dereference of null pointer
        iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
                               ^~~~~~~~~~~~~~~~~~~~~
1 warning generated.
profiles/audio/media.c:1450:6: warning: 8th function call argument is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2996:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:2999:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.




---
Regards,
Linux Bluetooth


--===============8744681669549891414==--
