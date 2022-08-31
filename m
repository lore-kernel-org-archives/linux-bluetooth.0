Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D2EECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 10:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiHaKXV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiHaKXR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 06:23:17 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F60B8F32
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 03:23:16 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id f9so7038466qvw.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=8VfwVqtmiJtD+QBcdbDmrxqEWRRsqt42OKlttMUNfjE=;
        b=UQDNB55SqQwL394pR1idbTwscuT6iCMaG8Pyr2hxypfbuehuMpxFXiMGxx/KxLb0wU
         r9U4LRmyXlyQiBkgvEmHZmZdtaezHcpWARwZAqRCgW/BDvjqLbOeQgT8QwRu/VZFeB+0
         USsZNtC6n3xah43Pszh6jn3VtBmLkUxuXgmJrtfQ7mRX9b11xyp4Ifv1TQ635tuHHq5K
         SX0dnnHRZLP+2TNQ0yhBoXSdRXS6zI6Ki97k9iRWp6cF+3igQPqusTnAIa/5M54r91C4
         Dq9+EosilS0SWGuGg+FNzfWzQpNyH3THWePL1c/S1rfbT4t2m1aPEEwSBeEWElvn2qog
         hxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=8VfwVqtmiJtD+QBcdbDmrxqEWRRsqt42OKlttMUNfjE=;
        b=UvGPwem8AnynGQ8i+tya6akNVL2swG5VeDanvnhvZDbcPBKVmfJkFVV6a1iNbbcB+T
         c0r6vOnJGgXuVvF+rfHVkDHmyLG7n9QDZ03ayNniPiHT9YxhUlSNUsC8CHp1zaMAu2Cm
         /w1ySqg2k5QhFRTO4AZL0Q3nRGSVBVS0gnzM+oqdf6isNQ7ZrgDQzdFsWdm+6VH2wW8P
         rVPLSAck5GvO7R5z/2k9RtcCcNfoE1s/SLj0W7fSUeDBNrScJTmsfXiLi1iMywLbKPDq
         mhWXs2ezDDTJY6Ri1LzysswqpiLeFcIacJCdQ6DBqa2GUMK3G68b8X3Fp/VYOnbcq5eu
         8q+A==
X-Gm-Message-State: ACgBeo2ywEdoOEWi9KhYFysDFwCCUDYBRbQoAF6PKwFw10Yx1aF8ntSO
        5aI+cfLawVifqomwx8hJafyvkt6AJ5dU0w==
X-Google-Smtp-Source: AA6agR5WnhfKNVhrD+4dVmX320fbisox+nxvRS+Go0hZg0mJITtF3321uv5LkDTW6aGrNjOXRP1KqA==
X-Received: by 2002:a05:6214:5285:b0:472:ed70:23a0 with SMTP id kj5-20020a056214528500b00472ed7023a0mr18598089qvb.121.1661941395625;
        Wed, 31 Aug 2022 03:23:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.63.38])
        by smtp.gmail.com with ESMTPSA id j17-20020ac86651000000b00343057845f7sm8251171qtp.20.2022.08.31.03.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 03:23:15 -0700 (PDT)
Message-ID: <630f3693.c80a0220.658dc.628a@mx.google.com>
Date:   Wed, 31 Aug 2022 03:23:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0045662068147593657=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ,v4,1/6] adapter: Keep track of whether the adapter is rfkill'ed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220831091912.47894-1-hadess@hadess.net>
References: <20220831091912.47894-1-hadess@hadess.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0045662068147593657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672764

---Test result---

Test Summary:
CheckPatch                    FAIL      9.12 seconds
GitLint                       PASS      6.06 seconds
Prep - Setup ELL              PASS      31.33 seconds
Build - Prep                  PASS      0.88 seconds
Build - Configure             PASS      10.02 seconds
Build - Make                  PASS      941.21 seconds
Make Check                    PASS      12.27 seconds
Make Check w/Valgrind         PASS      338.64 seconds
Make Distcheck                PASS      277.34 seconds
Build w/ext ELL - Configure   PASS      10.07 seconds
Build w/ext ELL - Make        PASS      97.46 seconds
Incremental Build w/ patches  PASS      702.02 seconds
Scan Build                    PASS      736.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v4,1/6] adapter: Keep track of whether the adapter is rfkill'ed
ERROR:CODE_INDENT: code indent should use tabs where possible
#95: FILE: src/adapter.c:7558:
+^I        g_dbus_emit_property_changed(dbus_conn, adapter->path,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#110: FILE: src/adapter.c:7574:
+^I        g_dbus_emit_property_changed(dbus_conn, adapter->path,$

/github/workspace/src/12960589.patch total: 2 errors, 0 warnings, 90 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12960589.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,v4,2/6] adapter: Implement PowerState property
ERROR:CODE_INDENT: code indent should use tabs where possible
#96: FILE: src/adapter.c:590:
+^I        g_dbus_emit_property_changed(dbus_conn, adapter->path,$

WARNING:LONG_LINE: line length of 97 exceeds 80 columns
#123: FILE: src/adapter.c:659:
+		reset_power_state_target(adapter, settings & MGMT_SETTING_POWERED ? 0x01 : 0x00);

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#153: FILE: src/adapter.c:727:
+						ADAPTER_INTERFACE, "PowerState");

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#175: FILE: src/adapter.c:761:
+						ADAPTER_INTERFACE, "PowerState");

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#209: FILE: src/adapter.c:3101:
+						ADAPTER_INTERFACE, "PowerState");

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#222: FILE: src/adapter.c:3115:
+						ADAPTER_INTERFACE, "PowerState");

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#239: FILE: src/adapter.c:3156:
+	} else if (adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_NONE) {

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#245: FILE: src/adapter.c:3162:
+		if (adapter->power_state_target == ADAPTER_POWER_STATE_TARGET_ON)

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#273: FILE: src/adapter.c:5620:
+						ADAPTER_INTERFACE, "PowerState");

WARNING:LONG_LINE_STRING: line length of 81 exceeds 80 columns
#282: FILE: src/adapter.c:7365:
+						ADAPTER_INTERFACE, "PowerState");

/github/workspace/src/12960593.patch total: 1 errors, 9 warnings, 197 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12960593.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0045662068147593657==--
