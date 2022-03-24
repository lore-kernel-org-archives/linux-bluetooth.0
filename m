Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D40C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 23:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355777AbiCXX0i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 19:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354077AbiCXX0h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 19:26:37 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D81A9967
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 16:25:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id i4so5245988qti.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TdxrZfXRkQ15lg0JNZJxdDZxu9PcbmpfltcuIZKZ1BU=;
        b=AX0//BC8SJEhIYHa50reQhJcsvJTjGzbpFiKzdkSfJKwFAnDaduBYgZu3qbWGUNDZL
         9noevSnowwObf/Ig6RFZflIMNwARI55VRJDHSA3xHmvWU4Y6vojp6avJkka3BNfqeIKt
         AGbL0kJujrnOtKqTs6z6cNgaTEu99fcf2s1QF3O/DAU9jFVLMZ/wI2M5czpu31c93Ces
         Sm/VTV2lsZfkeKDI+jt6s+DQS6P6Bkh/estRbZykWt3eBHTgWdjbVvooezLSxE1j9Qby
         43bshPUR/REUOz2wdsEeRQu7WKwYcW7CVxGxBUhhuhxQliFk9EG8j/T8/acepscU6NSg
         x54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TdxrZfXRkQ15lg0JNZJxdDZxu9PcbmpfltcuIZKZ1BU=;
        b=WTp6es7uH4x/CjBlTS17tObRbittogymftBGdlHkUTZAJ2a4LBosKr/P5gAq7sFnBN
         ui8lMNH8eQXj/eUA1a9pjuWWpAcgJOaMpT0F8J/kQ3lu70JntHtB0VO/UPjPW84qr7bk
         lfoojkF3ieIhzPpWmlJBIpRAqFLNnLOllz+56BMWLhiGvcnI25wx1sYFX3N0a0ALOY3C
         ABKEr6EqeoJuIZNA71Kw268+F3yZBC7xeIhVH5rMs1fGHRgW97N7DE6wi/iDYCsUvpmN
         zRmgACt2sZ6vl0Qd95HSJjLEyYL0gTUt9Qq7gwAqg1od0QfA9bHGQtKUdf28Xwb6LbMw
         QmGg==
X-Gm-Message-State: AOAM532WQNYF9s6lBE94+ayG/5SVuV2bIsBTTxaMUVdmqzXe6GNPZ6e7
        l42cv0WsWi9Wt0G7zdR4UpK54K9xk/+50w==
X-Google-Smtp-Source: ABdhPJyXSOY8l8c69dRlNZGPTNcQL/kJf/LAZ3KGAMgfoLZz2UhNrcDTcLVLvaDNbgDnDPZXUtUH/g==
X-Received: by 2002:ac8:588c:0:b0:2e1:ee12:3473 with SMTP id t12-20020ac8588c000000b002e1ee123473mr6774231qta.455.1648164302840;
        Thu, 24 Mar 2022 16:25:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.242.33])
        by smtp.gmail.com with ESMTPSA id u19-20020a05622a199300b002e1a669eeb6sm3565053qtc.34.2022.03.24.16.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 16:25:02 -0700 (PDT)
Message-ID: <623cfdce.1c69fb81.97131.786f@mx.google.com>
Date:   Thu, 24 Mar 2022 16:25:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5218297835700247641=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] adapter: Fix adding SDP records when operating on LE only mode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220324213658.59479-1-luiz.dentz@gmail.com>
References: <20220324213658.59479-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5218297835700247641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626167

---Test result---

Test Summary:
CheckPatch                    FAIL      2.83 seconds
GitLint                       PASS      1.96 seconds
Prep - Setup ELL              PASS      39.94 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      7.92 seconds
Build - Make                  PASS      1322.38 seconds
Make Check                    PASS      11.75 seconds
Make Check w/Valgrind         PASS      407.79 seconds
Make Distcheck                PASS      215.81 seconds
Build w/ext ELL - Configure   PASS      8.41 seconds
Build w/ext ELL - Make        PASS      1371.63 seconds
Incremental Build with patchesPASS      2697.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/2] a2dp: Don't initialize a2dp_sep->destroy until properly registered
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#93: 
   by 0x4A574A8: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.19.14)

/github/workspace/src/12791043.patch total: 0 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12791043.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5218297835700247641==--
