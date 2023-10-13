Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE792CDB47E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Oct 2023 11:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjJML0g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Oct 2023 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjJML0f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Oct 2023 07:26:35 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958EBB7
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 04:26:33 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41b513e4a22so5287151cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Oct 2023 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697196392; x=1697801192; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=takQQLdk3E29UXf0CbZugt7CA31RX9dtloqSLuAqhK8=;
        b=h6xdJ5Z6v16yeWomyXNj8pVCKh0gtBicDYUfTNzucYmIcJ6KCtOdiEE7ptktxcgYma
         10q8PW0xopj+Lqz5TWqRK3+eC1owzknDkHAT6Y16R+eJ/h4WOxv9zv6z8Ry+81ZgD4sY
         Sq5saVBgdwOZbROpfx5V8vr7g92RgRGhD09MiBXg7vi4R9pCb8S7QKT2ChvcZf6l1/Gl
         zqpA+1uBxqakP9l26Jv7QN3MgtuMYuZEemu6U7M2Kh8rscxM3ROG4SESe/LRyNI37u1m
         v/wIaLgDnyMWH90OZPFVU54e2K0WkHvCxb0NM5ltoFm1KBrqWwfDRNwA8g7nO0mzxhix
         EcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697196392; x=1697801192;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=takQQLdk3E29UXf0CbZugt7CA31RX9dtloqSLuAqhK8=;
        b=rxT8C9qITqjsrI0fV24gsW9CofOBXPQh9W9JspRhl/gagH5C0KaXtYGIeqnbhuTSYX
         T9c8swSOPJQQOoSputjfdx+mJSKyWy5q2Uby/rRX0+KXCTLTVvwwiRiY9V8eHpaHd5t4
         +Q8whOt6mwuoX2if/eUlPNtlVR1xsdsRqI8RGJfwsN6i5xCh5NYS2kfdCdvrqFaeNFgN
         no6DRZ+AOQt6OOa1/k5PtWk+73OWwtPULwD6nntk/w+/A9+t2bz94tmCM7Vbs8TYOTu1
         zYrNvAYRrCHIXbaqAgGJvCfKz/8B8C9IAHwZQucCNBh7ZyIZV25wsS0sFjwUZo3XtZal
         9BRA==
X-Gm-Message-State: AOJu0YxEbWb2rZzbbUuniU8dqhEQx4ht6qzAB2R5QAsink5XH6KyFWBT
        s2PZ0PXKzYy/TPGKpDY/39x8ioQD75w=
X-Google-Smtp-Source: AGHT+IED72d7XojMZTi+R+JvRJ/Vf5FBjDnZFeVD4TW4okW6m8xzIZ3cgE5pVhUJquOTYtuNkArXxg==
X-Received: by 2002:ac8:7f05:0:b0:410:9836:8066 with SMTP id f5-20020ac87f05000000b0041098368066mr27350369qtk.43.1697196392372;
        Fri, 13 Oct 2023 04:26:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.43.91])
        by smtp.gmail.com with ESMTPSA id he19-20020a05622a601300b0041b381b9833sm519490qtb.75.2023.10.13.04.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:26:31 -0700 (PDT)
Message-ID: <65292967.050a0220.67d56.23bf@mx.google.com>
Date:   Fri, 13 Oct 2023 04:26:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6090177972091587211=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: bap: Fix source+sink endpoint registration
In-Reply-To: <20231013100537.3867-2-claudia.rosu@nxp.com>
References: <20231013100537.3867-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6090177972091587211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792936

---Test result---

Test Summary:
CheckPatch                    FAIL      1.32 seconds
GitLint                       PASS      0.74 seconds
BuildEll                      PASS      27.69 seconds
BluezMake                     PASS      884.34 seconds
MakeCheck                     PASS      11.65 seconds
MakeDistcheck                 PASS      172.79 seconds
CheckValgrind                 PASS      267.85 seconds
CheckSmatch                   PASS      361.35 seconds
bluezmakeextell               PASS      115.77 seconds
IncrementalBuild              PASS      1379.67 seconds
ScanBuild                     PASS      1048.46 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] bap: Fix source+sink endpoint registration
WARNING:LONG_LINE: line length of 86 exceeds 80 columns
#158: FILE: src/shared/bap.c:2720:
+		queue_foreach(sessions, notify_session_pac_added, pac_broadcast_sink);

/github/workspace/src/src/13420604.patch total: 0 errors, 1 warnings, 115 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13420604.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6090177972091587211==--
