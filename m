Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718E1C636CD
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Feb 2023 18:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBESNg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Feb 2023 13:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBESNf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Feb 2023 13:13:35 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90131196A2
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 10:13:32 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1442977d77dso12760004fac.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Feb 2023 10:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H24wrjKwatIcEVst0EG2mNAFQqij+g2HBfZ1qvIHuyw=;
        b=MXqsokNL0xqWhXiGTe0kcY9H8bYU2FhztX4IiJ8AHwjnqIjag6Ngd7LGzwrkjVEVCr
         wYYVKCYIin4GVfC9mPecKYJRodkaNXJO8cQ2souwKCe2yKe5KrDKEoZ8tAOfX72liuEa
         KH7NZUvg7GHj0xbIecp4UN2oU9LVZLYD5fnLlPNjUEkLEVavkiRXSspxMJ7Ne0rbqLIH
         I4YE7EkjbtiDpF4RaJvCXxyQbnPBsenOK2/kZZtvb3XOPOL2aoVpFqQcBYT+Z5G9EpkX
         Eljvfu2r86eDmpbF2vwXNZeeCLDPDaQMiPp03aFbdanS8ZyltAcV3S0qVyIBYmG74vLE
         3Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H24wrjKwatIcEVst0EG2mNAFQqij+g2HBfZ1qvIHuyw=;
        b=UIVtwZswrES7F2YTU0986QYzBQYbYHJC6sq4WroFkbVe9KAdxzI+bghyzNImi1foOn
         oJC/VGBxnVn8dLAcgWqW75MA0fwKvAOcl++5eNEwnTTJa/csWiQwpdpkeY3gsLV5+c57
         LS3ZHYLT8a7NH3zHAhbKg4zbIQxGH5KBGzATwo73cKYnNTzFGlUFiBCqlr7NYa8Xd+Mr
         8H99bAyU0sOcmBmQSA4Fs2epMP0pa1XjOc2enVH4np3uN/GmRJ+EHe0VFqjagB8V1YC0
         RzaV4prn7kB7V+Z2zh5rWJ1ZxQut8kMwVidiVrN1eUx/q3tWZDyO20GXZ6g02zKYYP7v
         8SSw==
X-Gm-Message-State: AO0yUKUUCLhUcmq+18Eg95DOdLgsRxMy0+me8+O/cs3RFz1dwsD1uzyk
        AaZ+we1a573oEl1W0tPCz5T+XnxtW+8=
X-Google-Smtp-Source: AK7set842/tGzqeHYOlDF1Y0i2xCUTsC8RsX9o2Rr0litbI9SmfXO6XThG3Vf27HKEB5om3H+u3k4Q==
X-Received: by 2002:a05:6870:b6a7:b0:163:30c7:c821 with SMTP id cy39-20020a056870b6a700b0016330c7c821mr9724151oab.42.1675620811019;
        Sun, 05 Feb 2023 10:13:31 -0800 (PST)
Received: from [172.17.0.2] ([104.44.128.240])
        by smtp.gmail.com with ESMTPSA id v16-20020a056820101000b004fc4000ae48sm3518451oor.15.2023.02.05.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 10:13:30 -0800 (PST)
Message-ID: <63dff1ca.050a0220.3d527.cd96@mx.google.com>
Date:   Sun, 05 Feb 2023 10:13:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6532994841556693110=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: fix crash unregistering media endpoint while streaming
In-Reply-To: <7fb15c0b34a29d0b85568ce8dcc9969771f498c0.1675615318.git.pav@iki.fi>
References: <7fb15c0b34a29d0b85568ce8dcc9969771f498c0.1675615318.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6532994841556693110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=718927

---Test result---

Test Summary:
CheckPatch                    FAIL      0.89 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      26.96 seconds
BluezMake                     PASS      950.69 seconds
MakeCheck                     PASS      11.26 seconds
MakeDistcheck                 PASS      148.56 seconds
CheckValgrind                 PASS      243.93 seconds
CheckSmatch                   PASS      324.61 seconds
bluezmakeextell               PASS      96.97 seconds
IncrementalBuild              PASS      809.84 seconds
ScanBuild                     PASS      1007.16 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/bap: fix crash unregistering media endpoint while streaming
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#60: 
    #0 0x7f93b12b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)

/github/workspace/src/src/13129108.patch total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13129108.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6532994841556693110==--
