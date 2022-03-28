Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A4AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Mar 2022 23:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiC2AAF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiC2AAA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Mar 2022 20:00:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A219C160681
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 16:58:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so1040979pjo.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 16:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/LY6yiqxF2Uwo6Qj2pW/tdFCbtNAkAYl8mjfqGdBguA=;
        b=AnQ5rrmcywffS+dLbwZQaMiSg528dc0CDi52goXoHb1Av97i9yjzAKd505YqNXXCFf
         U46CmZfmXb7jQkprpDbzupPBIrfP9tNJJDadp8CR4oekmJ/J9f10dpQHUN5AsOePhsoQ
         5rauxLz3BVsz6OVbBH0+cIB7bzuC8KzpHo+6zEPrxa398gqIZh2AHL/xQzHtzfzHKz9C
         AsL6c2/D5iUtVUukhSRXeyxGuSrcWULVTBR8mBnBReSz0pyfuzzRrrcrl4FM21ACw8qw
         CPH1RsOca3i6afFijQ8r5tR0K0pPimSyLPcWP53vzsuNyMjbHguBKG8wAeWcXL19kJfn
         bxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/LY6yiqxF2Uwo6Qj2pW/tdFCbtNAkAYl8mjfqGdBguA=;
        b=1JWFVDJwurS1ikyWJZ8K+g/j1qBzO+AbbOC1T9kZOYHci9YEmq80U+Wd7CZoIb47S7
         98Skw0MwRF78zsgtcwmcDNpOqUrPf12aTfWUdXixdTDw5QCJu5GyQWAMI8OPkoYt/ILq
         bsEusnhdzPZXFopfs9ZOv1k6NmXEoHqKOh/q+5A68CHMR6gx8fB3HmL0twnzO+cZNzPG
         A9pUlbYxw/Sb/Qs4bOSWyET3dRt8GJA+e9CM0CnQ/GD/wy2OQFO1F9ofOd6Ezh6ef3m3
         3Ha46aHrdh+HsNUzXt2279iqW9aRN+0FqlPNmKk1HIsucXBZeJ7kevEsJ7FmqdWOuzRZ
         fkyg==
X-Gm-Message-State: AOAM531TKhif4PKsWG0Rw7eT3HWJnMfF7MLLdME1IxgqJPRIx693tkcv
        l+cLgRsCE9dyWs9duthBYwnfsDPrsj4=
X-Google-Smtp-Source: ABdhPJxrktpk4Z07EQOXX9GGrwQ894riqIRgFT1kECrAantceRnbnY0zv/PXpvOFklp6BA/F5G6jfQ==
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id d22-20020a170902729600b0014b4bc60e81mr27753357pll.132.1648511897975;
        Mon, 28 Mar 2022 16:58:17 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.172.204])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm14329741pgc.50.2022.03.28.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:58:17 -0700 (PDT)
Message-ID: <62424b99.1c69fb81.3bcf9.6a4d@mx.google.com>
Date:   Mon, 28 Mar 2022 16:58:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4438511353531094101=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] shell: Make bt_shell_add_submenu set main menu if none has been set
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220328212518.1890451-1-luiz.dentz@gmail.com>
References: <20220328212518.1890451-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4438511353531094101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627009

---Test result---

Test Summary:
CheckPatch                    FAIL      1.64 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      53.47 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      10.70 seconds
Build - Make                  PASS      1802.68 seconds
Make Check                    PASS      13.23 seconds
Make Check w/Valgrind         PASS      545.21 seconds
Make Distcheck                PASS      282.63 seconds
Build w/ext ELL - Configure   PASS      10.07 seconds
Build w/ext ELL - Make        PASS      1754.57 seconds
Incremental Build with patchesPASS      3577.10 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,2/2] client: Add support for player submenu
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#272: FILE: client/player.c:1102:
+static GDBusClient *client;
                    ^

/github/workspace/src/12794262.patch total: 1 errors, 0 warnings, 1319 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12794262.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4438511353531094101==--
