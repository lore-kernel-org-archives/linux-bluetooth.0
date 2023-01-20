Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2677C05027
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Jan 2023 22:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjATWxD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Jan 2023 17:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjATWxC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Jan 2023 17:53:02 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E07F7B2D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 14:52:28 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s4so5380037qtx.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0BorpMZPrX0w7R8Vr9ggMvFFPfhCtCgEnuw85+IacQM=;
        b=ADsyGmecSWhq490E/+dmEHIZK9rqKoul+KbRFDexZIQVySaDoHrZUZI2XxGSuf5bjL
         l1DFzzvrrz0ycDn+Z+qr3+RlDhCi9fBHQoQh+Rk42NIQMQoIqXKtka6LE0ma/78SL1VG
         rKsPBfRhz33z2S5hL8fbrkEbc+v5O/F1Ec76asyVxSbSWsJSa/GJ9k4zxE/eEwGikQ6N
         j6EiDbNitsLnj4lSOZqZPFsb3weGRyX3UOuZ1WX784Zo4JWVrajNg5+xGGOXJFxazMf8
         qzvrsfgpMkVh3A3y7YwPWpdIO0h0sZMwqSE6JNX8rnWRkzUn1uAirh4iWQZhjnp6HmHX
         OEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BorpMZPrX0w7R8Vr9ggMvFFPfhCtCgEnuw85+IacQM=;
        b=vb8VGT2XgEQXaTQCBjYDU4UMU4/ybXAmZ70ln4o51Mrwk1g7hB0Uj1QMwtmQI7F69j
         /tb73eAFDZWmb2fZY+A3CDNnK6oeSQS29vHJ+KgmSQkKtls67REpSzfMqMESq/mmuhV9
         7vVK1dTGkjQIAHbTHAjFHgWIytRfo0XK7wXvZ+PfhiRiv0ahsCjP7w/bH1anq5M7e2I7
         fML42bZN8lHlMC9hwFjR4Fqye3HZ5NvWtZRIzANst6/AfpCAfoEKF/V6EuemRYnvEX2Y
         7t39wXZUMjkPLx+Jl7l9FajEdRPELmVzwV/DqflDNl0QyfoTUuzxh1Zekxn1DeUABayN
         HP+g==
X-Gm-Message-State: AFqh2kqHtSwv0IoyU3XILuNe7omKvcdBkQ+nQdixxZ/voG5D3p7q3zd6
        7zUdwBFDEuxuCZtmO956rW8z2AHsXLw=
X-Google-Smtp-Source: AMrXdXsGvynXmf2+E1In3qRBW5VZY+IbwUh4AXsixnLTmPj6575dry8PviB3D1LGzP3i3gW6YHIwTQ==
X-Received: by 2002:a05:622a:5d8f:b0:3b6:316e:90c1 with SMTP id fu15-20020a05622a5d8f00b003b6316e90c1mr24131772qtb.10.1674255064596;
        Fri, 20 Jan 2023 14:51:04 -0800 (PST)
Received: from [172.17.0.2] ([172.176.229.16])
        by smtp.gmail.com with ESMTPSA id az20-20020a05620a171400b007091068cff1sm2332952qkb.28.2023.01.20.14.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:51:04 -0800 (PST)
Message-ID: <63cb1ad8.050a0220.eb359.8a0b@mx.google.com>
Date:   Fri, 20 Jan 2023 14:51:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0093644907737235244=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: Mesh v1.1 additions
In-Reply-To: <20230120194731.90065-2-brian.gix@gmail.com>
References: <20230120194731.90065-2-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0093644907737235244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=714256

---Test result---

Test Summary:
CheckPatch                    FAIL      9.32 seconds
GitLint                       FAIL      4.13 seconds
BuildEll                      PASS      26.61 seconds
BluezMake                     PASS      760.73 seconds
MakeCheck                     PASS      11.33 seconds
MakeDistcheck                 PASS      148.69 seconds
CheckValgrind                 PASS      239.29 seconds
CheckSmatch                   WARNING   320.71 seconds
bluezmakeextell               PASS      95.92 seconds
IncrementalBuild              PASS      6720.33 seconds
ScanBuild                     WARNING   942.59 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,02/11] mesh: Add Remote Provisioning
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3306: FILE: mesh/remprv-server.c:238:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3515: FILE: mesh/remprv-server.c:447:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3519: FILE: mesh/remprv-server.c:451:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#3798: FILE: mesh/remprv-server.c:730:
+		/* Fallthrough */

/github/workspace/src/src/13110477.patch total: 0 errors, 4 warnings, 3742 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13110477.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,07/11] mesh: Add Mesh Private Beacon server
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#227: FILE: mesh/prvbeac-server.c:74:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#239: FILE: mesh/prvbeac-server.c:86:
+		/* Fallthrough */

WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#246: FILE: mesh/prvbeac-server.c:93:
+		/* Fallthrough */

/github/workspace/src/src/13110472.patch total: 0 errors, 3 warnings, 166 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13110472.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,01/11] doc/mesh: Add Remote Provisioning DBus APIs

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
mesh/remprv-server.c:709:3: warning: Value stored to 'status' is never read
                status = PB_REM_ERR_SUCCESS;
                ^        ~~~~~~~~~~~~~~~~~~
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
unit/test-mesh-crypto.c:1337:3: warning: 7th function call argument is an uninitialized value
                mesh_crypto_packet_decrypt(pkt, pkt_len,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
unit/test-mesh-crypto.c:1559:4: warning: 7th function call argument is an uninitialized value
                        mesh_crypto_packet_decrypt(packet, packet_len,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============0093644907737235244==--
