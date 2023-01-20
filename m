Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F85C38159
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Jan 2023 04:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjATEM3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 23:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjATEM2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 23:12:28 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B967E9EE13
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 20:12:26 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id fd15so3312228qtb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 20:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V0mhW4Ax1KfIELdqY0XfBMaMuxja46f70Q4U/DW6hoo=;
        b=Y4aApzRg1BdViP6UEcmjLPo2gcY1eMoZxLumFtQ1SULaWwR4XqJj1DfXFAfzP2ymX8
         N0VsxU0zVnKI5hbc7kGL8Gsaw1oND0EKlK0sOJzaNObCVBc7OgNpYVF01Gh3cmC3hP/U
         zXoo4wyRZ46d27NuwirnvQ1RBJJQlY1mu3/2FLxchET6bw49j4BF9xgIij26HEDJgKaS
         5yG35Sxv2a6bxrsf415reH/hoVn/+vneDYBCEnxhAc0wgUgnGLQrNjXLPPoyURXz+ia0
         YUHDVIyCvfYMz/uG6WuP8Qp6nMJhO7PftFucZHc4H8HovZpVw4wlKy+laWqTANN6s/39
         +p2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0mhW4Ax1KfIELdqY0XfBMaMuxja46f70Q4U/DW6hoo=;
        b=wlDSGJ379gdYk918z2YNIw7uOWGRugut91BFd6deCXcvh6S1bNE2aArf+68h1uB1Ya
         wACObZAUvfb8/xqMN6z95aLY2MplGZaHeNR+rkdokLAOK6lvhH4uHFzkGI156sBEPG6S
         bFclA9wWj4ruSuR5Kxuk2KF/EANgY6zECDm3O1d7hQpAjvGdt9JEqkhls2DGExAHcVoj
         Ll3Mh2vbSSCiltkguSHxMMZq6hI4HBBQ6VtF5fYwSYjaWLtp1+0hw4t3iaCi2nDUOWeI
         z6bSx2/bIQ2usW6fETyG7CxA+aBsL2381gxmPdQ7bELI8ojZ90psm1xdQbx0QiT6Zx3i
         f/2Q==
X-Gm-Message-State: AFqh2kpW7Pn+OESp28lU2urT0zOPCXAYomuSdPQRTBgQbQSeukoGg9jc
        YA2CP1sw+tWvKzkFitjhSwHP7WemMtwSug==
X-Google-Smtp-Source: AMrXdXtsGUAkeaBbSepHkCBHWiapy8778bFlozaA2Nv6Y6Y81ZoHlaPQlLbPpKgmnn13CTkVD81WAA==
X-Received: by 2002:a05:622a:6094:b0:3a5:fd39:ff90 with SMTP id hf20-20020a05622a609400b003a5fd39ff90mr54139532qtb.3.1674187945636;
        Thu, 19 Jan 2023 20:12:25 -0800 (PST)
Received: from [172.17.0.2] ([172.176.196.113])
        by smtp.gmail.com with ESMTPSA id bz25-20020a05622a1e9900b003a591194221sm4703545qtb.7.2023.01.19.20.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 20:12:25 -0800 (PST)
Message-ID: <63ca14a9.050a0220.c4a4e.2490@mx.google.com>
Date:   Thu, 19 Jan 2023 20:12:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1882843315939663940=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: Mesh v1.1 additions
In-Reply-To: <20230119235755.46002-2-brian.gix@gmail.com>
References: <20230119235755.46002-2-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1882843315939663940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=713938

---Test result---

Test Summary:
CheckPatch                    FAIL      9.88 seconds
GitLint                       FAIL      4.26 seconds
BuildEll                      PASS      27.14 seconds
BluezMake                     PASS      835.50 seconds
MakeCheck                     PASS      11.77 seconds
MakeDistcheck                 PASS      147.68 seconds
CheckValgrind                 PASS      243.94 seconds
CheckSmatch                   WARNING   326.37 seconds
bluezmakeextell               PASS      97.49 seconds
IncrementalBuild              PASS      8277.83 seconds
ScanBuild                     WARNING   997.72 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,02/12] mesh: Add Remote Provisioning
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3305: FILE: mesh/remprv-server.c:238:
+		/* Fall Through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3514: FILE: mesh/remprv-server.c:447:
+		/* Fall Through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3518: FILE: mesh/remprv-server.c:451:
+		/* Fall Through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3797: FILE: mesh/remprv-server.c:730:
+		/* Fall Through */

