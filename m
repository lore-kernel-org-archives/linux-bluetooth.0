Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB282C001DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 10:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGXK21 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 06:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGXK1f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 06:27:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC071FC9
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 03:23:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666ecb21f86so3985411b3a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690194199; x=1690798999;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a0g8neNlOf99i29eUycGFI19veQjtSet6SMwPNrAe/Y=;
        b=d+FPQtQnoTNLEu/+Yo7jzvukdmDIL7spb0iocLAz1UC6KE6sx84cRpRnO5Vu9DRx0/
         9eIjjZ19ScIoywHzt4i9KYLm/XJTIhPbB2dDaQyhDlKIj9o78Q7lyb2vHWxrwAp3pIQy
         +PO/SXw0cMf3ipmDOjLShGmtuCOOOBijiipM5hb7h9FckwM1BsaJHQ13brG2viVxUHqN
         zCeo/6saB/XHqA059gkZsG1DtSKte6GxmkEK/5S0B6L8+46zJTR6LE1DmSnip7eSghCP
         bIdcE3I4pThYi0Wx/Rxzz9wOHd53w5/wi6PwGcivIiXgIPRY5yASD1vXILtfQDqoWMVv
         9aDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690194199; x=1690798999;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0g8neNlOf99i29eUycGFI19veQjtSet6SMwPNrAe/Y=;
        b=RYdsaMqEv/Ex4FMD/5t6sloLSm49I/25UCQL+VTrRRbfKzoFinQSIwe2hZfy1t9KCS
         d6OwpOljNbB43JsOVS99e9eGayjFwdQlPydqVmhdoQtc7Aw0ADA/pQQAm767qff2UuSj
         Jf+e1txDoBljx3aXrMRoT2Zv+ru7IVttLg1qcXIS8ncxGB7f9a2gxZU1lvP+01gdO9dF
         +93SVWpVii6eRJbHsmNYXg/wLOVQItglXsECQttFXkgITVP1wUscWKgryxkPiWhuD8o8
         FRDJ6dS99QcVcoomJmQvMiUqveZc2vU7HByk18U4XAydxtsQPo1BprgAQhSyXkOaV+7H
         ctVQ==
X-Gm-Message-State: ABy/qLbync2IsVSWUSlCokk/o85KFSBia7OfQe9d7bo3MRaE/RI/GrV6
        fphHGlCa7i1UREAborzHrYTqINtvzk8=
X-Google-Smtp-Source: APBJJlEc652X+0GVFzrLm35el83vfsjbZXhtodKYVGzgSd/u8BkBuZwZoMbWlJhjV/rNPwbMeRFBAg==
X-Received: by 2002:a05:6a00:2ea9:b0:666:d78c:33ab with SMTP id fd41-20020a056a002ea900b00666d78c33abmr11778140pfb.21.1690194199547;
        Mon, 24 Jul 2023 03:23:19 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.245.114])
        by smtp.gmail.com with ESMTPSA id a4-20020aa780c4000000b00682c1db7551sm7368474pfn.49.2023.07.24.03.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:23:19 -0700 (PDT)
Message-ID: <64be5117.a70a0220.58afd.c6da@mx.google.com>
Date:   Mon, 24 Jul 2023 03:23:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4118140222315661301=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nitin.jadhav@nxp.com
Subject: RE: Fixed the crash observed with VOCS when pairing with LE Audio TWS earbuds
In-Reply-To: <20230724085530.5555-2-nitin.jadhav@nxp.com>
References: <20230724085530.5555-2-nitin.jadhav@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4118140222315661301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=768787

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       FAIL      0.64 seconds
BuildEll                      PASS      32.68 seconds
BluezMake                     PASS      990.43 seconds
MakeCheck                     PASS      13.04 seconds
MakeDistcheck                 PASS      185.50 seconds
CheckValgrind                 PASS      300.84 seconds
CheckSmatch                   PASS      394.85 seconds
bluezmakeextell               PASS      121.85 seconds
IncrementalBuild              PASS      809.02 seconds
ScanBuild                     WARNING   1239.51 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/1] shared/vcp: Fixed the crash observed with VOCS when pairing with LE Audio TWS earbuds

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (100>80): "[BlueZ,v1,1/1] shared/vcp: Fixed the crash observed with VOCS when pairing with LE Audio TWS earbuds"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/vcp.c:1424:3: warning: Potential leak of memory pointed to by 'vocs_ao_dec_r'
                DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%02x",
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/vcp.c:31:2: note: expanded from macro 'DBG'
        vcp_debug(_vcp, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============4118140222315661301==--
