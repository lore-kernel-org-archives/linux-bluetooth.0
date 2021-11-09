Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D51C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 21:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616EC61178
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 21:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhKIV5O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 16:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243296AbhKIV5N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 16:57:13 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6195C061764
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 13:54:26 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 132so530860qkj.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 13:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=r1BnJVyMnYGUo/NVe1RWVlXnMn1V8oOpCXUL4xndShk=;
        b=B4GGO3nKKRiHfs+6yvphLA1umMKUmSytzO0AvgHJNQX+KteUiZfoeu01xfdJ2sW7cl
         vL3rkLAl2viNdMLAaYlkTka4WgM+SaT8dtIkuK67rC7je6xA0bUIncaB5qqj5ItQancD
         fNdgWluDY6QAJD11m/pPmWj5bB7GQ8QWIST4PgqFBGDhfvwavhtFbpYUsxUVg6azd2bS
         jmEK2PhrUsRUSEHmvHiX+oHMU95kUIthb3263xN/nRBNh2U7w7crQZY6N6Ps6OI5S6H+
         Zxe4c+RC3FQN9eDXl+1LXH8lk8ZLYEtNrsWbL2MxwKr4HOiRJhxCMqDQOPhm9euWNNzH
         lXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=r1BnJVyMnYGUo/NVe1RWVlXnMn1V8oOpCXUL4xndShk=;
        b=F5JP8qpMJYwCr89U9m8t36i/9Gc/rTz3NxTnfTrKCpLhlnI27qAAy8ouHOOKOK9WAq
         /qn2RxCpSUdzFUyD2+myRG80EVDC83/dwb++LxQXZl/NFeNxIH6lZszAz32GR1Dls8Wg
         bmBz2jlotai43nC3k1IRpidkuQslO+AXPGfmWEbdugEUSh8PlfN0UgKUblc23TvQh5X4
         6eyMdVrJ9G1ILFVjeY+hH9uzLj/aSX0tfab1+PU/n+z4UoOIshV+pl3u7SXmuHE2jj8N
         K1Qi9vDjEV7f0XQ3TzpqqcwmS5R3HgJa4ENQDz7esFaa9gEsB1Ufj5vLCXAgsxSTGFQP
         2GjQ==
X-Gm-Message-State: AOAM530pKhRjz3ThJHoe9XVyGzOlJfgWPk/0FAg1pDW1m/knCH0f9UGI
        fb58KrHJAjqZr2ivAdQBRfugCHE0Em2iCg==
X-Google-Smtp-Source: ABdhPJyZeD1Jjr3fxYSRXaGgPPPG1K3RV9I2JWMxgVB+LipmI8QDve0da0V8SrfagZS3z7WeSXFqHA==
X-Received: by 2002:a37:620d:: with SMTP id w13mr8960128qkb.44.1636494865732;
        Tue, 09 Nov 2021 13:54:25 -0800 (PST)
Received: from [172.17.0.2] ([20.122.40.227])
        by smtp.gmail.com with ESMTPSA id l15sm13264485qtk.41.2021.11.09.13.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 13:54:25 -0800 (PST)
Message-ID: <618aee11.1c69fb81.4dc68.a49d@mx.google.com>
Date:   Tue, 09 Nov 2021 13:54:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2761156141744247867=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,BlueZ] client/gatt: Fix using atoi
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211109213721.1121677-1-luiz.dentz@gmail.com>
References: <20211109213721.1121677-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2761156141744247867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=577649

---Test result---

Test Summary:
CheckPatch                    FAIL      1.46 seconds
GitLint                       PASS      0.90 seconds
Prep - Setup ELL              PASS      40.77 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      7.68 seconds
Build - Make                  PASS      175.76 seconds
Make Check                    PASS      9.67 seconds
Make Distcheck                PASS      208.11 seconds
Build w/ext ELL - Configure   PASS      7.83 seconds
Build w/ext ELL - Make        PASS      166.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2,BlueZ] client/gatt: Fix using atoi
WARNING:TYPO_SPELLING: 'prefered' may be misspelled - perhaps 'preferred'?
#84: 
likely the prefered format for the likes of handles, etc, so this
           ^^^^^^^^

/github/workspace/src/12611125.patch total: 0 errors, 1 warnings, 126 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12611125.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2761156141744247867==--