/github/workspace/src/src/13108984.patch total: 0 errors, 4 warnings, 3740 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13108984.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,07/12] mesh: Add Mesh Private Beacon server
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#228: FILE: mesh/prvbeac-server.c:74:
+		/* Fall Through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#240: FILE: mesh/prvbeac-server.c:86:
+		/* Fall Through */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#247: FILE: mesh/prvbeac-server.c:93:
+		/* Fall Through */

/github/workspace/src/src/13108981.patch total: 0 errors, 3 warnings, 166 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13108981.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,08/12] mesh: Add Tx/Rx support of Mesh Private Beacons
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#163: FILE: mesh/net-keys.c:70:
+static struct l_queue *beacons = NULL;

WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#981: FILE: mesh/net.c:2834:
+							beacon_data->net_key_id);

/github/workspace/src/src/13108983.patch total: 1 errors, 1 warnings, 1067 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13108983.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,01/12] doc/mesh: Add Remote Provisioning DBus APIs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
11: B3 Line contains hard tab characters (\t): "	* Refresh Device Keys"
12: B3 Line contains hard tab characters (\t): "	* Reassign Node Addresses"
13: B3 Line contains hard tab characters (\t): "	* Refresh Node Composition"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
mesh/manager.c:113:35: warning: non-ANSI function declaration of function 'free_pending_add_call'mesh/crypto.c:1023:30: warning: non-ANSI function declaration of function 'mesh_crypto_check_avail'unit/test-mesh-crypto.c: note: in included file:
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
mesh/remprv-server.c:735:12: warning: Assigned value is garbage or undefined
                msg[n++] = status;
                         ^ ~~~~~~
1 warning generated.
mesh/prov-initiator.c:123:7: warning: Access to field 'server' results in a dereference of a null pointer (loaded from variable 'prov')
        if (!prov->server)
             ^~~~~~~~~~~~
1 warning generated.
tools/mesh/mesh-db.c:1978:4: warning: Value stored to 'jobj' is never read
                        jobj = json_object_new_object();
                        ^      ~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.
In file included from unit/test-mesh-crypto.c:20:
In file included from ./mesh/crypto.c:18:
In file included from ./ell/ell.h:1:
./ell/util.h:187:9: warning: 1st function call argument is an uninitialized value
        return L_BE32_TO_CPU(L_GET_UNALIGNED((const uint32_t *) ptr));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./ell/util.h:89:28: note: expanded from macro 'L_BE32_TO_CPU'
#define L_BE32_TO_CPU(val) bswap_32(val)
                           ^~~~~~~~~~~~~
/usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
#define bswap_32(x) __bswap_32 (x)
                    ^~~~~~~~~~~~~~
unit/test-mesh-crypto.c:995:11: warning: The left expression of the compound assignment is an uninitialized value. The computed value will also be garbage
                key_aid |= KEY_ID_AKF;
                ~~~~~~~ ^
unit/test-mesh-crypto.c:1038:2: warning: 4th function call argument is an uninitialized value
        verify_uint8("NID", 0, keys->net_nid, nid);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
unit/test-mesh-crypto.c:1319:6: warning: Branch condition evaluates to a garbage value
        if (ctl) {
            ^~~
unit/test-mesh-crypto.c:1539:7: warning: Branch condition evaluates to a garbage value
                if (net_ctl) {
                    ^~~~~~~
unit/test-mesh-crypto.c:1806:3: warning: 1st function call argument is an uninitialized value
                l_put_be64(cmac_tmp, cmac);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~
6 warnings generated.



---
Regards,
Linux Bluetooth


--===============1882843315939663940==--
