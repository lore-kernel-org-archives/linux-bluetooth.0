Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEECC6FA92
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiIWLWE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 07:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiIWLWA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 07:22:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE4113791B
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 04:21:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i3so8029807qkl.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 04:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=EsAAI+fspJvYyp4KYHtbOKLdxKposfg0OC4VA0F+w3w=;
        b=APfFumi51VgUJVjrWC2mk9WgPv0ZDxeWOUAQc98uqldUmsZEYiejal/2AZVyWpYn8E
         IgoZaZF9ENdcrR7HlxGvqg4HCKP39cHwKoAlzr2dP/PspJ3RP1GfLkWasYLH1AlVZdSr
         TbZm5W38V0BxkFlr2hSJp49SJw8oCZQ0iw4M21pyzGHQ2qrMelKMseR9EDdLq+3eujj9
         jPVCnTsCd29Y61q6baNS1SCjVXOrChqqcJFEf40jD/3pVKXifEPm5JaJXqLdmoYGz7pl
         HQXFfvwDW5XPYoN/eAmdwfZJ3rZozY1aaS3F0AVHNe0NSSpOB7LD/x0rj6CPwZ1gqRtm
         D4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=EsAAI+fspJvYyp4KYHtbOKLdxKposfg0OC4VA0F+w3w=;
        b=Iyf4mC7YCCzmx6TIVSdL+QO+ol21q3LjkKxRfaV+zfXyGl/8Fcv9b2Fkv1PqQ6N8XT
         s4ErOWLohtsEvAq6ffs6mXnL9HuLYVXj1FHI64z+6PdtBrXCGp6B1yAEP0KrSQ866BUt
         eLLsp0T72L0HzoxXN5pM6QEYVTXvx01dcxBH8Vq8sNPpTTcq25y7RyowMfHQUqPwV4iu
         +8OfBcjr1urhDZqQmy+CzPG6+8aqXhtzQRTfVJqQAVFidmSusDaSmRQRFZ1kT/5M91Po
         oDVTwiYBGqYyzobuuOzMwXmPV7lUKQfWIG+4WYjcrBh0qKwcKa+f0khfJcc0rDKfnTuN
         jDZw==
X-Gm-Message-State: ACrzQf03mVval2nYIIMAPsfz+b5wPhDCdeLYD8ZQMCxtK52FSS1ildB2
        Y8bIJBB+VGNXduHvZJruu9H8LCWUa9k=
X-Google-Smtp-Source: AMsMyM7l+/5r6h8ASa1Grl6m+N1ibk1MXnOQRJtb+zCeO9a6H7NAj40XeXb9ga0UXyvksug3a88ZIg==
X-Received: by 2002:a05:620a:4145:b0:6ce:8c42:7087 with SMTP id k5-20020a05620a414500b006ce8c427087mr5334620qko.334.1663932114923;
        Fri, 23 Sep 2022 04:21:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.91.151])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a0b5600b006b61b2cb1d2sm5408905qkg.46.2022.09.23.04.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 04:21:54 -0700 (PDT)
Message-ID: <632d96d2.050a0220.966ee.3608@mx.google.com>
Date:   Fri, 23 Sep 2022 04:21:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4947027937426037338=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220923102421.10336-2-ceggers@arri.de>
References: <20220923102421.10336-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4947027937426037338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679824

---Test result---

Test Summary:
CheckPatch                    PASS      12.59 seconds
GitLint                       FAIL      8.83 seconds
Prep - Setup ELL              PASS      26.35 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      8.36 seconds
Build - Make                  PASS      747.77 seconds
Make Check                    PASS      11.00 seconds
Make Check w/Valgrind         PASS      289.46 seconds
Make Distcheck                PASS      239.58 seconds
Build w/ext ELL - Configure   PASS      8.42 seconds
Build w/ext ELL - Make        PASS      84.11 seconds
Incremental Build w/ patches  PASS      892.46 seconds
Scan Build                    WARNING   493.39 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,9/9] battery: provided_battery_property_changed_cb: check for NULL iterator
1: T1 Title exceeds max length (82>80): "[BlueZ,9/9] battery: provided_battery_property_changed_cb: check for NULL iterator"


##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
client/gatt.c:2146:2: warning: Null pointer passed to 2nd parameter expecting 'nonnull'
        memcpy(*dst_value + offset, src_val, src_len);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============4947027937426037338==--
